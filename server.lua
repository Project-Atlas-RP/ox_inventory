if not lib then return end

require 'modules.bridge.server'
require 'modules.crafting.server'
require 'modules.shops.server'
require 'modules.pefcl.server'

if GetConvar('inventory:versioncheck', 'true') == 'true' then
    lib.versionCheck('overextended/ox_inventory')
end

local TriggerEventHooks = require 'modules.hooks.server'
local db = require 'modules.mysql.server'
local Items = require 'modules.items.server'
local Inventory = require 'modules.inventory.server'
local Utils = require 'modules.utils.server'

---@param player table
---@param data table?
--- player requires source, identifier, and name
--- optionally, it should contain jobs/groups, sex, and dateofbirth
function server.setPlayerInventory(player, data)
    while not shared.ready do Wait(0) end

    if not data then
        data = db.loadPlayer(player.identifier)
    end

    local inventory = {}
    local totalWeight = 0

    if type(data) == 'table' then
        local ostime = os.time()

        for _, v in pairs(data) do
            if type(v) == 'number' or not v.count or not v.slot then
                if server.convertInventory then
                    inventory, totalWeight = server.convertInventory(player.source, data)
                    break
                else
                    return error(('Inventory for player.%s (%s) contains invalid data. Ensure you have converted inventories to the correct format.')
                    :format(player.source, GetPlayerName(player.source)))
                end
            else
                local item = Items(v.name)

                if item then
                    v.metadata = Items.CheckMetadata(v.metadata or {}, item, v.name, ostime)
                    local weight = Inventory.SlotWeight(item, v)
                    totalWeight = totalWeight + weight

                    inventory[v.slot] = { name = item.name, label = item.label, weight = weight, slot = v.slot, count = v
                    .count, description = item.description, metadata = v.metadata, stack = item.stack, close = item
                    .close }
                end
            end
        end
    end

    player.source = tonumber(player.source)
    local inv = Inventory.Create(player.source, player.name, 'player', shared.playerslots, totalWeight,
        shared.playerweight, player.identifier, inventory)

    if inv then
        inv.player = server.setPlayerData(player)
        inv.player.ped = GetPlayerPed(player.source)

        if server.syncInventory then server.syncInventory(inv) end
        TriggerClientEvent('ox_inventory:setPlayerInventory', player.source, Inventory.Drops, inventory, totalWeight,
            inv.player)
    end
end

exports('setPlayerInventory', server.setPlayerInventory)
AddEventHandler('ox_inventory:setPlayerInventory', server.setPlayerInventory)

local registeredDumpsters = {}

---@param coords vector3
---@return string?
local function getDumpsterIdFromCoords(coords)
	for id, dumpster in pairs(registeredDumpsters) do
		if #(coords - dumpster.coords) < 0.1 then
			return id
		end
	end
end

---@param playerPed number
---@param stash OxInventory
---@return vector3?
local function getClosestStashCoords(playerPed, stash)
    local playerCoords = GetEntityCoords(playerPed)
    local distance = stash.distance or 10
    local coordinates = stash.coords

    if not coordinates then return end

    if type(coordinates) == 'table' then
        for i = 1, #coordinates do
            local coords = coordinates[i] --[[@as vector3]]

            if #(coords - playerCoords) < distance then
                return coords
            end
        end

        return
    end

    return #(coordinates - playerCoords) < distance and coordinates or nil
end

