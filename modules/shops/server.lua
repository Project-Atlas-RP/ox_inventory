if not lib then return end

local Items = require 'modules.items.server'
local Inventory = require 'modules.inventory.server'
local ShopHours = require 'modules.shophours'
local TriggerEventHooks = require 'modules.hooks.server'
local Shops = {}
local locations = shared.target and 'targets' or 'locations'
local defaultShopDefinitions = lib.load('data.shops') or {}
local runtimeShopDefinitions = {}

local function deepCopy(value)
	if type(value) ~= 'table' then return value end

	local copy = {}

	for key, nestedValue in pairs(value) do
		copy[key] = deepCopy(nestedValue)
	end

	return copy
end

---@param meta1 table
---@param meta2 table
---@return boolean blocked true if stacking should be blocked
local function hasDifferentDurability(meta1, meta2)
	local dur1 = meta1.durability
	local dur2 = meta2.durability
	return dur1 ~= nil and dur2 ~= nil and dur1 ~= dur2
end

---@class OxShopItem
---@field slot number
---@field weight number

local function setupShopItems(id, shopType, shopName, groups)
	local shop = id and Shops[shopType][id] or Shops[shopType] --[[@as OxShop]]

	for i = 1, shop.slots do
		local slot = shop.items[i]

		if slot.grade and not groups then
			print(('^1attempted to restrict slot %s (%s) to grade %s, but %s has no job restriction^0'):format(id, slot.name, json.encode(slot.grade), shopName))
			slot.grade = nil
		end

		local Item = Items(slot.name)

		if Item then
			-- Determine currency symbol for UI display
			local currencySymbol = '$'
			if slot.currency == 'prison_credits' then
				currencySymbol = '⃀'
			elseif slot.currency and slot.currency ~= 'money' then
				local currencyItem = Items(slot.currency)
				currencySymbol = currencyItem and currencyItem.label or slot.currency
			end
			
			---@type OxShopItem
			slot = {
				name = Item.name,
				slot = i,
				weight = Item.weight,
				count = slot.count,
				price = (server.randomprices and (not slot.currency or slot.currency == 'money')) and (math.ceil(slot.price * (math.random(80, 120)/100))) or slot.price or 0,
				metadata = slot.metadata,
				license = slot.license,
				currency = slot.currency,
				currencySymbol = currencySymbol,
				grade = slot.grade,
				requiresItem = slot.requiresItem,
				requiresCount = slot.requiresCount,
			}

			if slot.metadata then
				slot.weight = Inventory.SlotWeight(Item, slot, true)
			end

			shop.items[i] = slot
		end
	end
end

local function canViewShopItem(inv, shopItem)
	local requiredItem = type(shopItem) == 'table' and shopItem.requiresItem or nil
	if type(requiredItem) ~= 'string' or requiredItem == '' then
		return true
	end

	local requiredCount = math.max(1, math.floor(tonumber(shopItem.requiresCount) or 1))
	return Inventory.GetItemCount(inv, requiredItem) >= requiredCount
end

local function buildVisibleShop(shop, inv)
	local visibleItems = {}
	local slotMap = {}
	local visibleSlot = 0

	for actualSlot = 1, shop.slots do
		local shopItem = shop.items[actualSlot]
		if shopItem and canViewShopItem(inv, shopItem) then
			visibleSlot += 1
			local visibleItem = deepCopy(shopItem)
			visibleItem.slot = visibleSlot
			visibleItems[visibleSlot] = visibleItem
			slotMap[visibleSlot] = actualSlot
		end
	end

	local visibleShop = table.clone(shop)
	visibleShop.items = visibleItems
	visibleShop.slots = visibleSlot

	return visibleShop, slotMap
end

