return {
	sequence = {
		[0.0333333333333333] = {
			{
				m_Time = 0.03333334,
				animeActionSubName = "",
				action = "play",
				entity = 0,
				crossFade = 0.05,
				animeActionName = "chair2_lie"
			},
			{
				m_Time = 0.03333334,
				animeActionSubName = "",
				action = "play",
				entity = 1,
				crossFade = 0.05,
				animeActionName = "chair2_lie"
			}
		},
		[6.03333333333333] = {
			{
				m_Time = 6.033333,
				animeActionSubName = "",
				action = "play",
				entity = 1,
				crossFade = 0.05,
				animeActionName = "chair2_stand"
			},
			{
				m_Time = 6.033333,
				animeActionSubName = "",
				action = "play",
				entity = 0,
				crossFade = 0.05,
				animeActionName = "chair2_stand"
			},
			{
				m_Time = 6.033333,
				scheme = "chair2_no_idle",
				action = "changeScheme",
				entity = 0
			},
			{
				value = false,
				m_Time = 6.033333,
				action = "setMobility",
				entity = 0
			}
		},
		[7.5] = {
			{
				value = false,
				m_Time = 7.5,
				action = "setMobility",
				entity = 0
			}
		}
	},
	keys = {
		0.0333333333333333,
		6.03333333333333,
		7.5
	},
	duration = 7.533333,
	fps = 30
}