---@param source number
---@param invType string
---@param data? string|number|table
---@param ignoreSecurityChecks boolean?
---@return table | false | nil, table | false | nil, string?
local function openInventory(source, invType, data, ignoreSecurityChecks)
    if Inventory.Lock then return false end

    local left = Inventory(source)
    local right, closestCoords

    if not left then return end

    left:closeInventory(true)
    Inventory.CloseAll(left, source)

    if invType == 'player' and data == source then
        data = nil
    end

    local playerPed = left.player.ped

    if data then
        local isDataTable = type(data) == 'table'

        if invType == 'stash' then
            right = Inventory(data, left, ignoreSecurityChecks)
            if right == false then return false end
        elseif isDataTable then
            if data.netid then
                local entity = NetworkGetEntityFromNetworkId(data.netid)

                if not entity then return end

                if not ignoreSecurityChecks then
                    if #(GetEntityCoords(playerPed) - GetEntityCoords(entity)) > 16 then return end
                end

                if invType == 'glovebox' then
                    if not ignoreSecurityChecks and GetVehiclePedIsIn(playerPed, false) ~= entity then
                        return
                    end
                end

                if invType == 'trunk' then
                    local lockStatus = ignoreSecurityChecks and 0 or GetVehicleDoorLockStatus(entity)

                    -- 0: no lock; 1: unlocked; 8: boot unlocked
                    if lockStatus > 1 and lockStatus ~= 8 then
                        return false, false, 'vehicle_locked'
                    end
                end

                local plate = (invType == 'glovebox' or invType == 'trunk') and GetVehicleNumberPlateText(entity)

                if plate then
                    if server.trimplate then plate = string.strtrim(plate) end

                    if not data.id then
                        data.id = (invType == 'glovebox' and 'glove' or 'trunk') .. plate
                    end
                end

                data.type = invType
                right = Inventory(data)

                if right and data.netid ~= right.netid then
                    local invEntity = NetworkGetEntityFromNetworkId(right.netid)

					if not (invEntity > 0 and DoesEntityExist(invEntity)) or (plate and not string.match(GetVehicleNumberPlateText(invEntity) or '', plate)) then
						Inventory.Remove(right)
						right = Inventory(data)
					end
				end
			elseif invType == 'drop' then
				right = Inventory(data.id)
			else
				return
			end
		elseif invType == 'policeevidence' then
			if ignoreSecurityChecks or server.hasGroup(left, shared.police) then
				right = Inventory(('evidence-%s'):format(data))
			end
		elseif invType == 'dumpster' then
			-- Treat dumpsters like temporary drops with refill cooldown
			-- data can be a string ID (e.g. 'dumpster12345' when networkdumpsters is off)
			-- or a vector3 coords (when networkdumpsters is on)
			local isCoords = type(data) ~= 'string'
			local dumpsterId

			if isCoords then
				-- Coords-based lookup (networkdumpsters enabled)
				dumpsterId = getDumpsterIdFromCoords(data)
			else
				-- String-based ID (networkdumpsters disabled) - use the string directly
				-- Check if an inventory already exists with this ID
				local existing = Inventory(data)
				if existing then
					dumpsterId = data
				end
			end

			if not dumpsterId then
				-- Create new dumpster inventory with random refill cooldown
				local refillCooldown = math.random(server.dumpsterRefillMin, server.dumpsterRefillMax)
				if isCoords then
					dumpsterId = ('dumpster-%s'):format(math.random(100000, 999999))
				else
					dumpsterId = data
				end
				right = Inventory.Create(dumpsterId, locale('dumpster'), invType, 15, 0, 100000, false)
				if isCoords then
					registeredDumpsters[dumpsterId] = { coords = data, lastRefill = os.time(), cooldown = refillCooldown }
				else
					registeredDumpsters[dumpsterId] = { id = data, lastRefill = os.time(), cooldown = refillCooldown }
				end
			else
				right = Inventory(dumpsterId)

				if right then
					local dumpster = registeredDumpsters[dumpsterId]
					local isEmpty = (type(right.items) ~= 'table') or not next(right.items)

					-- Refill if empty and cooldown has passed (default 10-15 min)
					if dumpster then
						local cooldown = dumpster.cooldown or math.random(server.dumpsterRefillMin, server.dumpsterRefillMax)
						if isEmpty and (os.time() - (dumpster.lastRefill or 0)) >= cooldown then
							local ok, items, weight = pcall(Inventory.Load, dumpsterId, invType, false)
							if ok then
								right.items = items or {}
								right.weight = weight or 0
								dumpster.lastRefill = os.time()
								-- Randomize cooldown for next refill
								dumpster.cooldown = math.random(server.dumpsterRefillMin, server.dumpsterRefillMax)
							else
								-- If loot generation fails for any reason, don't block opening.
								right.items = right.items or {}
								right.weight = right.weight or 0
							end
						end
					end
				end
			end
		elseif invType == 'container' then
			left.containerSlot = data --[[@as number]]
			data = left.items[data]

            if data then
                right = Inventory(data.metadata.container)

                if not right then
                    right = Inventory.Create(data.metadata.container, data.label, invType, data.metadata.size[1], 0,
                        data.metadata.size[2], false)
                end
            else
                left.containerSlot = nil
            end
        else
            right = Inventory(data)
        end

        if not right then return end

        -- Security check to make sure the requested inventory type is the same as the found inventory
        -- Only case where a missmatch is tolerated is for temporary stashes
        if right.type ~= invType and not (right.type == 'temp' and invType == 'stash') then
            Utils.LogExploit(source, 'openInventory', 'Attempted to open inventory with invalid inventory type.', true)
            return
        end

        if not ignoreSecurityChecks then
            local playerState = Player(source).state

            if right.groups and not server.hasGroup(left, right.groups) then return end
            if right.instance and playerState.instance ~= right.instance then return end
        end

        local hookPayload = {
            source = source,
            inventoryId = right.id,
            inventoryType = right.type,
        }

        if invType == 'container' then hookPayload.slot = left.containerSlot end

        if isDataTable and data.netid then hookPayload.netId = data.netid end

        if left == right then return end

        if right.player then
            if right.open then return end

            right.coords = not ignoreSecurityChecks and GetEntityCoords(right.player.ped) or nil
        end

        if not ignoreSecurityChecks and right.coords then
            closestCoords = getClosestStashCoords(playerPed, right)

            if not closestCoords then return end
        end

        local hooks <close> = TriggerEventHooks('openInventory', hookPayload)

        if not hooks.success then return end
    end

    left:openInventory(right)

    return {
        id = left.id,
        label = left.label,
        type = left.type,
        slots = left.slots,
        weight = left.weight,
        maxWeight = left.maxWeight
    }, right and {
        id = right.id,
        label = right.player and '' or right.label,
        type = right.player and 'otherplayer' or right.type,
        slots = right.slots,
        weight = right.weight,
        maxWeight = right.maxWeight,
        items = right.items,
        coords = closestCoords or right.coords,
        distance = right.distance,
        instance = right.instance
    }
