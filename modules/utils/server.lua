if not lib then return end

local Utils = {}

local webHook = GetConvar('inventory:webhook', '')

if webHook ~= '' then
	local validHosts = {
		['i.imgur.com'] = true,
	}

	local validExtensions = {
		['png'] = true,
		['apng'] = true,
		['webp'] = true,
	}

	local headers = { ['Content-Type'] = 'application/json' }

	function Utils.IsValidImageUrl(url)
		local host, extension = url:match('^https?://([^/]+).+%.([%l]+)')
		return host and extension and validHosts[host] and validExtensions[extension]
	end

	---@param title string
	---@param message string
	---@param image string
	function Utils.DiscordEmbed(title, message, image, color, playerId)
		local level = 'info'
		if color == 65280 or color == 3066993 then level = 'success'
		elseif color == 16711680 or color == 15158332 then level = 'error'
		elseif color == 16776960 or color == 16744448 then level = 'warning'
		end
		local extra = {}
		if image and image ~= '' then extra.image = image end
		exports.atlas_logs:log('Inventory', title or 'ox_inventory', message or '', level, playerId, extra)
	end
end

return Utils
