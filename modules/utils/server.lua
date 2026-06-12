if not lib then return end

local Utils = {}

local webHook = GetConvar('inventory:webhook', '')

if webHook ~= '' then
    local validExtensions = {
        ['png'] = true,
        ['apng'] = true,
        ['webp'] = true,
    }

    local headers = { ['Content-Type'] = 'application/json' }

    function Utils.IsValidImageUrl(url)
        local isUri = url:match("^nui://.+")
        if isUri then
            local resource, extension = url:match('^nui://([^/]+)/.-%.(%l+)$')

            if not resource or not extension then return false end

            local resourceState = GetResourceState(resource)
            if resourceState ~= 'started' then return false end

            return validExtensions[extension]
        end

        local isUrl = url:match("^https?://.+")
        if isUrl then
            local host, extension = url:match('^https?://([^/]+).+%.([%l]+)')

            if not host or not extension then return false end

            return server.validhosts[host] and validExtensions[extension]
        end

        return false
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

---Prints a warning to console and logs an exploited event.
---@param playerId number
---@param event string
---@param msg string
---@param kickPlayer? boolean
function Utils.LogExploit(playerId, event, msg, kickPlayer)
    local playerName = GetPlayerName(playerId) or tostring(playerId)
    local warning = ('%s (%d) suspected of exploiting. %s'):format(playerName, playerId, msg)
    local scopedEvent = ('%s:%s'):format(shared.resource, event)

    lib.print.warn(warning)

    -- Atlas patch: lib.logger replaced with atlas_logs. atlas_logs is the
    -- canonical sink so exploit attempts show up in the in-game web panel.
    pcall(function()
        exports.atlas_logs:log('Anti-Cheat', 'Exploit Detected',
            ('%s (id %d) suspected of exploiting (%s): %s%s'):format(
                playerName, playerId, scopedEvent, msg, kickPlayer and ' — kicked' or ''),
            'error', playerId, {
                event = scopedEvent,
                kicked = kickPlayer == true,
            })
    end)

    if kickPlayer then
        -- Atlas patch: route through the central anticheat gateway (txApi -> txAdmin)
        -- with a DropPlayer fallback if atlas_anticheat is unavailable.
        if not pcall(function()
            exports.atlas_anticheat:Kick(playerId, ('ox_inventory: %s'):format(msg or 'suspicious behaviour'))
        end) then
            DropPlayer(tostring(playerId), 'Dropped for suspicious behaviour.')
        end
    end
end

return Utils