end

---@param source number
---@param invType string
---@param data string|number|table
lib.callback.register('ox_inventory:openInventory', function(source, invType, data)
    if invType == 'player' and source ~= data then
        local serverId = type(data) == 'table' and data.id or data

        if source == serverId or type(serverId) ~= 'number' then return end

        local left = Inventory(source)
        if not left then return end

        local isPolice = server.hasGroup(left, shared.police)
        local isTargetStealable = Player(serverId).state.canSteal

        if not isPolice and not isTargetStealable then return end
    end

    return openInventory(source, invType, data)
end)

---@param netId number
lib.callback.register('ox_inventory:isVehicleATrailer', function(source, netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    local retval = GetVehicleType(entity)
    return retval == 'trailer'
end)

---@param playerId number
---@param invType string
---@param data string|number|table
function server.forceOpenInventory(playerId, invType, data)
    local left, right = openInventory(playerId, invType, data, true)

    if left and right then
        TriggerClientEvent('ox_inventory:forceOpenInventory', playerId, left, right)
        return right.id
    end
end

exports('forceOpenInventory', server.forceOpenInventory)

local Licenses = lib.load('data.licenses')

lib.callback.register('ox_inventory:buyLicense', function(source, id)
    local license = Licenses[id]
    if not license then return end

    local inventory = Inventory(source)
    if not inventory then return end

    return server.buyLicense(inventory, license)
end)

lib.callback.register('ox_inventory:getItemCount', function(source, item, metadata, target)
    local inventory = target and Inventory(target) or Inventory(source)
    return (inventory and Inventory.GetItemCount(inventory, item, metadata, true))
end)

lib.callback.register('ox_inventory:getInventory', function(source, id)
    local inventory = Inventory(id or source)
    return inventory and {
        id = inventory.id,
        label = inventory.label,
        type = inventory.type,
        slots = inventory.slots,
        weight = inventory.weight,
        maxWeight = inventory.maxWeight,
        owned = inventory.owner and true or false,
        items = inventory.items
    }
end)

RegisterNetEvent('ox_inventory:usedItemInternal', function(slot)
    local inventory = Inventory(source)

    if not inventory then return end

    local item = inventory.usingItem

    if not item or item.slot ~= slot then
        Utils.LogExploit(inventory.id, 'usedItemInternal', 'Triggered internal event.', true)
        return
    end

    TriggerEvent('ox_inventory:usedItem', inventory.id, item.name, item.slot, next(item.metadata) and item.metadata)

    inventory.usingItem = nil
end)

local GetLocks = require 'modules.locks'

---@param source number
---@param itemName string
---@param slot number?
---@param metadata { [string]: any }?
---@return table | boolean | nil
lib.callback.register('ox_inventory:useItem', function(source, itemName, slot, metadata, noAnim)
    local inventory = Inventory(source)

    if inventory and inventory.player then
        local item = Items(itemName)
        local data = item and
        (slot and inventory.items[slot] or Inventory.GetSlotWithItem(inventory, item.name, metadata, true))

        if not data then return end

        slot = data.slot
        local durability = data.metadata.durability --[[@as number|boolean|nil]]
        local consume = item.consume
        local label = data.metadata.label or item.label

        if durability and consume then
            if durability > 100 then
                local ostime = os.time()

                if ostime > durability then
                    Items.UpdateDurability(inventory, data, item, 0)
                    return TriggerClientEvent('ox_lib:notify', source,
                        { type = 'error', description = locale('no_durability', label) })
                elseif consume ~= 0 and consume < 1 then
                    local degrade = (data.metadata.degrade or item.degrade) * 60
                    local percentage = ((durability - ostime) * 100) / degrade

                    if percentage < consume * 100 then
                        return TriggerClientEvent('ox_lib:notify', source,
                            { type = 'error', description = locale('not_enough_durability', label) })
                    end
                end
            elseif durability <= 0 then
                return TriggerClientEvent('ox_lib:notify', source,
                    { type = 'error', description = locale('no_durability', label) })
            elseif consume ~= 0 and consume < 1 and durability < consume * 100 then
                return TriggerClientEvent('ox_lib:notify', source,
                    { type = 'error', description = locale('not_enough_durability', label) })
            end

            if data.count > 1 and consume < 1 and consume > 0 and not Inventory.GetEmptySlot(inventory) then
                return TriggerClientEvent('ox_lib:notify', source,
                    { type = 'error', description = locale('cannot_use', label) })
            end
        end

        if item and data and data.count > 0 and data.name == item.name then
            local activeSlots <close> = GetLocks({
                ('inventory-%s:slot-%s'):format(inventory.id, slot),
            })

    		if not activeSlots then return end

            data = { name = data.name, label = label, count = data.count, slot = slot, metadata = data.metadata, weight =
            data.weight }

            if item.ammo then
                if inventory.weapon then
                    local weapon = inventory.items[inventory.weapon]

                    if weapon and weapon?.metadata.durability > 0 then
                        consume = nil
                    end
                else
                    return false
                end
            elseif item.component or item.tint then
                consume = 1
                data.component = true
            elseif consume then
                if data.count >= consume then
                    local result = item.cb and item.cb('usingItem', item, inventory, slot)

                    if result == false then return end

                    if result ~= nil then
                        data.server = result
                    end
                else
                    return TriggerClientEvent('ox_lib:notify', source,
                        { type = 'error', description = locale('item_not_enough', item.name) })
                end
            elseif not item.weapon and server.UseItem then
                inventory.usingItem = data
                -- This is used to call an external useItem function, i.e. ESX.UseItem
                -- If an error is being thrown on item use there is no internal solution. We previously kept a list
                -- of usable items which led to issues when restarting resources (for obvious reasons), but config
                -- developers complained the inventory broke their items. Safely invoking registered item callbacks
                -- should resolve issues, i.e. https://github.com/esx-framework/esx-legacy/commit/9fc382bbe0f5b96ff102dace73c424a53458c96e
                return pcall(server.UseItem, source, data.name, data)
            end

            data.consume = consume

            local hooks <close> = TriggerEventHooks('usingItem', {
                source = source,
                inventoryId = inventory and inventory.id,
                item = inventory.items[slot],
                consume = consume
            })

            if not hooks.success then return false end

            ---@type boolean
            local success = lib.callback.await('ox_inventory:usingItem', source, data, noAnim)

            if item.weapon then
                inventory.weapon = success and slot or nil
            end

            if not success then hooks.success = false return end

            inventory.usingItem = data

            if consume and consume ~= 0 and not data.component then
                data = inventory.items[data.slot]

                if not data then hooks.success = false return end

                durability = consume ~= 0 and consume < 1 and data.metadata.durability --[[@as number | false]]

                if durability then
                    if durability > 100 then
                        local degrade = (data.metadata.degrade or item.degrade) * 60
                        durability -= degrade * consume
                    else
                        durability -= consume * 100
                    end

                    if data.count > 1 then
                        local emptySlot = Inventory.GetEmptySlot(inventory)

                        if emptySlot then
                            local newItem = Inventory.SetSlot(inventory, item, 1, table.deepclone(data.metadata),
                                emptySlot)

                            if newItem then
                                Items.UpdateDurability(inventory, newItem, item, durability)
                            end
                        end

                        durability = 0
                    else
                        Items.UpdateDurability(inventory, data, item, durability)
                    end

                    if durability <= 0 then
                        durability = false
                    end
                end

                if not durability then
                    Inventory.RemoveItem(inventory.id, data.name, consume < 1 and 1 or consume, nil, data.slot)
                else
                    inventory.changed = true

                    if server.syncInventory then server.syncInventory(inventory) end
                end

                if item?.cb then
                    item.cb('usedItem', item, inventory, data.slot)
                end
            end

            return true
        end
    end
end)

local function conversionScript()
    shared.ready = false

    local file = 'setup/convert.lua'
    local import = LoadResourceFile(shared.resource, file)
    local func = load(import, ('@@%s/%s'):format(shared.resource, file)) --[[@as function]]

    conversionScript = func()
end

RegisterCommand('convertinventory', function(source, args)
    if source ~= 0 then return warn('This command can only be executed with the server console.') end
    if type(conversionScript) == 'function' then conversionScript() end
    local arg = args[1]

    local convert = arg and conversionScript[arg]

    if not convert then
        return warn('Invalid conversion argument. Valid options: esx, esxproperty')
    end

    CreateThread(convert)
end, true)


lib.addCommand({ 'additem', 'giveitem' }, {
    help = 'Gives an item to a player with the given id',
    params = {
        { name = 'target', type = 'playerId',                              help = 'The player to receive the item' },
        { name = 'item',   type = 'string',                                help = 'The name of the item' },
        { name = 'count',  type = 'number',                                help = 'The amount of the item to give', optional = true },
        { name = 'type',   help = 'Sets the "type" metadata to the value', optional = true },
    },
    restricted = 'group.admin',
}, function(source, args)
    local item = Items(args.item)

    if item then
        local inventory = Inventory(args.target) --[[@as OxInventory]]
        local count = args.count and math.max(args.count, 1) or 1

		-- Admin commands bypass weight limit (ignoreWeight = true) and prevent drop (preventDrop = true)
		local success, response = Inventory.AddItem(inventory, item.name, count, args.type and { type = tonumber(args.type) or args.type }, nil, nil, true, true)

        if not success then
            return Citizen.Trace(('Failed to give %sx %s to player %s (%s)'):format(count, item.name, args.target,
                response))
        end

        source = Inventory(source) or { label = 'console', owner = 'console' }

		if server.loglevel > 0 then
			lib.logger(source.owner, 'admin', ('"%s" gave %sx %s to "%s"'):format(source.label, count, item.name, inventory.label))
		end
		pcall(function()
			local adminId = type(source) == 'table' and source.id or nil
			exports.atlas_logs:log('Inventory', 'Admin Item Given', (source.label or 'console') .. ' gave ' .. count .. 'x ' .. (item.label or item.name) .. ' to ' .. inventory.label, 'warning', adminId, {
				items = {{ name = item.name, label = item.label, count = count }},
				targetPlayers = inventory.player and { inventory.id } or nil
			})
		end)
	end
end)

lib.addCommand('removeitem', {
    help = 'Removes an item to a player with the given id',
    params = {
        { name = 'target', type = 'playerId',                                          help = 'The player to remove the item from' },
        { name = 'item',   type = 'string',                                            help = 'The name of the item' },
        { name = 'count',  type = 'number',                                            help = 'The amount of the item to take',    optional = true },
        { name = 'type',   help = 'Only remove items with a matching metadata "type"', optional = true },
    },
    restricted = 'group.admin',
}, function(source, args)
    local item = Items(args.item)

    if item then
        local inventory = Inventory(args.target) --[[@as OxInventory]]
        local count = args.count and math.max(args.count, 1) or 1

        local success, response = Inventory.RemoveItem(inventory, item.name, count,
            args.type and { type = tonumber(args.type) or args.type }, nil, true)

        if not success then
            return Citizen.Trace(('Failed to remove %sx %s from player %s (%s)'):format(count, item.name, args.target,
                response))
        end

        source = Inventory(source) or { label = 'console', owner = 'console' }

		if server.loglevel > 0 then
			lib.logger(source.owner, 'admin', ('"%s" removed %sx %s from "%s"'):format(source.label, count, item.name, inventory.label))
		end
		pcall(function()
			local adminId = type(source) == 'table' and source.id or nil
			exports.atlas_logs:log('Inventory', 'Admin Item Removed', (source.label or 'console') .. ' removed ' .. count .. 'x ' .. (item.label or item.name) .. ' from ' .. inventory.label, 'warning', adminId, {
				items = {{ name = item.name, label = item.label, count = count }},
				targetPlayers = inventory.player and { inventory.id } or nil
			})
		end)
	end
end)

lib.addCommand('setitem', {
    help = 'Sets the item count for a player, removing or adding as needed',
    params = {
        { name = 'target', type = 'playerId',                                     help = 'The player to set the items for' },
        { name = 'item',   type = 'string',                                       help = 'The name of the item' },
        { name = 'count',  type = 'number',                                       help = 'The amount of items to set',     optional = true },
        { name = 'type',   help = 'Add or remove items with the metadata "type"', optional = true },
    },
    restricted = 'group.admin',
}, function(source, args)
    local item = Items(args.item)

    if item then
        local inventory = Inventory(args.target) --[[@as OxInventory]]
        local count = args.count and math.max(args.count, 0) or 0

        local success, response = Inventory.SetItem(inventory, item.name, count or 0,
            args.type and { type = tonumber(args.type) or args.type })

        if not success then
            return Citizen.Trace(('Failed to set %s count to %sx for player %s (%s)'):format(item.name, count,
                args.target, response))
        end

        source = Inventory(source) or { label = 'console', owner = 'console' }

		if server.loglevel > 0 then
			lib.logger(source.owner, 'admin', ('"%s" set "%s" %s count to %sx'):format(source.label, inventory.label, item.name, count))
		end
		pcall(function()
			local adminId = type(source) == 'table' and source.id or nil
			exports.atlas_logs:log('Inventory', 'Admin Item Set', (source.label or 'console') .. ' set ' .. inventory.label .. ' ' .. (item.label or item.name) .. ' count to ' .. count, 'warning', adminId, {
				items = {{ name = item.name, label = item.label, count = count }},
				targetPlayers = inventory.player and { inventory.id } or nil
			})
		end)
	end
end)

lib.addCommand('clearevidence', {
    help = 'Clears a police evidence locker with the given id',
    params = {
        { name = 'locker', type = 'number', help = 'The locker id to clear' },
    },
}, function(source, args)
    if not server.isPlayerBoss then return end

    local inventory = Inventory(source)
    if not inventory then return end

    local group, grade = server.hasGroup(inventory, shared.police)
    local hasPermission = group and server.isPlayerBoss(source, group, grade)

    if hasPermission then
        MySQL.query('DELETE FROM ox_inventory WHERE name = ?', { ('evidence-%s'):format(args.locker) })
    end
end)

lib.addCommand('takeinv', {
    help = 'Confiscates the target inventory, to restore with /restoreinv',
    params = {
        { name = 'target', type = 'playerId', help = 'The player to confiscate items from' },
    },
    restricted = 'group.admin',
}, function(source, args)
    Inventory.Confiscate(args.target)
end)

lib.addCommand({ 'restoreinv', 'returninv' }, {
    help = 'Restores a previously confiscated inventory for the target',
    params = {
        { name = 'target', type = 'playerId', help = 'The player to restore items to' },
    },
    restricted = 'group.admin',
}, function(source, args)
    Inventory.Return(args.target)
end)

-- Dynamic Item Replacement System
local function processItemReplacement(playerId, itemData)
    if not itemData.onUse then return end
    
    local onUse = itemData.onUse
    
    -- Handle different onUse configurations
    if onUse.giveItem then
        local giveItemData = onUse.giveItem
        local itemName = giveItemData.name or giveItemData
        local count = giveItemData.count or 1
        local metadata = giveItemData.metadata
        
        -- Add the replacement item to player inventory
        local success, response = Inventory.AddItem(playerId, itemName, count, metadata)
        
        if not success then
            -- If inventory is full, try to drop the item on the ground
            local playerPos = GetEntityCoords(GetPlayerPed(playerId))
            if playerPos then
                exports.ox_inventory:CustomDrop('replacement', {
                    {name = itemName, count = count, metadata = metadata}
                }, playerPos, 1, 1000)
            end
        end
    end
    
    -- Handle multiple replacement items
    if onUse.giveItems then
        for _, giveItemData in ipairs(onUse.giveItems) do
            local itemName = giveItemData.name
            local count = giveItemData.count or 1
            local metadata = giveItemData.metadata
            
            local success, response = Inventory.AddItem(playerId, itemName, count, metadata)
            
            if not success then
                local playerPos = GetEntityCoords(GetPlayerPed(playerId))
                if playerPos then
                    exports.ox_inventory:CustomDrop('replacement', {
                        {name = itemName, count = count, metadata = metadata}
                    }, playerPos, 1, 1000)
                end
            end
        end
    end
    
    -- Handle custom functions
    if onUse.customFunction and type(onUse.customFunction) == 'function' then
        onUse.customFunction(playerId, itemData)
    end
end

-- Hook into the usedItem event to process replacements
AddEventHandler('ox_inventory:usedItem', function(playerId, itemName, slotId, metadata)
    local item = Items(itemName)
    if item and item.onUse then
        processItemReplacement(playerId, item)
    end
end)

lib.addCommand('clearinv', {
    help = 'Wipes all items from the target inventory',
    params = {
        { name = 'invId', help = 'The inventory to wipe items from' },
    },
    restricted = 'group.admin',
}, function(source, args)
    Inventory.Clear(tonumber(args.invId) or args.invId == 'me' and source or args.invId)
end)

lib.addCommand('saveinv', {
    help = 'Save all pending inventory changes to the database',
    params = {
        { name = 'lock', help = 'Lock inventory access, until restart or saved without a lock', optional = true },
    },
    restricted = 'group.admin',
}, function(source, args)
    Inventory.SaveInventories(args.lock == 'true', false)
end)

lib.addCommand('viewinv', {
    help = 'Inspect the target inventory without allowing interactions',
    params = {
        { name = 'invId', help = 'The inventory to inspect' },
    },
    restricted = 'group.admin',
}, function(source, args)
    Inventory.InspectInventory(source, tonumber(args.invId) or args.invId)
end)

-- Dynamic Alcohol system integration
exports('alcohol', function(event, item, inventory, slot, data)
    if event == 'usingItem' then
        -- Get alcohol level from item's client data, default to 1.0 if not specified
        local alcoholLevel = item.client and item.client.alcoholLevel or 1.0
        
        -- Use the existing alcohol callback system
        local success = lib.callback.await('consumables:client:DrinkAlcohol', inventory.id, alcoholLevel)
        
        if success then
            return true -- Item was consumed successfully
        else
            return false -- Consumption was cancelled, don't remove item
        end
    end
end)

-- Atlas RP: UI Settings persistence (zoom, window positions)
-- Create table if not exists on resource start
MySQL.ready(function()
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `ox_inventory_uisettings` (
            `identifier` VARCHAR(60) NOT NULL,
            `settings` LONGTEXT NULL,
            PRIMARY KEY (`identifier`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
    ]])
end)

