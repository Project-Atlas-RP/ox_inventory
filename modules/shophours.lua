if not lib then return end

local ShopHours = {}

-- Cache for shop hours to avoid repeated calculations
local hourCache = {}
local lastHourCheck = 0

---Check if a shop is currently open based on its configured hours
---@param shop table The shop configuration with opens/closes fields
---@return boolean isOpen Whether the shop is currently open
function ShopHours.isShopOpen(shop)
    if not shop.opens or not shop.closes then
        return true -- Shop has no time restrictions, always open
    end
    
    -- Use in-game time on client, real-world time on server
    local currentHour
    if GetClockHours then
        -- Client side - use in-game time
        currentHour = GetClockHours()
    else
        -- Server side - use a simple fallback time since both GetClockHours() and os.date might not be available
        -- For now, we'll assume shops are always open on server checks
        -- The client-side will handle the actual time-based restrictions
        currentHour = 12 -- Default to noon (most shops would be open)
    end
    local cacheKey = ('%s_%s_%s'):format(shop.name or 'unknown', shop.opens, shop.closes)
    
    -- Cache results for 1 minute to avoid excessive calculations
    local currentTime = GetGameTimer()
    if hourCache[cacheKey] and (currentTime - lastHourCheck) < 60000 then -- 60000ms = 1 minute
        return hourCache[cacheKey]
    end
    
    local opens = shop.opens
    local closes = shop.closes
    local isOpen = false
    
    -- Handle shops that are open overnight (closes next day)
    if opens > closes then
        -- Example: opens at 21 (9 PM), closes at 5 (5 AM next day)
        isOpen = currentHour >= opens or currentHour < closes
    else
        -- Example: opens at 9 (9 AM), closes at 17 (5 PM same day)
        isOpen = currentHour >= opens and currentHour < closes
    end
    
    -- Cache the result
    hourCache[cacheKey] = isOpen
    lastHourCheck = GetGameTimer()
    
    return isOpen
end

---Get the status message for a shop's operating hours
---@param shop table The shop configuration
---@return string status The status message ('Open', 'Closed - Opens at X', etc.)
function ShopHours.getShopStatus(shop)
    print(shop.opens, shop.closes)
    if not shop.opens or not shop.closes then
        print("here")
        return 'Open'
    end

    if ShopHours.isShopOpen(shop) then
        return 'Open'
    else
        -- Use in-game time on client, real-world time on server
        local currentHour
        if GetClockHours then
            -- Client side - use in-game time
            currentHour = GetClockHours()
        else
            -- Server side - use a simple fallback time since both GetClockHours() and os.date might not be available
            -- For now, we'll assume shops are always open on server checks
            -- The client-side will handle the actual time-based restrictions
            currentHour = 12 -- Default to noon (most shops would be open)
        end
        local opens = shop.opens
        local closes = shop.closes
        local hoursUntilOpen
        
        if opens > closes then
            -- Overnight shop
            if currentHour >= closes and currentHour < opens then
                hoursUntilOpen = opens - currentHour
            else
                -- Currently past closing time but before midnight
                hoursUntilOpen = (24 - currentHour) + opens
            end
        else
            -- Regular daytime shop
            if currentHour < opens then
                hoursUntilOpen = opens - currentHour
            else
                hoursUntilOpen = (24 - currentHour) + opens
            end
        end
        
        local openTime = ShopHours.formatHour(opens)
        return ('Closed - Opens at %s'):format(openTime)
    end
end

---Format hour in 12-hour format for display
---@param hour number The hour in 24-hour format (0-23)
---@return string formatted The formatted time string
function ShopHours.formatHour(hour)
    if hour == 0 then
        return '12 AM'
    elseif hour < 12 then
        return ('%d AM'):format(hour)
    elseif hour == 12 then
        return '12 PM'
    else
        return ('%d PM'):format(hour - 12)
    end
end

---Clear the hour cache (useful for testing or when time changes)
function ShopHours.clearCache()
    table.wipe(hourCache)
    lastHourCheck = 0
end

return ShopHours