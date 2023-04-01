return {
	sequence = {
		[0.0166666666666667] = {
			{
				m_Time = 0.01666667,
				animeActionSubName = "",
				action = "play",
				entity = 0,
				crossFade = 0.05,
				animeActionName = "chair1_sit_down"
			}
		},
		[1.26666666666667] = {
			{
				m_Time = 1.266667,
				animeActionSubName = "",
				action = "play",
				entity = 0,
				crossFade = 0.05,
				animeActionName = "chair1_sit_stand"
			},
			{
				m_Time = 1.266667,
				scheme = "chair1_no_idle",
				action = "changeScheme",
				entity = 0
			}
		},
		[2.96666666666667] = {
			{
				value = false,
				m_Time = 2.966667,
				action = "setMobility",
				entity = 0
			}
		}
	},
	keys = {
		0.0166666666666667,
		1.26666666666667,
		2.96666666666667
	},
	duration = 3,
	fps = 30
}
