assert(lib.checkDependency('qbx_core', '1.18.1'), 'qbx_core v1.18.1 or higher is required')
assert(lib.checkDependency('qbx_vehicles', '1.2.0'), 'qbx_vehicles v1.2.0 or higher is required')
local Inventory = require 'modules.inventory.server'
local QBX = exports.qbx_core

AddEventHandler('qbx_core:server:playerLoggedOut', server.playerDropped)

-- Jobs that require the player to be ACTIVELY ON DUTY to count for ox_inventory
-- group checks (police armory, medicine cabinet, etc.). An off-duty officer
-- has these jobs in playerData.jobs, but we strip them from inv.player.groups
-- so shop access via groups = shared.police / { ambulance = 0 } gates correctly.
local DUTY_RESTRICTED_JOBS = {
    police = true,
    bcso = true,
    sasp = true,
    ambulance = true,
}

-- Strip duty-restricted jobs from `groups` unless the player is currently
-- clocked into that exact job AND on duty. Mutates and returns `groups`.
local function applyDutyFilter(groups, playerData)
    if not groups then return groups end
    local activeJob = playerData and playerData.job
    local activeName = activeJob and activeJob.name
    local activeOnDuty = activeJob and activeJob.onduty
    for jobName in pairs(groups) do
        if DUTY_RESTRICTED_JOBS[jobName] then
            if jobName ~= activeName or not activeOnDuty then
                groups[jobName] = nil
            end
        end
    end
    return groups
end

-- Synthetic, duty-INDEPENDENT groups so the police armoury / medicine cabinet
-- SHOPS open while off duty, WITHOUT also un-gating the police stashes/evidence
-- (those keep groups = shared.police, which applyDutyFilter still strips off duty).
-- The two shops are pointed at these groups in data/shops.lua.
local SHOP_GROUP_FOR_JOB = {
    police = 'police_armoury',
    bcso = 'police_armoury',
    sasp = 'police_armoury',
    ambulance = 'medical_cabinet',
}

-- (Re)compute each synthetic shop group from its contributing job grades. Must
-- run on an UN-stripped groups copy and BEFORE applyDutyFilter (which removes the
-- real job group off duty); the shop group is not in DUTY_RESTRICTED_JOBS, so it
-- survives. Carries the grade so per-item grade gates (e.g. the carbine's
-- grade = 3) still work against the shop group. Recomputed (not merely added) so
-- losing/switching the job clears the shop access too.
local function addShopGroups(groups)
    if not groups then return groups end
    local computed = {}
    for jobName, shopGroup in pairs(SHOP_GROUP_FOR_JOB) do
        local grade = groups[jobName]
        if grade ~= nil and (computed[shopGroup] == nil or grade > computed[shopGroup]) then
            computed[shopGroup] = grade
        end
    end
    for _, shopGroup in pairs(SHOP_GROUP_FOR_JOB) do
        groups[shopGroup] = computed[shopGroup] -- nil clears it when no job grants it
    end
    return groups
end

-- QBX:GetGroups can be momentarily stale (it returns WITHOUT the active job —
-- qbx restores PlayerData.job/gang on login, and keeps them across duty toggles,
-- without firing SetJob). Rebuilding groups from it alone would drop the
-- synthetic police_armoury / medical_cabinet group, so seed the active job + gang
-- from PlayerData before addShopGroups runs. Must be called BEFORE applyDutyFilter
-- (which strips the real job group off duty; the synthetic group survives).
local function seedActiveGroups(groups, playerData)
    if not (groups and playerData) then return groups end
    if playerData.job and playerData.job.name then
        groups[playerData.job.name] = playerData.job.grade and playerData.job.grade.level or 0
    end
    if playerData.gang and playerData.gang.name then
        groups[playerData.gang.name] = playerData.gang.grade and playerData.gang.grade.level or 0
    end
    return groups
end

AddEventHandler('qbx_core:server:onGroupUpdate', function(source, groupName, groupGrade)
    local inventory = Inventory(source)
    if not inventory then return end
    local player = QBX:GetPlayer(source)
    if not player then
        inventory.player.groups[groupName] = not groupGrade and nil or groupGrade
        return
    end
    -- Rebuild from a fresh (un-stripped) copy, apply this specific change, then
    -- recompute shop groups + duty filter — so the synthetic groups are correct on
    -- job removal/grade change, not just on a freshly-added LEO job.
    inventory.player.groups = QBX:GetGroups(source) or {}
    seedActiveGroups(inventory.player.groups, player.PlayerData)
    inventory.player.groups[groupName] = not groupGrade and nil or groupGrade
    addShopGroups(inventory.player.groups)
    applyDutyFilter(inventory.player.groups, player.PlayerData)
end)

-- When duty status flips, refresh the inventory's groups so the shop check
-- sees the up-to-date state.
AddEventHandler('QBCore:Server:SetDuty', function(source, onduty)
    local inventory = Inventory(source)
    if not inventory then return end
    local player = QBX:GetPlayer(source)
    if not player then return end
    -- Rebuild groups from scratch (fresh copy from QBX), seed the active job (the
    -- copy can lack it), then filter.
    inventory.player.groups = QBX:GetGroups(source) or {}
    seedActiveGroups(inventory.player.groups, player.PlayerData)
    addShopGroups(inventory.player.groups)
    applyDutyFilter(inventory.player.groups, player.PlayerData)
end)

local function setupPlayer(playerData)
    playerData.identifier = playerData.citizenid
    playerData.name = ('%s %s'):format(playerData.charinfo.firstname, playerData.charinfo.lastname)
    server.setPlayerInventory(playerData)

    local accounts = Inventory.GetAccountItemCounts(playerData.source)
    if not accounts then return end
    for account in pairs(accounts) do
        local playerAccount = account == 'money' and 'cash' or account
        Inventory.SetItem(playerData.source, account, playerData.money[playerAccount])
    end