---@param shopType string
---@param properties OxShop
local function registerShopType(shopType, properties)
	local shopLocations = properties[locations] or properties.locations

	if shopLocations then
		Shops[shopType] = properties
		-- Store shop hours information
		Shops[shopType].opens = properties.opens
		Shops[shopType].closes = properties.closes
	else
		Shops[shopType] = {
			label = properties.name,
			id = shopType,
			groups = properties.groups or properties.jobs,
			items = properties.inventory,
			slots = #properties.inventory,
			type = 'shop',
			opens = properties.opens,
			closes = properties.closes,
		}

		setupShopItems(nil, shopType, properties.name, properties.groups or properties.jobs)
	end
end

---@param shopType string
---@param id number
local function createShop(shopType, id)
	local shop = Shops[shopType]

	if not shop then return end

	local store = (shop[locations] or shop.locations)?[id]

	if not store then return end

	local groups = shop.groups or shop.jobs
    local coords

    if shared.target then
        if store.length then
            local z = store.loc.z + math.abs(store.minZ - store.maxZ) / 2
            coords = vec3(store.loc.x, store.loc.y, z)
		elseif type(store) == 'vector3' then
			coords = store
        else
            coords = store.coords or store.loc
        end
    else
        coords = store
    end

	shop[id] = {
		label = shop.name,
		id = shopType..' '..id,
		groups = groups,
		items = table.clone(shop.inventory),
		slots = #shop.inventory,
		type = 'shop',
		coords = coords,
		distance = shared.target and shop.targets?[id]?.distance,
		opens = shop.opens,
		closes = shop.closes,
	}

	setupShopItems(id, shopType, shop.name, groups)

	return shop[id]
end

local function replaceShopDefinitions(shopDefinitions)
	table.wipe(Shops)
	runtimeShopDefinitions = deepCopy(shopDefinitions or defaultShopDefinitions)

	for shopType, shopDetails in pairs(runtimeShopDefinitions) do
		registerShopType(shopType, shopDetails)
	end
end

replaceShopDefinitions(defaultShopDefinitions)

---@param shopType string
---@param shopDetails OxShop
exports('RegisterShop', function(shopType, shopDetails)
	runtimeShopDefinitions[shopType] = deepCopy(shopDetails)
	registerShopType(shopType, shopDetails)
end)

exports('GetShopDefinitions', function()
	return deepCopy(runtimeShopDefinitions)
end)

exports('ApplyShopDefinitions', function(shopDefinitions)
	replaceShopDefinitions(shopDefinitions)
	TriggerClientEvent('ox_inventory:shopsUpdated', -1, deepCopy(runtimeShopDefinitions))
	return true
end)

lib.callback.register('ox_inventory:getShopDefinitions', function()
	return deepCopy(runtimeShopDefinitions)
end)

lib.callback.register('ox_inventory:openShop', function(source, data)
	local playerInv, shop = Inventory(source)

	if not playerInv then return end

	if data then
		shop = Shops[data.type]

		if not shop then return end

		if not shop.items then
			shop = (data.id and shop[data.id] or createShop(data.type, data.id))

			if not shop then return end
		end

		---@cast shop OxShop

		-- Note: Shop hours are handled client-side since server doesn't have access to in-game time
		-- The client prevents NPCs from spawning when shops are closed
		-- This provides double-layer security while keeping time sync consistent

		if shop.groups then
			local group = server.hasGroup(playerInv, shop.groups)
			if not group then return end
		end

		if type(shop.coords) == 'vector3' and #(GetEntityCoords(GetPlayerPed(source)) - shop.coords) > 10 then
			return
		end

		shop, playerInv.currentShopSlots = buildVisibleShop(shop, playerInv)

		-- Check if the player can purchase any items (license check)
		-- If all items require a license the player doesn't have, deny access
		if shop.items and server.hasLicense then
			local hasAnyPurchasableItem = false
			local requiredLicense = nil

			for _, item in pairs(shop.items) do
				if item.license then
					if server.hasLicense(playerInv, item.license) then
						hasAnyPurchasableItem = true
						break
					else
						requiredLicense = item.license
					end
				else
					-- Item doesn't require a license, player can purchase it
					hasAnyPurchasableItem = true
					break
				end
			end

			if not hasAnyPurchasableItem and requiredLicense then
				return nil, nil, 'shop_no_license'
			end
		end

		local shopType, shopId = shop.id:match('^(.-) (%d+)$')

        local hookPayload = {
            source = source,
            shopId = shopId or shop.id,
			shopType = shopType or shop.id,
            label = shop.label,
            slots = shop.slots,
            items = shop.items,
            groups = shop.groups,
            coords = shop.coords,
            distance = shop.distance
        }

        local hooks <close> = TriggerEventHooks('openShop', hookPayload)

		if not hooks.success then return end

		---@diagnostic disable-next-line: assign-type-mismatch
		playerInv:openInventory(playerInv)
		playerInv.currentShop = shop.id
	end

	return { label = playerInv.label, type = playerInv.type, slots = playerInv.slots, weight = playerInv.weight, maxWeight = playerInv.maxWeight }, shop
end)

