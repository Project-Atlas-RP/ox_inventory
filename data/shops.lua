return {
	-- Businesses
	BshotOffline = {
		name = 'Burger Shot',
		inventory = {
			{ name = 'burger', price = 10 },
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
		},
	},

	-- Other
	General = {
		name = 'Shop',
		blip = {
			id = 59, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'water', price = 10 },
			{ name = 'sprunk', price = 10 },
			{name ='sham_sandwich', price = 15},
			{name ='chipscheese', price = 15},
			{name ='chipssalt', price = 15},
			{name ='chipsribs', price = 15},
			{name ='chipshabanero', price = 15},
			{name ='rolling_paper', price = 25},
			{name ='lighter', price = 100},
			{name ='wallet', price = 50},
		}, locations = {
			vec3(25.7, -1347.3, 29.49),
			vec3(-3038.71, 585.9, 7.9),
			vec3(-3241.47, 1001.14, 12.83),
			vec3(1728.66, 6414.16, 35.03),
			vec3(1697.99, 4924.4, 42.06),
			vec3(1961.48, 3739.96, 32.34),
			vec3(547.79, 2671.79, 42.15),
			vec3(2679.25, 3280.12, 55.24),
			vec3(2557.94, 382.05, 108.62),
			vec3(373.55, 325.56, 103.56),
		}, targets = {
			{ loc = vec3(25.06, -1347.32, 29.5), length = 0.7, width = 0.5, heading = 0.0, minZ = 29.5, maxZ = 29.9, distance = 1.5 },
			{ loc = vec3(-3039.18, 585.13, 7.91), length = 0.6, width = 0.5, heading = 15.0, minZ = 7.91, maxZ = 8.31, distance = 1.5 },
			{ loc = vec3(-3242.2, 1000.58, 12.83), length = 0.6, width = 0.6, heading = 175.0, minZ = 12.83, maxZ = 13.23, distance = 1.5 },
			{ loc = vec3(1728.39, 6414.95, 35.04), length = 0.6, width = 0.6, heading = 65.0, minZ = 35.04, maxZ = 35.44, distance = 1.5 },
			{ loc = vec3(1698.37, 4923.43, 42.06), length = 0.5, width = 0.5, heading = 235.0, minZ = 42.06, maxZ = 42.46, distance = 1.5 },
			{ loc = vec3(1960.54, 3740.28, 32.34), length = 0.6, width = 0.5, heading = 120.0, minZ = 32.34, maxZ = 32.74, distance = 1.5 },
			{ loc = vec3(548.5, 2671.25, 42.16), length = 0.6, width = 0.5, heading = 10.0, minZ = 42.16, maxZ = 42.56, distance = 1.5 },
			{ loc = vec3(2678.29, 3279.94, 55.24), length = 0.6, width = 0.5, heading = 330.0, minZ = 55.24, maxZ = 55.64, distance = 1.5 },
			{ loc = vec3(2557.19, 381.4, 108.62), length = 0.6, width = 0.5, heading = 0.0, minZ = 108.62, maxZ = 109.02, distance = 1.5 },
			{ loc = vec3(373.13, 326.29, 103.57), length = 0.6, width = 0.5, heading = 345.0, minZ = 103.57, maxZ = 103.97, distance = 1.5 },
			{ loc = vec3(-47.47, -1757.59, 29.61), length = 0.5, width = 0.5, heading = 96.0, minZ = 46.4, maxZ = 46.8, distance = 1.5 },
			{ loc = vec3(-706.90, -913.76, 19.41), length = 0.5, width = 0.5, heading = 96.0, minZ = 46.4, maxZ = 46.8, distance = 1.5 },
			{ loc = vec3(1163.97, -323.04, 69.43), length = 0.5, width = 0.5, heading = 96.0, minZ = 46.4, maxZ = 46.8, distance = 1.5 },
			{ loc = vec3(-1820.62, 793.57, 138.28), length = 0.5, width = 0.5, heading = 96.0, minZ = 46.4, maxZ = 46.8, distance = 1.5 },
			{ loc = vec3(1202.30, 2650.34, 38.04), length = 0.5, width = 0.5, heading = 235.0, minZ = 42.06, maxZ = 42.46, distance = 1.5 },
		}
	},

	DigitalDen = {
		name = 'Digital Den',
		blip = {
			id = 521, colour = 27, scale = 0.8
		}, inventory = {
			{ name = 'phone', price = 200 },
			{ name = 'usb_stick', price = 50 },
			-- { name = 'laptop', price = 1000 },
		}, locations = {
			vec3(-509.3, 281.36, 83.29)
		}, targets = {
			{
				ped = 'a_f_y_business_01',
				scenario = 'WORLD_HUMAN_STAND_IMPATIENT',
				loc = vec3(-510.23, 288.78, 82.29), distance = 2.0,
				heading = 178.0,
			}
		}
	},
	
	Liquor = {
		name = 'Liquor Store',
		-- blip = {
		-- 	id = 93, colour = 69, scale = 0.8
		-- },
		inventory = {
			{ name = 'vodka', price = 15 },
			{ name = 'whiskey', price = 20 },
			{ name = 'wine', price = 30 },
			{ name = 'beer', price = 10 },
			{name ='lighter', price = 100},

		}, locations = {
			vec3(1135.808, -982.281, 46.415),
			vec3(-1222.915, -906.983, 12.326),
			vec3(-1487.553, -379.107, 40.163),
			vec3(-2968.243, 390.910, 15.043),
			vec3(1166.024, 2708.930, 38.157),
			vec3(1392.562, 3604.684, 34.980),
			vec3(-1393.409, -606.624, 30.319)
		}, targets = {
			{ loc = vec3(1134.9, -982.34, 46.41), length = 0.5, width = 0.5, heading = 96.0, minZ = 46.4, maxZ = 46.8, distance = 1.5 },
			{ loc = vec3(-1222.33, -907.82, 12.43), length = 0.6, width = 0.5, heading = 32.7, minZ = 12.3, maxZ = 12.7, distance = 1.5 },
			{ loc = vec3(-1486.67, -378.46, 40.26), length = 0.6, width = 0.5, heading = 133.77, minZ = 40.1, maxZ = 40.5, distance = 1.5 },
			{ loc = vec3(-2967.0, 390.9, 15.14), length = 0.7, width = 0.5, heading = 85.23, minZ = 15.0, maxZ = 15.4, distance = 1.5 },
			{ loc = vec3(1165.95, 2710.20, 38.26), length = 0.6, width = 0.5, heading = 178.84, minZ = 38.1, maxZ = 38.5, distance = 1.5 },
			{ loc = vec3(1393.0, 3605.95, 35.11), length = 0.6, width = 0.6, heading = 200.0, minZ = 35.0, maxZ = 35.4, distance = 1.5 }
		}
	},

	YouTool = {
		name = 'YouTool',
		blip = {
			id = 402, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'lockpick', price = 10 },
			{ name = 'drill', price = 800 },
			{ name = 'weapon_crowbar', price = 90 },
			{ name = "weapon_wrench", price = 85},
			{ name = "weapon_hammer", price = 78},
			{ name = "weapon_pickaxe", price = 300},
			{ name = 'water_can', price = 150, metadata = {durability = 100} },
			{ name = 'fertilizer', price = 50 },
			{ name = 'shovel', price = 100 },
		}, locations = {
			vec3(2748.0, 3473.0, 55.67),
			vec3(342.99, -1298.26, 32.51)
		}, targets = {
			{ loc = vec3(2746.8, 3473.13, 55.67), length = 0.6, width = 3.0, heading = 65.0, minZ = 55.0, maxZ = 56.8, distance = 3.0 }
		}
	},

	Ammunation = {
		name = 'Ammunation',
		blip = {
			id = 110, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'ammo-9', price = 5, },
			{ name = 'WEAPON_KNIFE', price = 90 },
			{ name = 'WEAPON_BAT', price = 100 },
			{ name = 'WEAPON_PISTOL', price = 1000, metadata = { registered = true }, license = 'weapon' }
		}, locations = {
			vec3(-662.180, -934.961, 21.829),
			vec3(810.25, -2157.60, 29.62),
			vec3(1693.44, 3760.16, 34.71),
			vec3(-330.24, 6083.88, 31.45),
			vec3(252.63, -50.00, 69.94),
			vec3(22.56, -1109.89, 29.80),
			vec3(2567.69, 294.38, 108.73),
			vec3(-1117.58, 2698.61, 18.55),
			vec3(842.44, -1033.42, 28.19)
		}, targets = {
			{
				ped = 's_m_y_ammucity_01',
				scenario = 'WORLD_HUMAN_STAND_IMPATIENT',
				loc = vec3(22.69, -1105.17, 28.78),
				heading = 157.0,
			},
			{
				ped = 's_m_y_ammucity_01',
				scenario = 'WORLD_HUMAN_STAND_IMPATIENT',
				loc = vec3(-662.51, -933.59, 20.81),
				heading = 180.0,
			},
			{ped = 's_m_y_ammucity_01',
			scenario = 'WORLD_HUMAN_STAND_IMPATIENT',
			loc = vec3(810.31, -2159.04, 28.60),
			heading = 360.0,
		},
		{
			ped = 's_m_y_ammucity_01',
			scenario = 'WORLD_HUMAN_STAND_IMPATIENT',
			loc = vec3(1692.32, 3761.1, 33.77),
			heading = 227.0,
		},
		{
			ped = 's_m_y_ammucity_01',
			scenario = 'WORLD_HUMAN_STAND_IMPATIENT',
			loc = vec3(-331.66, 6084.94, 30.45),
			heading = 227.0,
		},
		{
			ped = 's_m_y_ammucity_01',
			scenario = 'WORLD_HUMAN_STAND_IMPATIENT',
			loc = vec3(253.93, -50.27, 68.94),
			heading = 69.0, -- nice
		
		},
		{
			ped = 's_m_y_ammucity_01',
			scenario = 'WORLD_HUMAN_STAND_IMPATIENT',
			loc = vec3(2568.08, 292.62, 107.73),
			heading = 360.0,
		
		},
		{
			ped = 's_m_y_ammucity_01',
			scenario = 'WORLD_HUMAN_STAND_IMPATIENT',
			loc = vec3(-1119.2, 2699.54, 17.55),
			heading = 219.0,
		
		
		},
		{
			ped = 's_m_y_ammucity_01',
			scenario = 'WORLD_HUMAN_STAND_IMPATIENT',
			loc = vec3(842.64, -1035.25, 27.19),
			heading = 357.0,
		},
		}
	},

	Produce = {
		name = 'Produce Stand',
		inventory = {
			{ name = 'corn', price = 5 },
			{ name = 'carrot', price = 5 },
			{ name = 'cabbage', price = 5 },
			{ name = 'potato', price = 5 },
			{ name = 'tomato', price = 5 },
			{ name = 'onion', price = 5 },
		}, locations = {
			vec3(1477.61, 2723.18, 37.59)
		}, targets = {
			{
			ped = 'a_f_y_eastsa_03',
			scenario = 'WORLD_HUMAN_SMOKING',
			loc = vec3(1477.61, 2723.18, 36.59),
			heading = 34.0,
			} 
		}
	},
	Canteen = {
		name = ' Prison Canteen',
		inventory = {
			{ name = 'sham_sandwich', price = 10, currency = 'prison_credits' },
			{ name = 'water', price = 5, currency = 'prison_credits' },
			
		}, locations = {
			vec3(1736.59, 2589.41, 44.42)
		}, targets = {
			{
			ped = 's_f_y_factory_01',
			scenario = 'WORLD_HUMAN_STAND_IMPATIENT',
			loc = vec3(1736.59, 2589.41, 44.56),
			heading = 185.0,
			} 
		}
	},

	PoliceArmoury = {
		name = 'Police Armoury',
		groups = shared.police,
		inventory = {
			{ name = 'ammo-9', price = 5, },
			{ name = 'ammo-rifle', price = 5, },
			{ name = 'WEAPON_FLASHLIGHT', price = 200 },
			{ name = 'WEAPON_NIGHTSTICK', price = 100 },
			{ name = 'WEAPON_PISTOL', price = 500, metadata = { registered = true, serial = 'POL' }, license = 'weapon' },
			{ name = 'WEAPON_CARBINERIFLE', price = 1000, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 3 },
			{ name = 'WEAPON_STUNGUN', price = 500, metadata = { registered = true, serial = 'POL'} },
			{ name = 'spikestrip', price = 250 },
			{ name = 'nikon', price = 0 },
			{ name = 'radio', price = 0 },
			{ name = 'handcuffs', price = 0 },
			{ name = 'armour', price = 0 },
			{ name = 'ifaks', price = 0 },
			{ name = 'donut', price = 0 },
			{ name = 'evidence_toolkit', price = 0 },
			{ name = 'empty_evidence_bag', price = 0 },
			{ name = 'gov_badge', price = 0 },
			{ name = 'barrier', price = 0 },
			{ name = 'trafficcone', price = 0 },
		}, 
		locations = {
			vec3(451.51, -979.44, 30.68),
			vec3(1068.13, 2728.21, 38.76) -- Harmony
		}, 
		targets = {
			{ loc = vec3(453.21, -980.03, 30.68), length = 0.5, width = 3.0, heading = 270.0, minZ = 30.5, maxZ = 32.0, distance = 6 }, -- MRPD
			{ loc = vec3(603.24, 6.37, 88.23), length = 0.5, width = 3.0, heading = 248.27, minZ = 30.5, maxZ = 32.0, distance = 6 }, -- Vinewood
			{ loc = vec3(1068.13, 2728.21, 38.76), length = 0.5, width = 3.0, heading = 248.27, minZ = 30.5, maxZ = 32.0, distance = 6 }, -- Harmony
		}
	},

	Medicine = {
		name = 'Medicine Cabinet',
		groups = {
			['ambulance'] = 0
		},
		inventory = {
			{ name = 'radio', price = 0 },
			{ name = 'bandage', price = 0 },
			{ name = 'painkillers', price = 0 },
			{ name = 'firstaid', price = 0 },
			{ name = 'weapon_flashlight', price = 0 },
			{ name = 'weapon_fireextinguisher', price = 0 },
			{ name = 'gov_badge', price = 0 },
			{ name = 'barrier', price = 0 },
			{ name = 'trafficcone', price = 0 },
		}, 
		locations = {
			vec3(298.51, -597.21, 43.15),
			vec3(1115.16, 2741.94, 39.01),
		}, 
		targets = {
			{ loc = vec3(298.51, -597.21, 42.15), length = 1.5, width = 3.0, heading = 270.0, minZ = 41.5, maxZ = 44.0, distance = 6 },
			{ loc = vec3(1115.16, 2741.94, 38.01), length = 1.5, width = 3.0, heading = 270.0, minZ = 38.5, maxZ = 41.0, distance = 6 },
		}
	},

	Pharmacy = {
		name = "Pharmacy",
		blip = {
			id = 403, colour = 3, scale = 0.6
		},
		inventory = {
			{ name = "bandage", price = 0 },
			{ name = "Ammonia", price = 0, count = 75},
			{ name = "Pseudoephedrine", price = 0, count = 50},
		},
		locations = {
			vec3(-176.16, 6387.30, 31.52), -- Paleto
			vec3(-708.51, -893.53, 23.91), -- Little Seoul
		},
		targets = {
			{ loc = vec3(-176.16, 6387.30, 31.52), length = 1.5, width = 3.0, heading = 270.0, minZ = 41.5, maxZ = 44.0, distance = 6 }, -- Paleto
			{ loc = vec3(-708.51, -893.53, 23.91), length = 1.5, width = 3.0, heading = 270.0, minZ = 41.5, maxZ = 44.0, distance = 6 }, -- Little Seoul
		}
	},

	BlackMarketArms = {
		name = 'Black Market (Arms)',
		inventory = {
			{ name = 'WEAPON_DAGGER', price = 5000, metadata = { registered = false	}, currency = 'black_money' },
			{ name = 'WEAPON_CERAMICPISTOL', price = 50000, metadata = { registered = false }, currency = 'black_money' },
			{ name = 'at_suppressor_light', price = 50000, currency = 'black_money' },
			{ name = 'ammo-rifle', price = 1000, currency = 'black_money' },
			{ name = 'ammo-rifle2', price = 1000, currency = 'black_money' }
		}, locations = {
			vec3(309.09, -913.75, 56.46)
		}, targets = {

		}
	},

	-- Soda Vending Machines (Sprunk, eCola machines)
	VendingMachineSoda = {
		name = 'Soda Machine',
		inventory = {
			{ name = 'sprunk', price = 10 },
			{ name = 'cola', price = 10 },
			{ name = 'orang_o_tang', price = 10 },
			{ name = 'junkdrink', price = 10 },
		},
		model = {
			`prop_vend_soda_01`, `prop_vend_soda_02`
		}
	},

	-- Water Dispensers and Fridges
	VendingMachineWater = {
		name = 'Drink Cooler',
		inventory = {
			{ name = 'water', price = 10 },
			{ name = 'raine', price = 10 },
			{ name = 'cola', price = 10 },
			{ name = 'sprunk', price = 10 },
			{ name = 'orang_o_tang', price = 10 },
			{ name = 'junkdrink', price = 10 },
		},
		model = {
			`prop_vend_water_01`, `prop_vend_fridge01`
		}
	},

	-- Coffee Machines
	VendingMachineCoffee = {
		name = 'Bean Machine',
		inventory = {
			{ name = 'coffee', price = 10 },
			{ name = 'latte', price = 10 },
			{ name = 'espresso', price = 10 },
			{ name = 'hot_chocolate', price = 10 },
		},
		model = {
			`prop_vend_coffe_01`
		}
	},

	-- Snack Vending Machines
	VendingMachineSnacks = {
		name = 'Snack Machine',
		inventory = {
			{ name = 'ps_and_qs', price = 5 },
			{ name = 'ego_chaser', price = 5 },
			{ name = 'meteorite_bar', price = 5 },
			{ name = 'chipscheese', price = 15 },
			{ name = 'chipshabanero', price = 15 },
			{ name = 'chipsribs', price = 15 },
			{ name = 'chipssalt', price = 15 },
		},
		model = {
			`prop_vend_snak_01`, `prop_vend_snak_01_tu`
		}
	},
	VendingMachineWaterDispenser = {
		name = 'Water Dispenser',
		inventory = {
			{ name = 'water', price = 5 },
		},
		model = {
			`prop_watercooler`, `prop_watercooler_dark`
	},
	},

	TraderBob = {
		name = "Trader Bob's",
		blip = {
			id = 469, colour = 69, scale = 0.6
		},
		inventory = {
			{ name = "corn_seed", price = 10 },
			{ name = "tomato_seed", price = 10 },
			{ name = "carrot_seed", price = 10 },
			{ name = "lettuce_seed", price = 10 },
			{ name = "cucumber_seed", price = 10 },
			{ name = "garlic_seed", price = 10 },
			{ name = "onion_seed", price = 10 },
			{ name = "potato_seed", price = 10 },
			{ name = "pumpkin_seed", price = 10 },
			{ name = "radish_seed", price = 10 },
			{ name = "red_beet_seed", price = 10 },
			{ name = "sunflower_seed", price = 10 },
			{ name = "watermelon_seed", price = 10 },
			{ name = "wheat_seed", price = 10 },
			{ name = "water_can", price = 150, metadata = {durability = 100} },
			{ name = "fertilizer", price = 50 },
		},
	},

	HuntingShop = {
		name = "Sporting Shop",
		blip = {
			id = 141, colour = 69, scale = 0.8
		},
		inventory = {
			{ name = "weapon_knife", price = 90 },
			{ name = "weapon_hatchet", price = 86},
			{ name = "weapon_huntingrifle", price = 670, metadata = { registered = true }, license = 'hunting' },
			{ name = "ammo-hunting", price = 6 },
			{ name = "bait_deer", price = 25 },
			{ name = "bait_boar", price = 15 },
			{ name = "binoculars", price = 40 },
			{ name = "fishingrod", price = 240 },
			{ name = "worm", price = 1 },
			{ name = "minnow", price = 1 },
			{ name = "jig_green", price = 7 },
			{ name = "jig_black", price = 7 },
			{ name = "jig_red", price = 7 },
			{ name = "jig_silver", price = 7 },
			{ name = "jig_gold", price = 7 },
			{ name = "spoon_green", price = 7 },
			{ name = "spoon_black", price = 7 },
			{ name = "spoon_red", price = 7 },
			{ name = "spoon_silver", price = 7 },
			{ name = "spoon_gold", price = 7 },
		}, 
		locations = {
			vec3(-1600.764, 5195.79, 4.37),
		},
		targets = {
			{ loc = vec3(-1600.65, 5195.86, 4.03), length = 0.5, width = 3.0, heading = 270.0, minZ = 30.5, maxZ = 32.0, distance = 6 }
		}
	},
	BlackMarket = {
		name = 'Black Market',
		inventory = {
			{ name = 'weed_seed', price = 300 },
		}, 
		locations = {
			vec3(238.63, 143.02, 137.55)
		}, 
		targets = {
			{
				ped = 's_m_y_dealer_01',
				scenario = 'WORLD_HUMAN_LEANING',
				loc = vec3(238.63, 143.02, 136.55),
				heading = 250.0,
			}
		},
		opens = 21, -- 9 PM
		closes = 5   -- 5 AM
	},

	PoliceArmoury = {
		name = 'Police Armoury',
		groups = shared.police,
		inventory = {
			-- Weapons & Ammo
			{ name = 'ammo-9', price = 0 },
			{ name = 'ammo-rifle', price = 0 },
			{ name = 'ammo-shotgun', price = 0 },
			{ name = 'WEAPON_FLASHLIGHT', price = 0 },
			{ name = 'WEAPON_NIGHTSTICK', price = 0 },
			{ name = 'WEAPON_PISTOL', price = 0, metadata = { registered = true, serial = 'POL' }, license = 'weapon' },
			{ name = 'WEAPON_CARBINERIFLE', price = 0, metadata = { registered = true, serial = 'POL' }, license = 'weapon', grade = 3 },
			{ name = 'WEAPON_PUMPSHOTGUN', price = 0, metadata = { registered = true, serial = 'POL' }, license = 'weapon' },
			{ name = 'WEAPON_STUNGUN', price = 0, metadata = { registered = true, serial = 'POL' } },
			-- Equipment
			{ name = 'nikon', price = 0 },
			{ name = 'handcuffs', price = 0 },
			{ name = 'radio', price = 0 },
			{ name = 'armour', price = 0 },
			{ name = 'spikestrip', price = 0 },
			{ name = 'coffee', price = 0 },
			{ name = 'repairkit', price = 0 },
			-- Evidence
			{ name = 'evidence_toolkit', price = 0 },
			{ name = 'empty_evidence_bag', price = 0 },
			{ name = 'gov_badge', price = 0 },
			{ name = 'barrier', price = 0 },
			{ name = 'trafficcone', price = 0 },
		},
		locations = {
			vec3(451.51, -979.44, 30.68)
		},
		targets = {
			{ loc = vec3(453.21, -980.03, 30.68), length = 0.5, width = 3.0, heading = 270.0, minZ = 30.5, maxZ = 32.0, distance = 6 }, -- MRPD
			{ loc = vec3(603.24, 6.37, 88.23), length = 0.5, width = 3.0, heading = 248.27, minZ = 30.5, maxZ = 32.0, distance = 6 }, -- Vinewood
			{ loc = vec3(1066.98, 2724.22, 38.85), length = 0.5, width = 3.0, heading = 248.27, minZ = 38.35, maxZ = 39.35, distance = 6 }, --route68
		}
	},

	BarShop = {
		name = 'Bar Shop',
		groups = {
			['tequilala'] = 0,
		},
		inventory = {
			{ name = 'vodka', price = 0 },
			{ name = 'whiskey', price = 0 },
			{ name = 'tequila', price = 0 },
			{ name = 'rum', price = 0 },
			{ name = 'gin', price = 0 },
			{ name = 'beer', price = 0 },
			{ name = 'fruitjuice', price = 0 },
			{ name = 'junkdrink', price = 0 },
			{ name = 'cola', price = 0 },
			{ name = 'limejuice', price = 0 },
			{ name = 'sugar', price = 0 },
			{ name = 'ice', price = 0 },
		}, locations = {
			vec3(-571.01, 286.32, 78.18)
		}, targets = {
			{
				ped = 's_m_y_barman_01',
				scenario = 'WORLD_HUMAN_BARTENDER',
				loc = vec3(-571.01, 286.32, 78.18),
				heading = 37.56,
				unique = true -- Only target this specific NPC instance
			}
		}
	},

	FurnitureStore = {
		name = 'Furniture Store',
		blip = {
			id = 478, colour = 69, scale = 0.8
		},
		inventory = {
			{ name = 'furniture_cardboard_box', price = 2500, metadata = { warning = 'Cannot be placed in starter apartments' } },
			{ name = 'furniture_wooden_crate', price = 5000, metadata = { warning = 'Cannot be placed in starter apartments' } },
			{ name = 'furniture_metal_cabinet', price = 10000, metadata = { warning = 'Cannot be placed in starter apartments' } },
			{ name = 'furniture_safe', price = 20000, metadata = { warning = 'Cannot be placed in starter apartments' } },
			{ name = 'furniture_wardrobe', price = 4000, metadata = { warning = 'Cannot be placed in starter apartments' } },
			{ name = 'furniture_wardrobe_fancy', price = 6000, metadata = { warning = 'Cannot be placed in starter apartments' } },
			{ name = 'furniture_dresser', price = 5000, metadata = { warning = 'Cannot be placed in starter apartments' } },
		},
		locations = {
			vec3(109.35, -153.04, 53.77),
		},
		targets = {
			{
				ped = 'a_m_m_business_01',
				scenario = 'WORLD_HUMAN_STAND_IMPATIENT',
				loc = vec3(109.35, -153.04, 53.77),
				heading = 113.44,
				distance = 2.0,
			},
		}
	},
}