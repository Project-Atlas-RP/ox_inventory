if not lib then return end

local shopTypes = {}
local shops = {}
local modelShops = {}
local createBlip = require 'modules.utils.client'.CreateBlip
local ShopHours = require 'modules.shophours'

local function buildShopTypes(shopDefinitions)
	table.wipe(shopTypes)

	for shopType, shopData in pairs(shopDefinitions or {} --[[@as table<string, OxShop>]]) do
		local shop = {
			name = shopData.name,
			groups = shopData.groups or shopData.jobs,
			blip = shopData.blip,
			label = shopData.label,
			icon = shopData.icon,
			opens = shopData.opens,
			closes = shopData.closes,
			model = shopData.model,
			targets = shopData.targets,
			locations = shopData.locations,
		}

		shopTypes[shopType] = shop
		local blip = shop.blip

		if blip then
			blip.name = ('ox_shop_%s'):format(shopType)
			AddTextEntry(blip.name, shop.name or shopType)
		end
	end
end

buildShopTypes(lib.load('data.shops') or {})

---@param point CPoint
local function onEnterShop(point)
	-- Check if shop is open based on configured hours
	if point.opens or point.closes then
		local shopConfig = { opens = point.opens, closes = point.closes, name = point.type }
		if not ShopHours.isShopOpen(shopConfig) then
			return -- Don't spawn NPC if shop is closed
		end
	end

	if not point.entity then
		local model = lib.requestModel(point.ped or point.model)

		if not model then return end

		local entity
		if point.ped then
			entity = CreatePed(0, model, point.coords.x, point.coords.y, point.coords.z, point.heading, false, true)

			if point.scenario then TaskStartScenarioInPlace(entity, point.scenario, 0, true) end

			FreezeEntityPosition(entity, true)
			SetEntityInvincible(entity, true)
			SetBlockingOfNonTemporaryEvents(entity, true)
		else
			entity = CreateObjectNoOffset(model, point.coords.x, point.coords.y, point.coords.z, false, false, false)
			SetEntityHeading(entity, point.heading or 0.0)
			FreezeEntityPosition(entity, true)
		end

		SetModelAsNoLongerNeeded(model)

		local shopConfig = { opens = point.opens, closes = point.closes, name = point.type }
		local statusLabel = ShopHours.getShopStatus(shopConfig)
		local interactionLabel = statusLabel == 'Open' and point.label or ('CLOSED - %s'):format(statusLabel)

		exports.ox_target:addLocalEntity(entity, {
            {
                icon = point.icon or 'fas fa-shopping-basket',
                label = interactionLabel,
                groups = point.groups,
                onSelect = function()
					if ShopHours.isShopOpen(shopConfig) then
						client.openInventory('shop', { id = point.invId, type = point.type })
					else
						lib.notify({
							title = 'Shop Closed',
							description = ShopHours.getShopStatus(shopConfig),
							type = 'error'
						})
					end
                end,
                iconColor = point.iconColor,
                distance = point.shopDistance or 2.0
            }
		})

		point.entity = entity
	end
end

local Utils = require 'modules.utils.client'

local function onExitShop(point)
	local entity = point.entity

	if not entity then return end

	exports.ox_target:removeLocalEntity(entity)
	Utils.DeleteEntity(entity)

	point.entity = nil
end

local function hasShopAccess(shop)
	if shop.groups and not client.hasGroup(shop.groups) then
		return false
	end
	
	-- Check shop hours
	if shop.opens or shop.closes then
		return ShopHours.isShopOpen(shop)
	end
	
	return true
end

local function wipeShops()
	for i = 1, #modelShops do
		local modelShop = modelShops[i]
		exports.ox_target:removeModel(modelShop.models, modelShop.name)
	end

	table.wipe(modelShops)

	for i = 1, #shops do
		local shop = shops[i]

		if shop.zoneId then
            exports.ox_target:removeZone(shop.zoneId)
            shop.zoneId = nil
		end

		if shop.remove then
			if shop.entity then onExitShop(shop) end

			shop:remove()
		end

		if shop.blip then
			RemoveBlip(shop.blip)
		end
	end

	table.wipe(shops)
end