local function canAffordItem(inv, currency, price)
	-- Handle prison credits currency
	if currency == 'prison_credits' then
		local credits = exports.atlas_prison:GetPrisonCredits(inv.id)
		local canAfford = price >= 0 and credits >= price
		
		return canAfford or {
			type = 'error',
			description = ('You need %d prison credits but only have %d'):format(price, credits)
		}
	end

	if currency == 'money' then
		local cashOnPerson = Inventory.GetItemCount(inv, 'money')
		local cashInWallets = 0

		for slot, slotData in pairs(inv.items) do
			if slotData and slotData.name == 'wallet' and slotData.metadata and slotData.metadata.container then
				local walletInv = Inventory.GetContainerFromSlot(inv, slot)
				if walletInv then
					cashInWallets += Inventory.GetItemCount(walletInv, 'money')
				end
			end
		end

		local canAfford = price >= 0 and (cashOnPerson + cashInWallets) >= price

		return canAfford or {
			type = 'error',
			description = locale('cannot_afford', ('%s%s'):format(locale('$'), math.groupdigits(price)))
		}
	end
	
	local canAfford = price >= 0 and Inventory.GetItemCount(inv, currency) >= price

	return canAfford or {
		type = 'error',
		description = locale('cannot_afford', ('%s%s'):format((currency == 'money' and locale('$') or math.groupdigits(price)), (currency == 'money' and math.groupdigits(price) or ' '..Items(currency).label)))
	}
end

local function removeCurrency(inv, currency, price)
	-- Handle prison credits currency
	if currency == 'prison_credits' then
		return exports.atlas_prison:RemovePrisonCredits(inv.id, price) == true
	end

	if currency ~= 'money' then
		return Inventory.RemoveItem(inv, currency, price) == true
	end

	local remaining = price
	local cashOnPerson = Inventory.GetItemCount(inv, 'money')

	if cashOnPerson > 0 and remaining > 0 then
		local removeFromInventory = math.min(cashOnPerson, remaining)

		if removeFromInventory > 0 and not Inventory.RemoveItem(inv, 'money', removeFromInventory) then
			return false
		end

		remaining -= removeFromInventory
	end

	if remaining > 0 then
		for slot, slotData in pairs(inv.items) do
			if remaining <= 0 then break end

			if slotData and slotData.name == 'wallet' and slotData.metadata and slotData.metadata.container then
				local walletInv = Inventory.GetContainerFromSlot(inv, slot)
				if walletInv then
					local walletCash = Inventory.GetItemCount(walletInv, 'money')
					local removeFromWallet = math.min(walletCash, remaining)

					if removeFromWallet > 0 and not Inventory.RemoveItem(walletInv, 'money', removeFromWallet) then
						return false
					end

					remaining -= removeFromWallet
				end
			end
		end
	end

	return remaining <= 0
end

