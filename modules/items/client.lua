if not lib then return end

local Items = require 'modules.items.shared' --[[@as table<string, OxClientItem>]]

local function sendDisplayMetadata(data)
    SendNUIMessage({
		action = 'displayMetadata',
		data = data
	})
end

--- use array of single key value pairs to dictate order
---@param metadata string | table<string, string> | table<string, string>[]
---@param value? string
local function displayMetadata(metadata, value)
	local data = {}

	if type(metadata) == 'string' then
        if not value then return end

        data = { { metadata = metadata, value = value } }
	elseif table.type(metadata) == 'array' then
		for i = 1, #metadata do
			for k, v in pairs(metadata[i]) do
				data[i] = {
					metadata = k,
					value = v,
				}
			end
		end
	else
		for k, v in pairs(metadata) do
			data[#data + 1] = {
				metadata = k,
				value = v,
			}
		end
	end

    if client.uiLoaded then
        return sendDisplayMetadata(data)
    end

    CreateThread(function()
        repeat Wait(100) until client.uiLoaded

        sendDisplayMetadata(data)
    end)
end

exports('displayMetadata', displayMetadata)

---@param _ table?
---@param name string?
---@return table?
local function getItem(_, name)
    if not name then return Items end

	if type(name) ~= 'string' then return end

    name = name:lower()

    if name:sub(0, 7) == 'weapon_' then
        name = name:upper()
    end

    return Items[name]
end

setmetatable(Items --[[@as table]], {
	__call = getItem
})

---@cast Items +fun(itemName: string): OxClientItem
---@cast Items +fun(): table<string, OxClientItem>

local function Item(name, cb)
	local item = Items[name]
	if item then
		if not item.client?.export and not item.client?.event then
			item.effect = cb
		end
	end
end

local ox_inventory = exports[shared.resource]
-----------------------------------------------------------------------------------------------
-- Clientside item use functions
-----------------------------------------------------------------------------------------------

Item('bandage', function(data, slot)
	local maxHealth = GetEntityMaxHealth(cache.ped)
	local health = GetEntityHealth(cache.ped)
	ox_inventory:useItem(data, function(data)
		if data then
			SetEntityHealth(cache.ped, math.min(maxHealth, math.floor(health + maxHealth / 16)))
			lib.notify({ description = 'You feel better already' })
		end
	end)
end)

Item('armour', function(data, slot)
	if GetPedArmour(cache.ped) < 100 then
		ox_inventory:useItem(data, function(data)
			if data then
				SetPlayerMaxArmour(PlayerData.id, 100)
				SetPedArmour(cache.ped, 100)
			end
		end)
	end
end)

client.parachute = false

local function attachParachuteBag(ped)
	lib.requestModel(1269906701)
	-- Don't re-attach — CreateParachuteBagObject auto-attaches the bag to the ped's back
	-- using the correct bone/offset. Manual AttachEntityToEntity overrides this and was
	-- positioning the bag off the player's hip. If the bag desyncs during ragdoll, the
	-- watchdog tick in showParachuteDeployHint will recreate it.
	return CreateParachuteBagObject(ped, true, true)
end

local function showParachuteDeployHint()
	CreateThread(function()
		local prompted = false
		while client.parachute do
			local ped = cache.ped
			local pState = GetPedParachuteState(ped)
			if pState ~= -1 then
				-- Parachute deployed (or in free-fall with parachute readied) — clear hint and stop loop
				if prompted then lib.hideTextUI() end
				return
			end
			-- Show hint only while genuinely falling, not while standing or in vehicle
			local falling = IsPedFalling(ped) or IsPedInParachuteFreeFall(ped)
			if falling and not IsPedInAnyVehicle(ped, false) then
				if not prompted then
					lib.showTextUI('[LMB] Deploy Parachute')
					prompted = true
				end
			elseif prompted then
				lib.hideTextUI()
				prompted = false
			end
			-- Re-attach the bag if it has disappeared (jump/ragdoll desync)
			local bag = client.parachute and client.parachute[1]
			if bag and not DoesEntityExist(bag) then
				client.parachute[1] = attachParachuteBag(ped)
			end
			Wait(200)
		end
		if prompted then lib.hideTextUI() end
	end)