local function refreshShops()
	wipeShops()
	ShopHours.clearCache() -- Clear shop hours cache when refreshing

	local id = 0

	for type, shop in pairs(shopTypes) do
		local blip = shop.blip
		local label = shop.label or locale('open_label', shop.name)

		if shared.target then
			if shop.model and #shop.model > 0 then
				if not hasShopAccess(shop) then goto skipLoop end

				exports.ox_target:removeModel(shop.model, shop.name)
				exports.ox_target:addModel(shop.model, {
                    {
                        name = shop.name,
                        icon = shop.icon or 'fas fa-shopping-basket',
                        label = label,
                        onSelect = function()
                            client.openInventory('shop', { type = type })
                        end,
                        distance = 2
                    },
				})
				modelShops[#modelShops + 1] = {
					models = shop.model,
					name = shop.name,
				}
			elseif shop.targets and #shop.targets > 0 then
				for i = 1, #shop.targets do
					local target = shop.targets[i]
					local shopid = ('%s-%s'):format(type, i)

					if target.ped then
						id += 1

						shops[id] = lib.points.new({
							coords = target.loc,
							heading = target.heading,
							distance = 60,
							inv = 'shop',
							invId = i,
							type = type,
							blip = blip and hasShopAccess(shop) and createBlip(blip, target.loc),
							ped = target.ped,
							scenario = target.scenario,
							label = label,
							groups = shop.groups,
							icon = shop.icon or 'fas fa-shopping-basket',
							iconColor = target.iconColor,
							onEnter = onEnterShop,
							onExit = onExitShop,
							shopDistance = target.distance,
							opens = shop.opens,
							closes = shop.closes,
						})
					elseif target.model then
						id += 1

						shops[id] = lib.points.new({
							coords = target.loc,
							heading = target.heading or 0.0,
							distance = 60,
							inv = 'shop',
							invId = i,
							type = type,
							blip = blip and hasShopAccess(shop) and createBlip(blip, target.loc),
							model = target.model,
							label = label,
							groups = shop.groups,
							icon = shop.icon or 'fas fa-shopping-basket',
							iconColor = target.iconColor,
							onEnter = onEnterShop,
							onExit = onExitShop,
							shopDistance = target.distance,
							opens = shop.opens,
							closes = shop.closes,
						})
					else
						if not hasShopAccess(shop) then goto nextShop end

						id += 1

						shops[id] = {
							zoneId = Utils.CreateBoxZone(target, {
                                {
                                    name = shopid,
                                    icon = shop.icon or 'fas fa-shopping-basket',
                                    label = label,
                                    groups = shop.groups,
                                    onSelect = function()
                                        client.openInventory('shop', { id = i, type = type })
                                    end,
                                    iconColor = target.iconColor,
                                    distance = target.distance
                                }
                            }),
							blip = blip and createBlip(blip, target.coords)
						}
					end

					::nextShop::
				end
			elseif shop.locations and #shop.locations > 0 then
				if not hasShopAccess(shop) then goto skipLoop end

				for i = 1, #shop.locations do
					local coords = shop.locations[i]
					local shopid = ('%s-location-%s'):format(type, i)
					id += 1

					shops[id] = {
						zoneId = exports.ox_target:addSphereZone({
							coords = coords,
							radius = 0.8,
							debug = false,
							options = {
								{
									name = shopid,
									icon = shop.icon or 'fas fa-shopping-basket',
									label = label,
									groups = shop.groups,
									onSelect = function()
										client.openInventory('shop', { id = i, type = type })
									end,
									distance = 2.0,
								}
							}
						}),
						blip = blip and createBlip(blip, coords)
					}
				end
			end
		elseif shop.locations then
			if not hasShopAccess(shop) then goto skipLoop end
            local shopPrompt = { icon = 'fas fa-shopping-basket' }

			for i = 1, #shop.locations do
				local coords = shop.locations[i]
				id += 1

				shops[id] = lib.points.new(coords, 16, {
					coords = coords,
					distance = 16,
					inv = 'shop',
					invId = i,
					type = type,
                    marker = client.shopmarker,
                    prompt = {
                        options = shop.icon and { icon = shop.icon } or shopPrompt,
                        message = ('**%s**  \n%s'):format(label, locale('interact_prompt', GetControlInstructionalButton(0, 38, true):sub(3)))
                    },
					nearby = Utils.nearbyMarker,
					blip = blip and createBlip(blip, coords)
				})
			end
		end

		::skipLoop::
	end
end

-- Automatic shop hours management system
-- This checks frequently for in-game time changes and refreshes shops accordingly
local lastHour = GetClockHours()
CreateThread(function()
	while true do
		Wait(30000) -- Check every 30 seconds (in-game time changes faster)
		
		local currentHour = GetClockHours()
		if currentHour ~= lastHour then
			lastHour = currentHour
			print(('[ShopHours] In-game time changed to %d:00 - Refreshing shop availability'):format(currentHour))
			
			-- Check each shop individually to manage NPCs based on hours
			for i = 1, #shops do
				local shop = shops[i]
				if shop and (shop.opens or shop.closes) then
					local shopConfig = { opens = shop.opens, closes = shop.closes, name = shop.type }
					local isOpen = ShopHours.isShopOpen(shopConfig)
					
					-- If shop is now closed and has an NPC, remove it
					if not isOpen and shop.entity then
						onExitShop(shop)
						print(('[ShopHours] Removed NPC for closed shop: %s'):format(shop.type))
					-- If shop is now open and doesn't have an NPC, spawn it
					elseif isOpen and not shop.entity and shop.ped then
						onEnterShop(shop)
						print(('[ShopHours] Spawned NPC for opened shop: %s'):format(shop.type))
					end
				end
			end
		end
	end
end)

RegisterNetEvent('ox_inventory:shopsUpdated', function(shopDefinitions)
	buildShopTypes(shopDefinitions)
	refreshShops()
end)

CreateThread(function()
	local runtimeShopDefinitions = lib.callback.await('ox_inventory:getShopDefinitions', false)

	if type(runtimeShopDefinitions) == 'table' then
		buildShopTypes(runtimeShopDefinitions)
	end
end)

return {
	refreshShops = refreshShops,
	wipeShops = wipeShops,
}
