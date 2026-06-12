AddStateBagChangeHandler('isLoggedIn', ('player:%s'):format(cache.serverId), function(_, _, value)
    if not value then client.onLogout() end
end)

-- Synthetic shop groups (mirror of the server bridge in modules/bridge/qbx/server.lua)
-- so the police armoury / medicine cabinet shop targets + blips stay visible while
-- off duty. Client groups are never duty-stripped, so recomputing here matches the
-- server's off-duty shop access. Keep SHOP_GROUP_FOR_JOB in sync with the server.
local SHOP_GROUP_FOR_JOB = {
    police = 'police_armoury',
    bcso = 'police_armoury',
    sasp = 'police_armoury',
    ambulance = 'medical_cabinet',
}

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
        -- Only set/raise — never clear. The server sets these duty-INDEPENDENTLY
        -- at load (server.setPlayerData), but the client's real job group IS
        -- duty-stripped, so a plain recompute here would wipe police_armoury /
        -- medical_cabinet whenever ANY group update fires while off duty (or the
        -- duty-stripped state), breaking armoury/medicine access until /setjob.
        if computed[shopGroup] ~= nil then
            groups[shopGroup] = computed[shopGroup]
        end
    end
    return groups
end

RegisterNetEvent('qbx_core:client:onGroupUpdate', function(groupName, groupGrade)
    local groups = PlayerData.groups
    if not groupGrade then
        groups[groupName] = nil
    else
        groups[groupName] = groupGrade
    end
    addShopGroups(groups)
    client.setPlayerData('groups', groups)
end)

RegisterNetEvent('qbx_core:client:setGroups', function(groups)
    addShopGroups(groups)
    client.setPlayerData('groups', groups)
end)

---@diagnostic disable-next-line: duplicate-set-field
function client.setPlayerStatus(values)
    local playerState = LocalPlayer.state
    for name, value in pairs(values) do
        -- compatibility for ESX style values
        if value > 100 or value < -100 then
            value = value * 0.0001
        end

        playerState:set(name, lib.math.clamp(playerState[name] + value, 0, 100), true)
    end
end
