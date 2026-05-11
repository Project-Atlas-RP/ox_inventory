return {
	-- 0	vehicle has no storage
	-- 1	vehicle has no trunk storage
	-- 2	vehicle has no glovebox storage
	-- 3	vehicle has trunk in the hood
	Storage = {
		[`jester`] = 3,
		[`adder`] = 3,
		[`osiris`] = 1,
		[`biff`] = 1,
		[`hauler`] = 1,
		[`hauler2`] = 1,
		[`packer`] = 1,
		[`phantom`] = 1,
		[`phantom2`] = 1,
		[`phantom3`] = 1,
		[`phantom4`] = 1,
		[`flatbed`] = 1,
		[`flatbed2`] = 1,
		[`bulldozer`] = 1,
		[`cutter`] = 1,
		[`dump`] = 1,
		[`handler`] = 1,
		[`docktug`] = 1,
		[`forklift`] = 1,
		[`mixer`] = 1,
		[`mixer2`] = 1,
		[`rubble`] = 1,
		[`tiptruck`] = 1,
		[`tiptruck2`] = 1,
		[`utillitruck`] = 1,
		[`utillitruck2`] = 1,
		[`utillitruck3`] = 1,
		[`towtruck`] = 1,
		[`towtruck2`] = 1,
		[`towtruck3`] = 1,
		[`towtruck4`] = 1,
		[`ripley`] = 1,
		[`tractor`] = 1,
		[`tractor2`] = 1,
		[`tractor3`] = 1,
		[`scrap`] = 1,
		[`slamtruck`] = 1,
		[`wastelander`] = 1,
		[`trash`] = 1,
		[`trash2`] = 1,
		[`bus`] = 1,
		[`tftowstorm`] = 1,
		[`tftowstorm2`] = 1,
		[`pounder`] = 0,
		[`pounder2`] = 0,
		[`pfister811`] = 1,
		[`penetrator`] = 1,
		[`autarch`] = 1,
		[`bullet`] = 1,
		[`cheetah`] = 1,
		[`cyclone`] = 1,
		[`voltic`] = 1,
		[`reaper`] = 3,
		[`entityxf`] = 1,
		[`t20`] = 1,
		[`taipan`] = 1,
		[`tezeract`] = 1,
		[`torero`] = 3,
		[`turismor`] = 1,
		[`fmj`] = 1,
		[`infernus`] = 1,
		[`italigtb`] = 3,
		[`italigtb2`] = 3,
		[`nero2`] = 1,
		[`vacca`] = 3,
		[`vagner`] = 1,
		[`visione`] = 1,
		[`prototipo`] = 1,
		[`zentorno`] = 1,
		[`trophytruck`] = 0,
		[`trophytruck2`] = 0,
	},

	-- slots, maxWeight; default weight is 8000 per slot
	glovebox = {
		[0] = {6, 20000},		-- Compact
		[1] = {6, 20000},		-- Sedan
		[2] = {6, 24000},		-- SUV
		[3] = {6, 20000},		-- Coupe
		[4] = {6, 22000},		-- Muscle
		[5] = {6, 20000},		-- Sports Classic
		[6] = {6, 20000},		-- Sports
		[7] = {6, 18000},		-- Super
		[8] = {3, 10000},		-- Motorcycle
		[9] = {6, 24000},		-- Offroad
		[10] = {6, 26000},	-- Industrial
		[11] = {6, 24000},	-- Utility
		[12] = {6, 26000},	-- Van
		[14] = {10, 40000},	-- Boat
		[15] = {10, 40000},	-- Helicopter
		[16] = {12, 60000},	-- Plane
		[17] = {6, 22000},	-- Service
		[18] = {8, 52000},	-- Emergency (6 glovebox + 2 gun rack)
		[19] = {6, 24000},	-- Military
		[20] = {6, 26000},	-- Commercial (trucks)
		models = {
			-- (no model overrides needed when matching defaults)
		}
	},

	trunk = {
		[0] = {16, 60000},		-- Compact
		[1] = {24, 90000},		-- Sedan
		[2] = {30, 100000},	-- SUV
		[3] = {20, 70000},		-- Coupe
		[4] = {24, 90000},		-- Muscle
		[5] = {20, 70000},		-- Sports Classic
		[6] = {20, 70000},		-- Sports
		[7] = {16, 60000},		-- Super
		[8] = {4, 15000},		-- Motorcycle
		[9] = {24, 90000},	-- Offroad
		[10] = {34, 130000},	-- Industrial
		[11] = {28, 100000},	-- Utility
		[12] = {38, 120000},	-- Van
		-- [14] -- Boat
		-- [15] -- Helicopter
		-- [16] -- Plane
		[17] = {24, 90000},	-- Service
		[18] = {24, 90000},	-- Emergency
		[19] = {28, 100000},	-- Military
		[20] = {38, 140000},	-- Commercial
		-- Models in this table get trunk inventory access even if the model
		-- has no openable trunk door (the door-validity check is bypassed).
		-- Used for vehicles like the pizzaboy where we want a storage box at
		-- the back without an animated trunk lid.
		boneIndex = {
			[`pizzaboy`] = true,
		},
		models = {
			[`xa21`] = {10, 18000},		-- Super (front trunk)
			[`adder`] = {10, 18000},		-- Super (front trunk)
			[`pizzaboy`] = {6, 25000},	-- Pizza delivery scooter (rear top-box, no door anim)
			[`baller`] = {28, 110000},	-- SUV
			[`granger`] = {32, 120000},	-- SUV
			[`dubsta`] = {28, 110000},		-- SUV
			[`bison`] = {36, 130000},		-- Utility pickup
			[`mesa`] = {24, 90000},		-- Offroad
			[`speedo`] = {40, 150000},		-- Van
			[`gstslt1`] = {16, 60000},	-- Step van (postal-style)

			-- Super / hyper (small front storage)
			[`banshee2`] = {10, 18000},
			[`furia`] = {10, 18000},
			[`gp1`] = {10, 18000},
			[`ignus`] = {10, 18000},
			[`italigtb`] = {10, 18000},
			[`krieger`] = {10, 18000},
			[`lm87`] = {10, 18000},
			[`nero`] = {10, 18000},
			[`s80`] = {10, 18000},
			[`sc1`] = {10, 18000},
			[`sultanrs`] = {10, 18000},
			[`tempesta`] = {10, 18000},
			[`thrax`] = {10, 18000},
			[`tigon`] = {10, 18000},
			[`torero2`] = {10, 18000},
			[`turismo3`] = {10, 18000},
			[`tyrant`] = {10, 18000},
			[`tyrus`] = {10, 18000},
			[`vacca`] = {10, 18000},
			[`vigilante`] = {10, 18000},
			[`virtue`] = {10, 18000},
			[`voltic2`] = {10, 18000},
			[`zeno`] = {10, 18000},
			[`zorrusso`] = {10, 18000},

			-- Sports / coupes (medium trunk)
			[`jester`] = {18, 70000},
			[`jester2`] = {18, 70000},
			[`jester3`] = {18, 70000},
			[`jester4`] = {18, 70000},
			[`comet2`] = {18, 70000},
			[`comet3`] = {18, 70000},
			[`comet4`] = {22, 90000},
			[`comet5`] = {18, 70000},
			[`comet6`] = {18, 70000},
			[`comet7`] = {18, 70000},
			[`pariah`] = {18, 70000},
			[`italigto`] = {18, 70000},
			[`italirsx`] = {18, 70000},
			[`r300`] = {16, 60000},
			[`calico`] = {16, 60000},
			[`growler`] = {18, 70000},
			[`remus`] = {18, 70000},
			[`rt3000`] = {18, 70000},
			[`neo`] = {18, 70000},
			[`neon`] = {18, 70000},
			[`ninef`] = {18, 70000},
			[`ninef2`] = {18, 70000},
			[`omnis`] = {18, 70000},
			[`omnisegt`] = {18, 70000},
			[`panthere`] = {18, 70000},
			[`penumbra`] = {18, 70000},
			[`penumbra2`] = {18, 70000},
			[`rapidgt`] = {18, 70000},
			[`rapidgt2`] = {18, 70000},
			[`rapidgt4`] = {18, 70000},
			[`seven70`] = {18, 70000},
			[`sm722`] = {18, 70000},
			[`specter`] = {18, 70000},
			[`specter2`] = {18, 70000},
			[`streiter`] = {18, 70000},
			[`sugoi`] = {18, 70000},
			[`surano`] = {16, 60000},
			[`tenf`] = {18, 70000},
			[`tenf2`] = {18, 70000},
			[`tropos`] = {18, 70000},
			[`vectre`] = {18, 70000},
			[`verlierer2`] = {18, 70000},
			[`vstr`] = {18, 70000},
			[`zr350`] = {18, 70000},
			[`zr380`] = {16, 60000},
			[`zr3802`] = {16, 60000},
			[`zr3803`] = {16, 60000},

			-- Sedans (larger trunk)
			[`cog55`] = {26, 100000},
			[`cog552`] = {26, 100000},
			[`cognoscenti`] = {26, 100000},
			[`cognoscenti2`] = {26, 100000},
			[`stretch`] = {32, 120000},
			[`superd`] = {26, 100000},
			[`tailgater2`] = {24, 100000},
			[`rhinehart`] = {24, 100000},

			-- SUVs (larger cargo)
			[`baller2`] = {28, 110000},
			[`baller3`] = {28, 110000},
			[`baller4`] = {30, 115000},
			[`baller5`] = {30, 115000},
			[`baller6`] = {30, 115000},
			[`baller7`] = {30, 115000},
			[`baller8`] = {30, 115000},
			[`bjxl`] = {28, 110000},
			[`cavalcade`] = {28, 110000},
			[`cavalcade2`] = {28, 110000},
			[`cavalcade3`] = {30, 115000},
			[`contender`] = {32, 120000},
			[`dubsta2`] = {28, 110000},
			[`everon3`] = {32, 120000},
			[`fq2`] = {28, 110000},
			[`granger2`] = {32, 120000},
			[`gresley`] = {28, 110000},
			[`habanero`] = {24, 90000},
			[`huntley`] = {28, 110000},
			[`iwagen`] = {28, 110000},
			[`jubilee`] = {28, 110000},
			[`landstalker`] = {28, 110000},
			[`landstalker2`] = {30, 115000},
			[`novak`] = {28, 110000},
			[`patriot`] = {30, 115000},
			[`patriot2`] = {32, 120000},
			[`radi`] = {28, 110000},
			[`rebla`] = {28, 110000},
			[`rocoto`] = {28, 110000},
			[`seminole`] = {28, 110000},
			[`seminole2`] = {28, 110000},
			[`serrano`] = {28, 110000},
			[`squaddie`] = {32, 120000},
			[`toros`] = {28, 110000},
			[`xls`] = {28, 110000},
			[`xls2`] = {28, 110000},

			-- Pickups / off-road
			[`bison2`] = {36, 130000},
			[`bison3`] = {36, 130000},
			[`bobcatxl`] = {36, 130000},
			[`sadler`] = {34, 120000},
			[`sadler2`] = {34, 120000},
			[`rancherxl`] = {34, 120000},
			[`rancherxl2`] = {34, 120000},
			[`sandking2`] = {36, 130000},
			[`caracara`] = {36, 130000},
			[`caracara2`] = {38, 140000},
			[`kamacho`] = {34, 120000},
			[`riata`] = {34, 120000},
			[`rebel`] = {34, 120000},
			[`rebel2`] = {34, 120000},
			[`yosemite`] = {36, 130000},
			[`yosemite2`] = {36, 130000},
			[`yosemite3`] = {36, 130000},
			[`draugur`] = {34, 120000},
			[`dloader`] = {32, 120000},
			[`hellion`] = {32, 120000},
			[`vagrant`] = {18, 70000},
			[`outlaw`] = {20, 80000},
			[`terminus`] = {32, 120000},
			[`ratel`] = {20, 80000},
			[`winky`] = {18, 70000},

			-- Vans (large cargo)
			[`gburrito`] = {40, 150000},
			[`gburrito2`] = {40, 150000},
			[`journey`] = {42, 160000},
			[`journey2`] = {42, 160000},
			[`minivan`] = {34, 120000},
			[`minivan2`] = {34, 120000},
			[`rumpo3`] = {40, 150000},
			[`speedo2`] = {40, 150000},
			[`speedo4`] = {40, 150000},
			[`speedo5`] = {40, 150000},
			[`surfer`] = {24, 90000},
			[`surfer2`] = {24, 90000},
			[`surfer3`] = {24, 90000},
			[`taco`] = {32, 120000},
			[`youga`] = {36, 130000},
			[`youga2`] = {36, 130000},
			[`youga3`] = {36, 130000},
			[`youga4`] = {36, 130000},
			[`boxville`] = {44, 170000},
			[`boxville2`] = {44, 170000},
			[`boxville3`] = {44, 170000},
			[`boxville4`] = {44, 170000},
			[`boxville5`] = {44, 170000},
			[`boxville6`] = {44, 170000},
			[`camper`] = {40, 150000},

			-- Service / emergency (moderate cargo)
			[`coach`] = {44, 170000},
			[`airbus`] = {44, 170000},
			[`rentalbus`] = {44, 170000},
			[`tourbus`] = {44, 170000},
			[`brickade`] = {70, 280000},
			[`brickade2`] = {70, 280000},
			[`rallytruck`] = {44, 170000},
			[`ambulance`] = {32, 120000},
			[`firetruk`] = {36, 130000},
			[`pbus`] = {36, 130000},
			[`policeb`] = {6, 20000},
			[`policeb2`] = {6, 20000},
			[`lguard`] = {28, 110000},
			[`pranger`] = {28, 110000},
			[`riot`] = {40, 150000},
			[`riot2`] = {40, 150000},

			-- Military (large cargo)
			[`barracks`] = {50, 200000},
			[`barracks2`] = {50, 200000},
			[`barracks3`] = {50, 200000},
			[`crusader`] = {36, 130000},
			[`vetir`] = {44, 170000},
			[`insurgent`] = {40, 150000},
			[`insurgent2`] = {40, 150000},
			[`insurgent3`] = {40, 150000},
			[`nightshark`] = {40, 150000},
			[`menacer`] = {40, 150000},
			[`apc`] = {44, 170000},
			[`halftrack`] = {44, 170000},
			[`khanjali`] = {44, 170000},
			[`rhino`] = {44, 170000},

			-- Utility / industrial / commercial (very large cargo)
			[`guardian`] = {44, 170000},
			[`benson`] = {60, 240000},
			[`benson2`] = {60, 240000},
			[`mule`] = {50, 200000},
			[`mule2`] = {50, 200000},
			[`mule3`] = {50, 200000},
			[`mule4`] = {50, 200000},
			[`mule5`] = {50, 200000},
			[`stockade3`] = {50, 200000},
			[`stockade4`] = {50, 200000}
		},
	}
}
