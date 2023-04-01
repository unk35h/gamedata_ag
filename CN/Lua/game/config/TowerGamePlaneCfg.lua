return {
	[0] = {
		name = "0",
		icon_battle = "0",
		dismantle_return = 0,
		type = -1,
		sub_type = 0,
		upgrade_cost = 0,
		condition = 0,
		desc = "0",
		activity_id = 101591,
		id = 0,
		icon = "0",
		sub_array = {
			1001,
			1009
		}
	},
	[1001] = {
		name = "控制型-A",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1001",
		dismantle_return = 160,
		type = 0,
		sub_type = 1,
		upgrade_cost = 160,
		condition = 0,
		desc = "射程<color=#FF9500>10</color>m，每隔<color=#FF9500>3</color>秒，造成一次<color=#FF9500>230%</color>的单体伤害，被命中的敌人移速降低<color=#FF9500>35%</color>，持续<color=#FF9500>2.5</color>秒",
		activity_id = 101591,
		id = 1001,
		icon = "Textures/MardukUI/boss/snakeactive/1001",
		sub_array = {
			1002
		}
	},
	[1002] = {
		name = "控制型-A1",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1002",
		dismantle_return = 250,
		type = 0,
		sub_type = 1,
		upgrade_cost = 250,
		condition = 0,
		desc = "射程<color=#FF9500>12</color>m，每隔<color=#FF9500>3</color>秒，造成一次<color=#FF9500>350%</color>的单体伤害，使命中的敌人移速降低<color=#FF9500>35%</color>，持续<color=#FF9500>2.5</color>秒",
		activity_id = 101591,
		id = 1002,
		icon = "Textures/MardukUI/boss/snakeactive/1002",
		sub_array = {
			1003,
			1004
		}
	},
	[1003] = {
		name = "群伤型分支",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1003",
		dismantle_return = 300,
		type = 0,
		sub_type = 1,
		upgrade_cost = 300,
		condition = 101601,
		desc = "射程<color=#FF9500>12</color>m，每秒造成<color=#FF9500>50%</color>的范围伤害，范围内的敌人移速降低<color=#FF9500>35%</color>，持续<color=#FF9500>2.5</color>秒",
		activity_id = 101591,
		id = 1003,
		icon = "Textures/MardukUI/boss/snakeactive/1003",
		sub_array = {
			1005,
			1006
		}
	},
	[1004] = {
		name = "冰冻型分支",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1004",
		dismantle_return = 300,
		type = 0,
		sub_type = 1,
		upgrade_cost = 300,
		condition = 101602,
		desc = "射程<color=#FF9500>12</color>m，每隔<color=#FF9500>8</color>秒，发射一枚冰冻弹，命中时在半径<color=#FF9500>4</color>m内造成<color=#FF9500>500%</color>的范围伤害，冰冻被命中的敌人，持续<color=#FF9500>3</color>秒",
		activity_id = 101591,
		id = 1004,
		icon = "Textures/MardukUI/boss/snakeactive/1004",
		sub_array = {
			1007,
			1008
		}
	},
	[1005] = {
		name = "溶解装置",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1005",
		dismantle_return = 200,
		type = 0,
		sub_type = 2,
		upgrade_cost = 200,
		condition = 101601,
		desc = "装置等级上限<color=#FF9500>3</color>，敌人生命值越低造成的伤害越高，敌人每损失<color=#FF9500>1%</color>的血量，额外受到<color=#FF9500>1%</color>、<color=#FF9500>2%</color>、<color=#FF9500>3%</color>伤害",
		activity_id = 101591,
		id = 1005,
		icon = "Textures/MardukUI/boss/snakeactive/1005",
		sub_array = {}
	},
	[1006] = {
		name = "混乱装置",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1006",
		dismantle_return = 300,
		type = 0,
		sub_type = 2,
		upgrade_cost = 300,
		condition = 101601,
		desc = "装置等级上限<color=#FF9500>2</color>，每隔<color=#FF9500>25</color>、<color=#FF9500>15</color>秒，使范围内的敌人混乱，持续<color=#FF9500>5</color>秒",
		activity_id = 101591,
		id = 1006,
		icon = "Textures/MardukUI/boss/snakeactive/1006",
		sub_array = {}
	},
	[1007] = {
		name = "碎冰装置",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1007",
		dismantle_return = 200,
		type = 0,
		sub_type = 2,
		upgrade_cost = 200,
		condition = 101602,
		desc = "装置等级上限<color=#FF9500>3</color>，解除冰冻时，额外受到<color=#FF9500>300%</color>、<color=#FF9500>600%</color>、<color=#FF9500>900%</color>伤害",
		activity_id = 101591,
		id = 1007,
		icon = "Textures/MardukUI/boss/snakeactive/1007",
		sub_array = {}
	},
	[1008] = {
		name = "极寒装置",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1008",
		dismantle_return = 300,
		type = 0,
		sub_type = 2,
		upgrade_cost = 300,
		condition = 101602,
		desc = "装置等级上限<color=#FF9500>2</color>，冰冻弹的影响范围扩大至<color=#FF9500>6</color>m、<color=#FF9500>8</color>m",
		activity_id = 101591,
		id = 1008,
		icon = "Textures/MardukUI/boss/snakeactive/1008",
		sub_array = {}
	},
	[1009] = {
		name = "攻击型-B",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1009",
		dismantle_return = 110,
		type = 1,
		sub_type = 1,
		upgrade_cost = 110,
		condition = 0,
		desc = "射程<color=#FF9500>10</color>m，每隔<color=#FF9500>1.5</color>秒，造成一次<color=#FF9500>180%</color>的单体伤害",
		activity_id = 101591,
		id = 1009,
		icon = "Textures/MardukUI/boss/snakeactive/1009",
		sub_array = {
			1010
		}
	},
	[1010] = {
		name = "攻击型-B1",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1010",
		dismantle_return = 160,
		type = 1,
		sub_type = 1,
		upgrade_cost = 160,
		condition = 0,
		desc = "射程<color=#FF9500>12</color>m，每隔<color=#FF9500>1.5</color>秒，造成一次<color=#FF9500>250%</color>的单体伤害",
		activity_id = 101591,
		id = 1010,
		icon = "Textures/MardukUI/boss/snakeactive/1010",
		sub_array = {
			1011,
			1012
		}
	},
	[1011] = {
		name = "火焰型分支",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1011",
		dismantle_return = 230,
		type = 1,
		sub_type = 1,
		upgrade_cost = 230,
		condition = 101601,
		desc = "射程<color=#FF9500>12</color>m，每隔<color=#FF9500>6</color>秒，发射一枚火焰弹，命中时在半径<color=#FF9500>5</color>m内造成<color=#FF9500>500%</color>的范围伤害",
		activity_id = 101591,
		id = 1011,
		icon = "Textures/MardukUI/boss/snakeactive/1011",
		sub_array = {
			1013,
			1014
		}
	},
	[1012] = {
		name = "狙击型分支",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1012",
		dismantle_return = 275,
		type = 1,
		sub_type = 1,
		upgrade_cost = 275,
		condition = 101602,
		desc = "射程<color=#FF9500>20</color>m，每隔<color=#FF9500>8</color>秒，狙击敌人，优先选择精英目标，造成一次<color=#FF9500>2000%</color>的单体伤害",
		activity_id = 101591,
		id = 1012,
		icon = "Textures/MardukUI/boss/snakeactive/1012",
		sub_array = {
			1015,
			1016
		}
	},
	[1013] = {
		name = "燃烧装置",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1013",
		dismantle_return = 200,
		type = 1,
		sub_type = 2,
		upgrade_cost = 200,
		condition = 101601,
		desc = "装置等级上限<color=#FF9500>3</color>，火焰弹命中敌人时，附加<color=#FF9500>1</color>、<color=#FF9500>2</color>、<color=#FF9500>3</color>级灼烧，持续<color=#FF9500>12</color>秒",
		activity_id = 101591,
		id = 1013,
		icon = "Textures/MardukUI/boss/snakeactive/1013",
		sub_array = {}
	},
	[1014] = {
		name = "多发装置",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1014",
		dismantle_return = 300,
		type = 1,
		sub_type = 2,
		upgrade_cost = 300,
		condition = 101601,
		desc = "装置等级上限<color=#FF9500>2</color>，额外发射<color=#FF9500>1</color>、<color=#FF9500>2</color>个火焰弹",
		activity_id = 101591,
		id = 1014,
		icon = "Textures/MardukUI/boss/snakeactive/1014",
		sub_array = {}
	},
	[1015] = {
		name = "过载装置",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1015",
		dismantle_return = 200,
		type = 1,
		sub_type = 2,
		upgrade_cost = 200,
		condition = 101602,
		desc = "装置等级上限<color=#FF9500>3</color>，提升狙击速度，攻击间隔改为<color=#FF9500>7</color>、<color=#FF9500>6</color>、<color=#FF9500>5</color>秒",
		activity_id = 101591,
		id = 1015,
		icon = "Textures/MardukUI/boss/snakeactive/1015",
		sub_array = {}
	},
	[1016] = {
		name = "标记装置",
		icon_battle = "Textures/MardukUI/boss/snakeactive_buff02/1016",
		dismantle_return = 300,
		type = 1,
		sub_type = 2,
		upgrade_cost = 300,
		condition = 101602,
		desc = "装置等级上限<color=#FF9500>2</color>，攻击会标记目标，使其受到的伤害提升<color=#FF9500>50%</color>、<color=#FF9500>100%</color>，持续<color=#FF9500>3</color>秒",
		activity_id = 101591,
		id = 1016,
		icon = "Textures/MardukUI/boss/snakeactive/1016",
		sub_array = {}
	},
	all = {
		0,
		1001,
		1002,
		1003,
		1004,
		1005,
		1006,
		1007,
		1008,
		1009,
		1010,
		1011,
		1012,
		1013,
		1014,
		1015,
		1016
	}
}
