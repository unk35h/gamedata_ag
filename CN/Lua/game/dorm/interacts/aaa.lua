return {
	sequence = {
		[0.816666666666667] = {
			{
				grabBy = 0,
				m_Time = 0.8166667,
				action = "grabPart",
				attachPoint = "gua_R_hand_bone",
				itemPartName = "itemTest",
				grabFrom = 1
			}
		},
		[2.25] = {
			{
				itemPartHost = 1,
				itemPartName = "itemTest",
				action = "restorePart",
				m_Time = 2.25
			}
		},
		[4.16666666666667] = {
			{
				m_Time = 4.166667,
				animeActionSubName = "",
				action = "play",
				entity = 0,
				crossFade = 0.05,
				animeActionName = "oven"
			},
			{
				m_Time = 4.166667,
				animeActionSubName = "",
				action = "play",
				entity = 1,
				crossFade = 0.05,
				animeActionName = "oven"
			}
		},
		[4.86666666666667] = {
			{
				m_Time = 4.866667,
				referenceTarget = 1,
				action = "putAt",
				entity = 0,
				referencePointName = "gua_start"
			}
		},
		[5.25] = {
			{
				m_Time = 5.25,
				scheme = "sit",
				action = "changeScheme",
				entity = 0
			}
		},
		[8.98333333333333] = {
			{
				playerType = 1,
				name = "bbb",
				action = "playVoice",
				sheet = "aaa",
				m_Time = 8.983334,
				awb = "ccc"
			}
		},
		[10] = {
			{
				field = "nextInteract",
				m_Time = 10,
				action = "setValue",
				entity = 0,
				value = "bbb"
			}
		}
	},
	keys = {
		0.816666666666667,
		2.25,
		4.16666666666667,
		4.86666666666667,
		5.25,
		8.98333333333333,
		10
	},
	duration = 10,
	fps = 60
}