RegisterNetEvent('ox_inventory:saveUISettings', function(data)
    local source = source
    local player = exports.qbx_core:GetPlayer(source)
    if not player then return end
    
    local identifier = player.PlayerData.citizenid
    local settings = json.encode(data)
    
    MySQL.insert('INSERT INTO ox_inventory_uisettings (identifier, settings) VALUES (?, ?) ON DUPLICATE KEY UPDATE settings = ?', {
        identifier, settings, settings
    })
end)

lib.callback.register('ox_inventory:loadUISettings', function(source)
    local player = exports.qbx_core:GetPlayer(source)
    if not player then return {} end
    
    local identifier = player.PlayerData.citizenid
    local result = MySQL.scalar.await('SELECT settings FROM ox_inventory_uisettings WHERE identifier = ?', { identifier })
    
    if result then
        return json.decode(result) or {}
    end
    
    return {}
end)

-------------------------------
-- Gun Rack (emergency vehicles)
-------------------------------

do
    local GunRack = lib.load('data.gunrack')
    local startSlot = GunRack.gunRackStartSlot

    -- Build uppercase lookup of allowed weapons
    local allowedUpper = {}
    for weapon in pairs(GunRack.allowedWeapons) do
        allowedUpper[weapon:upper()] = true
    end

    ---@param invId string|number
    ---@return boolean
    local function isGunRackGlovebox(invId)
        if type(invId) ~= 'string' or not invId:find('^glove') then return false end
        local inv = Inventory(invId)
        return inv ~= nil and inv.type == 'glovebox' and inv.slots >= (startSlot + 1)
    end

    ---@param slot table|number
    ---@return number
    local function getSlotNumber(slot)
        return type(slot) == 'table' and slot.slot or slot
    end

    exports.ox_inventory:registerHook('swapItems', function(payload)
        local src = payload.source
        local toInvId = type(payload.toInventory) == 'string' and payload.toInventory or tostring(payload.toInventory)
        local fromInvId = type(payload.fromInventory) == 'string' and payload.fromInventory or tostring(payload.fromInventory)

        local toIsGunRack = isGunRackGlovebox(toInvId)
        local fromIsGunRack = isGunRackGlovebox(fromInvId)

        if not toIsGunRack and not fromIsGunRack then return end

        -- Check if interaction involves a gun rack slot
        local toSlotNum = getSlotNumber(payload.toSlot)
        local fromSlotNum = type(payload.fromSlot) == 'table' and payload.fromSlot.slot or nil

        local touchesGunRackSlot = (toIsGunRack and toSlotNum >= startSlot)
            or (fromIsGunRack and fromSlotNum and fromSlotNum >= startSlot)

        if not touchesGunRackSlot then return end

        -- Gun rack slots require on-duty LEO
        local player = exports.qbx_core:GetPlayer(src)
        if not player then return false end

        local job = player.PlayerData.job
        if not job or job.type ~= 'leo' or not job.onduty then
            if src then
                exports.qbx_core:Notify(src, 'Only on-duty law enforcement can use the gun rack.', 'error')
            end
            return false
        end

        -- Items going INTO gun rack slots must be allowed weapons
        if toIsGunRack and toSlotNum >= startSlot then
            local item = payload.fromSlot
            if not item or type(item) ~= 'table' then return false end

            local itemName = (item.name or ''):upper()
            if not allowedUpper[itemName] then
                exports.qbx_core:Notify(src, 'Only rifles and shotguns can be stored in the gun rack.', 'error')
                return false
            end
        end
    end, {
        print = false,
    })
end
