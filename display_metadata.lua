CreateThread(function()
    exports.ox_inventory:displayMetadata({
        -- Rental Contract
        { rentalModel = "Model" },          
        { plate       = "Plate" },          
        { renter      = "Renter"} ,         
        { dateRented        = "Date Rented" }, 
        
        -- Atlas Drugs: quality is shown as stars directly on the inventory
        -- slot (see web InventorySlot.tsx + the `grade` metadata field), not as
        -- a tooltip row, so nothing is registered here.
        -- Atlas Drugs
        { qualityLabel = "Quality" },

        -- Id Card
        { lastname    = 'Last Name' },
        { firstname   = 'First Name' },
        { birthdate   = 'Date of Birth' },
        { sex         = 'Sex' },
        { nationality = 'Nationality' },
        { citizenid   = 'Citizen ID' },

        -- Atlas Polaroid photographs (caption rides metadata.description;
        -- prints are anonymous by design — no Taken By row)
        { taken_at = 'Taken At' },
    })
end)