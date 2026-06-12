return {
	anim = {
		['eating'] = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
		['drinking'] = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
		['drinking_coffee'] = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
	},
	prop = {
		['burger'] = { model = `prop_cs_burger_01`, pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
		['candy'] = { model = `prop_candy_pqs`, pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
		['chocolate'] = { model = `prop_choc_ego`, pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
		['meteorite'] = { model = `prop_choc_meto`, pos = vec3(0.02, 0.02, -0.02), rot = vec3(0.0, 0.0, 0.0) },
		['coffee_cup'] = { model = `p_amb_coffeecup_01`, pos = vec3(0.0, -0.01, -0.01), rot = vec3(0.0, 0.0, 0.0) },
		['soda_can'] = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
		['ecola_can'] = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
		['water_bottle'] = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
		['chips'] = { model = `v_ret_ml_chips2`, pos = vec3(0.14, 0.02, -0.02), rot = vec3(90.0, 0.0, -90.0) },
		['v_ret_ml_chips2'] = { model = `v_ret_ml_chips2`, pos = vec3(0.14, 0.02, -0.02), rot = vec3(90.0, 0.0, -90.0) },

		-- atlas_restaurants barbecue + Burger Shot foods. ox_inventory resolves a
		-- STRING `prop` as an alias key (not a model), so a bzzz model name used
		-- directly never spawns a held prop unless it's registered here. Offsets
		-- copied from bzzz_grillfood / bzzz_fastfood's own item defs.
		['bzzz_food_grill_steak_grill_a']    = { model = `bzzz_food_grill_steak_grill_a`,    pos = vec3(0.03, -0.03, -0.02), rot = vec3(18.0, -35.0, 64.0) },
		['bzzz_food_grill_skewer_grill_a']   = { model = `bzzz_food_grill_skewer_grill_a`,   pos = vec3(0.04, -0.02, -0.03), rot = vec3(15.0, -30.0, 65.0) },
		['bzzz_food_grill_sausage_grill_a']  = { model = `bzzz_food_grill_sausage_grill_a`,  pos = vec3(0.04, -0.02, -0.03), rot = vec3(15.0, -30.0, 65.0) },
		['bzzz_food_grill_ribs_grill_b']     = { model = `bzzz_food_grill_ribs_grill_b`,     pos = vec3(0.01, -0.01, -0.01), rot = vec3(-62.0, 5.0, 174.0) },
		['bzzz_food_grill_chicken_grill_b']  = { model = `bzzz_food_grill_chicken_grill_b`,  pos = vec3(-0.01, 0.0, 0.0),    rot = vec3(-20.0, -16.0, -83.0) },
		['bzzz_food_grill_chicken_grill_c']  = { model = `bzzz_food_grill_chicken_grill_c`,  pos = vec3(-0.01, 0.0, 0.0),    rot = vec3(-20.0, -16.0, -83.0) },
		['bzzz_food_grill_chicken_grill_d']  = { model = `bzzz_food_grill_chicken_grill_d`,  pos = vec3(-0.01, 0.0, 0.0),    rot = vec3(-20.0, -16.0, -83.0) },
		['bzzz_food_grill_corn_grill_a']     = { model = `bzzz_food_grill_corn_grill_a`,     pos = vec3(0.04, -0.02, -0.03), rot = vec3(15.0, -30.0, 65.0) },
		['bzzz_food_grill_potato_grill_a']   = { model = `bzzz_food_grill_potato_grill_a`,   pos = vec3(-0.03, 0.0, -0.01),  rot = vec3(2.0, -15.0, 106.0) },
		['bzzz_food_grill_salmon_grill_a']   = { model = `bzzz_food_grill_salmon_grill_a`,   pos = vec3(0.0, -0.02, -0.02),  rot = vec3(25.0, -35.0, 64.0) },
		['bzzz_food_grill_fish_grill_a']     = { model = `bzzz_food_grill_fish_grill_a`,     pos = vec3(0.06, 0.0, -0.04),   rot = vec3(-20.0, -16.0, -83.0) },
		['bzzz_food_grill_bacon_grill_a']    = { model = `bzzz_food_grill_bacon_grill_a`,    pos = vec3(0.02, -0.01, -0.01), rot = vec3(0.0, 0.0, 80.0) },
		['bzzz_food_grill_burger_grill_a']   = { model = `bzzz_food_grill_burger_grill_a`,   pos = vec3(0.0, -0.02, -0.03),  rot = vec3(0.0, 0.0, -50.0) },
		['bzzz_food_grill_burger_grill_d']   = { model = `bzzz_food_grill_burger_grill_d`,   pos = vec3(0.0, -0.02, -0.03),  rot = vec3(0.0, 0.0, -50.0) },
		['bzzz_fastfood_burgershot_bigburger_a']    = { model = `bzzz_fastfood_burgershot_bigburger_a`,    pos = vec3(-0.01, 0.0, -0.02), rot = vec3(31.0, 15.0, 0.0) },
		['bzzz_fastfood_burgershot_cheeseburger_a'] = { model = `bzzz_fastfood_burgershot_cheeseburger_a`, pos = vec3(-0.01, 0.0, -0.02), rot = vec3(31.0, 15.0, 0.0) },
		['bzzz_fastfood_burgershot_fries_a']  = { model = `bzzz_fastfood_burgershot_fries_a`,  bone = 60309, pos = vec3(0.09, 0.04, 0.05), rot = vec3(-80.0, 50.0, 0.0) },
		['bzzz_fastfood_burgershot_onion_a']  = { model = `bzzz_fastfood_burgershot_onion_a`,  pos = vec3(-0.04, 0.01, -0.01), rot = vec3(1.0, 45.0, -85.0) },
		['bzzz_fastfood_burgershot_nugget_a'] = { model = `bzzz_fastfood_burgershot_nugget_a`, pos = vec3(-0.04, 0.01, -0.01), rot = vec3(1.0, 45.0, -85.0) },
	}
}