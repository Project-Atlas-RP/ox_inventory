local containers = {}

---@class ItemContainerProperties
---@field slots number
---@field maxWeight number
---@field whitelist? table<string, true> | string[]
---@field blacklist? table<string, true> | string[]
---@field weightFactor? number multiplier applied to contained weight when computing the container item's own slot weight (default 1.0; e.g. 0.5 means contents transfer at 50%)

local function arrayToSet(tbl)
	local size = #tbl
	local set = table.create(0, size)

	for i = 1, size do
		set[tbl[i]] = true
	end

	return set
end

---Registers items with itemName as containers (i.e. backpacks, wallets).
---@param itemName string
---@param properties ItemContainerProperties
---@todo Rework containers for flexibility, improved data structure; then export this method.
local function setContainerProperties(itemName, properties)
	local blacklist, whitelist = properties.blacklist, properties.whitelist

	if blacklist then
		local tableType = table.type(blacklist)

		if tableType == 'array' then
			blacklist = arrayToSet(blacklist)
		elseif tableType ~= 'hash' then
			TypeError('blacklist', 'table', type(blacklist))
		end
	end

	if whitelist then
		local tableType = table.type(whitelist)

		if tableType == 'array' then
			whitelist = arrayToSet(whitelist)
		elseif tableType ~= 'hash' then
			TypeError('whitelist', 'table', type(whitelist))
		end
	end

	containers[itemName] = {
		size = { properties.slots, properties.maxWeight },
		blacklist = blacklist,
		whitelist = whitelist,
		weightFactor = type(properties.weightFactor) == 'number' and properties.weightFactor or 1.0,
	}
end

exports('setContainerProperties', setContainerProperties)

setContainerProperties('paperbag', {
	slots = 5,
	maxWeight = 1000,
	blacklist = { 'testburger' }
})

-- EMS duffle bag: a portable medical container (opens like a paper bag).
-- weightFactor 0.5 = contents add half their weight to the bag's own slot,
-- matching the backpack weight rule so it can't be used to dodge weight limits.
setContainerProperties('ems_duffle_bag', {
	slots = 20,
	maxWeight = 30000,
	weightFactor = 0.5,
})

setContainerProperties('wallet', {
	slots = 10,
	maxWeight = 1000,
	whitelist = { 'money', 'quarter', 'creditcard', 'id_card', 'driver_license' ,'weaponlicense', 'license' , 'photo', 'businesscard', 'bankcard' , 'note', 'receipt', 'lawyerpass', 'gov_badge', 'rental_contract', 'trucking_contract' }
})

-- Wearable backpacks (managed by atlas_backpacks). Blacklist nesting other bags.
-- weightFactor 0.5 = contents add half their weight to the bag's own slot weight,
-- so a stash can't be exploited by nesting full backpacks inside it.
-- atlas_backpacks re-registers these at startup; values here are the fallback
-- if that resource isn't loaded.
local backpackBlacklist = {
	'backpack_tote', 'backpack_tote_b',
	'backpack_small', 'backpack_medium',
	'backpack_large',
}

setContainerProperties('backpack_tote', {
	slots = 8,
	maxWeight = 10000,
	blacklist = backpackBlacklist,
	weightFactor = 0.5,
})

setContainerProperties('backpack_tote_b', {
	slots = 8,
	maxWeight = 10000,
	blacklist = backpackBlacklist,
	weightFactor = 0.5,
})

setContainerProperties('backpack_small', {
	slots = 15,
	maxWeight = 20000,
	blacklist = backpackBlacklist,
	weightFactor = 0.5,
})

setContainerProperties('backpack_medium', {
	slots = 20,
	maxWeight = 30000,
	blacklist = backpackBlacklist,
	weightFactor = 0.5,
})

setContainerProperties('backpack_large', {
	slots = 40,
	maxWeight = 60000,
	blacklist = backpackBlacklist,
	weightFactor = 0.5,
})

return containers
