return {
	sequence = {
		[0.1] = {
			{
				m_Time = 0.1,
				animeActionSubName = "",
				action = "play",
				entity = 0,
				crossFade = 0.05,
				animeActionName = "bed_lie"
			}
		},
		[6.26666666666667] = {
			{
				m_Time = 6.266667,
				animeActionSubName = "",
				action = "play",
				entity = 0,
				crossFade = 0.05,
				animeActionName = "bed_stand"
			},
			{
				m_Time = 6.266667,
				scheme = "bed_no_idle",
				action = "changeScheme",
				entity = 0
			},
			{
				value = false,
				m_Time = 6.266667,
				action = "setMobility",
				entity = 0
			}
		},
		[11.0333333333333] = {
			{
				value = false,
				m_Time = 11.03333,
				action = "setMobility",
				entity = 0
			}
		}
	},
	keys = {
		0.1,
		6.26666666666667,
		11.0333333333333
	},
	duration = 11.06667,
	fps = 30
}
