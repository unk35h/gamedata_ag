return {
	{
		id = 1,
		narrator_icon = "1036",
		narrator_name = "巴德尔",
		is_no_home = true,
		steps = {
			101,
			102,
			106
		},
		open_condition = {},
		skip_condition = {
			{
				"stage",
				1010001
			}
		},
		leaps = {}
	},
	{
		id = 2,
		narrator_icon = "1036",
		narrator_name = "巴德尔",
		is_no_home = true,
		steps = {
			201,
			202,
			206
		},
		open_condition = {
			{
				"stage",
				1010001
			}
		},
		skip_condition = {
			{
				"stage",
				1010002
			}
		},
		leaps = {}
	},
	{
		id = 3,
		narrator_icon = "1036",
		narrator_name = "巴德尔",
		is_no_home = false,
		steps = {},
		open_condition = {
			{
				"stage",
				1010002
			}
		},
		skip_condition = {},
		leaps = {}
	},
	{
		id = 4,
		narrator_icon = "1036",
		narrator_name = "巴德尔",
		is_no_home = false,
		steps = {
			401,
			402,
			403,
			404,
			405,
			406,
			407,
			408,
			409,
			410,
			414
		},
		open_condition = {
			{
				"guide",
				3
			}
		},
		skip_condition = {
			{
				"stage",
				1010003
			}
		},
		leaps = {}
	},
	{
		id = 5,
		narrator_icon = "1036",
		narrator_name = "巴德尔",
		is_no_home = true,
		steps = {
			501,
			502,
			503,
			504,
			505,
			506,
			507,
			511
		},
		open_condition = {
			{
				"stage",
				1010003
			}
		},
		skip_condition = {
			{
				"stage",
				1010004
			}
		},
		leaps = {}
	},
	{
		id = 6,
		narrator_icon = "1036",
		narrator_name = "巴德尔",
		is_no_home = true,
		steps = {
			601,
			602,
			603,
			607
		},
		open_condition = {
			{
				"stage",
				1010004
			}
		},
		skip_condition = {
			{
				"stage",
				1010005
			}
		},
		leaps = {}
	},
	[8] = {
		id = 8,
		narrator_icon = "1036",
		narrator_name = "巴德尔",
		is_no_home = false,
		steps = {},
		open_condition = {
			{
				"stage",
				1010005
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[9] = {
		id = 9,
		narrator_icon = "1036",
		narrator_name = "巴德尔",
		is_no_home = false,
		steps = {
			901,
			902
		},
		open_condition = {
			{
				"guide",
				8
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[10] = {
		id = 10,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			1001,
			1002,
			1003,
			1004,
			1005
		},
		open_condition = {
			{
				"playerLevel",
				21
			},
			{
				"uiNameList",
				{
					"home",
					"chapterMap"
				}
			}
		},
		skip_condition = {},
		leaps = {
			{
				"chapterMap",
				2
			}
		}
	},
	[11] = {
		id = 11,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			1101,
			1102,
			1103,
			1104,
			1105
		},
		open_condition = {
			{
				"playerLevel",
				27
			},
			{
				"uiNameList",
				{
					"home",
					"chapterMap",
					"mythic"
				}
			}
		},
		skip_condition = {},
		leaps = {
			{
				"chapterMap",
				2
			},
			{
				"mythic",
				4
			}
		}
	},
	[12] = {
		id = 12,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			1201,
			1202,
			1203,
			1204
		},
		open_condition = {
			{
				"playerLevel",
				28
			},
			{
				"uiNameList",
				{
					"home",
					"chapterMap"
				}
			}
		},
		skip_condition = {},
		leaps = {
			{
				"chapterMap",
				2
			}
		}
	},
	[13] = {
		id = 13,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			1301,
			1302,
			1303,
			1304,
			1305
		},
		open_condition = {
			{
				"playerLevel",
				30
			},
			{
				"uiNameList",
				{
					"home",
					"chapterMap"
				}
			},
			{
				"playerLevelLessThan",
				80
			}
		},
		skip_condition = {
			{
				"playerLevel",
				79
			}
		},
		leaps = {
			{
				"chapterMap",
				2
			}
		}
	},
	[16] = {
		id = 16,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			1601,
			1602
		},
		open_condition = {
			{
				"uiNameList",
				{
					"weaponServantEnter"
				}
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[17] = {
		id = 17,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			1701,
			1702,
			1703,
			1704
		},
		open_condition = {
			{
				"stage",
				1010102
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[18] = {
		id = 18,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			1801,
			1802,
			1803,
			1804,
			1805,
			1806,
			1807,
			1808
		},
		open_condition = {
			{
				"stage",
				1010113
			}
		},
		skip_condition = {},
		leaps = {
			{
				"newHero",
				2
			}
		}
	},
	[19] = {
		skip_condition = "",
		id = 19,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {},
		open_condition = {
			{
				"stage",
				1010211
			}
		},
		leaps = {}
	},
	[20] = {
		id = 20,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			2001,
			2002,
			2003,
			2004
		},
		open_condition = {
			{
				"playerLevel",
				25
			},
			{
				"stage",
				1010501
			},
			{
				"uiNameList",
				{
					"chapterMap"
				}
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[21] = {
		id = 21,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			2101,
			2102,
			2103
		},
		open_condition = {
			{
				"stage",
				1010613
			},
			{
				"uiNameList",
				{
					"chapterMap"
				}
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[22] = {
		id = 22,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			2201,
			2202,
			2203
		},
		open_condition = {
			{
				"playerLevel",
				40
			},
			{
				"stage",
				1010801
			},
			{
				"uiNameList",
				{
					"chapterMap"
				}
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[23] = {
		id = 23,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			2301
		},
		open_condition = {
			{
				"playerLevel",
				30
			},
			{
				"uiNameList",
				{
					"home"
				}
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[27] = {
		id = 27,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			2701,
			2702,
			2703,
			2704,
			2705,
			2706
		},
		open_condition = {
			{
				"stage",
				1011206
			}
		},
		skip_condition = {},
		leaps = {
			{
				"skuldTravelView",
				2
			}
		}
	},
	[28] = {
		id = 28,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {},
		open_condition = {},
		skip_condition = {},
		leaps = {}
	},
	[29] = {
		id = 29,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			2901,
			2902
		},
		open_condition = {
			{
				"stage",
				1011242
			}
		},
		skip_condition = {},
		leaps = {
			{
				"skuldTravelView",
				2
			}
		}
	},
	[34] = {
		id = 34,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			3401
		},
		open_condition = {
			{
				"playerLevel",
				20
			}
		},
		skip_condition = {
			{
				"playerLevel",
				25
			}
		},
		leaps = {}
	},
	[36] = {
		id = 36,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			3601,
			3602,
			3603,
			3604,
			3605
		},
		open_condition = {
			{
				"drawNewHero"
			},
			{
				"uiNameList",
				{
					"home"
				}
			}
		},
		skip_condition = {
			{
				"playerLevel",
				20
			}
		},
		leaps = {}
	},
	[37] = {
		id = 37,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			3701,
			3702,
			3703,
			3704
		},
		open_condition = {
			{
				"equipLevel",
				30
			},
			{
				"uiNameList",
				{
					"equipEnchantMainView"
				}
			}
		},
		skip_condition = {
			{
				"playerLevel",
				50
			}
		},
		leaps = {}
	},
	[38] = {
		id = 38,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			3801,
			3802
		},
		open_condition = {
			{
				"playerLevel",
				25
			},
			{
				"stage",
				1010501
			},
			{
				"uiNameList",
				{
					"chapterMap"
				}
			}
		},
		skip_condition = {
			{
				"playerLevel",
				30
			}
		},
		leaps = {}
	},
	[39] = {
		id = 39,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			3901,
			3902,
			3903
		},
		open_condition = {
			{
				"playerLevel",
				60
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[40] = {
		id = 40,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			4001,
			4002,
			4003,
			4004,
			4005,
			4006,
			4007
		},
		open_condition = {
			{
				"uiNameList",
				{
					"transitionSkill"
				}
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[41] = {
		id = 41,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			4101,
			4102,
			4103,
			4104
		},
		open_condition = {
			{
				"uiNameList",
				{
					"equipRaceView"
				}
			}
		},
		skip_condition = {
			{
				"playerLevel",
				50
			}
		},
		leaps = {}
	},
	[42] = {
		id = 42,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			4201,
			4202,
			4203,
			4204,
			4205,
			4206,
			4207,
			4208
		},
		open_condition = {
			{
				"playerLevel",
				60
			},
			{
				"uiNameList",
				{
					"home",
					"chapterMap",
					"abyssMain"
				}
			}
		},
		skip_condition = {},
		leaps = {
			{
				"chapterMap",
				2
			},
			{
				"abyssMain",
				4
			}
		}
	},
	[43] = {
		id = 43,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			4301,
			4302,
			4303,
			4304,
			4305,
			4306,
			4307,
			4308,
			4309,
			4310,
			4311
		},
		open_condition = {
			{
				"playerLevel",
				70
			},
			{
				"uiNameList",
				{
					"home",
					"weaponModuleView"
				}
			}
		},
		skip_condition = {},
		leaps = {
			{
				"weaponModuleView",
				5
			}
		}
	},
	[44] = {
		id = 44,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			4401,
			4402,
			4403,
			4404,
			4405,
			4406,
			4407,
			4408,
			4409,
			4410,
			4411,
			4412
		},
		open_condition = {
			{
				"uiNameList",
				{
					"activityNoob"
				}
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[45] = {
		id = 45,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			4501
		},
		open_condition = {
			{
				"playerLevel",
				60
			},
			{
				"uiNameList",
				{
					"home"
				}
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[46] = {
		id = 46,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {},
		open_condition = {
			{
				"playerLevel",
				32
			},
			{
				"uiNameList",
				{
					"home",
					"chapterMap",
					"polyhedronLobby"
				}
			}
		},
		skip_condition = {},
		leaps = {
			{
				"chapterMap",
				2
			},
			{
				"polyhedronLobby",
				4
			}
		}
	},
	[47] = {
		id = 47,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			4701
		},
		open_condition = {
			{
				"playerLevel",
				35
			},
			{
				"uiNameList",
				{
					"home"
				}
			},
			{
				"heroFavorability",
				{
					1084,
					5
				}
			}
		},
		skip_condition = {},
		leaps = {
			{
				"backHomeEnterView",
				2
			},
			{
				"dorm",
				4
			}
		}
	},
	[48] = {
		id = 48,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			4801,
			4802,
			4803,
			4804,
			4805
		},
		open_condition = {
			{
				"playerLevel",
				35
			},
			{
				"uiNameList",
				{
					"backHomeEnterView",
					"dorm"
				}
			}
		},
		skip_condition = {},
		leaps = {
			{
				"dorm",
				2
			}
		}
	},
	[49] = {
		id = 49,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			4901,
			4902,
			4903,
			4904
		},
		open_condition = {
			{
				"playerLevel",
				35
			},
			{
				"uiNameList",
				{
					"dorm"
				}
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[50] = {
		id = 50,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			5001,
			5002,
			5003,
			5004,
			5005,
			5006,
			5007,
			5008
		},
		open_condition = {
			{
				"playerLevel",
				35
			},
			{
				"uiNameList",
				{
					"dorm"
				}
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[51] = {
		id = 51,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			5101,
			5102,
			5103,
			5104
		},
		open_condition = {
			{
				"playerLevel",
				35
			},
			{
				"uiNameList",
				{
					"heroInteractView"
				}
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[52] = {
		id = 52,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			5201,
			5202,
			5203,
			5204,
			5205,
			5206,
			5207
		},
		open_condition = {
			{
				"playerLevel",
				35
			},
			{
				"uiNameList",
				{
					"backHomeEnterView",
					"restaurantMain"
				}
			}
		},
		skip_condition = {},
		leaps = {
			{
				"restaurantMain",
				2
			}
		}
	},
	[53] = {
		id = 53,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			5301,
			5302,
			5303,
			5304,
			5305
		},
		open_condition = {
			{
				"playerLevel",
				35
			},
			{
				"uiNameList",
				{
					"restaurantMain"
				}
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[54] = {
		id = 54,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			5401,
			5402,
			5403,
			5404,
			5405,
			5406,
			5407,
			5408
		},
		open_condition = {
			{
				"playerLevel",
				35
			},
			{
				"uiNameList",
				{
					"restaurantMain"
				}
			}
		},
		skip_condition = {},
		leaps = {}
	},
	[55] = {
		id = 55,
		narrator_icon = "mmr",
		narrator_name = "弥弥尔",
		is_no_home = false,
		steps = {
			5501,
			5502,
			5503,
			5504,
			5505
		},
		open_condition = {
			{
				"playerLevel",
				35
			},
			{
				"uiNameList",
				{
					"restaurantMain"
				}
			}
		},
		skip_condition = {},
		leaps = {}
	},
	all = {
		1,
		2,
		3,
		4,
		5,
		6,
		8,
		9,
		10,
		11,
		12,
		13,
		16,
		17,
		18,
		19,
		20,
		21,
		22,
		23,
		27,
		28,
		29,
		34,
		36,
		37,
		38,
		39,
		40,
		41,
		42,
		43,
		44,
		45,
		46,
		47,
		48,
		49,
		50,
		51,
		52,
		53,
		54,
		55
	}
}
