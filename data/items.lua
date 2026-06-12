    return {
    -- Delivery Job Items
    ["delivery_package"] = {
        label = "Delivery Package",
        weight = 5000,
        stack = false,
        close = true,
        description = "A package that needs to be delivered"
    },

    ["suspicious_package"] = {
        label = "Suspicious Package",
        weight = 5000,
        stack = false, 
        close = true,
        description = "A package containing possibly illegal or dangerous items",
        client = {
            image = 'delivery_package.png',
        }
    },

    ["half_eaten_sandwich"] = {
        label = "Half-Eaten Sandwich",
        weight = 500,
        stack = false,
        description = "A half-eaten sandwich that looks and smells questionable",
        client = {
            status = { hunger = 60000 },
            anim = 'eating',
            prop = 'sandwich',
            usetime = 2500,
            notification = "You ate the half-eaten sandwich. It tasted... lived-in."
        },
    },

    -- Currency items
    -- ["prison_credits"] = {
    --     label = "Prison Credits",
    --     weight = 0,
    --     stack = true,
    --     close = true,
    --     description = "Virtual currency used within the prison system"
    -- },

    -- Robbery Loot Items
    ["marked_bills"] = {
        label = "Marked Bills",
        weight = 0,
        stack = true,
        close = true,
        description = "Bills marked by law enforcement for tracking purposes"
    },
    ["marked_gold_bars"] = {
        label = "Marked Gold Bars",
        weight = 500,
        stack = true,
        description = "Gold bars marked by law enforcement for tracking purposes"
    },
    ['senorabank_keycard'] = {
        label = 'Grand Senora Central Bank Keycard',
        weight = 100,
        description = 'A keycard that grants access to the Grand Senora Central Bank vault.'
    },
    ['paletobank_keycard'] = {
        label = 'Paleto Bay Bank Keycard',
        weight = 100,
        description = 'A keycard that grants access to the Paleto Bay Bank vault.'
    },
    ['mazebank_keycard'] = {
        label = 'Maze Bank Keycard',
        weight = 100,
        description = 'A keycard that grants access to the Maze Bank vault.'
    },
    ['pacificbank_keycard'] = {
        label = 'Pacific Standard Bank Keycard',
        weight = 100,
        description = 'A keycard that grants access to the Pacific Standard Bank vault.'
    },
    ["goldring"] = {
        label = "Gold Ring",
        weight = 200,
        description = "A shiny gold ring.",
        client = {
            image = 'goldring.png',
        }
        
    },
    ["cubancigarbox"] = {
        label = "Cuban Cigar Box",
        weight = 300,
        description = "A box containing premium Cuban cigars."
    },

    -- Interactive smokes (atlas_consumables)
    ['cigarette'] = {
        label = 'Cigarette',
        weight = 5,
        stack = true,
        close = true,
        description = 'Light one up. Multiple drags before it burns out.',
        client = {
            image = 'cigarette.png',
        },
    },
    ['redwood'] = {
        label = 'Redwood Cigarette',
        weight = 5,
        stack = true,
        close = true,
        description = 'A pack-fresh Redwood. Smooth and long-lasting.',
        client = {
            image = 'cigarettes_redwood.png',
        },
    },
    ['cigar'] = {
        label = 'Cigar',
        weight = 15,
        stack = true,
        close = true,
        description = 'A real cigar. Plenty of puffs.',
        client = {
            image = 'cigar.png',
        },
    },
    ['tobacco_pipe'] = {
        label = 'Castle Pipe',
        weight = 100,
        stack = false,
        close = true,
        client = {
            image = '',
        },
    },

    -- food items
    -- Utility Kitchen
    --[[
    ["fries"] = {
        label = "Fries",
        weight = 1,
        stack = true,
    },
    ["sunflower_oil"] = {
        label = "Sunflower Oil",
        weight = 1,
        stack = true,
    },
    ["patty"] = {
        label = "Patty",
        weight = 1,
        stack = true,
    },
    ["cheddar"] = {
        label = "Cheddar",
        weight = 1,
        stack = true,
    },
    ["pickle"] = {
        label = "Pickle",
        weight = 1,
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ["bacon"] = {
        label = "Bacon",
        weight = 1,
        stack = true,
    },
    ["hamburger"] = {
        label = "Hamburger",
        weight = 1,
        stack = true,
    },
    ["frozen_fries"] = {
        label = "Frozen Fries",
        weight = 1,
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ]]

    -- Kept defined: referenced by external resources outside utility_kitchen
    -- hamburger — atlas_itemthrowing throwable model
    -- olive — atlas_fruit_picking tree product (and atlas_loot loot table)
    -- (pizza_slice / pizza_box removed 2026-06-10 along with the rest of the
    -- pizza content — no resource references them anymore)
    -- ["hamburger"] = {
    --     label = "Hamburger",
    --     weight = 1,
    --     stack = true,
    -- },
    -- ["olive"] = {
    --     label = "Olive",
    --     weight = 1,
    --     stack = true,
    -- },

    -- =========================================================
    -- atlas_restaurants cook-state items (raw / cooked / burnt)
    -- =========================================================

    -- Burger patty cook states
    ["raw_patty"] = {
        label = "Raw Patty",
        weight = 115,
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ["patty"] = {
        label = "Patty",
        weight = 115,
        stack = true,
        degrade = 5760,
        decay = true,
        client = {
            status = { hunger = 200000 },
            anim = 'eating',
            prop = 'bzzz_food_grill_burger_grill_a',
            usetime = 2500,
            notification = 'You ate a grilled patty',
        },
    },
    ["burnt_patty"] = {
        label = "Burnt Patty",
        weight = 115,
        stack = true,
    },

    -- Fries cook states
    ["raw_fries"] = {
        label = "Raw Fries",
        weight = 120,
        stack = true,
        degrade = 8640,
        decay = true,
    },
    ["fries"] = {
        label = "Fries",
        weight = 120,
        stack = true,
        client = {
            status = { hunger = 120000 },
            anim = 'eating',
            prop = 'bzzz_fastfood_burgershot_fries_a',
            usetime = 2000,
            notification = 'You ate some fries'
        },
    },
    ["burnt_fries"] = {
        label = "Burnt Fries",
        weight = 120,
        stack = true,
    },

    -- Top bun cook states
    ["raw_top_bun"] = {
        label = "Raw Top Bun",
        weight = 30,
        stack = true,
        degrade = 8640,
        decay = true,
    },
    ["top_bun"] = {
        label = "Top Bun",
        weight = 30,
        stack = true,
        degrade = 8640,
        decay = true,
    },
    ["burnt_top_bun"] = {
        label = "Burnt Top Bun",
        weight = 30,
        stack = true,
    },

    -- Bottom bun cook states
    ["raw_bottom_bun"] = {
        label = "Raw Bottom Bun",
        weight = 30,
        stack = true,
        degrade = 8640,
        decay = true,
    },
    ["bottom_bun"] = {
        label = "Bottom Bun",
        weight = 30,
        stack = true,
        degrade = 8640,
        decay = true,
    },
    ["burnt_bottom_bun"] = {
        label = "Burnt Bottom Bun",
        weight = 30,
        stack = true,
    },

    -- Burnt fryer/grill components — what you get for overcooking bacon, chicken
    -- fillets, nuggets, or onion rings (inedible waste, like burnt_patty).
    ["burnt_bacon_strip"] = {
        label = "Burnt Bacon Strip",
        weight = 35,
        stack = true,
    },
    ["burnt_chicken_fillet"] = {
        label = "Burnt Chicken Fillet",
        weight = 110,
        stack = true,
    },
    ["burnt_onion_rings"] = {
        label = "Burnt Onion Rings",
        weight = 90,
        stack = true,
    },
    ["burnt_nuggets"] = {
        label = "Burnt Chicken Nuggets",
        weight = 90,
        stack = true,
    },

    -- =========================================================
    -- Public barbecue (atlas_restaurants world grills). Deliberately SEPARATE
    -- from the Burger Shot pipeline above so the two don't compete: everything
    -- here is 1:1. Cook-state items that ALREADY EXIST are reused (raw_patty/
    -- patty, raw_bacon/bacon_strip, raw_chicken_fillet/chicken_fillet); other
    -- cooked outputs are clean grilled_* items (the bzzz model is only the eat
    -- prop). No fire phase: food goes raw -> cooked -> burnt, and an overcooked
    -- slot hands back a burnt item (burnt_patty / burnt_food / ...) so the cook
    -- can clear it and start fresh.
    -- Flow: PREP raw meat -> raw component -> GRILL -> (optionally) PREP-build
    -- into a burger/salad. Veg/fish are grilled directly.
    -- =========================================================
    -- Generic charred output for overcooked foods that have no specific burnt
    -- variant (steak/sausage/rib/skewer/chicken cuts/corn/potato/fish/salmon).
    ["burnt_food"] = {
        label = "Burnt Food",
        description = "A charred, ruined piece of food.",
        weight = 120,
        stack = true,
    },
    -- Raw components (shaped at the barbecue prep tab; grilled on the slot).
    ["bbq_raw_steak"] = {
        label = "Raw Steak Cut",
        weight = 250,
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ["bbq_raw_skewer"] = {
        label = "Raw Meat Skewer",
        description = "Cubed meat on a skewer. Best not to ask what kind.",
        weight = 220,
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ["bbq_raw_sausage"] = {
        label = "Raw Sausage",
        weight = 180,
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ["bbq_raw_ribs"] = {
        label = "Raw Rib",
        weight = 220,
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ["bbq_raw_chicken_leg"] = {
        label = "Raw Chicken Leg",
        weight = 160,
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ["bbq_raw_chicken_wing"] = {
        label = "Raw Chicken Wing",
        weight = 90,
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ["bbq_raw_fish"] = {
        label = "Raw Fish Fillet",
        description = "A fish fillet cut at the butcher, ready for the grill.",
        weight = 200,
        stack = true,
        degrade = 10080,
        decay = true,
    },
    -- Cooked grilled foods (1 raw component -> 1 of these on the grill). Clean
    -- item names; the bzzz_food_grill_* model is only the held/eat prop. Foods
    -- that already exist as cook-states are NOT here (patty / bacon_strip /
    -- chicken_fillet are reused for the patty / bacon / chicken-fillet recipes).
    ["grilled_steak"] = {
        label = "Grilled Steak", weight = 280, stack = true, degrade = 5760, decay = true,
        client = { status = { hunger = 320000 }, anim = 'eating', prop = 'bzzz_food_grill_steak_grill_a', usetime = 6000, notification = 'You ate a grilled steak' },
    },
    ["grilled_skewer"] = {
        label = "Grilled Meat Skewer", weight = 240, stack = true, degrade = 5760, decay = true,
        client = { status = { hunger = 260000 }, anim = 'eating', prop = 'bzzz_food_grill_skewer_grill_a', usetime = 5600, notification = 'You ate a meat skewer' },
    },
    ["grilled_sausage"] = {
        label = "Grilled Sausage", weight = 200, stack = true, degrade = 5760, decay = true,
        client = { status = { hunger = 220000 }, anim = 'eating', prop = 'bzzz_food_grill_sausage_grill_a', usetime = 5000, notification = 'You ate a grilled sausage' },
    },
    ["grilled_rib"] = {
        label = "Grilled Rib", weight = 230, stack = true, degrade = 5760, decay = true,
        client = { status = { hunger = 280000 }, anim = 'eating', prop = 'bzzz_food_grill_ribs_grill_b', usetime = 6000, notification = 'You ate a grilled rib' },
    },
    ["grilled_chicken_leg"] = {
        label = "Grilled Chicken Leg", weight = 180, stack = true, degrade = 5760, decay = true,
        client = { status = { hunger = 110000 }, anim = 'eating', prop = 'bzzz_food_grill_chicken_grill_b', usetime = 5600, notification = 'You ate a grilled chicken leg' },
    },
    ["grilled_chicken_wing"] = {
        label = "Grilled Chicken Wing", weight = 100, stack = true, degrade = 5760, decay = true,
        client = { status = { hunger = 60000 }, anim = 'eating', prop = 'bzzz_food_grill_chicken_grill_c', usetime = 4400, notification = 'You ate a grilled chicken wing' },
    },
    ["grilled_corn"] = {
        label = "Grilled Corn", weight = 200, stack = true, degrade = 5760, decay = true,
        client = { status = { hunger = 160000 }, anim = 'eating', prop = 'bzzz_food_grill_corn_grill_a', usetime = 5000, notification = 'You ate grilled corn' },
    },
    ["grilled_potato"] = {
        label = "Grilled Potato", weight = 220, stack = true, degrade = 5760, decay = true,
        client = { status = { hunger = 180000 }, anim = 'eating', prop = 'bzzz_food_grill_potato_grill_a', usetime = 5000, notification = 'You ate a grilled potato' },
    },
    ["grilled_salmon"] = {
        label = "Grilled Salmon", weight = 220, stack = true, degrade = 5760, decay = true,
        client = { status = { hunger = 260000 }, anim = 'eating', prop = 'bzzz_food_grill_salmon_grill_a', usetime = 5600, notification = 'You ate grilled salmon' },
    },
    ["grilled_fish"] = {
        label = "Grilled Fish", weight = 220, stack = true, degrade = 5760, decay = true,
        client = { status = { hunger = 240000 }, anim = 'eating', prop = 'bzzz_food_grill_fish_grill_a', usetime = 5600, notification = 'You ate grilled fish' },
    },
    -- Assembled barbecue dishes (built at the prep tab from cooked components;
    -- the grilled patty itself reuses the restaurant `patty` item).
    ["bbq_burger"] = {
        label = "BBQ Burger",
        weight = 350,
        stack = true,
        degrade = 2880,
        decay = true,
        client = {
            status = { hunger = 350000 },
            anim = 'eating',
            prop = 'bzzz_fastfood_burgershot_bigburger_a',
            usetime = 6000,
            notification = 'You ate a BBQ burger',
        },
    },
    ["bbq_cheeseburger"] = {
        label = "BBQ Cheeseburger",
        weight = 380,
        stack = true,
        degrade = 2880,
        decay = true,
        client = {
            status = { hunger = 400000 },
            anim = 'eating',
            prop = 'bzzz_fastfood_burgershot_cheeseburger_a',
            usetime = 6000,
            notification = 'You ate a BBQ cheeseburger',
        },
    },
    ["bbq_salad_garden"] = {
        label = "Garden Salad",
        weight = 250,
        stack = true,
        degrade = 1440,
        decay = true,
        client = {
            status = { hunger = 200000 },
            anim = { dict = 'bzzz_burgershot_anim2', clip = 'anim2' },
            prop = { model = 'bzzz_prop_fastfood_vegesalad_a', bone = 60309, pos = vec3(0.11, -0.01, 0.05), rot = vec3(-30.0, 10.0, 0.0) },
            propTwo = { model = 'bzzz_prop_fastfood_vegesalad_b', bone = 28422, pos = vec3(0.07, 0.04, -0.03), rot = vec3(-100.0, -40.0, -30.0) },
            usetime = 5000,
            notification = 'You ate a garden salad',
        },
    },
    ["bbq_salad_chicken"] = {
        label = "Grilled Chicken Salad",
        weight = 300,
        stack = true,
        degrade = 1440,
        decay = true,
        client = {
            status = { hunger = 220000 },
            anim = { dict = 'bzzz_burgershot_anim2', clip = 'anim2' },
            prop = { model = 'bzzz_prop_fastfood_vegesalad_a', bone = 60309, pos = vec3(0.11, -0.01, 0.05), rot = vec3(-30.0, 10.0, 0.0) },
            propTwo = { model = 'bzzz_prop_fastfood_vegesalad_b', bone = 28422, pos = vec3(0.07, 0.04, -0.03), rot = vec3(-100.0, -40.0, -30.0) },
            usetime = 5000,
            notification = 'You ate a grilled chicken salad',
        },
    },
    ["bbq_salad_steak"] = {
        label = "Steak Salad",
        weight = 320,
        stack = true,
        degrade = 1440,
        decay = true,
        client = {
            status = { hunger = 320000 },
            anim = { dict = 'bzzz_burgershot_anim2', clip = 'anim2' },
            prop = { model = 'bzzz_prop_fastfood_vegesalad_a', bone = 60309, pos = vec3(0.11, -0.01, 0.05), rot = vec3(-30.0, 10.0, 0.0) },
            propTwo = { model = 'bzzz_prop_fastfood_vegesalad_b', bone = 28422, pos = vec3(0.07, 0.04, -0.03), rot = vec3(-100.0, -40.0, -30.0) },
            usetime = 5000,
            notification = 'You ate a steak salad',
        },
    },
    ["bbq_salad_salmon"] = {
        label = "Salmon Salad",
        weight = 300,
        stack = true,
        degrade = 1440,
        decay = true,
        client = {
            status = { hunger = 300000 },
            anim = { dict = 'bzzz_burgershot_anim2', clip = 'anim2' },
            prop = { model = 'bzzz_prop_fastfood_vegesalad_a', bone = 60309, pos = vec3(0.11, -0.01, 0.05), rot = vec3(-30.0, 10.0, 0.0) },
            propTwo = { model = 'bzzz_prop_fastfood_vegesalad_b', bone = 28422, pos = vec3(0.07, 0.04, -0.03), rot = vec3(-100.0, -40.0, -30.0) },
            usetime = 5000,
            notification = 'You ate a salmon salad',
        },
    },
    ["bbq_bacon_cheeseburger"] = {
        label = "Bacon Cheeseburger",
        weight = 420,
        stack = true,
        degrade = 2880,
        decay = true,
        client = {
            status = { hunger = 430000 },
            anim = 'eating',
            prop = 'bzzz_fastfood_burgershot_cheeseburger_a',
            usetime = 6000,
            notification = 'You ate a bacon cheeseburger',
        },
    },
    ["bbq_loaded_potato"] = {
        label = "Loaded Potato",
        description = "Grilled potato loaded with bacon and cheese.",
        weight = 300,
        stack = true,
        degrade = 2880,
        decay = true,
        client = {
            status = { hunger = 260000 },
            anim = 'eating',
            prop = 'bzzz_food_grill_potato_grill_a',
            usetime = 5600,
            notification = 'You ate a loaded potato',
        },
    },
    ["bbq_fish_burger"] = {
        label = "Fish Burger",
        weight = 360,
        stack = true,
        degrade = 2880,
        decay = true,
        client = {
            status = { hunger = 340000 },
            anim = 'eating',
            prop = 'bzzz_fastfood_burgershot_bigburger_a',
            usetime = 6000,
            notification = 'You ate a fish burger',
        },
    },
    ["bbq_surf_turf"] = {
        label = "Surf & Turf",
        description = "A grilled steak paired with grilled fish and a grilled potato — the works.",
        weight = 480,
        stack = true,
        degrade = 2880,
        decay = true,
        client = {
            status = { hunger = 480000 },
            anim = { dict = 'bzzz_burgershot_anim2', clip = 'anim2' },
            prop = { model = 'bzzz_food_grill_bbq_f', bone = 60309, pos = vec3(0.11, -0.01, 0.05), rot = vec3(-30.0, 10.0, 0.0) },
            propTwo = { model = 'bzzz_prop_fastfood_vegesalad_b', bone = 28422, pos = vec3(0.07, 0.04, -0.03), rot = vec3(-100.0, -40.0, -30.0) },
            usetime = 6400,
            notification = 'You devoured a surf & turf plate',
        },
    },
    ["bbq_salad_cobb"] = {
        label = "Cobb Salad",
        description = "Loaded salad with grilled chicken and bacon.",
        weight = 340,
        stack = true,
        degrade = 1440,
        decay = true,
        client = {
            status = { hunger = 240000 },
            anim = { dict = 'bzzz_burgershot_anim2', clip = 'anim2' },
            prop = { model = 'bzzz_prop_fastfood_vegesalad_a', bone = 60309, pos = vec3(0.11, -0.01, 0.05), rot = vec3(-30.0, 10.0, 0.0) },
            propTwo = { model = 'bzzz_prop_fastfood_vegesalad_b', bone = 28422, pos = vec3(0.07, 0.04, -0.03), rot = vec3(-100.0, -40.0, -30.0) },
            usetime = 5000,
            notification = 'You ate a cobb salad',
        },
    },

    -- =========================================================
    -- Burger Shot prep intermediates (made at the prep_station from raw
    -- produce/meat bought from farmers & hunters). 1 raw item -> several of
    -- these, which keeps menu costs low. Vegetable/dairy bits perish.
    -- =========================================================
    ["tomato_sliced"] = {
        label = "Tomato Slices",
        weight = 5,
        stack = true,
        degrade = 8640,
        decay = true,
    },
    ["lettuce_shredded"] = {
        label = "Shredded Lettuce",
        weight = 5,
        stack = true,
        degrade = 8640,
        decay = true,
    },
    ["onion_sliced"] = {
        label = "Sliced Onion",
        weight = 5,
        stack = true,
        degrade = 8640,
        decay = true,
    },
    ["pickle_slice"] = {
        label = "Pickle Slices",
        weight = 5,
        stack = true,
        degrade = 14400,
        decay = true,
    },
    ["cheese_block"] = {
        label = "Cheese Block",
        weight = 200,
        stack = true,
        degrade = 20160,
        decay = true,
    },
    ["cheese_slice"] = {
        label = "Cheese Slice",
        weight = 10,
        stack = true,
        degrade = 14400,
        decay = true,
    },
    ["flour"] = {
        label = "Flour",
        weight = 10,
        stack = true,
        degrade = 43200,
        decay = true,
    },
    ["raw_bacon"] = {
        label = "Raw Bacon",
        weight = 40,
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ["bacon_strip"] = {
        label = "Bacon Strip",
        weight = 35,
        stack = true,
        degrade = 5760,
        decay = true,
        client = {
            status = { hunger = 80000 },
            anim = 'eating',
            prop = 'bzzz_food_grill_bacon_grill_a',
            usetime = 2000,
            notification = 'You ate a bacon strip',
        },
    },
    ["raw_chicken_fillet"] = {
        label = "Raw Chicken Fillet",
        weight = 110,
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ["chicken_fillet"] = {
        label = "Chicken Fillet",
        weight = 110,
        stack = true,
        degrade = 5760,
        decay = true,
        client = {
            status = { hunger = 120000 },
            anim = 'eating',
            prop = 'bzzz_food_grill_chicken_grill_d',
            usetime = 2500,
            notification = 'You ate a chicken fillet',
        },
    },
    ["raw_onion_rings"] = {
        label = "Raw Onion Rings",
        weight = 80,
        stack = true,
        degrade = 8640,
        decay = true,
    },
    ["raw_nuggets"] = {
        label = "Raw Nuggets",
        weight = 80,
        stack = true,
        degrade = 10080,
        decay = true,
    },

    ['burger'] = {
        label = 'Burger',
        weight = 110,
        client = {
            status = { hunger = 150000 },
            anim = 'eating',
            prop = 'bzzz_fastfood_burgershot_cheeseburger_a',
            usetime = 2500,
            notification = 'You ate a delicious burger'
        },
    },

    -- =========================================================
    -- Burger Shot menu products (assembled at the prep_station 'Build' tab
    -- from cooked components, then sold at the register). Named after the GTA
    -- Burger Shot menu. The plain `burger` above is sold as the "Moo Burger";
    -- everything below is a signature item.
    -- =========================================================
    ['bs_bleeder'] = {
        label = 'The Bleeder',
        weight = 250,
        client = { status = { hunger = 300000 }, anim = 'eating', prop = 'bzzz_fastfood_burgershot_cheeseburger_a', usetime = 2500, notification = 'You sank your teeth into a Bleeder' },
    },
    ['bs_heartstopper'] = {
        label = 'Heart Stopper',
        weight = 480,
        client = { status = { hunger = 450000 }, anim = 'eating', prop = 'bzzz_fastfood_burgershot_bigburger_a', usetime = 3500, notification = 'You survived a Heart Stopper... barely' },
    },
    ['bs_moneyshot'] = {
        label = 'Money Shot',
        weight = 360,
        client = { status = { hunger = 400000 }, anim = 'eating', prop = 'bzzz_fastfood_burgershot_bigburger_a', usetime = 3000, notification = 'You devoured a Money Shot' },
    },
    ['bs_torpedo'] = {
        label = 'The Torpedo',
        weight = 280,
        client = { status = { hunger = 300000 }, anim = 'eating', prop = 'bzzz_fastfood_burgershot_cheeseburger_a', usetime = 2500, notification = 'You launched a Torpedo' },
    },
    ['bs_meatfree'] = {
        label = 'Meat Free',
        weight = 220,
        client = { status = { hunger = 350000 }, anim = 'eating', prop = 'bzzz_fastfood_burgershot_cheeseburger_a', usetime = 2500, notification = 'You ate a Meat Free burger' },
    },
    ['bs_beeftower'] = {
        label = 'Beef Tower',
        weight = 360,
        client = { status = { hunger = 400000 }, anim = 'eating', prop = 'bzzz_fastfood_burgershot_bigburger_a', usetime = 3000, notification = 'You toppled a Beef Tower' },
    },
    ['bs_meatstack'] = {
        label = 'Meat Stack',
        weight = 360,
        client = { status = { hunger = 350000 }, anim = 'eating', prop = 'bzzz_fastfood_burgershot_bigburger_a', usetime = 3000, notification = 'You demolished a Meat Stack' },
    },
    ['bs_bigburger'] = {
        label = 'Big Burger',
        weight = 320,
        client = { status = { hunger = 300000 }, anim = 'eating', prop = 'bzzz_fastfood_burgershot_bigburger_a', usetime = 2800, notification = 'You ate a Big Burger' },
    },
    ['bs_fowlshot'] = {
        label = 'Fowl Shot',
        weight = 250,
        client = { status = { hunger = 250000 }, anim = 'eating', prop = 'bzzz_fastfood_burgershot_cheeseburger_a', usetime = 2500, notification = 'You ate a Fowl Shot' },
    },
    ['bs_cheesefries'] = {
        label = 'Cheese Fries',
        weight = 140,
        client = { status = { hunger = 100000 }, anim = 'eating', prop = 'bzzz_fastfood_burgershot_fries_a', usetime = 2200, notification = 'You ate cheese fries' },
    },
    ['bs_dirtyfries'] = {
        label = 'Dirty Fries',
        weight = 170,
        client = { status = { hunger = 150000 }, anim = 'eating', prop = 'bzzz_fastfood_burgershot_fries_a', usetime = 2400, notification = 'You ate loaded dirty fries' },
    },
    ['onion_rings'] = {
        label = 'Onion Rings',
        weight = 90,
        client = {
            status = { hunger = 120000 },
            anim = 'eating',
            prop = 'bzzz_fastfood_burgershot_onion_a',
            usetime = 2000,
            notification = 'You ate some onion rings'
        },
    },
    ['nuggets'] = {
        label = 'Chicken Nuggets',
        weight = 90,
        client = {
            status = { hunger = 150000 },
            anim = 'eating',
            prop = 'bzzz_fastfood_burgershot_nugget_a',
            usetime = 2000,
            notification = 'You ate some nuggets'
        },
    },

    ['sham_sandwich'] = {
        label = 'Sandwich',
        weight = 200,
        client = {
            status = { hunger = 150000 },
            anim = 'eating',
            prop = 'sandwich',
            usetime = 2500,
        },
    },

    ['chipscheese'] = {
        label = ' Phat Chips Cheese flavor',
        weight = 150,
        client = {
            status = { hunger = 100000 },
            anim = 'eating',
            prop = 'v_ret_ml_chips2',
            usetime = 2500,
        },
        onUse = {
            giveItem = 'trash_chips'
        },
    },

    ['chipshabanero'] = {
        label = ' Phat Chips Habanero flavor',
        weight = 150,
        client = {
            status = { hunger = 100000 },
            anim = 'eating',
            prop = 'v_ret_ml_chips2',
            usetime = 2500,
        },
        onUse = {
            giveItem = 'trash_chips'
        },
    },

    ['chipsribs'] = {
        label = ' Phat Chips Sticky Ribs flavor',
        weight = 150,
        client = {
            status = { hunger = 100000 },
            anim = 'eating',
            prop = 'v_ret_ml_chips2',
            usetime = 2500,
        },
        onUse = {
            giveItem = 'trash_chips'
        },
    },

    ['chipssalt'] = {
        label = ' Phat Chips Salt & Vinegar flavor',
        weight = 150,
        client = {
            status = { hunger = 100000 },
            anim = 'eating',
            prop = 'v_ret_ml_chips2',
            usetime = 2500,
        },
        onUse = {
            giveItem = 'trash_chips'
        },
    },

    ['brownie_mix'] = {
        label = 'Brownie Mix',
        description = 'A box of tubby brand brownie mix',
        weight = 150, 
        stack = false,
        client = {

        },
    },

    ['brownie'] = {
        label = 'Brownie',
        weight = 100,
        stack = false,
        client = {
            status = { hunger = 100000 },
            anim = 'eating',
            prop = 'chocolate',
            usetime = 4000,
            notification = 'You ate a brownie.'
        },
    },

    ['weed_brownie'] = {
        label = 'Brownie',
        weight = 100,
        stack = false,
    },

    ['meth_brownie'] = {
        label = 'Brownie',
        weight = 100,
        stack = false,
    },

     -- ['mustard'] = {
     --    label = 'Mustard',
     --    weight = 500,
     --    client = {
     --        status = { hunger = 25000, thirst = 25000 },
     --        anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
     --        prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
     --        usetime = 2500,
     --        notification = 'You... drank mustard'
     --    }
     -- },


    -- drink items
     ['water'] = {
        label = 'Water',
        weight = 250,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
            usetime = 2500,
            cancel = true,
            notification = 'You drank some refreshing water'
        },
        -- Example of giving multiple items with different counts
       -- onUse = {
        --    giveItems = {
        --        { name = 'garbage', count = 1 },  -- Empty bottle becomes garbage
       --     }
       -- }
    },

     ['sprunk'] = {
        label = 'Sprunk',
        weight = 350,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
            notification = 'You quenched your thirst with a sprunk'
        }
    }, 

    ['cola'] = {
        label = 'eCola',
        weight = 350,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
            notification = 'You drank a refreshing eCola'
        }
    },

    -- GTA 5 Lore-Friendly Vending Machine Items
    ['orang_o_tang'] = {
        label = 'Orang-O-Tang',
        weight = 350,
        client = {
            status = { thirst = 200000 },
            anim = 'drinking',
            prop = 'soda_can',
            usetime = 4000,
            notification = 'You drank a tangy Orang-O-Tang'
        }
    },

    ['raine'] = {
        label = 'Raine',
        weight = 400,
        client = {
            status = { thirst = 250000 },
            anim = 'drinking',
            prop = 'water_bottle',
            usetime = 5000,
            notification = 'You drank some premium Raine Water'
        }
    },

    -- =========================================================
    -- Burger Shot soda-fountain drinks — DEDICATED cup items poured at the
    -- drink machine (separate from the canned/bottled sodas elsewhere). GTA
    -- brands served in a fountain cup.
    -- =========================================================
    ['soda_ecola'] = {
        label = 'eCola',
        weight = 350,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `bzzz_fastfood_burgershot_drink_a`, pos = vec3(0.01, 0.02, 0.05), rot = vec3(0.0, 0.0, 0.0) },
            usetime = 2500,
            notification = 'You sipped an ice-cold eCola'
        }
    },
    ['soda_ecola_cherry'] = {
        label = 'eCola Cherry',
        weight = 350,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `bzzz_fastfood_burgershot_drink_a`, pos = vec3(0.01, 0.02, 0.05), rot = vec3(0.0, 0.0, 0.0) },
            usetime = 2500,
            notification = 'You drank a fizzy eCola Cherry'
        }
    },
    ['soda_sprunk'] = {
        label = 'Sprunk',
        weight = 350,
        client = {
            status = { thirst = 210000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `bzzz_fastfood_burgershot_drink_a`, pos = vec3(0.01, 0.02, 0.05), rot = vec3(0.0, 0.0, 0.0) },
            usetime = 2500,
            notification = 'You gulped a citrusy Sprunk'
        }
    },
    ['soda_sprunk_zero'] = {
        label = 'Sprunk Zero',
        weight = 350,
        client = {
            status = { thirst = 220000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `bzzz_fastfood_burgershot_drink_a`, pos = vec3(0.01, 0.02, 0.05), rot = vec3(0.0, 0.0, 0.0) },
            usetime = 2500,
            notification = 'You drank a crisp Sprunk Zero'
        }
    },
    ['soda_orangotang'] = {
        label = 'Orang-O-Tang',
        weight = 350,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `bzzz_fastfood_burgershot_drink_a`, pos = vec3(0.01, 0.02, 0.05), rot = vec3(0.0, 0.0, 0.0) },
            usetime = 2500,
            notification = 'You drank a tangy Orang-O-Tang'
        }
    },
    ['soda_raine'] = {
        label = 'Raine Water',
        weight = 400,
        client = {
            status = { thirst = 250000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `bzzz_fastfood_burgershot_drink_a`, pos = vec3(0.01, 0.02, 0.05), rot = vec3(0.0, 0.0, 0.0) },
            usetime = 2500,
            notification = 'You sipped some crisp Raine water'
        }
    },
    ['soda_junkenergy'] = {
        label = 'Junk Energy',
        weight = 350,
        client = {
            status = { thirst = 180000, stress = -10000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `bzzz_fastfood_burgershot_drink_a`, pos = vec3(0.01, 0.02, 0.05), rot = vec3(0.0, 0.0, 0.0) },
            usetime = 2500,
            notification = 'Junk Energy — keep it sleazy!'
        }
    },
    ['soda_bsshake'] = {
        label = 'Burger Shot Shake',
        weight = 400,
        client = {
            status = { thirst = 160000, hunger = 80000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `bzzz_fastfood_burgershot_drink_a`, pos = vec3(0.01, 0.02, 0.05), rot = vec3(0.0, 0.0, 0.0) },
            usetime = 4000,
            notification = 'You slurped a thick Burger Shot shake'
        }
    },

    ['ps_and_qs'] = {
        label = "P's & Q's",
        weight = 100,
        client = {
            status = { hunger = 80000 },
            anim = 'eating',
            prop = 'candy',
            usetime = 3500,
            notification = "You ate some P's & Q's"
        }
    },

    ['ego_chaser'] = {
        label = 'Ego Chaser',
        weight = 120,
        client = {
            status = { hunger = 100000 },
            anim = 'eating',
            prop = 'chocolate',
            usetime = 5000,
            notification = 'You ate an Ego Chaser energy bar'
        }
    },

    ['meteorite_bar'] = {
        label = 'Meteorite Bar',
        weight = 100,
        -- consume handled by atlas_consumables (multi-bite session)
    },

    ['latte'] = {
        label = 'Bean Machine Latte',
        weight = 250,
        client = {
            status = { thirst = 180000 },
            anim = 'drinking',
            prop = 'coffee_cup',
            usetime = 7000,
            notification = 'You enjoyed a creamy Bean Machine latte'
        }
    },

    ['espresso'] = {
        label = 'Espresso Shot',
        weight = 150,
        client = {
            status = { thirst = 100000 },
            anim = 'drinking',
            prop = 'coffee_cup',
            usetime = 2500,
            notification = 'You drank a strong espresso shot'
        }
    },

    ['hot_chocolate'] = {
        label = 'Hot Chocolate',
        weight = 250,
        client = {
            status = { thirst = 150000, hunger = 50000 },
            anim = 'drinking',
            prop = 'coffee_cup',
            usetime = 6000,
            notification = 'You enjoyed a warm hot chocolate'
        }
    },

     ['wine'] = {
        label = 'Wine',
        weight = 500,
        client = {
            status = { thirst = 120000, stress = -100000 },
            notification = 'You savored the wine and feel more sophisticated...',
            alcoholLevel = 1.0  -- Wine is moderate strength
        },
    },

    -- ['grapejuice'] = {
    --     label = 'Grape Juice',
    --     weight = 200,
    -- },

    ['fruitjuice'] = {
        label = 'Fruit Juice',
        weight = 200,
        client = {
            status = { thirst = 150000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
            notification = 'You drank some refreshing fruit juice'
        }
    },

    ['junkdrink'] = {
        label = 'Junk Energy Drink',
        weight = 350,
        client = {
            status = { thirst = 150000, energy = 100000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
            notification = 'You drank a Junk Energy Drink and feel energized!'
        }
    },

    ['limejuice'] = {
        label = 'Lime Juice',
        weight = 200,
    },

    ['coffee'] = {
        label = 'Coffee',
        weight = 200,
        client = {
            status = { thirst = 150000 },
            anim = 'drinking',
            prop = 'coffee_cup',
            usetime = 5000,
            notification = 'You drank a warm cup of coffee'
        }
    },

    ['vodka'] = {
        label = 'Vodka',
        weight = 500,
        client = {
            status = { thirst = 100000, stress = -150000 },
            notification = 'You drank some vodka and feel the burn...',
            alcoholLevel = 1.5  -- Vodka is stronger than beer
        },
    },

    ['whiskey'] = {
        label = 'Whiskey',
        weight = 200,
        client = {
            status = { thirst = 80000, stress = -120000 },
            notification = 'You took a swig of whiskey and feel the warmth...',
            alcoholLevel = 1.3  -- Whiskey is strong but slightly less than vodka
        },
    },

    ['beer'] = {
        label = 'Beer',
        weight = 200,
        client = {
            status = { thirst = 150000, stress = -80000 },
            notification = 'You drank a refreshing beer',
            alcoholLevel = 0.5  -- Beer is mild
        },
    },
    ['gin'] = {
        label = 'Gin',
        weight = 500,
        client = {
            status = { thirst = 90000, stress = -130000 },
            notification = 'You drank some gin and feel the botanicals...',
            alcoholLevel = 1.4  -- Gin is strong
        },
    },
    ['tequila'] = {
        label = 'Tequila',
        weight = 500,
        client = {
            status = { thirst = 90000, stress = -140000 },
            notification = 'You downed some tequila and feel the heat...',
            alcoholLevel = 1.6  -- Tequila is very strong
        },
    },
    ['rum'] = {
        label = 'Rum',
        weight = 500,
        client = {
            status = { thirst = 90000, stress = -120000 },
            notification = 'You sipped some rum and feel the island vibes...',
            alcoholLevel = 1.2  -- Rum is strong
        },
    },

    -- ==========================================================
    -- GTA-brand spirits added for the Liquor Store. The GTA beers
    -- (pisswasser / loggerbeer / jakeyslager) and dusche_gold
    -- champagne already exist further down — these just fill the
    -- whisky/vodka gap. Drink flow + drunkenness come from
    -- atlas_consumables (category 'alcohol'); the client block is
    -- the legacy fallback. Bottle art reused via client.image.
    -- ==========================================================
    ['cherenkov_vodka'] = {
        label = 'Cherenkov Vodka',
        weight = 500,
        client = {
            image = 'tequila.png',
            status = { thirst = 90000, stress = -150000 },
            notification = 'You knock back some Cherenkov — glows going down.',
            alcoholLevel = 1.5
        },
    },
    ['macbeth_whisky'] = {
        label = 'Macbeth Whisky',
        weight = 500,
        client = {
            image = 'bottle_whiskey_premium.png',
            status = { thirst = 80000, stress = -140000 },
            notification = 'You sip some Macbeth — smooth, smoky, regal.',
            alcoholLevel = 1.3
        },
    },
    -- ['coconut_rum'] = {
    --     label = 'Coconut Rum',
    --     weight = 500,
    --     client = {
    --         status = { thirst = 100000, stress = -110000 },
    --         notification = 'You enjoyed some coconut rum and feel relaxed...',
    --         alcoholLevel = 1.0  -- Coconut rum is moderate
    --     },
    --     server = {
    --         export = 'ox_inventory.alcohol'
    --     }
    -- },
    ['vermouth'] = {
        label = 'Vermouth',
        weight = 400,
        client = {
            status = { thirst = 80000, stress = -100000 },
            notification = 'You drank some vermouth and feel sophisticated...',
            alcoholLevel = 1.1  -- Vermouth is moderate strength
        },
    },
    ['bitters'] = {
        label = 'Bitters',
        weight = 100,
    },
    ['lemonjuice'] = {
        label = 'Lemon Juice',
        weight = 200,
    },
    ['ice'] = {
        label = 'Ice Cubes',
        weight = 50,
        stack = true,
    },
    ['sugar'] = {
        label = 'Sugar Cubes',
        weight = 20,
        stack = true,
    },
    ['whiskey_cola'] = {
        label = 'Whiskey Cola',
        weight = 300,
        client = {
            status = { thirst = 180000, stress = -100000 },
            notification = 'You enjoyed a Whiskey Cola cocktail',
            alcoholLevel = 1.4,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    ['mojito'] = {
        label = 'Mojito',
        weight = 300,
        client = {
            status = { thirst = 180000, stress = -120000 },
            notification = 'You enjoyed a refreshing Mojito',
            alcoholLevel = 1.3,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    ['margarita'] = {
        label = 'Margarita',
        weight = 300,
        client = {
            status = { thirst = 180000, stress = -130000 },
            notification = 'You enjoyed a zesty Margarita',
            alcoholLevel = 1.5,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    ['screwdriver_cocktail'] = {
        label = 'Screwdriver',
        weight = 300,
        client = {
            status = { thirst = 180000, stress = -90000 },
            notification = 'You enjoyed a Screwdriver',
            alcoholLevel = 1.2,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    ['redline_cocktail'] = {
        label = 'Redline Cocktail',
        weight = 300,
        client = {
            status = { thirst = 200000, energy = 150000 },
            notification = 'You drank a Redline Cocktail and feel energized!',
            alcoholLevel = 1.4,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    ['tequilashot'] = {
        label = 'Tequila Shot',
        weight = 200,
        client = {
            status = { thirst = 100000, stress = -80000 },
            notification = 'You took a Tequila Shot and feel the burn...',
            alcoholLevel = 1.6  -- Strong shot
        },
    },
    ['whiskeyshot'] = {
        label = 'Whiskey Shot',
        weight = 200,
        client = {
            status = { thirst = 90000, stress = -70000 },
            notification = 'You took a Whiskey Shot and feel the burn...',
            alcoholLevel = 1.3  -- Strong drink
        },
    },
    ['vodkashot'] = {
        label = 'Vodka Shot',
        weight = 200,
        client = {
            status = { thirst = 90000, stress = -80000 },
            notification = 'You downed a Vodka Shot and feel the chill...',
            alcoholLevel = 1.5  -- Strong shot
        },
    },
    ['cherrybomb'] = {
        label = 'Cherry Bomb',
        weight = 250,
        client = {
            status = { thirst = 150000, stress = -90000 },
            notification = 'You drank a Cherry Bomb and feel the buzz!',
            alcoholLevel = 1.2,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    ['lemondrop'] = {
        label = 'Lemon Drop',
        weight = 250,
        client = {
            status = { thirst = 150000, stress = -90000 },
            notification = 'You drank a Lemon Drop and feel the zing!',
            alcoholLevel = 1.2,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    ['vodkalemonade'] = {
        label = 'Vodka Lemonade',
        weight = 300,
        client = {
            status = { thirst = 180000, stress = -100000 },
            notification = 'You enjoyed a Vodka Lemonade',
            alcoholLevel = 1.3,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    ['tequilasunrise'] = {
        label = 'Tequila Sunrise',
        weight = 300,
        client = {
            status = { thirst = 180000, stress = -110000 },
            notification = 'You enjoyed a Tequila Sunrise',
            alcoholLevel = 1.4,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    ['rumandcola'] = {
        label = 'Rum and Cola',
        weight = 300,
        client = {
            status = { thirst = 180000, stress = -90000 },
            notification = 'You enjoyed a Rum and Cola',
            alcoholLevel = 1.2,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    ['oldfashoned'] = {
        label = 'Old Fashioned',
        weight = 300,
        client = {
            status = { thirst = 180000, stress = -120000 },
            notification = 'You enjoyed an Old Fashioned',
            alcoholLevel = 1.4,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    ['martini'] = {
        label = 'Martini',
        weight = 250,
        client = {
            status = { thirst = 150000, stress = -100000 },
            notification = 'You enjoyed a Martini',
            alcoholLevel = 1.3,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    ['manhattan'] = {
        label = 'Manhattan',
        weight = 250,
        client = {
            status = { thirst = 150000, stress = -110000 },
            notification = 'You enjoyed a Manhattan',
            alcoholLevel = 1.3,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    ['vespuccibreeze'] = {
        label = 'Vespucci Breeze',
        weight = 300,
        client = {
            status = { thirst = 180000, stress = -90000 },
            notification = 'You enjoyed a Vespucci Breeze',
            alcoholLevel = 1.2,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    ['pisswasser'] = {
        label = 'Pisswasser',
        weight = 200,
        client = {
            status = { thirst = 150000, stress = -80000 },
            notification = 'You drank a refreshing Pisswasser',
            alcoholLevel = 0.5  -- Mild strength
        },
    },
    ['dusche_gold'] = {
        label = 'Dusche Gold',
        weight = 200,
        client = {
            image = 'bottle_champagne.png',
            status = { thirst = 150000, stress = -80000 },
            notification = 'You drank a refreshing Dusche Gold',
            alcoholLevel = 0.5  -- Mild strength
        },
    },
    ['jakeyslager'] = {
        label = "Jakey's Lager",
        weight = 200,
        client = {
            image = 'jakeysLager.png',
            status = { thirst = 150000, stress = -80000 },
            notification = 'You drank a refreshing Jakeys Lager',
            alcoholLevel = 0.5  -- Mild strength
        },
    },
    ['loggerbeer'] = {
        label = 'Logger Beer',
        weight = 200,
        client = {
            status = { thirst = 150000, stress = -80000 },
            notification = 'You drank a refreshing Logger Beer',
            alcoholLevel = 0.5  -- Mild strength
        },
    },
    ['getaway_cocktail'] = {
        label = 'Getaway Cocktail',
        weight = 300,
        client = {
            status = { thirst = 200000, energy = 150000 },
            notification = 'You drank a Getaway Cocktail and feel energized!',
            alcoholLevel = 1.4,
        },
        server = {
            export = 'ox_inventory.alcohol',
        }
    },
    -- materials
    ['wood'] = {
        label = 'Wood',
        weight = 100,
    },
    ['cloth'] = {
        label = 'Cloth',
        weight = 100,
    },
    ['old_rags'] = {
        label = 'Old Rags',
        weight = 100,
    },

    -- Note: raw `steel` / `copper` / `aluminium` items were removed 2026-05-19.
    -- The bar_steel / bar_copper / bar_aluminium items below already exist in
    -- the world economy (Foundry sells them); houserobbery salvage + atlas_loot
    -- drops now produce those bars directly instead of the raw scrap variants.

    ['rubber'] = {
        label = 'Rubber',
        weight = 100,
    },

    ['metalscrap'] = {
        label = 'Metal Scrap',
        weight = 100,
    },

    ['iron'] = {
        label = 'Iron',
        weight = 100,
    },

    ['plastic'] = {
        label = 'Plastic',
        weight = 100,
    },

    ['glass'] = {
        label = 'Glass',
        weight = 100,
    },

    ['electronicscrap'] = {
        label = 'Electronic Scrap',
        weight = 100,
    },

    ['wires'] = {
        label = 'Wires',
        weight = 100,
    },

    ['leather'] = {
        label = 'Leather',
        weight = 100,
    },

    ['feather'] = {
        label = 'Feather',
        weight = 100,
    },

    -- police, DOJ and government items

     ['id_card'] = {
        label = 'Identification Card',
        weight = 10,
    },

    ['driver_license'] = {
        label = 'Drivers License',
        weight = 10,
    },

    ['weaponlicense'] = {
        label = 'Weapon License',
        weight = 10,
    },

    ['lawyerpass'] = {
        label = 'Lawyer Pass',
        weight = 10,
    },

    ['gov_badge'] = {
        label = 'Government Badge',
        weight = 100,
        stack = false,
        close = true,
    },

    ['barrier'] = {
        label = 'Road Barrier',
        weight = 5000,
        stack = true,
        close = true,
    },

    ['trafficcone'] = {
        label = 'Traffic Cone',
        weight = 1000,
        stack = true,
        close = true,
    },

    ['donut'] = {
        label = 'Donut',
        weight = 200,
        consume = 1,
    },

    ['jello_cup'] = {
        label = 'Jello Cup',
        weight = 150,
        consume = 1,
    },

    ['lollipop'] = {
        label = 'Lollipop',
        weight = 50,
        consume = 1,
    },

     ['handcuffs'] = {
        label = 'Handcuffs',
        weight = 100,
    },

    ['spikestrip'] = {
        label = 'Spike Strip',
        description = 'A deployable spike strip used to puncture vehicle tires',
        weight = 5000,
        stack = false,
        close = true,
        client = {
            export = 'qbx_police.useSpikestrip'
        }
    },

    ['zipties'] = {
        label = 'Zip Ties',
        description = 'Plastic restraints that can be used to tie someone up',
        weight = 50,
        stack = true,
        close = true,
        client = {
            export = 'qbx_police.useZipties'
        }
    },

    ["rental_contract"] = {
        label = "Rental Contract",
        description = "A vehicle rental agreement",
        weight = 10,
        stack = false,
        close = true,
    },

    ["trucking_contract"] = {
        label = "Trucking Contract",
        description = "Delivery Contract",
        weight = 10,
        stack = false,
        close = true,
        consume = 0,
        degrade = 1440, -- 1 day
        decay = true,
        server = {
            export = "atlas_truckingjob.trucking_contract"
        },
        buttons = {
            {
                label = "Cancel Contract",
                action = function(slot)
                    TriggerEvent("trucking:client:CancelDelivery")
                end
            }
        }
    },

    -- evidence items
    ['empty_evidence_bag'] = {
        label = 'Empty Evidence Bag',
        weight = 0,
    },

    ['filled_evidence_bag'] = {
        label = 'Filled Evidence Bag',
        weight = 0,
        buttons = {
            {
                label = 'Copy Serial Number',
                action = function(slot)
                    local items = exports.ox_inventory:Search('slots', 'filled_evidence_bag')
                    local serial

                    for _, v in pairs(items) do
                        if v.slot == slot then
                            local metadata = v.metadata or {}
                            local baggedItem = metadata.item or {}
                            local baggedMetadata = baggedItem.metadata or {}

                            serial = baggedMetadata.serial
                                or baggedMetadata.serie
                                or metadata.serial
                                or metadata.serie
                            break
                        end
                    end

                    if serial then
                        lib.setClipboard(serial)
                    else
                        lib.notify({
                            id = 'evidence_no_serial',
                            type = 'error',
                            description = 'No serial number found in this evidence bag.'
                        })
                    end
                end
            },
            {
                label = 'Copy Fingerprint ID',
                action = function(slot)
                    local items = exports.ox_inventory:Search('slots', 'filled_evidence_bag')
                    local fingerprint

                    for _, v in pairs(items) do
                        if v.slot == slot then
                            local metadata = v.metadata or {}
                            fingerprint = metadata.fingerprint
                            break
                        end
                    end

                    if fingerprint then
                        lib.setClipboard(fingerprint)
                        lib.notify({ id = 'evidence_copy_print', type = 'success', description = 'Fingerprint ID copied to clipboard.' })
                    else
                        lib.notify({
                            id = 'evidence_no_print',
                            type = 'error',
                            description = 'No fingerprint found in this evidence bag.'
                        })
                    end
                end
            },
            {
                label = 'Copy DNA ID',
                action = function(slot)
                    local items = exports.ox_inventory:Search('slots', 'filled_evidence_bag')
                    local dna

                    for _, v in pairs(items) do
                        if v.slot == slot then
                            local metadata = v.metadata or {}
                            dna = metadata.dnalabel
                            break
                        end
                    end

                    if dna then
                        lib.setClipboard(dna)
                        lib.notify({ id = 'evidence_copy_dna', type = 'success', description = 'DNA ID copied to clipboard.' })
                    else
                        lib.notify({
                            id = 'evidence_no_dna',
                            type = 'error',
                            description = 'No DNA sample found in this evidence bag.'
                        })
                    end
                end
            },
            {
                label = 'Copy Tracking #',
                action = function(slot)
                    local items = exports.ox_inventory:Search('slots', 'filled_evidence_bag')
                    local tracking

                    for _, v in pairs(items) do
                        if v.slot == slot then
                            local metadata = v.metadata or {}
                            tracking = metadata.tracking
                            break
                        end
                    end

                    if tracking then
                        lib.setClipboard(tracking)
                        lib.notify({ id = 'evidence_copy_tracking', type = 'success', description = 'Evidence tracking number copied to clipboard.' })
                    else
                        lib.notify({
                            id = 'evidence_no_tracking',
                            type = 'error',
                            description = 'No tracking number found on this evidence bag.'
                        })
                    end
                end
            }
        }
    },

	['nikon'] = {
		consume = 0.0,
		label = 'Nikoff G600',
		weight = 250,
		stack = false,
		description = 'Caught in 4k',
		server = {export = 'r14-evidence.nikon'},
	},

	['sdcard'] = {
		consume = 0.0,
		label = 'SD Card',
		weight = 100,
		stack = false,
		description = 'People still use these??',
		server = {export = 'r14-evidence.sdcard'},
	},

	-- ['dnatestkit'] = {
	-- 	consume = 0.0,
	-- 	label = 'DNA Field Swab Kit',
	-- 	weight = 100,
	-- 	stack = true,
	-- 	close = true,
	-- 	description = "A field DNA swab kit containing several vials and swabs",
	-- 	server = {export = 'r14-evidence.dnatestkit'},
	-- },

	-- ['gsrtestkit'] = {
	-- 	consume = 0.0,
	-- 	label = 'GSR Field Test Kit',
	-- 	weight = 100,
	-- 	stack = true,
	-- 	close = true,
	-- 	description = "A field GSR test kit containing several test strips",
	-- 	server = {export = 'r14-evidence.gsrtestkit'},
	-- },

    -- ['drugtestkit'] = {
	-- 	consume = 0.0,
	-- 	label = 'Drug Test Kit',
	-- 	weight = 100,
	-- 	stack = true,
	-- 	description = 'A multipanel oral drug test kit like the one your lame dad or boss buys... but for cops.',
	-- 	server = {export = 'r14-evidence.drugtestkit'},
	-- },

    -- ['breathalyzer'] = {
	-- 	consume = 0.0,
	-- 	label = 'Breathalyzer',
	-- 	weight = 200,
	-- 	stack = true,
	-- 	close = true,
	-- 	description = "A vintage 2000's WiWang breathalyzer engraved Property of LSPD",
	-- 	server = {export = 'r14-evidence.breathalyzer'},
	-- },

    -- ['fingerprintreader'] = {
	-- 	consume = 0.0,
	-- 	label = 'Pro Tech XFR8001',
	-- 	weight = 200,
	-- 	stack = false,
	-- 	close = true,
	-- 	description = "A Pro Tech mobile fingerprint reader that looks like it's seen better days, currently stuck in french.",
	-- 	server = {export = 'r14-evidence.fingerprintreader'},
	-- },

	-- ['accesstool'] = {
	-- 	consume = 0.0,
	-- 	label = 'Access Tool',
	-- 	weight = 200,
	-- 	stack = false,
	-- 	description = 'Snap into an access tool.',
	-- 	server = {export = 'r14-evidence.accesstool'},
	-- },

	['evidence_toolkit'] = {
		consume = 0.0,
		label = 'Evidence Toolkit',
		weight = 500,
		stack = false,
		close = true,
		description = 'A comprehensive law enforcement evidence toolkit containing DNA swabs, GSR test strips, drug test panels, breathalyzer, fingerprint reader, fingerprint kit, mikrosil, fingerprint tape, and vehicle access tools.',
		server = {export = 'r14-evidence.evidence_toolkit'},
	},

    -- ['fingerprintkit'] = {
	-- 	consume = 0.0,
	-- 	label = 'Fingerprint Kit',
	-- 	weight = 1000,
	-- 	stack = true,
	-- 	close = true,
	-- 	description = "A small kit that includes fingerprint dust, chemicals, and a brush for developing fingerprints",
	-- },

    -- ['mikrosil'] = {
	-- 	consume = 0.0,
	-- 	label = 'Mikrosil',
	-- 	weight = 200,
	-- 	stack = true,
	-- 	close = true,
	-- 	description = "Two tubes of silicon casting material used to lift fingerprints from irregular surfaces",
	-- },

	-- ['fingerprinttape'] = {
	-- 	consume = 0.0,
	-- 	label = 'Fingerprint Tape',
	-- 	weight = 200,
	-- 	stack = true,
	-- 	close = true,
	-- 	description = "Extra clear tape used to lift fingerprints from smooth, nonporous surfaces",
	-- },

    --medical items

     -- ['medication'] = {
     --    label = 'Medication',
     --    weight = 100,
     --    client = {
     --        status = { stress = -200000 },
     --        image = 'pill_bottle.png',
     --        anim = { dict = 'eat@pills@anim', clip = 'eat_pills_clip' },
     --        prop = { model = `alcaprop_medic_pills`, bone = 18905, pos = vec3(0.14, 0.0, 0.02), rot = vec3(74.0, 112.0, 186.0) },
     --        usetime = 3000,
     --        notification = 'You took some medication and feel more relaxed'
     --    }
     -- },

    ['bandage'] = {
        label = 'Bandage',
        weight = 115,
        description = 'A simple bandage used to stop bleeding and heal minor wounds.',
    },

    ['painkillers'] = {
        label = 'Painkillers',
        weight = 100,
        description = 'Painkillers used to relieve pain and reduce discomfort.',
    },

    ['firstaid'] = {
        label = 'First Aid',
        weight = 700,
    },

    ['ifaks'] = {
        label = 'Individual First Aid Kit',
        weight = 500,
    },

    

    -- rcore_spray compatibility
    ['spray'] = {
        label = 'Spray',
        weight = 500,
    },

    ['spray_remover'] = {
        label = 'Spray Remover',
        weight = 500,
    },
    

   -- technology items
    ['racing_gps'] = {
        label = 'Racing GPS',
        weight = 500,
        stack = false,
        close = true,
        description = 'A GPS device used for racing.',
    },

    ['phone'] = {
        label = 'Phone',
        weight = 190,
        discription = 'A modern smartphone used for communication and various applications.',
        stack = false,
        consume = 0,
        client = {
            add = function(total)
                if total > 0 then
                    pcall(function() return exports.npwd:setPhoneDisabled(false) end)
                end
            end,

            remove = function(total)
                if total < 1 then
                    pcall(function() return exports.npwd:setPhoneDisabled(true) end)
                end
            end
        }
    },

    ['fitbit'] = {
        label = 'Fitbit',
        weight = 50,
        stack = false,
        consume = 0,
        description = 'A fitness tracker. Keep it in your inventory and it will warn you when your hunger or thirst drops below 20%.',
        client = {
            event = 'atlas_fitbit:client:checkStatus',
        }
    },

     ['radio'] = {
        label = 'Radio',
        weight = 200,
        allowArmed = true,
        consume = 0,
        client = {
            event = 'mm_radio:client:use'
        }
    },

    ['jammer'] = {
        label = 'Radio Jammer',
        weight = 10000,
        allowArmed = true,
        client = {
            event = 'mm_radio:client:usejammer'
        }
    },

    ['radiocell'] = {
        label = 'AAA Cells',
        weight = 1000,
        stack = true,
        allowArmed = true,
        client = {
            event = 'mm_radio:client:recharge'
        }
    },

    ['cryptostick'] = {
        label = 'Crypto Stick',
        weight = 100,
        description = 'We are so up bros!',
    },

    ['usb_stick'] = {
        label = 'USB stick',
        weight = 100,
        description = 'A blank USB stick. What should I put on it?',
        client = {
            image = 'usb_stick.png'
        }
    },
    ['infectedusb'] = {
        label = 'Infected USB',
        weight = 100,
        description = 'A USB stick infected with a virus. Maybe I can use it to hack something?',
        client = {
            image = 'infectedusb.png'
        }
    },

    ['hackingphone'] = {
        label = 'Hacking Phone',
        weight = 500,
        description = 'What nafarious deeds will you use this for?',
        client = {
            image = 'hackingphone.png'
        }
    },

      -- ['hackingdevice'] = {
      --   label = 'Hacking Device',
      --   weight = 500,
      --   client = {
      --       image = 'hackingdevice.png'
      --   }
      -- },
    
    ['brokenphone'] = {
        label = 'Broken Phone',
        weight = 190,
        description = 'A broken phone that could be used for something, or thrown away.',
    },

    ['tablet'] = {
        label = 'Tablet',
        description = 'A personal tablet. Use it to open your apps.',
        weight = 800,
        stack = false,
        close = true,
        client = {
            export = 'atlas_tablet.openTablet'
        },
    },

    --------- drug items --------- 
    
    ['portable_scale'] = {
        label = 'Portable Scale',
        description = "A portable scale for measuring things",
        weight = 200,
        stack = false,
        client = {
            image = "portable_scale.png",
        },
    },

    -- Packaging Items
    ["plastic_baggy"] = {
        label = "Plastic Bag",
        weight = 100,
        client = {
            image = "plastic_baggy.png"
        },
    },

    ['glass_jar'] = {
        label = 'Glass Jar',
        weight = 100,
        client = {
            image = "glass_jar.png",
        },
    },

    ['rolling_paper'] = {
        label = 'Rolling Paper',
        weight = 0,
    },

    -- Packaged Items
    ['joint'] = {
        label = 'Joint',
        weight = 200,
    },

    ['weed_baggy'] = {
        label = 'Weed Baggy',
        weight = 100,
        stack = true, 
        client = {
            image = "weed_baggy.png",
        },
    },

    ['meth_baggy'] = {
        label = 'Meth Baggy',
        weight = 100,
        stack = true,
        client = {
            image = "meth_baggy.png",
        },
    },

    ['coke_baggy'] = {
        label = 'Coke Baggy',
        weight = 100,
        stack = true,
        clinet = {
            image = 'coke_baggy.png',
        },
    },

    ['weed_jar'] = {
        label = 'Jar of Weed',
        weight = 500,
        stack = true,
        client = {
            image = 'weed_jar.png',
        },
    },

    ['meth_jar'] = {
        label = 'Jar of Meth',
        weight = 500,
        stack = true,
        client = {
            image = 'meth_jar.png',
        },
    },

    ['coke_jar'] = {
        label = 'Jar of Coke',
        weight = 500,
        stack = true,
        client = {
            image = 'coke_jar.png',
        },
    },

    -- Serving tray: ox_inventory container restricted to restaurant food/drinks.
    -- Container properties (slots/weight/whitelist) are registered at runtime by
    -- atlas_restaurants/server/tray.lua; carry visuals live in atlas_restaurants
    -- client/tray.lua; place-only handover via atlas_itemthrowing.
    ['tray'] = {
        label = 'Serving Tray',
        weight = 800,
        stack = false,
        close = true,
        consume = 0,
        description = 'Carry food and drinks out to customers',
    },

    -- Weed Items
    ['weed_seed'] = {
        label = 'Weed Seed',
        weight = 100,
        stack = true,
        close = true,
        description = 'Weed Seed',
        client = {
            image = 'weed_seed.png',
        },
    },

    ['weedplant_branch'] = {
        label = 'Weed Plant Branch',
        weight = 100,
        stack = true,
        close = true,
        description = 'A branch from a weed plant.',
        client = {
            image = 'weedplant_branch.png',
        },
    },

    ['weed_buds'] = {
        label = 'Weed Buds',
        weight = 10,
        stack = true,
        close = true,
        description = 'Buds from a weed plant.',
        client = {
            image = 'weed_buds.png',
        },
    },

    ['weedplant_weed'] = {
        label = 'Weed Plant Weed',
        weight = 200,
    },

    -- Meth Items
    ["lab_kit"] = {
        label = "Lab Kit",
        weight = 15000,
        client = {
            image = "lab.png",
        },
    },

    ["ammonia"] = {
        label = "Ammonia",
        weight = 100,
        client = {
            image = "ammonia.png",
        },
    },

    ["phosphorus"] = {
        label = "Phosphorus",
        weight = 100,
        client = {
            image = "phosphorus.png",
        },
    },

    ["pseudoephedrine"] = {
        label = "Pseudoephedrine",
        weight = 100,
        client = {
            image = "pseudophederine.png",
        },
    },

    ["meth_rock"] = {
        label = "Meth Rock",
        weight = 100,
        client = {
            image = "meth_rock.png",
        },
    },

    -- Cocaine Items
    ['coke_leaf'] = {
        label = 'Cocaine Leaf',
        weight = 100,
        client = {
            image = '',
        },
    },

    ['coke_powder'] = {
        label = 'Cocaine Powder',
        weight = 100,
        client = {
            image = '',
        },
    },

   -- tool items

   ['garden_clippers'] = {
        label = 'Garden Clippers',
        weight = 1000,
        description = 'A pair of garden clippers',
        stack = false,
        client = {
            image = 'garden_clippers.png',
        },
   },

    ['fertilizer'] = {
        label = 'Fertilizer',
        weight = 1000,
        stack = false,
        client = {
            image = 'fertilizer.png',
            prop = {model = "prop_cs_sack_01"}
        }
    },

    ['water_can'] = {
        label = 'Watering Can',
        description = "A can for watering things",
        weight = 10000,
        stack = false,
        client = {
            image = 'water_can.png',
            prop = {model = "prop_wateringcan"}
        }
    },

   ['armour'] = {
        label = 'Bulletproof Vest',
        weight = 3000,
        stack = false,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500
        }
    },

    -- atlas_backpacks: wearable container backpacks. Right-click → Use to wear
    -- (attaches to your back); the backpack icon then appears in the inventory
    -- header — left-click it to reopen, right-click it to unequip.
    ['backpack_tote'] = {
        label = 'Tote',
        weight = 750,
        stack = false,
        close = false,
        description = '8 slots, holds up to 10kg. Use to sling it over your shoulder.',
    },

    ['backpack_tote_b'] = {
        label = 'Tote II',
        weight = 750,
        stack = false,
        close = false,
        description = '8 slots, holds up to 10kg. Use to sling it over your shoulder.',
    },

    ['backpack_small'] = {
        label = 'Small Backpack',
        weight = 1500,
        stack = false,
        close = false,
        description = '15 slots, holds up to 20kg. Use to wear it on your back.',
    },

    ['backpack_medium'] = {
        label = 'Medium Backpack',
        weight = 2000,
        stack = false,
        close = false,
        description = '20 slots, holds up to 30kg. Use to wear it on your back.',
    },

    ['backpack_large'] = {
        label = 'Large Backpack',
        weight = 5000,
        stack = false,
        close = false,
        description = '40 slots, holds up to 60kg. Use to wear it on your back.',
    },

    ['lockpick'] = {
        label = 'Lockpick',
        weight = 160,
        stack = true,
        description = 'A basic lockpick for opening simple locks.',
    },

    ['parachute'] = {
        label = 'Parachute',
        weight = 8000,
        stack = false,
        consume = 0, -- removed when actually deployed (see modules/items/client.lua + client.lua parachute logic)
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 1500
        }
    },

    ['advancedlockpick'] = {
        label = 'Advanced Lockpick',
        weight = 500,
        stack = true,
        description = 'An advanced lockpick for opening more complex locks.',
    },

    ['screwdriverset'] = {
        label = 'Screwdriver Set',
        weight = 500,
    },

    ['electronickit'] = {
        label = 'Electronic Kit',
        weight = 500,
    },

    ['drill'] = {
        label = 'Drill',
        weight = 5000,
        description = 'A powerful drill for breaking through tough materials.',
    },

    ['thermite'] = {
        label = 'Thermite',
        weight = 1000,
        description = 'A powerful chemical mixture used for explosives.',
    },

    -- ['jerry_can'] = {
    --     label = 'Jerrycan',
    --     weight = 3000,
    -- },

    -- ['nitrous'] = {
    --     label = 'Nitrous',
    --     weight = 1000,
    -- },

    -- ['walking_stick'] = {
    --     label = 'Walking Stick',
    --     weight = 1000,
    -- },

    ['lighter'] = {
        label = 'Lighter',
        weight = 200,
        description = 'Was this stolen or bought? Who knows, but it can be used to light things on fire.',
    },

    ['binoculars'] = {
        label = 'Binoculars',
        weight = 800,
    },

    ['blind_fold'] = {
        label = 'blindfold',
        weight = 300,
        stack = false,
        client = {
            image = 'head_bag.png',
        },
    },

    -- misc items
    ['pharmacy_register_key'] = {
        label = "Register Key",
        weight = 100,
        stack = false,
        description = "A key to a quick",
    },

    ['foot'] = {
        label = 'Foot',
        weight = 500,
        stack = false,
        description = 'Um... Ew? You should put that back where you found it.',
        client = {
            image = 'foot.png',
        }
    },
    ['toiletpaper'] = {
        label = 'Toilet Paper',
        weight = 50,
        description = 'A roll of toilet paper. Better stock up, you never know when you might need it.',
        stack = true,
        client = {
            image = 'toiletpaper.png',
        }
    },

    ['garbage'] = {
        label = 'Garbage',
        weight = 50,
        stack = true,
    },

    ['trash_chips'] = {
        label = 'Empty Chips Bag',
        weight = 50,
        description = 'An empty chips bag. Someone ate them all.',
        client = {
            image = 'emptychipsbag.png',
            
        }
    },

    ['paperbag'] = {
        label = 'Paper Bag',
        weight = 1,
        stack = false,
        close = false,
        consume = 0,
        description = 'what goodies could be inside?',
    },

    ['ems_duffle_bag'] = {
        label = 'EMS Duffle Bag',
        weight = 2000,
        stack = false,
        close = false,
        consume = 0,
        description = 'A durable canvas duffle for medical supplies.',
    },

    ['wallet'] = {
        label = 'Wallet',
        weight = 100,
        stack = false,
        close = false,
        consume = 0,
        description = 'A wallet that may contain money, cards, and other personal items.',
    },

    ['choco_chunk'] = {
        label = 'Choco Chunk',
        weight = 10,
        consume = 1,
        client = {
            status = { hunger = 40000, stress = -25000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger' },
            prop = { model = `prop_candy_pqs`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
            usetime = 2500,
        }
    },

    ['clothing'] = {
        label = 'Clothing',
        weight = 500,
        consume = 0,
    },

    ['money'] = {
        label = 'Money',
        description = 'A nessesary item needed for Capitalism',
    },

    ['quarter'] = {
        label = 'Quarter',
        weight = 10,
        description = 'A quarter. It\'s worth 25 cents.',
        stack = true,
        client = {
            image = "quarter.png",
        },
    },

    ['coin_wrapper'] = {
        label = 'Quarter Wrapper',
        weight = 10,
        description = 'Make sure to wash your hands afterwards.',
        stack = true,
        client = {
            image = "coin_wrapper.png"
        },
    },

    ['roll_of_quarters'] = {
        label = 'Roll of Quarters',
        weight = 400,
        description = 'A roll of quarters. It contains 40 quarters, worth a total of $10.',
        stack = true,
        client = {
            image = 'roll_of_quarters.png',
        },
    },

    ['dice'] = {
        label = 'Dice',
        weight = 50,
        description = 'Let\'s Go Gambling, Aw Dangit',
        stack = false,
        client = {
            image = "dice.png",
        },
    },

    -- ['black_money'] = {
    --     label = 'Dirty Money',
    --     description = 'Untraceable and illegal currency.',
    -- },


    ['diamond_ring'] = {
        label = 'Diamond Ring',
        weight = 1500,
        description = 'Diamonds are a girl\'s best friend.',
    },

    -- ['crowex'] = {
    --     label = 'Crowex Luxury Watch',
    --     weight = 1500,
    -- },

     ['goldwatch'] = {
        label = 'Golden Watch',
         weight = 1500,
         description = 'A fancy golden watch. You can\'t tell the time with it, but it sure looks good on your wrist.',
     },

    ['goldbar'] = {
        label = 'Minted Gold Bar',
        weight = 1500,
    },

    -- ['goldbar_small'] — removed 2026-05-19. Houserobbery jewelry melts now
    -- produce bar_silver / bar_brass directly (sellable at Foundry). See
    -- [Player]/[Crim]/atlas_houserobbery/sql/migrate_goldbar_small_to_foundry_bars.sql.

    ['goldchain'] = {
        label = 'Golden Chain',
        weight = 1500,
        description = 'A fancy golden chain that adds a touch of elegance to any outfit.',
    },
    ['jewelrychain'] = {
        label = 'Jewelry Chain',
        weight = 1500,
        description = 'A fancy jewelry chain that adds a touch of elegance to any outfit.',
            client = {
                image = 'jewelrychain.png',
            }
    },
    ['wedding_ring'] = {
        label = 'Wedding Ring',
        weight = 1500,
        description = 'A wedding ring with engraved words, "until death do us part, or I get sick of my in-laws".',
            client = {
                image = 'weddingring.png',
            }

    },

    ['firework1'] = {
        label = '2Brothers',
        weight = 1000,
    },

    ['firework2'] = {
        label = 'Poppelers',
        weight = 1000,
    },

    ['firework3'] = {
        label = 'WipeOut',
        weight = 1000,
    },

    ['firework4'] = {
        label = 'Weeping Willow',
        weight = 1000,
    },

    -- ['gatecrack'] = {
    --     label = 'Gatecrack',
    --     weight = 1000,
    -- },


 

    -- ['security_card_02'] = {
    --     label = 'Security Card B',
    --     weight = 100,
    -- },

    
    -- diving items

    ['diving_gear'] = {
        label = 'Diving Gear',
        weight = 30000,
    },

    ['diving_fill'] = {
        label = 'Diving Tube',
        weight = 3000,
    },
   
    -- farming items
    ["apple"] = {
        label = "Apple",
        description = "Freshly Picked Apple",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000, 
        },
    },
    ["orange"] = {
        label = "orange",
        description = "Freshly Picked Orange",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000, 
        },
    },
    ["peach"] = {
        label = "Peach",
        description = "Freshly Picked Peach",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000, 
        },
    },
    ["corn_seed"] = {
        label = "Corn Seed",
        description = "A corn seed used for growing corn",
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = "seed_corn.png",
            prop = {model = "SM_CornSeed_01"},
        },
    },
    ["tomato_seed"] = {
        label = "Tomato Seed",
        description = "A tomato seed used for growing tomatoes",
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = "seed_tomato.png",
            prop = {model = ""},
        },
    },
    ["lettuce_seed"] = {
        label = "Lettuce Seed",
        description = "A lettuce seed used for growing lettuce",
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = "seed_lettuce.png",
            prop = {model = ""},
        },
    },
    ["carrot_seed"] = {
        label = "Carrot Seed",
        description = "A carrot seed used for growing carrots",
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = "seed_carrot.png",
            prop = {model = ""},
        },
    },
    ["cucumber_seed"] = {
        label = "Cucumber Seed",
        description = "A cucumber seed used for growing cucumbers",
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = "seed_cucumber.png",
            prop = {model = ""},
        },
    },
    ["garlic_seed"] = {
        label = "Garlic Seed",
        description = "A garlic seed used for growing garlic",
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = "seed_garlic.png",
            prop = {model = ""},
        },
    },
    ["onion_seed"] = {
        label = "Onion Seed",
        description = "An onion seed used for growing onions",
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = "seed_onion.png",
            prop = {model = ""},
        },
    },
    ["potato_seed"] = {
        label = "Potato Seed",
        description = "A potato seed used for growing potatoes",
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = "seed_potato.png",
            prop = {model = ""},
        },
    },
    ["pumpkin_seed"] = {
        label = "Pumpkin Seed",
        description = "A pumpkin seed used for growing pumpkins",
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = "seed_pumpkin.png",
            prop = {model = ""},
        },
    },
    ["radish_seed"] = {
        label = "Radish Seed",
        description = "A radish seed used for growing radishes",
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = "seed_radish.png",
            prop = {model = ""},
        },
    },
    ["red_beet_seed"] = {
        label = "Red Beet Seed",
        description = "A red beet seed used for growing red beets",
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = "seed_beet.png",
            prop = {model = ""},
        },
    },
    ["sunflower_seed"] = {
        label = "Sunflower Seed",
        description = "A sunflower seed used for growing sunflowers",
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = "seed_sunflower.png",
            prop = {model = ""},
        },
    },
    ["watermelon_seed"] = {
        label = "Watermelon Seed",
        description = "A watermelon seed used for growing watermelons",
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = "seed_watermelon.png",
            prop = {model = ""},
        },
    },
    ["wheat_seed"] = {
        label = "Wheat Seed",
        description = "A wheat seed used for growing wheat",
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = "seed_wheat.png",
            prop = {model = ""},
        },
    },
    ['tobacco_seed'] = {
        label = 'Tobacco Seed',
        description = 'A tobacco seed used for growing tobacco',
        weight = 10,
        stack = true,
        close = true,
        client = {
            image = 'seed_tabacco.png',
        },
    },
    ['tobacco_leaf'] = {
        label = 'Tobacco Leaf',
        weight = 100,
        stack = true,
        client = {
            image = '',
        },
    },
    ["corn"] = {
        label = "Corn",
        description = "Freshly Grown Corn",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {model = "SM_Corn_03", pos = vec3(0.02, 0.0, 0.01), rot = vec3(0.0, 90.0, 0.0)},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000, 
        },
    },
    ["tomato"] = {
        label = "Tomato",
        description = "Freshly Grown Tomato",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {model = "SM_Tomato_06", pos = vec3(0.02, 0.0, 0.01), rot = vec3(0.0, 90.0, 0.0)},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000, 
        },
    },
    ["lettuce"] = {
        label = "Lettuce",
        description = "Freshly Grown Lettuce",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {model = "SM_Cabbage_05", pos = vec3(0.02, 0.0, 0.01), rot = vec3(0.0, 90.0, 0.0)},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000, 
        },
    },
    ["carrot"] = {
        label = "Carrot",
        description = "Freshly Grown Carrot",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {model = "SM_Carrot_06", pos = vec3(0.02, 0.0, 0.01), rot = vec3(0.0, 90.0, 0.0)},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000,
        },
    },
    ["cucumber"] = {
        label = "Cucumber",
        description = "Freshly Grown Cucumber",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {model = "SM_Cucumber_05", pos = vec3(0.02, 0.0, 0.01), rot = vec3(0.0, 90.0, 0.0)},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000, 
        },
    },
    ["garlic"] = {
        label = "Garlic",
        description = "Freshly Grown Garlic",
        weight = 1,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {model = "SM_Garlic_05", pos = vec3(0.02, 0.0, 0.01), rot = vec3(0.0, 90.0, 0.0)},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000, 
        },
    },
    ["onion"] = {
        label = "Onion",
        description = "Freshly Grown Onion",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {model = "SM_Onion_05", pos = vec3(0.02, 0.0, 0.01), rot = vec3(0.0, 90.0, 0.0)},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000,
        },
    },
    ["potato"] = {
        label = "Potato",
        description = "Freshly Grown Potato",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {model = "SM_Potato_06", pos = vec3(0.02, 0.0, 0.01), rot = vec3(0.0, 90.0, 0.0)},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000, 
        },
    },
    ["pumpkin"] = {
        label = "Pumpkin",
        description = "Freshly Grown Pumpkin",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {model = "SM_Pumpkin_06", pos = vec3(0.02, 0.0, 0.01), rot = vec3(0.0, 90.0, 0.0)},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000, 
        },
    },
    ["radish"] = {
        label = "Radish",
        description = "Freshly Grown Radish",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {model = "SM_Radish_05", pos = vec3(0.02, 0.0, 0.01), rot = vec3(0.0, 90.0, 0.0)},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000,
        },
    },
    ["red_beet"] = {
        label = "Red Beet",
        description = "Freshly Grown Red Beet",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {model = "SM_RedBeet_05", pos = vec3(0.02, 0.0, 0.01), rot = vec3(0.0, 90.0, 0.0)},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000,
        },
    },
    ["sunflower"] = {
        label = "Sunflower",
        description = "Freshly Grown Sunflower",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {model = "SM_SunflowerSeed_01", pos = vec3(0.02, 0.0, 0.01), rot = vec3(0.0, 90.0, 0.0)},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000, 
        },
    },
    ["watermelon"] = {
        label = "Watermelon",
        description = "Freshly Grown Watermelon",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {model = "SM_Watermelon_05", pos = vec3(0.02, 0.0, 0.01), rot = vec3(0.0, 90.0, 0.0)},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000, 
        },
    },
    ["wheat"] = {
        label = "Wheat",
        description = "Freshly Grown Wheat",
        weight = 10,
        consume = 1,
        degrade = 8640, -- 6 days
        decay = true, 
        stack = true, 
        close = true,
        client = {
            status = {hunger = 10000},
            image = "",
            prop = {model = "SM_Wheat_03", pos = vec3(0.02, 0.0, 0.01), rot = vec3(0.0, 90.0, 0.0)},
            anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp",},
            cancel = true,
            usetime = 2000,
        },
    },
    -- ['grape'] = {
    --     label = 'Grape',
    --     weight = 10,
    -- },
    
    -- atlas_fishing
    ['fishingrod'] = {
        label = 'Fishing Rod',
        consume = 0,
        stack = false,
        weight = 1000,
        client = {
            image = 'fishingrod.png',
            export = 'atlas_fishing.startFishing'
        }
    },
    ['worm'] = {
        label = 'Worm',
        stack = true,
        weight = 250,
        client = {
            image = 'worm.png',
            export = 'atlas_fishing.changeLure'
        }
    },
    ['minnow'] = {
        label = 'Minnow',
        stack = true,
        weight = 250,
        client = {
            image = 'minnow.png',
            export = 'atlas_fishing.changeLure'
        }
    },
        ['jig_green'] = {
        label = 'Green Jig',
        stack = true,
        weight = 250,
        client = {
            image = 'jig_green.png',
            export = 'atlas_fishing.changeLure'
        }
    },
    ['jig_black'] = {
        label = 'Black Jig',
        stack = true,
        weight = 250,
        client = {
            image = 'jig_black.png',
            export = 'atlas_fishing.changeLure'
        }
    },
    ['jig_red'] = {
        label = 'Red Jig',
        stack = true,
        weight = 250,
        client = {
            image = 'jig_red.png',
            export = 'atlas_fishing.changeLure'
        }
    },
    ['jig_silver'] = {
        label = 'Silver Jig',
        stack = true,
        weight = 250,
        client = {
            image = 'jig_silver.png',
            export = 'atlas_fishing.changeLure'
        }
    },
    ['jig_gold'] = {
        label = 'Gold Jig',
        stack = true,
        weight = 250,
        client = {
            image = 'jig_gold.png',
            export = 'atlas_fishing.changeLure'
        }
    },
    ['spoon_green'] = {
        label = 'Green Spoon',
        stack = true,
        weight = 250,
        client = {
            image = 'spoon_green.png',
            export = 'atlas_fishing.changeLure'
        }
    },
    ['spoon_black'] = {
        label = 'Black Spoon',
        stack = true,
        weight = 250,
        client = {
            image = 'spoon_black.png',
            export = 'atlas_fishing.changeLure'
        }
    },
    ['spoon_red'] = {
        label = 'Red Spoon',
        stack = true,
        weight = 250,
        client = {
            image = 'spoon_red.png',
            export = 'atlas_fishing.changeLure'
        }
    },
    ['spoon_silver'] = {
        label = 'Silver Spoon',
        stack = true,
        weight = 250,
        client = {
            image = 'spoon_silver.png',
            export = 'atlas_fishing.changeLure'
        }
    },
    ['spoon_gold'] = {
        label = 'Gold Spoon',
        stack = true,
        weight = 250,
        client = {
            image = 'spoon_gold.png',
            export = 'atlas_fishing.changeLure'
        }
    },
    ['fish'] = {
        label = 'Common Fish',
        weight = 5,
        client = {
            image = 'fish.png',
        },
        stack = false,
        consume = 0,
    },
    -- Lake
    ['bluegill'] = {
        label = 'Bluegill',
        description = [[A common bluegill.
        Weight: {fishWeight} lb
        Size: {fishSize} in]],
        weight = 1000,
        client = {
            image = 'bluegill.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['perch'] = {
        label = 'Perch',
        description = 'A common perch.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'perch.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['crappie'] = {
        label = 'Crappie',
        description = 'A black crappie.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'crappie.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['smallmouth_bass'] = {
        label = 'Smallmouth Bass',
        description = 'A smallmouth bass.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'smallmouth_bass.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['walleye'] = {
        label = 'Walleye',
        description = 'A walleye.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'walleye.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['largemouth_bass'] = {
        label = 'Largemouth Bass',
        description = 'A largemouth bass.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'largemouth_bass.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['northern_pike'] = {
        label = 'Northern Pike',
        description = 'A northern pike.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'northern_pike.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['lake_trout'] = {
        label = 'Lake Trout',
        description = 'A common lake trout.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'lake_trout.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['muskie'] = {
        label = 'Muskie',
        description = 'A muskie.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'muskie.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    -- River
    ['brook_trout'] = {
        label = 'Brook Trout',
        description = 'A brook trout.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'brook_trout.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['channel_catfish'] = {
        label = 'Channel Catfish',
        description = 'A channel catfish.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'channel_catfish.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['rainbow_trout'] = {
        label = 'Rainbow Trout',
        description = 'A rainbow trout.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'rainbow_trout.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['brown_trout'] = {
        label = 'Brown Trout',
        description = 'A brown trout.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'brown_trout.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['blue_catfish'] = {
        label = 'Blue Catfish',
        description = 'A blue catfish.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'blue_catfish.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    -- ocean
    ['flounder'] = {
        label = 'Flounder',
        description = 'A flounder.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'flounder.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['mackerel'] = {
        label = 'Mackerel',
        description = 'A mackerel.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'mackerel.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['speckled_trout'] = {
        label = 'Speckled Trout',
        description = 'A speckled trout.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'speckled_trout.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['cod'] = {
        label = 'Cod',
        description = 'Cod.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'cod.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['yellowtail'] = {
        label = 'Yellowtail',
        description = 'A yellowtail.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'yellowtail.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['mahi_mahi'] = {
        label = 'Mahi Mahi',
        description = 'A mahi mahi.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'mahi_mahi.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['king_salmon'] = {
        label = 'King Salmon',
        description = 'A king salmon.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'king_salmon.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['barracuda'] = {
        label = 'Barracuda',
        description = 'A barracuda.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'barracuda.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },
    ['white_seabass'] = {
        label = 'White Seabass',
        description = 'A white seabass.\nWeight: {fishWeight}lb\nSize: {fishSize}in',
        weight = 1000,
        client = {
            image = 'white_seabass.png',
        },
        stack = false,
        consume = 0,
        degrade = 10080,
        decay = true,
    },

   -- atlas_mining
    ['stones'] = {
        label = 'Stones',
        weight = 1200,
    },

    ['coal'] = {
        label = 'Coal',
        weight = 1000,
    },

    ['sulfur'] = {
        label = 'Sulfur',
        weight = 900,
    },

    ['phosphate'] = {
        label = 'Phosphate',
        weight = 800,
    },

    ['ore_bauxite'] = {
        label = 'Bauxite Ore',
        weight = 2250,
    },

    ['ore_copper'] = {
        label = 'Copper Ore',
        weight = 2250,
    },

    ['ore_gold'] = {
        label = 'Gold Ore',
        weight = 2250,
    },

    ['ore_iron'] = {
        label = 'Iron Ore',
        weight = 2250,
    },
    
    ['ore_lead'] = {
        label = 'Lead Ore',
        weight = 2250,
    },

    ['ore_silver'] = {
        label = 'Silver Ore',
        weight = 2250,
    },

    ['gem_uncut_sapphire'] = {
        label = 'Uncut Sapphire',
        weight = 1400,
    },
    ['gem_uncut_emerald'] = {
        label = 'Uncut Emerald',
        weight = 1400,
    },

    ['gem_uncut_ruby'] = {
        label = 'Uncut Ruby',
        weight = 1400,
    },

    ['gem_uncut_diamond'] = {
        label = 'Uncut Diamond',
        weight = 1400,
    },

    ['gem_sapphire'] = {
        label = 'Sapphire',
        weight = 1200,
    },
    ['gem_emerald'] = {
        label = 'Emerald',
        weight = 1200,
    },

    ['gem_ruby'] = {
        label = 'Ruby',
        weight = 1200,
    },

    ['gem_diamond'] = {
        label = 'Diamond',
        weight = 1200,
    },

    ['bar_copper'] = {
        label = 'Copper Bar',
        weight = 1000,
    },

    ['bar_silver'] = {
        label = 'Silver Bar',
        weight = 1000,
    },

    ['bar_gold'] = {
        label = 'Cast Gold Bar',
        weight = 1000,
    },

    ['bar_iron'] = {
        label = 'Iron Bar',
        weight = 1000,
    },

    ['bar_steel'] = {
        label = 'Steel Bar',
        weight = 1000,
    },

    ['aluminium_oxide'] = {
        label = 'Aluminium Oxide',
        weight = 700,
    },

    ['bar_aluminium'] = {
        label = 'Aluminium Bar',
        weight = 1000,
    },

    ['bar_lead'] = {
        label = 'Lead Bar',
        weight = 1000,
    },

    ['bar_brass'] = {
        label = 'Brass Bar',
        weight = 1000,
    },

    ['gunpowder'] = {
        label = 'Gunpowder',
        weight = 700,
    },

    ['explosivepowder'] = {
        label = 'Explosive Powder',
        weight = 700,
    },

    ['projectile'] = {
        label = 'Projectile',
        weight = 700,
    },

    ['bulletcasing'] = {
        label = 'Bullet Casing',
        weight = 700,
    },

    ['ring_silver'] = {
        label = 'Silver Ring',
        weight = 100,
        description = 'An imperfect silver ring.',
    },

    ['ring_gold'] = {
        label = 'Gold Ring',
        weight = 100,
        description = 'An imperfect gold ring.',
    },

    ['ring_diamond'] = {
        label = 'Diamond Ring',
        weight = 100,
        description = 'An imperfect diamond ring.',
    },
    
    ['ring_emerald'] = {
        label = 'Emerald Ring',
        weight = 100,
        description = 'An imperfect emerald ring.',
    },

    ['ring_ruby'] = {
        label = 'Ruby Ring',
        weight = 100,
        description = 'An imperfect ruby ring.',
    },

    ['ring_sapphire'] = {
        label = 'Sapphire Ring',
        weight = 100,
        description = 'An imperfect sapphire ring.',
    },

    ['necklace_silver'] = {
        label = 'Silver Necklace',
        weight = 100,
        description = 'An imperfect silver necklace.',
    },

    ['necklace_gold'] = {
        label = 'Gold Necklace',
        weight = 100,
        description = 'An imperfect gold necklace.',
    },

    ['necklace_diamond'] = {
        label = 'Diamond Necklace',
        weight = 100,
        description = 'An imperfect diamond necklace.',
    },

    ['necklace_emerald'] = {
        label = 'Emerald Necklace',
        weight = 100,
        description = 'An imperfect emerald necklace.',
    },

    ['necklace_ruby'] = {
        label = 'Ruby Necklace',
        weight = 100,
        description = 'An imperfect ruby necklace.',
    },

    ['necklace_sapphire'] = {
        label = 'Sapphire Necklace',
        weight = 100,
        description = 'An imperfect sapphire necklace.',
    },

    -- atlas_hunting
    ['bait_deer'] = {
        label = 'Deer Bait',
        weight = 500,  -- Adjust weight as needed
        stack = false,  -- Assuming one deer_bait cannot be stacked
        close = true,   -- Close inventory after use
        description = 'Used to bait deer to your hunting spot.',
        consume = 1,    -- Consumes 1 bait_deer per use
        client = {
            export = 'atlas_hunting.placeBait'
        }
    },
    ['bait_boar'] = {
        label = 'Boar Bait',
        weight = 500,  -- Adjust weight as needed
        stack = false,  -- Assuming one boar_bait cannot be stacked
        close = true,   -- Close inventory after use
        description = 'Used to bait boar to your hunting spot.',
        consume = 1,    -- Consumes 1 bait_boar per use
        client = {
            export = 'atlas_hunting.placeBait'
        }
    },
    ['deer_antlers'] = {
        label = 'Deer Antlers',
        weight = 600,
        stack = false,
        description = 'Antlers from a deer.',
    },
    ['boar_tusk'] = {
        label = 'Boar Tusk',
        weight = 300,
        stack = false,
        description = 'A tusk from a boar.',
    },
     ['rabbits_foot'] = {
        label = 'Rabbit\'s Foot',
        weight = 200,
        stack = false,
        description = 'A lucky rabbit\'s foot.',
    },
    ['mtlion_claw'] = {
        label = 'Mountain Lion Claw',
        weight = 200,
        stack = false,
        description = 'A claw from a mountain lion.',
    },
    ['carcass_deer'] = {
        label = 'Deer',
        weight = 4000,
        stack = false,
    },
    ['carcass_boar'] = {
        label = 'Boar',
        weight = 3000,
        stack = false,
    },
    ['carcass_cow'] = {
        label = 'Cow',
        weight = 5000,
        stack = false,
    },
    ['carcass_pig'] = {
        label = 'Pig',
        weight = 3000,
        stack = false,
    },
    ['carcass_rabbit'] = {
        label = 'Rabbit',
        weight = 1000,
        stack = false,
    },
    ['carcass_mtlion'] = {
        label = 'Mountain Lion',
        weight = 4000,
        stack = false,
    },
    ['carcass_chicken'] = {
        label = 'Chicken',
        weight = 1000,
        stack = false,
    },
    ['meat_chicken'] = {
        label = 'Raw Chicken',
        weight = 200, -- average chicken breast portion
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ['meat_deer'] = {
        label = 'Raw Venison',
        weight = 300, -- typical venison steak portion
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ['meat_boar'] = {
        label = 'Raw Pork',
        weight = 200, -- pork chop or wild boar cut
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ['meat_cow'] = {
        label = 'Raw Beef',
        weight = 300, -- average beef steak portion
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ['meat_rabbit'] = {
        label = 'Raw Rabbit',
        weight = 200, -- typical rabbit portion
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ['meat_mtlion'] = {
        label = 'Raw Lion',
        weight = 400, -- large wild cat meat (fictional)
        stack = true,
    },
    ['meat_bird'] = {
        label = 'Raw Fowl Meat',
        weight = 120, -- small wild bird (pigeon, seagull, crow)
        stack = true,
        degrade = 10080,
        decay = true,
    },
    ['pelt_ruined'] = {
        label = 'Ruined Pelt',
        weight = 800, -- average ruined pelt (medium animal)
        stack = false,
        description = 'A pelt that has been damaged.',
    },
    ['pelt_deer'] = {
        label = 'Deer Pelt',
        weight = 1500, -- average deer pelt
        stack = false,
        description = 'A pelt from a deer.',
    },
    ['pelt_boar'] = {
        label = 'Boar Pelt',
        weight = 1200, -- average boar pelt
        stack = false,
        description = 'A pelt from a boar.',
    },
    ['pelt_rabbit'] = {
        label = 'Rabbit Pelt',
        weight = 800, -- average rabbit pelt
        stack = true,
        description = 'A pelt from a rabbit.',
    },
    ['pelt_mtlion'] = {
        label = 'Mt. Lion Pelt',
        weight = 2500, -- large wild cat pelt
        stack = false,
        description = 'A pelt from a mountain lion.',
    },
    ['carcass_coyote'] = {
        label = 'Coyote',
        weight = 3000,
        stack = false,
    },
    ['meat_coyote'] = {
        label = 'Raw Coyote',
        weight = 300,
        stack = true,
    },
    ['pelt_coyote'] = {
        label = 'Coyote Pelt',
        weight = 1200,
        stack = true,
        description = 'A pelt from a coyote.',
    },
    ['coyote_fang'] = {
        label = 'Coyote Fang',
        weight = 300,
        stack = false,
        description = 'A fang from a coyote.',
    },

-- atlas_mechanic items --

-- mechanic_tools / toolbox removed 2026-06-10: tool requirements were cleared
-- in atlas_mechanic (install.sql migration) and atlas_chopshop (no-tool parts).
-- Temporarily disabled (not in use) — re-enable to restore the item.
-- ["ducttape"] = {
--     label = "Duct Tape", weight = 0, stack = false, close = true, description = "Good for quick fixes",
--     client = { image = "bodyrepair.png", event = "atlas_mechanic:client:item:quickRepair" }
-- },
-- ['mechboard'] = { label = 'Mechanic Sheet', weight = 0, stack = false, close = true,
--     buttons = {
--         { 	label = 'View List',
--             action = function(slot)
--                 local items = exports.ox_inventory:Search('slots', 'mechboard')
--                 for _, v in pairs(items) do
--                     if (v.slot == slot) then
--                         local item = v
--                         item.info = item.metadata["info"] or {}
--                         TriggerEvent("atlas_mechanic:client:item:giveList", item)
--                         exports.ox_inventory:closeInventory()
--                         break
--                     end
--                 end
--             end
--         },
--         { 	label = 'Copy Parts List',
--             action = function(slot)
--                 local items = exports.ox_inventory:Search('slots', 'mechboard')
--                 for _, v in pairs(items) do
--                     if (v.slot == slot) then
--                         lib.setClipboard(v.metadata.info.vehlist)
--                         break
--                     end
--                 end
--             end
--         },
--         { 	label = 'Copy Platedsdf Number',
--             action = function(slot)
--                 local items = exports.ox_inventory:Search('slots', 'mechboard')
--                 for _, v in pairs(items) do
--                     if (v.slot == slot) then
--                         lib.setClipboard(v.metadata.info.vehplate)
--                         break
--                     end
--                 end
--             end
--         },
--         {	label = 'Copy Vehicle Model',
--             action = function(slot)
--                 local items = exports.ox_inventory:Search('slots', 'mechboard')
--                 for _, v in pairs(items) do
--                     if (v.slot == slot) then
--                         lib.setClipboard(v.metadata.info.veh) break
--                     end
--                 end
--             end
--         },
--     },
--     client = {
--         event = "atlas_mechanic:client:item:giveList"
--     }
-- },
--Performance
["turbo"] = {
    label = "Supercharger Turbo", weight = 0, stack = false, close = true, description = "Who doesn't need a 65mm Turbo??",
    client = { image = "turbo.png", event = "atlas_mechanic:client:item:applyTurbo", remove = false },
},
-- Temporarily disabled (not in use) — re-enable to restore the item.
-- ["car_armor"] = {
--     label = "Vehicle Armor", weight = 0, stack = false, close = true, description = "",
--     client = { image = "armour.png", event = "atlas_mechanic:client:item:applyArmour", remove = false },
-- },
["nos"] = {
    label = "NOS Bottle", weight = 0, stack = false, close = true, description = "A full bottle of NOS",
    client = { image = "nos.png", event = "atlas_mechanic:client:item:applyNOS", },
},
["noscan"] = {
    label = "Empty NOS Bottle", weight = 0, stack = true, close = true, description = "An Empty bottle of NOS",
    client = { image = "noscan.png", }
},
["noscolour"] = {
    label = "NOS Colour Injector", weight = 0, stack = true, close = true, description = "Make that purge spray",
    client = { image = "noscolour.png", event = "atlas_mechanic:client:item:nosColorPicker", },
},

["engine1"] = {
    label = "Tier 1 Engine", weight = 0, stack = true, close = true, description = "",
    client = { image = "engine1.png",  event = "atlas_mechanic:client:item:applyEngine", level = 0, remove = false },
},
["engine2"] = {
    label = "Tier 2 Engine", weight = 0, stack = true, close = true, description = "",
    client = { image = "engine2.png",  event = "atlas_mechanic:client:item:applyEngine", level = 1, remove = false },
},
["engine3"] = {
    label = "Tier 3 Engine", weight = 0, stack = true, close = true, description = "",
    client = { image = "engine3.png",  event = "atlas_mechanic:client:item:applyEngine", level = 2, remove = false },
},
["engine4"] = {
    label = "Tier 4 Engine", weight = 0, stack = true, close = true, description = "",
    client = { image = "engine4.png",  event = "atlas_mechanic:client:item:applyEngine", level = 3, remove = false },
},
["engine5"] = {
    label = "Tier 5 Engine", weight = 0, stack = true, close = true, description = "",
    client = { image = "engine5.png",  event = "atlas_mechanic:client:item:applyEngine", level = 4, remove = false },
},

["transmission1"] = {
    label = "Tier 1 Transmission", weight = 0, stack = true, close = true, description = "",
    client = { image = "transmission1.png",  event = "atlas_mechanic:client:item:applyTransmission", level = 0, remove = false },
},
["transmission2"] = {
    label = "Tier 2 Transmission", weight = 0, stack = true, close = true, description = "",
    client = { image = "transmission2.png",  event = "atlas_mechanic:client:item:applyTransmission", level = 1, remove = false },
},
["transmission3"] = {
    label = "Tier 3 Transmission", weight = 0, stack = true, close = true, description = "",
    client = { image = "transmission3.png",  event = "atlas_mechanic:client:item:applyTransmission", level = 2, remove = false },
},
["transmission4"] = {
    label = "Tier 4 Transmission", weight = 0, stack = true, close = true, description = "",
    client = { image = "transmission4.png",  event = "atlas_mechanic:client:item:applyTransmission", level = 3, remove = false },
},

["brakes1"] = {
    label = "Tier 1 Brakes", weight = 0, stack = true, close = true, description = "",
    client = { image = "brakes1.png",  event = "atlas_mechanic:client:item:applyBrakes", level = 0, remove = false },
},
["brakes2"] = {
    label = "Tier 2 Brakes", weight = 0, stack = true, close = true, description = "",
    client = { image = "brakes2.png",  event = "atlas_mechanic:client:item:applyBrakes", level = 1, remove = false },
},
["brakes3"] = {
    label = "Tier 3 Brakes", weight = 0, stack = true, close = true, description = "",
    client = { image = "brakes3.png",  event = "atlas_mechanic:client:item:applyBrakes", level = 2, remove = false },
},

["suspension1"] = {
    label = "Tier 1 Suspension", weight = 0, stack = true, close = true, description = "",
    client = { image = "suspension1.png", event = "atlas_mechanic:client:item:applySuspension",  level = 0, remove = false },
},
["suspension2"] = {
    label = "Tier 2 Suspension", weight = 0, stack = true, close = true, description = "",
    client = { image = "suspension2.png", event = "atlas_mechanic:client:item:applySuspension", level = 1, remove = false },
},
["suspension3"] = {
    label = "Tier 3 Suspension", weight = 0, stack = true, close = true, description = "",
    client = { image = "suspension3.png", event = "atlas_mechanic:client:item:applySuspension", level = 2, remove = false },
},
["suspension4"] = {
    label = "Tier 4 Suspension", weight = 0, stack = true, close = true, description = "",
    client = { image = "suspension4.png", event = "atlas_mechanic:client:item:applySuspension", level = 3, remove = false },
},
["suspension5"] = {
    label = "Tier 5 Suspension", weight = 0, stack = true, close = true, description = "",
    client = { image = "suspension5.png", event = "atlas_mechanic:client:item:applySuspension", level = 4, remove = false },
},

-- Temporarily disabled (not in use) — re-enable to restore the item.
-- ["bprooftires"] = {
--     label = "Bulletproof Tires", weight = 0, stack = true, close = true, description = "",
--     client = { image = "bprooftires.png", event = "atlas_mechanic:client:item:applyBulletProof", remove = false },
-- },
["drifttires"] = {
    label = "Drift Tires", weight = 0, stack = true, close = true, description = "",
    client = { image = "drifttires.png", event = "atlas_mechanic:client:item:applyDrift", remove = false },
},

-- Temporarily disabled (not in use) — re-enable to restore these items.
-- Oil pumps, drive shafts, cylinder heads, battery cables, fuel tanks.
--[[
["oilp1"] = {
    label = "Tier 1 Oil Pump", weight = 0, stack = true, close = true, description = "",
    client = { image = "oilp1.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 1, mod = "oilp", remove = false },
},
["oilp2"] = {
    label = "Tier 2 Oil Pump", weight = 0, stack = true, close = true, description = "",
    client = { image = "oilp2.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 2, mod = "oilp", remove = false },
},
["oilp3"] = {
    label = "Tier 3 Oil Pump", weight = 0, stack = true, close = true, description = "",
    client = { image = "oilp3.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 3, mod = "oilp", remove = false },
},

["drives1"] = {
    label = "Tier 1 Drive Shaft", weight = 0, stack = true, close = true, description = "",
    client = { image = "drives1.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 1, mod = "drives", remove = false },
},
["drives2"] = {
    label = "Tier 2 Drive Shaft", weight = 0, stack = true, close = true, description = "",
    client = { image = "drives2.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 2, mod = "drives", remove = false },
},
["drives3"] = {
    label = "Tier 3 Drive Shaft", weight = 0, stack = true, close = true, description = "",
    client = { image = "drives3.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 3, mod = "drives", remove = false },
},

["cylind1"] = {
    label = "Tier 1 Cylinder Head", weight = 0, stack = true, close = true, description = "",
    client = { image = "cylind1.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 1, mod = "cylind", remove = false },
},
["cylind2"] = {
    label = "Tier 2 Cylinder Head", weight = 0, stack = true, close = true, description = "",
    client = { image = "cylind2.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 2, mod = "cylind", remove = false },
},
["cylind3"] = {
    label = "Tier 3 Cylinder Head", weight = 0, stack = true, close = true, description = "",
    client = { image = "cylind3.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 3, mod = "cylind", remove = false },
},

["cables1"] = {
    label = "Tier 1 Battery Cables", weight = 0, stack = true, close = true, description = "",
    client = { image = "cables1.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 1, mod = "cables", remove = false },
},
["cables2"] = {
    label = "Tier 2 Battery Cables", weight = 0, stack = true, close = true, description = "",
    client = { image = "cables2.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 2, mod = "cables", remove = false },
},
["cables3"] = {
    label = "Tier 3 Battery Cables", weight = 0, stack = true, close = true, description = "",
    client = { image = "cables3.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 3, mod = "cables", remove = false },
},

["fueltank1"] = {
    label = "Tier 1 Fuel Tank", weight = 0, stack = true, close = true, description = "",
    client = { image = "fueltank1.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 1, mod = "fueltank", remove = false },
},
["fueltank2"] = {
    label = "Tier 2 Fuel Tank", weight = 0, stack = true, close = true, description = "",
    client = { image = "fueltank2.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 2, mod = "fueltank", remove = false },
},
["fueltank3"] = {
    label = "Tier 3 Fuel Tank", weight = 0, stack = true, close = true, description = "",
    client = { image = "fueltank3.png", event = "atlas_mechanic:client:item:applyExtraPart", level = 3, mod = "fueltank", remove = false },
},
]]

-- Temporarily disabled (not in use) — re-enable to restore the item.
-- ["antilag"] = {
--     label = "AntiLag", weight = 0, stack = true, close = true, description = "",
--     client = { image = "antiLag.png", event = "atlas_mechanic:client:item:applyAntiLag", remove = false },
-- },

-- Temporarily disabled (not in use) — re-enable to restore the item.
-- ["underglow_controller"] = {
--     label = "Neon Controller", weight = 0, stack = true, close = true, description = "",
--     client = { image = "underglow_controller.png", event = "atlas_mechanic:client:item:neonMenu", },
-- },
-- Temporarily disabled (not in use) — re-enable to restore the item.
-- ["headlights"] = {
--     label = "Xenon Headlights", weight = 0, stack = true, close = true, description = "",
--     client = { image = "headlights.png", event = "atlas_mechanic:client:item:applyXenons", },
-- },

["newoil"] = {
    label = "Car Oil", weight = 4000, stack = true, close = true, description = "",
    client = { image = "caroil.png", },
},
["sparkplugs"] = {
    label = "Spark Plugs", weight = 200, stack = true, close = true, description = "",
    client = { image = "sparkplugs.png", },
},
["carbattery"] = {
    label = "Car Battery", weight = 15000, stack = true, close = true, description = "",
    client = { image = "carbattery.png", },
},
["axleparts"] = {
    label = "Axle Parts", weight = 10000, stack = true, close = true, description = "",
    client = { image = "axleparts.png", },
},
-- Temporarily disabled (not in use) — re-enable to restore the item.
-- ["sparetire"] = {
--     label = "Spare Tire", weight = 10000, stack = true, close = true, description = "",
--     client = { image = "sparetire.png", event = "atlas_mechanic:client:item:wheelRepair" },
-- },

["harness"] = {
    label = "Race Harness", weight = 2000, stack = true, close = true, description = "Racing Harness so no matter what you stay in the car",
    client = { image = "harness.png", event = "atlas_mechanic:client:item:applyHarness", remove = false },
},

-- Temporarily disabled (not in use) — re-enable to restore the item.
-- ["manual"] = {
--     label = "Manual Transmission", weight = 30000, stack = true, close = true, description = "Manual Transmission change for vehicles",
--     client = { image = "manual.png", event = "atlas_mechanic:client:item:applyManual", remove = false },
-- },

-- Furniture Store Items (atlas_furniturestore)
["furniture_cardboard_box"] = {
    label = "Cardboard Box",
    weight = 15000,
    stack = false,
    close = true,
    consume = 1,
    description = "A small cardboard box for basic storage. 6 slots.",
    server = {
        export = 'atlas_furniturestore.useFurniture',
    },
},

["furniture_wooden_crate"] = {
    label = "Wooden Crate",
    weight = 25000,
    stack = false,
    close = true,
    consume = 1,
    description = "A sturdy wooden crate. 10 slots of storage.",
    server = {
        export = 'atlas_furniturestore.useFurniture',
    },
},

["furniture_metal_cabinet"] = {
    label = "Metal Cabinet",
    weight = 40000,
    stack = false,
    close = true,
    consume = 1,
    description = "A heavy metal filing cabinet. 16 slots of storage.",
    server = {
        export = 'atlas_furniturestore.useFurniture',
    },
},

["furniture_safe"] = {
    label = "Safe",
    weight = 50000,
    stack = false,
    close = true,
    consume = 1,
    description = "A secure safe for valuables. 20 slots of storage.",
    server = {
        export = 'atlas_furniturestore.useFurniture',
    },
},

["furniture_wardrobe"] = {
    label = "Classic Wardrobe",
    weight = 35000,
    stack = false,
    close = true,
    consume = 1,
    description = "A classic wardrobe for your property. Use it to change outfits.",
    server = {
        export = 'atlas_furniturestore.useFurniture',
    },
},

["furniture_wardrobe_fancy"] = {
    label = "Fancy Wardrobe",
    weight = 35000,
    stack = false,
    close = true,
    consume = 1,
    description = "An elegant wardrobe for your property. Use it to change outfits.",
    server = {
        export = 'atlas_furniturestore.useFurniture',
    },
},

["furniture_dresser"] = {
    label = "Dresser",
    weight = 30000,
    stack = false,
    close = true,
    consume = 1,
    description = "A dressing table for your property. Use it to change outfits.",
    server = {
        export = 'atlas_furniturestore.useFurniture',
    },
},

-- Temporarily disabled (not in use) — re-enable to restore the item.
-- ["underglow"] = {
--     label = "Underglow LEDS", weight = 1000, stack = true, close = true, description = "Underglow addition for vehicles",
--     client = { image = "underglow.png", event = "atlas_mechanic:client:item:applyUnderglow", remove = false },
-- },

-- Temporarily disabled (not in use) — re-enable to restore the item.
-- ["stancerkit"] = {
--     label = "Stancer Kit", weight = 5000, stack = true, close = true, description = "Stancer Kit for vehicles",
--     client = { image = "stancerkit.png", event = "atlas_mechanic:client:item:openStancer", remove = false },
-- },

-- Temporarily disabled (not in use) — re-enable to restore the item.
-- ["newplate"] = {
--     label = "New Plate", weight = 250, stack = false, close = true, description = "A Customizable licence plate.",
--     client = { image = "newplate.png", event = "atlas_mechanic:client:item:setPlate" }
-- },

-- Replace these if these are already installed

["cleaningkit"] = {
   label = "Cleaning Kit", weight = 500, stack = true, close = true, description = "A microfiber cloth with some soap will let your car sparkle again!",
   client = { image = "cleaningkit.png", event = "atlas_mechanic:client:item:cleanVehicle"},
},
["repairkit"] = {
   label = "Repairkit", weight = 5000, stack = true, close = true, description = "A nice toolbox with stuff to repair your vehicle",
   client = { image = "repairkit.png", event = "atlas_mechanic:client:item:vehFailureRepair", item = "repairkit", full = false },
},
["advancedrepairkit"] = {
   label = "Advanced Repairkit", weight = 10000, stack = true, close = true, description = "A nice toolbox with stuff to repair your vehicle",
   client = { image = "advancedrepairkit.png", event = "atlas_mechanic:client:item:vehFailureRepair", item = "advancedrepairkit", full = true },
},

['terminal'] = {
    label = 'Wireless Terminal',
    weight = 5000,
    stack = false,
    close = true,
    description = 'A wireless terminal device',
    client = {
        image = 'terminal.png',
    }
},

['payticket'] = {
    label = 'Receipt',
    weight = 10,
    stack = true,
    close = false,
    description = 'Cash these in at the bank!',
    client = {
        image = 'ticket.png',
    }
},

['mdt'] = {
    label = 'Mobile Data Terminal',
    weight = 250,
    stack = true,
    consume = 0,
    close = true,
    description = "",
    client = {
        export = 'atlas_mdt.openMDT'
    }
},

['bodycam'] = {
    label = 'Bodycam',
    weight = 250,
    stack = true,
    consume = 0,
    close = true,
    description = "",
    client = {
        export = 'atlas_mdt.ToggleBodycam',
        remove = function(total)
            if total < 1 then
                TriggerEvent('atlas_mdt:client:DisableBodycam')
            end
        end
    }
},

-- ['tracker'] = {
--     label = 'Tracker',
--     description = "The app that lets you track the whereabouts of your fellow mates.",
--     weight = 100,
--     consume = 0,
--     client = {
--         remove = function(total)
--             if total < 1 then
--                 TriggerServerEvent('kartik-mdt:server:removePlayerBlip')
--             end
--         end
--     },
--     server = {
--         export = 'kartik-mdt.useTracker'
--     }
-- },

-- Atlas Newspaper
["newspaper"] = {
    label = "Newspaper",
    weight = 200,
    stack = false,
    close = true,
    consume = 0,
    description = "Today's edition of the Los Santos Daily.",
    client = {
        event = 'atlas_newspaper:client:useNewspaper',
    },
},

-- ============================================================
-- STOLEN ELECTRONICS (atlas_houserobbery pickup items)
-- Only 1 per inventory — carrying visually attaches prop
-- ============================================================

["stolen_flatscreen_tv"] = {
    label = "Flatscreen TV",
    weight = 15000,
    stack = false,
    close = true,
    description = "A large flatscreen TV ripped off the wall.",
},
["stolen_flatscreen_small"] = {
    label = "Small Flatscreen",
    weight = 8000,
    stack = false,
    close = true,
    description = "A smaller flatscreen TV. Easy to carry, easier to sell.",
},
["stolen_monitor"] = {
    label = "Monitor",
    weight = 5000,
    stack = false,
    close = true,
    description = "A computer monitor.",
},
["stolen_laptop"] = {
    label = "Laptop",
    weight = 2500,
    stack = false,
    close = true,
    description = "A laptop. Might still have data.",
},
["stolen_microwave"] = {
    label = "Microwave",
    weight = 12000,
    stack = false,
    close = true,
    description = "A microwave oven.",
},
["stolen_coffee_machine"] = {
    label = "Coffee Machine",
    weight = 5000,
    stack = false,
    close = true,
    description = "An expensive-looking coffee machine.",
},
["stolen_toaster"] = {
    label = "Toaster",
    weight = 2000,
    stack = false,
    close = true,
    description = "A toaster.",
},
["stolen_food_processor"] = {
    label = "Food Processor",
    weight = 4000,
    stack = false,
    close = true,
    description = "A kitchen food processor. Still has bits of food in it.",
},
["stolen_pc_tower"] = {
    label = "PC Tower",
    weight = 10000,
    stack = false,
    close = true,
    description = "A desktop computer tower.",
},
["stolen_game_console"] = {
    label = "Game Console",
    weight = 4500,
    stack = false,
    close = true,
    description = "A gaming console.",
},
["stolen_speaker"] = {
    label = "Speaker",
    weight = 6000,
    stack = false,
    close = true,
    description = "A high-quality speaker.",
},
["stolen_dvd_player"] = {
    label = "DVD Player",
    weight = 3000,
    stack = false,
    close = true,
    description = "A DVD player.",
},
["stolen_printer"] = {
    label = "Printer",
    weight = 7000,
    stack = false,
    close = true,
    description = "An office printer.",
},
["stolen_radio"] = {
    label = "Radio",
    weight = 3500,
    stack = false,
    close = true,
    description = "A portable radio.",
},
["stolen_mixer"] = {
    label = "Mixer",
    weight = 3000,
    stack = false,
    close = true,
    description = "A kitchen mixer.",
},
["stolen_juicer"] = {
    label = "Juicer",
    weight = 3500,
    stack = false,
    close = true,
    description = "A juice maker.",
},
["stolen_fridge_mini"] = {
    label = "Mini Fridge",
    weight = 20000,
    stack = false,
    close = true,
    description = "A small fridge.",
},
["stolen_fan"] = {
    label = "Fan",
    weight = 4000,
    stack = false,
    close = true,
    description = "A standing fan.",
},
["stolen_keyboard"] = {
    label = "Keyboard",
    weight = 1000,
    stack = false,
    close = true,
    description = "A computer keyboard.",
},
["stolen_headset"] = {
    label = "Headset",
    weight = 500,
    stack = false,
    close = true,
    description = "A PC headset.",
},

-- ============================================================
-- ATLAS HOUSEROBBERY LOOT — burglary-realistic items
-- Endpoints: F = atlas_fence, D = atlas_drugsales, P = atlas_shops pawn,
--            M = atlas_shops melt
-- Internal names with `stolen_` prefix are kept as a naming convention
-- (historical — they used to be excluded from pawn). Labels/descriptions
-- don't mention "stolen" so the items present as ordinary electronics.
-- See [Player]/[Crim]/atlas_houserobbery/docs/houserobbery_loot.md for the
-- canonical container × item matrix, weights, and per-endpoint values.
-- ============================================================

-- Cash / valuables --------------------------------------------------
["coin_jar"] = {
    label = "Jar of Coins",
    weight = 1200,
    stack = true,
    close = true,
    description = "A heavy jar full of loose change. Use to break it open and pocket the quarters.",
    server = {
        export = 'atlas_houserobbery.useCoinJar'
    }
},

-- Jewelry -----------------------------------------------------------
["pearl_necklace"] = {
    label = "Pearl Necklace",
    weight = 120,
    stack = true,
    close = true,
    description = "A string of cultured pearls.",
},
["cufflinks_pair"] = {
    label = "Pair of Cufflinks",
    weight = 60,
    stack = true,
    close = true,
    description = "A pair of silver cufflinks engraved with initials.",
},
["signet_ring"] = {
    label = "Signet Ring",
    weight = 80,
    stack = true,
    close = true,
    description = "A heavy engraved signet ring with a family crest.",
},
["vintage_pocket_watch"] = {
    label = "Vintage Pocket Watch",
    weight = 180,
    stack = true,
    close = true,
    description = "An antique pocket watch on a tarnished chain. Still ticks.",
},
["designer_earrings"] = {
    label = "Designer Earrings",
    weight = 40,
    stack = true,
    close = true,
    description = "A pair of designer earrings in a little box.",
},

-- Small electronics (salvage primary) -------------------------------
["stolen_smartwatch"] = {
    label = "Smartwatch",
    weight = 200,
    stack = true,
    close = true,
    description = "A high-end smartwatch.",
},
["stolen_earbuds"] = {
    label = "Premium Earbuds",
    weight = 120,
    stack = true,
    close = true,
    description = "A pair of premium earbuds. The charging case is dented.",
},
["stolen_smart_speaker"] = {
    label = "Smart Speaker",
    weight = 800,
    stack = true,
    close = true,
    description = "A smart speaker.",
},
["stolen_handheld_console"] = {
    label = "Handheld Console",
    weight = 400,
    stack = true,
    close = true,
    description = "A handheld game console.",
},
["stolen_router"] = {
    label = "Wi-Fi Router",
    weight = 600,
    stack = true,
    close = true,
    description = "A consumer Wi-Fi router. Probably worth scrap.",
},
["stolen_smart_thermostat"] = {
    label = "Smart Thermostat",
    weight = 200,
    stack = true,
    close = true,
    description = "A smart thermostat.",
},
["stolen_e_reader"] = {
    label = "E-Reader",
    weight = 300,
    stack = true,
    close = true,
    description = "An e-reader full of romance novels.",
},
["stolen_phone_charger"] = {
    label = "Phone Charger Bundle",
    weight = 200,
    stack = true,
    close = true,
    description = "A tangled bundle of phone chargers and cables.",
},

-- Pawnable goods ----------------------------------------------------
["silverware_set"] = {
    label = "Silverware Set",
    weight = 1500,
    stack = true,
    close = true,
    description = "A polished sterling silverware set, missing one fork.",
},
["crystal_decanter"] = {
    label = "Crystal Decanter",
    weight = 1500,
    stack = true,
    close = true,
    description = "A heavy crystal decanter. Don't drop it.",
},
["designer_handbag"] = {
    label = "Designer Handbag",
    weight = 900,
    stack = true,
    close = true,
    description = "A designer handbag with receipts still inside.",
},
["designer_sunglasses"] = {
    label = "Designer Sunglasses",
    weight = 80,
    stack = true,
    close = true,
    description = "A pair of designer sunglasses in a soft case.",
},
["fountain_pen"] = {
    label = "Fountain Pen",
    weight = 40,
    stack = true,
    close = true,
    description = "An expensive fountain pen, still loaded with ink.",
},
["designer_perfume"] = {
    label = "Designer Perfume",
    weight = 200,
    stack = true,
    close = true,
    description = "A bottle of designer perfume. Pricey.",
},
["cologne_bottle"] = {
    label = "Cologne Bottle",
    weight = 250,
    stack = true,
    close = true,
    description = "A nearly-full bottle of cologne.",
},

-- Collectibles ------------------------------------------------------
["coin_collection"] = {
    label = "Coin Collection",
    weight = 600,
    stack = true,
    close = true,
    description = "An antique coin collection in a wooden case. Use to break it apart for quarters.",
    server = {
        export = 'atlas_houserobbery.useCoinCollection'
    }
},
["baseball_signed"] = {
    label = "Signed Baseball",
    weight = 150,
    stack = true,
    close = true,
    description = "A baseball signed by someone the previous owner cared about.",
},
["comic_first_print"] = {
    label = "First-Print Comic",
    weight = 80,
    stack = true,
    close = true,
    description = "A first-print comic book in a protective sleeve.",
},
["figurine_collectible"] = {
    label = "Collectible Figurine",
    weight = 200,
    stack = true,
    close = true,
    description = "A limited-edition figurine still in its box.",
},
["art_figurine"] = {
    label = "Art Figurine",
    weight = 400,
    stack = true,
    close = true,
    description = "A small art piece. Tasteful, expensive.",
},

-- Pharmaceuticals (atlas_drugsales) ---------------------------------
["prescription_oxy"] = {
    label = "Oxycodone Bottle",
    weight = 80,
    stack = true,
    close = true,
    description = "An orange prescription bottle. Label torn off.",
},
["prescription_xanax"] = {
    label = "Xanax Bottle",
    weight = 60,
    stack = true,
    close = true,
    description = "An orange prescription bottle of small white bars.",
},
["prescription_adderall"] = {
    label = "Adderall Bottle",
    weight = 60,
    stack = true,
    close = true,
    description = "An orange prescription bottle of focus pills.",
},
["otc_painkillers"] = {
    label = "OTC Painkillers",
    weight = 50,
    stack = true,
    close = true,
    description = "An over-the-counter pain reliever bottle.",
},
["vitamin_bottle"] = {
    label = "Vitamin Bottle",
    weight = 100,
    stack = true,
    close = true,
    description = "A bottle of generic multivitamins.",
},

-- Liquor (drinkable — alcohol via ox_inventory.alcohol export) ------
["bottle_whiskey_premium"] = {
    label = "Premium Whiskey",
    weight = 1400,
    stack = true,
    close = true,
    description = "A bottle of single malt. The age statement is on the back.",
    client = {
        status = { thirst = 100000, stress = -150000 },
        notification = "You took a long pull of the single malt. Smooth burn.",
        alcoholLevel = 1.6,
    },
    server = {
        export = 'ox_inventory.alcohol'
    }
},
["bottle_wine_vintage"] = {
    label = "Vintage Wine Bottle",
    weight = 1300,
    stack = true,
    close = true,
    description = "A dusty bottle of vintage wine. Cork still intact.",
    client = {
        status = { thirst = 140000, stress = -120000 },
        notification = "You uncorked the vintage and savored a glass.",
        alcoholLevel = 1.0,
    },
    server = {
        export = 'ox_inventory.alcohol'
    }
},
["bottle_champagne"] = {
    label = "Champagne Bottle",
    weight = 1500,
    stack = true,
    close = true,
    description = "A bottle of champagne someone was saving for an occasion.",
    client = {
        status = { thirst = 130000, stress = -100000 },
        notification = "You popped the cork and toasted to nothing in particular.",
        alcoholLevel = 1.1,
    },
    server = {
        export = 'ox_inventory.alcohol'
    }
},

-- Documents & IDs ---------------------------------------------------
["bank_statement"] = {
    label = "Bank Statement",
    weight = 20,
    stack = true,
    close = true,
    description = "A bank statement showing more zeroes than you have.",
},

-- Clutter / filler --------------------------------------------------
["condom_pack"] = {
    label = "Pack of Condoms",
    weight = 30,
    stack = true,
    close = true,
    description = "A half-empty pack of condoms. Yikes.",
},
["family_photo"] = {
    label = "Family Photo",
    weight = 150,
    stack = true,
    close = true,
    description = "A framed family photo. Faces you don't recognise.",
},

-- Polaroid photography (atlas_polaroid) ------------------------------
["polaroid_camera"] = {
    label = "Polaroid Camera",
    weight = 600,
    stack = false,
    close = true,
    description = "An instant camera. Point, shoot, shake the print.",
    client = {
        image = 'polaroid_camera.png',
    }
},
["polaroid_film"] = {
    label = "Polaroid Film",
    weight = 50,
    stack = true,
    close = true,
    description = "Instant film. One print per shot.",
    client = {
        image = 'polaroid_film.png',
    }
},
["photograph"] = {
    label = "Photograph",
    weight = 10,
    stack = false,
    close = true,
    description = "An instant photo. Use it for a closer look.",
    client = {
        image = 'photograph.png',
    }
},
["usb_stick"] = {
    label = "USB Stick",
    weight = 10,
    stack = true,
    close = true,
    description = "A USB stick. Could be photos, could be tax records.",
},
["expired_id"] = {
    label = "Expired ID Card",
    weight = 5,
    stack = true,
    close = true,
    description = "An expired ID card. Useless, but they kept it.",
},

-- Garage / tools (pawnable + clutter) -------------------------------
["power_drill_stolen"] = {
    label = "Power Drill",
    weight = 1800,
    stack = true,
    close = true,
    description = "A cordless power drill. Battery half-charged.",
},
["branded_wrench_set"] = {
    label = "Branded Wrench Set",
    weight = 2500,
    stack = true,
    close = true,
    description = "A name-brand wrench set in a hard case.",
},

-- weapon parts  ------------------------------------------------
-- Realistic, per-type firearm internals + parts for the Gunsmithing loop:
-- craft these from bars/scrap, then assemble them into a working gun gated by
-- a rare schematic (see atlas_crafting `weapon_crafting` recipes). Weapon repair
-- does NOT use any of these — it is the per-weapon material bench at the
-- Gunsmith station (atlas_crafting_weapon_repairs).

-- Shared internals (used by every weapon tier) ----------------
["gun_spring"] = {
    label = "Gun Spring",
    weight = 150,
    stack = false,
    close = true,
    description = "A coiled recoil/hammer spring. Common to every firearm.",
},
["fire_control_group"] = {
    label = "Fire Control Group",
    weight = 300,
    stack = false,
    close = true,
    description = "Trigger, hammer and sear assembled as one fire-control unit.",
},

-- Pistol parts (3) --------------------------------------------
["pistol_frame"] = {
    label = "Pistol Frame",
    weight = 600,
    stack = false,
    close = true,
    description = "The serialized frame of a handgun.",
},
["pistol_slide"] = {
    label = "Pistol Slide",
    weight = 400,
    stack = false,
    close = true,
    description = "The reciprocating slide of a semi-automatic pistol.",
},
["pistol_barrel"] = {
    label = "Pistol Barrel",
    weight = 350,
    stack = false,
    close = true,
    description = "A short rifled barrel for a handgun.",
},

-- SMG parts (4) -----------------------------------------------
["smg_receiver"] = {
    label = "SMG Receiver",
    weight = 700,
    stack = false,
    close = true,
    description = "The serialized receiver of a submachine gun.",
},
["smg_barrel"] = {
    label = "SMG Barrel",
    weight = 500,
    stack = false,
    close = true,
    description = "A compact barrel chambered for pistol-calibre rounds.",
},
["smg_bolt"] = {
    label = "SMG Bolt",
    weight = 400,
    stack = false,
    close = true,
    description = "The blowback bolt of a submachine gun.",
},
["smg_stock"] = {
    label = "SMG Stock",
    weight = 450,
    stack = false,
    close = true,
    description = "A folding or collapsible stock for a submachine gun.",
},

-- Rifle parts (5) ---------------------------------------------
["rifle_lower"] = {
    label = "Rifle Lower Receiver",
    weight = 700,
    stack = false,
    close = true,
    description = "The serialized lower receiver of a rifle.",
},
["rifle_upper"] = {
    label = "Rifle Upper Receiver",
    weight = 800,
    stack = false,
    close = true,
    description = "The upper receiver that houses the bolt and barrel.",
},
["rifle_barrel"] = {
    label = "Rifle Barrel",
    weight = 750,
    stack = false,
    close = true,
    description = "A long rifled barrel for an automatic rifle.",
},
["rifle_bolt"] = {
    label = "Rifle Bolt Carrier",
    weight = 500,
    stack = false,
    close = true,
    description = "The bolt carrier group of a rifle.",
},
["rifle_stock"] = {
    label = "Rifle Stock",
    weight = 600,
    stack = false,
    close = true,
    description = "A shoulder stock for a rifle.",
},

-- Shotgun parts (4) -------------------------------------------
["shotgun_receiver"] = {
    label = "Shotgun Receiver",
    weight = 800,
    stack = false,
    close = true,
    description = "The serialized receiver of a shotgun.",
},
["shotgun_barrel"] = {
    label = "Shotgun Barrel",
    weight = 750,
    stack = false,
    close = true,
    description = "A smoothbore barrel for a shotgun.",
},
["shotgun_pump"] = {
    label = "Shotgun Pump",
    weight = 450,
    stack = false,
    close = true,
    description = "The pump/forend assembly of a shotgun.",
},
["shotgun_stock"] = {
    label = "Shotgun Stock",
    weight = 550,
    stack = false,
    close = true,
    description = "A shoulder stock for a shotgun.",
},

}

