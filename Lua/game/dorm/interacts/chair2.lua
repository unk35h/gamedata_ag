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
			}
		},
		[2.3] = {
			{
				m_Time = 2.3,
				animeActionSubName = "",
				action = "play",
				entity = 0,
				crossFade = 0.05,
				animeActionName = "chair1_sit_stand"
			},
			{
				m_Time = 2.3,
				scheme = "chair_sit_no_idle",
				action = "changeScheme",
				entity = 0
			}
		}
	},
	keys = {
		0,
		2.3
	},
	duration = 2.333333,
	fps = 30
}
