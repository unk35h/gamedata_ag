return {
	sequence = {
		[0] = {
			{
				m_Time = 0,
				animeActionSubName = "",
				action = "play",
				entity = 0,
				crossFade = 0.05,
				animeActionName = "chair1_sit_down"
			},
			{
				m_Time = 0,
				animeActionSubName = "",
				action = "play",
				entity = 1,
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
				animeActionSubName = "",
				action = "play",
				entity = 1,
				crossFade = 0.05,
				animeActionName = "chair1_sit_stand"
			},
			{
				m_Time = 1.266667,
				scheme = "chair1_no_idle",
				action = "changeScheme",
				entity = 0
			},
			{
				value = false,
				m_Time = 1.266667,
				action = "setMobility",
				entity = 0
			}
		},
		[4] = {
			{
				value = false,
				m_Time = 4,
				action = "setMobility",
				entity = 0
			}
		}
	},
	keys = {
		0,
		1.26666666666667,
		4
	},
	duration = 4.033333,
	fps = 30
}
