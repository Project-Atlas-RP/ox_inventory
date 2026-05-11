return {
	{
		coords = vec3(609.78, 14.36, 88.04),
		target = {
			loc = vec3(609.78, 14.36, 88.04),
			length = 1.5,
			width = 3.0,
			heading = 0,
			minZ = 87.54,
			maxZ = 88.54,
			label = 'Open personal locker'
		},
		name = 'policelockervinewood',
		label = 'Personal locker',
		owner = true,
		slots = 70,
		weight = 70000,
		groups = shared.police
	},

	{
		coords = vec3(1067.18, 2735.54, 38.86),
		target = {
			loc = vec3(1067.18, 2735.54, 38.86),
			length = 1.5,
			width = 3.0,
			heading = 0,
			minZ = 38.36,
			maxZ = 39.36,
			label = 'Open personal locker'
		},
		name = 'policelockerroute68',
		label = 'Personal locker',
		owner = true,
		slots = 70,
		weight = 70000,
		groups = shared.police
	},



	{
		coords = vec3(611.81, -19.40, 88.03),
		target = {
			loc = vec3(611.81, -19.40, 88.03),
			length = 1.5,
			width = 31.5,
			heading = 0,
			minZ = 87.54,
			maxZ = 88.54,
			label = 'Open fridge'
		},
		name = 'policefridge',
		label = 'Fridge',
		owner = false,
		slots = 25,
		weight = 70000,
		groups = shared.police
	},








	{
		coords = vec3(318.61, -600.60, 43.22),
		target = {
			loc = vec3(318.61, -600.60, 43.22),
			length = 1.5,
			width = 3.0,
			heading = 0,
			minZ = 42.72,
			maxZ = 43.72,
			label = 'Open personal locker'
		},
		name = 'emslockerpillbox',
		label = 'Personal Locker',
		owner = true,
		slots = 70,
		weight = 70000,
		groups = {['ambulance'] = 0}
	},


	-- Fast Food Trays
	{
		coords = vec3(1036.10, 2659.50, 40.20),
		target = {
			loc = vec3(1036.10, 2659.50, 40.20),
			length = 1.0,
			width = 1.0,
			heading = 0,
			minZ = 13.5,
			maxZ = 13.6,
			label = 'Open tray'
		},
		name = 'burgershot_tray_1',
		label = 'Tray',
		owner = false,
		slots = 10,
		weight = 10000,
	},

	{
		coords = vec3(289.72, -966.10, 29.23),
		target = {
			loc = vec3(289.72, -965.70, 29.23),
			length = 1.0,
			width = 1.0,
			heading = 0,
			minZ = 13.5,
			maxZ = 13.6,
			label = 'Open tray'
		},
		name = 'Pizzathis_tray_2',
		label = 'Tray',
		owner = false,
		slots = 10,
		weight = 10000,
	},

	{
		coords = vec3(287.40, -965.75, 29.23),
		target = {
			loc = vec3(287.40, -965.75, 29.23),
			length = 1.0,
			width = 1.0,
			heading = 0,
			minZ = 13.5,
			maxZ = 13.6,
			label = 'Open tray'
		},
		name = 'Pizzathis_tray_1',
		label = 'Tray',
		owner = false,
		slots = 10,
		weight = 10000,
	},
	{
		coords = vec3(291.99, -965.90, 29.23),
		target = {
			loc = vec3(291.99, -965.90, 29.23),
			length = 1.0,
			width = 1.0,
			heading = 0,
			minZ = 13.5,
			maxZ = 13.6,
			label = 'Open tray'
		},
		name = 'Pizzathis_tray_3',
		label = 'Tray',
		owner = false,
		slots = 10,
		weight = 10000,
	},

	-- Tequilala Main Fridge
	{
		coords = vec3(-562.64, 287.52, 81.3),
		target = {
			loc = vec3(-562.64, 287.52, 81.3),
			length = 5.0,
			width = 1.0,
			heading = 0,
			minZ = 38.85,
			maxZ = 39.85,
			label = 'Open Fridge'
		},
		name = 'tequilala_fridge1',
		label = 'Fridge',
		owner = false,
		slots = 50,
		weight = 100000,
		groups = {['tequilala'] = 0}
	},
	{ -- Downsairs Fridge Tequilala
		coords = vec3(-568.44, 276.91, 77.50),
		target = {
			loc = vec3(-568.44, 276.91, 77.50),
			length = 1.0,
			width = 2.7,
			heading = 0,
			minZ = 38.85,
			maxZ = 39.85,
			label = 'Open Fridge'
		},
		name = 'tequilala_fridge2',
		label = 'Fridge',
		owner = false,
		slots = 50,
		weight = 100000,
		groups = {['tequilala'] = 0}
	},
}