local function isRequiredGrade(grade, rank)
	if type(grade) == "table" then
		for i=1, #grade do
			if grade[i] == rank then
				return true
			end
		end
		return false
	else
		return rank >= grade
	end
end

lib.callback.register('ox_inventory:buyItem', function(source, data)
	if data.toType == 'player' then
		if data.count == nil then data.count = 1 end

		local playerInv = Inventory(source)

		if not playerInv or not playerInv.currentShop then return end

		local shopType, shopId = playerInv.currentShop:match('^(.-) (%d-)$')

		if not shopType then shopType = playerInv.currentShop end

		if shopId then shopId = tonumber(shopId) end

		local shop = shopId and Shops[shopType][shopId] or Shops[shopType]
		local sourceSlot = playerInv.currentShopSlots and playerInv.currentShopSlots[data.fromSlot] or data.fromSlot
		local fromData = shop.items[sourceSlot]
		local toData = playerInv.items[data.toSlot]

		if fromData then
			if not canViewShopItem(playerInv, fromData) then
				local requiredLabel = fromData.requiresItem and Items(fromData.requiresItem) and Items(fromData.requiresItem).label or fromData.requiresItem or 'required item'
				local requiredCount = math.max(1, math.floor(tonumber(fromData.requiresCount) or 1))
				return false, false, {
					type = 'error',
					description = ('You need %sx %s to unlock this shop item.'):format(requiredCount, requiredLabel)
				}
			end

			if fromData.count then
				if fromData.count < 1 then
					return false, false, { type = 'error', description = locale('shop_nostock') }
				elseif data.count > fromData.count then
					data.count = fromData.count
				end
			end

			if fromData.license and server.hasLicense and not server.hasLicense(playerInv, fromData.license) then
				return false, false, { type = 'error', description = locale('item_unlicensed') }
			end

			if fromData.grade then
				local _, rank = server.hasGroup(playerInv, shop.groups)
				if not isRequiredGrade(fromData.grade, rank) then
					return false, false, { type = 'error', description = locale('stash_lowgrade') }
				end
			end

			local currency = fromData.currency or 'money'
			local fromItem = Items(fromData.name)

			local result = fromItem.cb and fromItem.cb('buying', fromItem, playerInv, data.fromSlot, shop)
			if result == false then return false end

			local toItem = toData and Items(toData.name)

			local metadata, count = Items.Metadata(playerInv, fromItem, fromData.metadata and table.clone(fromData.metadata) or {}, data.count)
			local price = count * fromData.price

			if toData == nil or (fromItem.name == toItem?.name and fromItem.stack and table.matches(toData.metadata, metadata) and not hasDifferentDurability(toData.metadata, metadata)) then
				local newWeight = playerInv.weight + (fromItem.weight + (metadata?.weight or 0)) * count

				if newWeight > playerInv.maxWeight then
					return false, false, { type = 'error', description = locale('cannot_carry') }
				end

				local canAfford = canAffordItem(playerInv, currency, price)

				if canAfford ~= true then
					return false, false, canAfford
				end

				if fromData.count then
					fromData.count -= count
				end

				local hooks <close> = TriggerEventHooks('buyItem', {
					source = source,
					shopType = shopType,
					shopId = shopId,
					toInventory = playerInv.id,
					toSlot = data.toSlot,
					fromSlot = fromData,
					itemName = fromData.name,
					metadata = metadata,
					count = count,
					price = fromData.price,
					totalPrice = price,
					currency = currency,
				})

				if not hooks.success or not Inventory.SetSlot(playerInv, fromItem, count, metadata, data.toSlot) then
					if fromData.count then
						fromData.count += count
					end

					return false
				end

				playerInv.weight = newWeight

				if not removeCurrency(playerInv, currency, price) then
					-- Atlas: upstream ignores the removeCurrency result, but a yielding
					-- buyItem hook can let the buyer spend their currency between the
					-- canAffordItem check and here. Take the granted item back instead
					-- of selling it for free.
					Inventory.RemoveItem(playerInv, fromItem, count, metadata, data.toSlot)

					if fromData.count then
						fromData.count += count
					end

					return false, false, { type = 'error', description = locale('cannot_afford', ('%s%s'):format((currency == 'money' and locale('$') or math.groupdigits(price)), (currency == 'money' and math.groupdigits(price) or ' '..Items(currency).label))) }
				end

				if server.syncInventory then server.syncInventory(playerInv) end

				-- Handle custom currency display
				local pricePrefix, priceSuffix
				if currency == 'prison_credits' then
					pricePrefix = '⃀'
					priceSuffix = ''
				elseif currency == 'money' then
					pricePrefix = locale('$')
					priceSuffix = ''
				else
					local currencyItem = Items(currency)
					pricePrefix = ''
					priceSuffix = currencyItem and (' ' .. currencyItem.label) or (' ' .. currency)
				end
				
				local priceDisplay = math.groupdigits(price)
				local message = locale('purchased_for', count, metadata?.label or fromItem.label, pricePrefix, (pricePrefix ~= '' and priceDisplay or priceDisplay) .. priceSuffix)

				-- Atlas patch: lib.logger removed. atlas_logs is the canonical sink.
				pcall(function()
					exports.atlas_logs:log('Inventory', 'Item Purchased',
						playerInv.label .. ' purchased ' .. count .. 'x ' .. (metadata and metadata.label or fromItem.label) .. ' from ' .. shop.label .. ' for ' .. pricePrefix .. math.groupdigits(price) .. priceSuffix,
						'info', source, {
							items = {{ name = fromData.name, label = fromItem.label or fromData.name, count = count, metadata = metadata or nil }},
							shop = shop.label,
							price = price,
							unitPrice = fromData.price,
						})
				end)

				local updatedShopItem = nil
				local sourceItem = shop.items[sourceSlot]
				if sourceItem and sourceItem.count and canViewShopItem(playerInv, sourceItem) then
					updatedShopItem = deepCopy(sourceItem)
					updatedShopItem.slot = data.fromSlot
				end

				return true, {data.toSlot, playerInv.items[data.toSlot], updatedShopItem, playerInv.weight}, { type = 'success', description = message }
			end

			return false, false, { type = 'error', description = locale('unable_stack_items') }
		end
	end
end)