end

AddStateBagChangeHandler('loadInventory', nil, function(bagName, _, value)
    if not value then return end
    local plySrc = GetPlayerFromStateBagName(bagName)
    if not plySrc then return end
    setupPlayer(QBX:GetPlayer(plySrc).PlayerData)
end)

SetTimeout(500, function()
    local playersData = QBX:GetPlayersData()
    for i = 1, #playersData do setupPlayer(playersData[i]) end
end)

function server.UseItem(source, itemName, data)
    local cb = QBX:CanUseItem(itemName)
    return cb and cb(source, data)
end

---@diagnostic disable-next-line: duplicate-set-field
function server.setPlayerData(player)
    -- player here is the flattened PlayerData passed by setupPlayer above; it
    -- carries .job (active job) which applyDutyFilter needs. GetGroups can be
    -- stale on login (qbx restores the job without SetJob), so seed the active
    -- job/gang first — see seedActiveGroups.
    local groups = QBX:GetGroups(player.source) or {}
    seedActiveGroups(groups, player)
    addShopGroups(groups)
    applyDutyFilter(groups, player)
    return {
        source = player.source,
        name = ('%s %s'):format(player.charinfo.firstname, player.charinfo.lastname),
        groups = groups,
        sex = player.charinfo.gender,
        dateofbirth = player.charinfo.birthdate,
    }
end

---@diagnostic disable-next-line: duplicate-set-field
function server.syncInventory(inv)
    local accounts = Inventory.GetAccountItemCounts(inv)

    if not accounts then return end

    local player = QBX:GetPlayer(inv.id)
    player.Functions.SetPlayerData('items', inv.items)

    for account, amount in pairs(accounts) do
        account = account == 'money' and 'cash' or account
        if player.Functions.GetMoney(account) ~= amount then
            player.Functions.SetMoney(account, amount, ('Sync %s with inventory'):format(account))
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function server.hasLicense(inv, license)
    local player = QBX:GetPlayer(inv.id)
    if not player then return false end

    local licenseName = tostring(license or ''):lower()
    if licenseName == '' then return false end
    local aliasName = nil
    if licenseName == 'weapon' then aliasName = 'weapons'
    elseif licenseName == 'weapons' then aliasName = 'weapon' end

    local metadata = player.PlayerData.metadata or {}
    local licences = metadata.licences or {}
    local licenses = metadata.licenses or {}

    if licences[licenseName] or licenses[licenseName] or (aliasName and (licences[aliasName] or licenses[aliasName])) then
        return true
    end

    -- Fallback 1: DB metadata says license exists, but live metadata is stale.
    local metadataJson = MySQL.scalar.await('SELECT metadata FROM players WHERE citizenid = ? LIMIT 1', { player.PlayerData.citizenid })
    if metadataJson then
        local decoded = json.decode(metadataJson) or {}
        local dbLicences = decoded.licences or {}
        local dbLicenses = decoded.licenses or {}
        if dbLicences[licenseName] or dbLicenses[licenseName] or (aliasName and (dbLicences[aliasName] or dbLicenses[aliasName])) then
            licences[licenseName] = true
            licenses[licenseName] = true
            if aliasName then
                licences[aliasName] = true
                licenses[aliasName] = true
            end
            player.Functions.SetMetaData('licences', licences)
            player.Functions.SetMetaData('licenses', licenses)
            return true
        end
    end

    -- Fallback 2: atlas_mdt license table has active row.
    local hasActiveFromMdt = MySQL.scalar.await(
        'SELECT 1 FROM atlas_mdt_licenses WHERE citizenid = ? AND (license_type = ? OR license_type = ?) AND status = ? LIMIT 1',
        { player.PlayerData.citizenid, licenseName, aliasName or licenseName, 'active' }
    )

    if hasActiveFromMdt then
        licences[licenseName] = true
        licenses[licenseName] = true
        if aliasName then
            licences[aliasName] = true
            licenses[aliasName] = true
        end
        player.Functions.SetMetaData('licences', licences)
        player.Functions.SetMetaData('licenses', licenses)
        return true
    end

    return false
end

---@diagnostic disable-next-line: duplicate-set-field
function server.buyLicense(inv, license)
    local player = QBX:GetPlayer(inv.id)
    if not player then return end

    if player.PlayerData.metadata.licences[license.name] then
        return false, 'already_have'
    elseif Inventory.GetItem(inv, 'money', false, true) < license.price then
        return false, 'can_not_afford'
    end

    Inventory.RemoveItem(inv, 'money', license.price)

    -- Log the license spending to atlas_economy (RemoveItem fires as 'set', not counted in totals)
    pcall(function()
        exports.atlas_economy:logMoneyEvent(inv.id, 'cash', -license.price, 'remove', 'license-purchase:' .. license.name, 'ox_inventory')
    end)

    player.PlayerData.metadata.licences[license.name] = true
    player.Functions.SetMetaData('licences', player.PlayerData.metadata.licences)

    return true, 'have_purchased'
end

---@diagnostic disable-next-line: duplicate-set-field
function server.isPlayerBoss(playerId, group, grade)
    return QBX:IsGradeBoss(group, grade)
end

---@param entityId number
---@return number | string
---@diagnostic disable-next-line: duplicate-set-field
function server.getOwnedVehicleId(entityId)
    return Entity(entityId).state.vehicleid or exports.qbx_vehicles:GetVehicleIdByPlate(GetVehicleNumberPlateText(entityId))
end