end

local function stowParachute()
	if not client.parachute then return end
	-- Don't stow mid-deploy — once GetPedParachuteState != -1 the bag is auto-cleaned
	-- by the deploy tick and the item is already being consumed.
	if GetPedParachuteState(cache.ped) ~= -1 then return end
	local bag = client.parachute[1]
	if bag and DoesEntityExist(bag) then
		SetEntityAsMissionEntity(bag, false, true)
		DeleteEntity(bag)
	end
	RemoveWeaponFromPed(cache.ped, `GADGET_PARACHUTE`)
	SetPlayerParachuteTintIndex(PlayerData.id, -1)
	client.parachute = false
	-- Hide any lingering deploy hint; the watchdog loop will exit on its next tick.
	lib.hideTextUI()
end

Item('parachute', function(data, slot)
	if client.parachute then
		-- Already wearing it — using the item again stows the bag back into the inventory.
		-- Item is consume=0 so nothing was deducted on the original equip; the slot stays
		-- where it was.
		stowParachute()
		return
	end
	ox_inventory:useItem(data, function(data)
		if data then
			local chute = `GADGET_PARACHUTE`
			SetPlayerParachuteTintIndex(PlayerData.id, -1)
			GiveWeaponToPed(cache.ped, chute, 0, true, false)
			SetPedGadget(cache.ped, chute, true)
			client.parachute = { attachParachuteBag(cache.ped), slot?.metadata?.type or -1, slot.slot }
			if slot.metadata.type then
				SetPlayerParachuteTintIndex(PlayerData.id, slot.metadata.type)
			end
			showParachuteDeployHint()
		end
	end)
end)

Item('phone', function(data, slot)
	local success, result = pcall(function()
		return exports.npwd:isPhoneVisible()
	end)

	if success then
		exports.npwd:setPhoneVisible(not result)
	end
end)

Item('clothing', function(data, slot)
	local metadata = slot.metadata

	if not metadata.drawable then return print('Clothing is missing drawable in metadata') end
	if not metadata.texture then return print('Clothing is missing texture in metadata') end

	if metadata.prop then
		if not SetPedPreloadPropData(cache.ped, metadata.prop, metadata.drawable, metadata.texture) then
			return print('Clothing has invalid prop for this ped')
		end
	elseif metadata.component then
		if not IsPedComponentVariationValid(cache.ped, metadata.component, metadata.drawable, metadata.texture) then
			return print('Clothing has invalid component for this ped')
		end
	else
		return print('Clothing is missing prop/component id in metadata')
	end

	ox_inventory:useItem(data, function(data)
		if data then
			metadata = data.metadata

			if metadata.prop then
				local prop = GetPedPropIndex(cache.ped, metadata.prop)
				local texture = GetPedPropTextureIndex(cache.ped, metadata.prop)

				if metadata.drawable == prop and metadata.texture == texture then
					return ClearPedProp(cache.ped, metadata.prop)
				end

				-- { prop = 0, drawable = 2, texture = 1 } = grey beanie
				SetPedPropIndex(cache.ped, metadata.prop, metadata.drawable, metadata.texture, false);
			elseif metadata.component then
				local drawable = GetPedDrawableVariation(cache.ped, metadata.component)
				local texture = GetPedTextureVariation(cache.ped, metadata.component)

				if metadata.drawable == drawable and metadata.texture == texture then
					return -- item matches (setup defaults so we can strip?)
				end

				-- { component = 4, drawable = 4, texture = 1 } = jeans w/ belt
				SetPedComponentVariation(cache.ped, metadata.component, metadata.drawable, metadata.texture, 0);
			end
		end
	end)
end)

-----------------------------------------------------------------------------------------------

exports('Items', function(item) return getItem(nil, item) end)
exports('ItemList', function(item) return getItem(nil, item) end)

return Items
