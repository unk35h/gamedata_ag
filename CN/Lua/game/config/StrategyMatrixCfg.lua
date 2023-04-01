return {
	[91521] = {
		init_effect_template_id = 3,
		enter_story_id = 0,
		event_template_id = 2,
		activity_id = 91521,
		setting_template_id = 2,
		attribute_template_id = 2,
		tier_template_id = 2,
		pre_condition_args = {},
		hero_standard_system_id_list = {
			3031067
		},
		tier_story_list = {}
	},
	[121521] = {
		init_effect_template_id = 3,
		enter_story_id = 900801001,
		event_template_id = 3,
		activity_id = 121521,
		setting_template_id = 3,
		attribute_template_id = 2,
		tier_template_id = 3,
		pre_condition_args = {},
		hero_standard_system_id_list = {
			3031028
		},
		tier_story_list = {
			900802002,
			900901002,
			901001002,
			901101002
		}
	},
	[121522] = {
		init_effect_template_id = 3,
		enter_story_id = 0,
		event_template_id = 4,
		activity_id = 121522,
		setting_template_id = 4,
		attribute_template_id = 2,
		tier_template_id = 4,
		pre_condition_args = {
			{
				50105,
				{
					121521,
					4,
					10
				}
			}
		},
		hero_standard_system_id_list = {
			3031028
		},
		tier_story_list = {}
	},
	all = {
		91521,
		121521,
		121522
	}
}