server.shops = Shops

-- Export shop hours functions for other resources to use
exports('isShopOpen', function(shopType)
	local shop = Shops[shopType]
	if not shop then return false end
	return ShopHours.isShopOpen(shop)
end)

exports('getShopStatus', function(shopType)
	local shop = Shops[shopType]
	if not shop then return 'Shop not found' end
	return ShopHours.getShopStatus(shop)
end)

-- Admin command to check shop hours and status
lib.addCommand('checkshop', {
	help = 'Check the operating hours and current status of a shop',
	params = {
		{ name = 'shopname', type = 'string', help = 'The name of the shop to check' },
	},
	restricted = 'group.admin',
}, function(source, args)
	local shopType = args.shopname
	local shop = Shops[shopType]
	
	if not shop then
		TriggerClientEvent('ox_lib:notify', source, {
			title = 'Shop Check',
			description = ('Shop "%s" not found'):format(shopType),
			type = 'error'
		})
		return
	end
	
	local status = ShopHours.getShopStatus(shop)
	local hoursText = 'Open 24/7 - No time restrictions'
	
	if shop.opens and shop.closes then
		local openTime = ShopHours.formatHour(shop.opens)
		local closeTime = ShopHours.formatHour(shop.closes)
		hoursText = ('Opens: %s, Closes: %s'):format(openTime, closeTime)
	end
	
	TriggerClientEvent('ox_lib:notify', source, {
		title = ('Shop: %s'):format(shop.label or shopType),
		description = ('%s\n%s'):format(status, hoursText),
		type = 'info',
		duration = 5000
	})
end)
