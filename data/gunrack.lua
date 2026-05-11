-- Gun Rack configuration for emergency vehicle gloveboxes
-- On-duty LEOs in emergency vehicles get extra gun rack slots (6-8) in their glovebox

return {
    -- The first N slots in the glovebox are normal storage
    -- Slots after this are gun rack slots (restricted to weapons + on-duty LEOs)
    gunRackStartSlot = 7,
    gunRackSlots = 2,

    -- Vehicle classes that have a gun rack (18 = Emergency)
    vehicleClasses = {
        [18] = true,
    },

    -- Weapons allowed in the gun rack slots (rifles and shotguns only)
    allowedWeapons = {
        -- Rifles
        ['WEAPON_ADVANCEDRIFLE']        = true,
        ['WEAPON_ASSAULTRIFLE']         = true,
        ['WEAPON_ASSAULTRIFLE_MK2']     = true,
        ['WEAPON_BULLPUPRIFLE']         = true,
        ['WEAPON_BULLPUPRIFLE_MK2']     = true,
        ['WEAPON_CARBINERIFLE']         = true,
        ['WEAPON_CARBINERIFLE_MK2']     = true,
        ['WEAPON_HEAVYRIFLE']           = true,
        ['WEAPON_MILITARYRIFLE']        = true,
        ['WEAPON_SPECIALCARBINE']       = true,
        ['WEAPON_SPECIALCARBINE_MK2']   = true,
        ['WEAPON_TACTICALRIFLE']        = true,
        ['WEAPON_BATTLERIFLE']          = true,

        -- Shotguns
        ['WEAPON_ASSAULTSHOTGUN']       = true,
        ['WEAPON_BULLPUPSHOTGUN']       = true,
        ['WEAPON_COMBATSHOTGUN']        = true,
        ['WEAPON_DBSHOTGUN']            = true,
        ['WEAPON_HEAVYSHOTGUN']         = true,
        ['WEAPON_PUMPSHOTGUN']          = true,
        ['WEAPON_PUMPSHOTGUN_MK2']      = true,
        ['WEAPON_SAWNOFFSHOTGUN']       = true,
        ['WEAPON_AUTOSHOTGUN']          = true,
    },
}
