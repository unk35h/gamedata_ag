return {
	sequence = {
		[0] = {
			{
				m_Time = 0,
				animeActionSubName = "",
				action = "play",
				entity = 0,
				crossFade = 0.05,
				animeActionName = "eat"
			}
		},
		[0.2] = {
			{
				attachPoint = "gua_R_hand_bone",
				m_Time = 0.2,
				action = "playEfx",
				entity = 0,
				efxPath = "Effect/Dorm/food03",
				duration = 4.5
			}
		},
		[5.5] = {
			{
				attachPoint = "gua_R_hand_bone",
				m_Time = 5.5,
				action = "clearEfx",
				entity = 0
			}
		}
	},
	keys = {
		0,
		0.2,
		5.5
	},
	duration = 6,
	fps = 30
}
