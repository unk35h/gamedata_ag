return {
	[101] = {
		talk_anchors = 0,
		type = "EnterStage",
		is_finish = false,
		id = 101,
		talk_content = "",
		params = {
			1010001
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[102] = {
		talk_anchors = 0,
		type = "WaitBattleResult",
		is_finish = true,
		id = 102,
		talk_content = "",
		params = {
			103,
			104,
			105,
			102
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[103] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 103,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				1,
				"itemBtn_"
			}
		},
		mask_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				1,
				"buttonImage_"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[104] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 104,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSectionInfo",
			{
				"guideComponents",
				"guide_battleBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[105] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 105,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"guideComponents",
				"guide_startBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[106] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		is_finish = false,
		id = 106,
		talk_content = "",
		params = {
			true
		},
		guide_component = {
			"common",
			"battleChapterResult",
			{
				"btnBack_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[201] = {
		talk_anchors = 0,
		type = "EnterStage",
		is_finish = false,
		id = 201,
		talk_content = "",
		params = {
			1010002
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[202] = {
		talk_anchors = 0,
		type = "WaitBattleResult",
		is_finish = false,
		id = 202,
		talk_content = "",
		params = {
			203,
			204,
			205,
			202
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[203] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 203,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				2,
				"itemBtn_"
			}
		},
		mask_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				2,
				"buttonImage_"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[204] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 204,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSectionInfo",
			{
				"guideComponents",
				"guide_battleBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[205] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 205,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"guideComponents",
				"guide_startBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[206] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		is_finish = true,
		id = 206,
		talk_content = "",
		params = {
			false
		},
		guide_component = {
			"common",
			"battleChapterResult",
			{
				"btnBack_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[301] = {
		talk_anchors = 0,
		type = "JumpTo",
		is_finish = false,
		id = 301,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[302] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 302,
		talk_content = "进入源层前，先提升队伍的实力做准备吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_goddess"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-918,
			300
		}
	},
	[303] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 303,
		talk_content = "前鬼坊也会一起进入源层，这次她将配合你的作战安排。",
		params = {},
		guide_component = {
			"child_getcom",
			"newHero",
			{
				"guideComponents",
				"guide_shortGridContent_"
			},
			"1148",
			"Button"
		},
		mask_component = {
			"child",
			"newHero",
			{
				"guideComponents",
				"guide_shortGridContent_"
			},
			"1148/heroinfo"
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[304] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 304,
		talk_content = "首先，试着提升前鬼坊的作战等级吧。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				1,
				"upgradeBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[305] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 305,
		talk_content = "学习资料已经准备好了，点击「升级」就可以快速获得作战知识。",
		params = {},
		guide_component = {
			"common",
			"newAddExp",
			{
				"okBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[306] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		is_finish = false,
		id = 306,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"newHeroUpgradeSuccess",
			{
				"bgBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[307] = {
		talk_anchors = 4,
		type = "ClickCToggle",
		is_finish = false,
		id = 307,
		talk_content = "刻印可以为修正者提供额外的力量。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"toggle5_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[308] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 308,
		talk_content = "在中继之环中查看刻印的配备情况。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				4,
				"guideComponents",
				"guide_itemBtn1"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[309] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 309,
		talk_content = "在刚才的战斗中获得了新的刻印，现在为前鬼坊装备上吧。",
		params = {},
		guide_component = {
			"listIndex",
			"heroEquipBag",
			{
				"equipBag_",
				"scrollHelper_"
			},
			1,
			{
				"clickBtn_"
			}
		},
		mask_component = {},
		mask_scale = {
			0.7,
			0.7
		},
		talk_position = {
			386,
			133
		}
	},
	[310] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 310,
		talk_content = "刻印有对应的装备位，每三个同名刻印同时装备时还会有额外的加成效果。",
		params = {},
		guide_component = {
			"common",
			"heroEquipBag",
			{
				"guideComponents",
				"guide_suitPanel"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[311] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 311,
		talk_content = "点击「更换」将刻印置入对应的共鸣位。",
		params = {},
		guide_component = {
			"common",
			"heroEquipBag",
			{
				"guideComponents",
				"guide_changeBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[312] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 312,
		talk_content = "此外，刻印也可以提升等级以增强力量。",
		params = {},
		guide_component = {
			"common",
			"heroEquipBag",
			{
				"guideComponents",
				"guide_item1Btn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[313] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 313,
		talk_content = "同作为人类文明史的载体，刻印间可以通过共化来进行升级。",
		params = {},
		guide_component = {
			"common",
			"heroEquipBag",
			{
				"guideComponents",
				"guide_btn_strengthOld"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[314] = {
		talk_anchors = 4,
		type = "EventTrigger",
		is_finish = false,
		id = 314,
		talk_content = "选择作为共化素材的刻印「启示录」。",
		params = {
			"pointerDown"
		},
		guide_component = {
			"listIndex_getcom",
			"equipStrengthView",
			{
				"scrollHelper"
			},
			1,
			{
				"longClickBtn_"
			},
			"EventTriggerListener"
		},
		mask_component = {},
		mask_scale = {
			0.7,
			0.7
		},
		talk_position = {
			386,
			133
		}
	},
	[315] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = true,
		id = 315,
		talk_content = "「启示录」是一种特殊的刻印，当它作为共化材料时可以提供更多的经验。",
		params = {},
		guide_component = {
			"common",
			"equipStrengthView",
			{
				"btnStrength_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[316] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		is_finish = false,
		id = 316,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"equipStrengthSuccessView",
			{
				"gameObject_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[317] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 317,
		talk_content = "返回主界面。",
		params = {},
		guide_component = {
			"windowBar",
			"homeBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			581,
			-218
		}
	},
	[401] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 401,
		talk_content = "队伍整备得差不多了，点击「作战」继续执行任务吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-360,
			292
		}
	},
	[402] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 402,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"contentView_",
				1,
				"itemList_",
				1,
				"btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[403] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 403,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				3,
				"itemBtn_"
			}
		},
		mask_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				3,
				"gameObject_"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[404] = {
		talk_anchors = 0,
		talk_position = "",
		type = "SetTeam",
		is_finish = false,
		id = 404,
		talk_content = "",
		params = {
			1084,
			0,
			0
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {}
	},
	[405] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 405,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSectionInfo",
			{
				"guideComponents",
				"guide_battleBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[406] = {
		talk_anchors = 4,
		type = "EventTrigger",
		is_finish = false,
		id = 406,
		talk_content = "将刚加入的前鬼坊编入作战队伍。",
		params = {
			"pointerDown"
		},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"drag2_"
			},
			"EventTriggerListener"
		},
		mask_component = {
			"common",
			"sectionSelectHero",
			{
				"guideComponents",
				"guide_addBtn2"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[407] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 407,
		talk_content = "",
		params = {},
		guide_component = {
			"child_getcom",
			"heroTeamInfo",
			{
				"guideComponents",
				"guide_listContent"
			},
			"1148",
			"Button"
		},
		mask_component = {
			"child",
			"heroTeamInfo",
			{
				"guideComponents",
				"guide_listContent"
			},
			"1148/heroinfo"
		},
		mask_scale = {},
		talk_position = {}
	},
	[408] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 408,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"heroTeamInfo",
			{
				"joinBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[409] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 409,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"guideComponents",
				"guide_startBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[410] = {
		talk_anchors = 0,
		type = "WaitBattleResult",
		is_finish = true,
		id = 410,
		talk_content = "",
		params = {
			411,
			412,
			413,
			410
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[411] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 411,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				3,
				"itemBtn_"
			}
		},
		mask_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				3,
				"gameObject_"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[412] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 412,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSectionInfo",
			{
				"guideComponents",
				"guide_battleBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[413] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 413,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"guideComponents",
				"guide_startBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[414] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		is_finish = false,
		id = 414,
		talk_content = "",
		params = {
			false
		},
		guide_component = {
			"common",
			"battleChapterResult",
			{
				"btnBack_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[501] = {
		talk_anchors = 0,
		talk_position = "",
		type = "SetTeam",
		is_finish = false,
		id = 501,
		talk_content = "",
		params = {
			1084,
			1148,
			0
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {}
	},
	[502] = {
		talk_anchors = 0,
		type = "JumpTo",
		is_finish = false,
		id = 502,
		talk_content = "",
		params = {
			313,
			10100,
			1010004,
			1,
			1
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[503] = {
		talk_anchors = 4,
		type = "EventTrigger",
		is_finish = false,
		id = 503,
		talk_content = "看起来出现了更为强大的敌人，但是不用担心，波塞冬也赶到了。",
		params = {
			"pointerDown"
		},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"drag3_"
			},
			"EventTriggerListener"
		},
		mask_component = {
			"common",
			"sectionSelectHero",
			{
				"guideComponents",
				"guide_addBtn3"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[504] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 504,
		talk_content = "将新加入的波塞冬编入作战队伍。",
		params = {},
		guide_component = {
			"child_getcom",
			"heroTeamInfo",
			{
				"guideComponents",
				"guide_listContent"
			},
			"1039",
			"Button"
		},
		mask_component = {
			"child",
			"heroTeamInfo",
			{
				"guideComponents",
				"guide_listContent"
			},
			"1039/heroinfo"
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[505] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 505,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"heroTeamInfo",
			{
				"joinBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[506] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 506,
		talk_content = "有了波塞冬的支援，小队实力也更有保证了。现在，继续迎击敌人吧。",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"guideComponents",
				"guide_startBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[507] = {
		talk_anchors = 0,
		type = "WaitBattleResult",
		is_finish = true,
		id = 507,
		talk_content = "",
		params = {
			508,
			509,
			510,
			507
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[508] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 508,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				4,
				"itemBtn_"
			}
		},
		mask_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				4,
				"gameObject_"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[509] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 509,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSectionInfo",
			{
				"guideComponents",
				"guide_battleBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[510] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 510,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"guideComponents",
				"guide_startBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[511] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		is_finish = false,
		id = 511,
		talk_content = "",
		params = {
			true
		},
		guide_component = {
			"common",
			"battleChapterResult",
			{
				"btnBack_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[601] = {
		talk_anchors = 0,
		talk_position = "",
		type = "SetTeam",
		is_finish = false,
		id = 601,
		talk_content = "",
		params = {
			1084,
			1148,
			1039
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {}
	},
	[602] = {
		talk_anchors = 0,
		type = "EnterStage",
		is_finish = false,
		id = 602,
		talk_content = "",
		params = {
			1010005
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[603] = {
		talk_anchors = 0,
		type = "WaitBattleResult",
		is_finish = true,
		id = 603,
		talk_content = "",
		params = {
			604,
			605,
			606,
			603
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[604] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 604,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				5,
				"itemBtn_"
			}
		},
		mask_component = {
			"common",
			"chapterSection",
			{
				"missionItem_",
				5,
				"gameObject_"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[605] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 605,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"chapterSectionInfo",
			{
				"guideComponents",
				"guide_battleBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[606] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 606,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"sectionSelectHero",
			{
				"guideComponents",
				"guide_startBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[607] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		is_finish = false,
		id = 607,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"battleChapterResult",
			{
				"btnBack_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[801] = {
		talk_anchors = 0,
		type = "JumpTo",
		is_finish = false,
		id = 801,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[802] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 802,
		talk_content = "管理员，权钥系统已经完成调试了，去看看吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_goddess"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-918,
			300
		}
	},
	[803] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 803,
		talk_content = "当修正者苏醒时，「盖亚」系统会为其赋予一定的系统权能，即是权钥。",
		params = {},
		guide_component = {
			"child_getcom",
			"newHero",
			{
				"guideComponents",
				"guide_shortGridContent_"
			},
			"1084",
			"Button"
		},
		mask_component = {
			"child",
			"newHero",
			{
				"guideComponents",
				"guide_shortGridContent_"
			},
			"1084/heroinfo"
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[804] = {
		talk_anchors = 3,
		type = "ClickCToggle",
		is_finish = false,
		id = 804,
		talk_content = "权钥既是修正者的武器，也是修正者的力量来源。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"toggle4_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[805] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 805,
		talk_content = "和修正者可以变强一样，权钥也能够被强化。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				3,
				"weaponstrengthBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[806] = {
		talk_anchors = 4,
		type = "EventTrigger",
		is_finish = false,
		id = 806,
		talk_content = "从源层深处发现的源质结晶可以被权钥净化并吸收。",
		params = {
			"pointerDown"
		},
		guide_component = {
			"listIndex_getcom",
			"weapon",
			{
				"scrollHelper_"
			},
			1,
			{
				"longClickBtn_"
			},
			"EventTriggerListener"
		},
		mask_component = {},
		mask_scale = {
			0.7,
			0.7
		},
		talk_position = {
			386,
			133
		}
	},
	[807] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 807,
		talk_content = "这次的行动收获了不少源质结晶，试着强化一下薇儿丹蒂的权钥——卢恩之刃吧。",
		params = {},
		guide_component = {
			"common",
			"weapon",
			{
				"upgradebtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[808] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		is_finish = false,
		id = 808,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"weaponStr",
			{
				"bgmask_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[809] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 809,
		talk_content = "除了吸收源质结晶以外，还有其他的方式能够增强权钥的力量，点击回到权钥界面。",
		params = {},
		guide_component = {
			"windowBar",
			"backBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			378,
			-218
		}
	},
	[810] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 810,
		talk_content = "每件权钥都可以选择一位钥从依附，增强修正者对其的控制力。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				3,
				"emptyreplaceBtn_"
			}
		},
		mask_component = {
			"common",
			"newHero",
			{
				"pages_",
				3,
				"guideComponents",
				"guide_notequipped"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[811] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 811,
		talk_content = "需要注意，每个神系的钥从仅可以依附在对应神系的修正者权钥之上。",
		params = {},
		guide_component = {
			"common",
			"weaponServant",
			{
				"guideComponents",
				"guide_camp"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[812] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 812,
		talk_content = "钥从依附权钥后，除了可以提供攻击力加成外，还具备有特殊的权能。",
		params = {},
		guide_component = {
			"common",
			"weaponServant",
			{
				"guideComponents",
				"guide_weaponStr"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[813] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 813,
		talk_content = "钥从依附权钥后，除了可以提供攻击力加成外，还具备有特殊的权能。",
		params = {},
		guide_component = {
			"common",
			"weaponServant",
			{
				"guideComponents",
				"guide_describe"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[814] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = true,
		id = 814,
		talk_content = "现在选择这位钥从依附在卢恩之刃上吧。",
		params = {},
		guide_component = {
			"common",
			"weaponServant",
			{
				"replacebtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[815] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 815,
		talk_content = "权钥调整完毕，继续执行任务吧。",
		params = {},
		guide_component = {
			"windowBar",
			"homeBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			581,
			-218
		}
	},
	[901] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 901,
		talk_content = "选择继续作战。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-360,
			292
		}
	},
	[902] = {
		talk_anchors = 0,
		type = "JumpTo",
		is_finish = false,
		id = 902,
		talk_content = "",
		params = {
			305,
			10101,
			1010101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1001] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 1001,
		talk_content = "新人，历战轮回装置的调试已经完成了，现在去确认一下吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-360,
			292
		}
	},
	[1002] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 1002,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"challengeToggle_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1003] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 1003,
		talk_content = "历战轮回系统会不断考验你和小队成员的极限，尽可能地在模拟战场中坚持，取得好成绩吧。",
		params = {},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"401",
			"Button"
		},
		mask_component = {
			"child",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"401/guide_mask"
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[1004] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 1004,
		talk_content = "",
		params = {},
		guide_component = {
			"listIndex",
			"towerStage",
			{
				"list"
			},
			1,
			{
				"m_btn"
			}
		},
		mask_component = {
			"listIndex",
			"towerStage",
			{
				"list"
			},
			1,
			{
				"guideComponents",
				"guide_conent"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[1005] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 1005,
		talk_content = "更加详细的内容，就参考下这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[1101] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 1101,
		talk_content = "新人，黑区净化系统已经调整完成，现在去看看吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-360,
			292
		}
	},
	[1102] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 1102,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"challengeToggle_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1103] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 1103,
		talk_content = "在黑区净化里，系统将会模拟预演世界线的变动，给予修正者一定程度的考核。",
		params = {},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"302",
			"Button"
		},
		mask_component = {
			"child",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"302/guide_mask"
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[1104] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 1104,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"mythicDifficulty",
			{
				"m_sureBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1105] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 1105,
		talk_content = "更加详细的内容，就参考下这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[1201] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 1201,
		talk_content = "新人，来隐科组一趟吧，有一件重要的事需要你帮忙。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-360,
			292
		}
	},
	[1202] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 1202,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"challengeToggle_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1203] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 1203,
		talk_content = "在之前的行动中，我们已经收集到了很多移转之辉，现在要做的将它转换成有用的算力。",
		params = {},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"404",
			"Button"
		},
		mask_component = {
			"child",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"404/guide_mask"
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[1204] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 1204,
		talk_content = "具体的细节，等你来隐科组再谈吧。",
		params = {},
		guide_component = {
			"child_getcom",
			"warChessStage",
			{
				"itemParent_"
			},
			"4040101",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[1301] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 1301,
		talk_content = "新人，梦境再构装置的使用权限已经开放了，现在去看看吧，",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-360,
			292
		}
	},
	[1302] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 1302,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"challengeToggle_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1303] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 1303,
		talk_content = "这个装置会藉由梦境能力的开发，真实地再现曾经与修正者们交战过的强大敌人。",
		params = {},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"301",
			"Button"
		},
		mask_component = {
			"child",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"301/guide_mask"
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[1304] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 1304,
		talk_content = "选择想要挑战的对手。",
		params = {},
		guide_component = {
			"common",
			"bossSwitch",
			{
				"bossItemList_",
				1,
				"btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[1305] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 1305,
		talk_content = "更加详细的内容，就参考下这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[1601] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 1601,
		talk_content = "点击这里，可以看到当前所拥有的全部钥从。",
		params = {},
		guide_component = {
			"common",
			"weaponServantEnter",
			{
				"listBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[1602] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 1602,
		talk_content = "对沉睡着的钥从，可以对其进行真名唤醒。",
		params = {},
		guide_component = {
			"common",
			"weaponServantEnter",
			{
				"mergeBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1701] = {
		talk_anchors = 0,
		type = "JumpTo",
		is_finish = false,
		id = 1701,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1702] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 1702,
		talk_content = "探测系统开放了。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_draw"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-784,
			300
		}
	},
	[1703] = {
		talk_anchors = 0,
		type = "JumpTo",
		is_finish = false,
		id = 1703,
		talk_content = "",
		params = {
			402
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1704] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 1704,
		talk_content = "可以使用刚刚获得的探测凭证，进行一次探测。",
		params = {},
		guide_component = {
			"common",
			"draw",
			{
				"btnOnce_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1801] = {
		talk_anchors = 0,
		type = "JumpTo",
		is_finish = false,
		id = 1801,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1802] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 1802,
		talk_content = "新人，神格系统的权限已经开放，去为修正者选择合适的作战方式吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_goddess"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-918,
			300
		}
	},
	[1803] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 1803,
		talk_content = "",
		params = {},
		guide_component = {
			"child_getcom",
			"newHero",
			{
				"guideComponents",
				"guide_shortGridContent_"
			},
			"1084",
			"Button"
		},
		mask_component = {
			"child",
			"newHero",
			{
				"guideComponents",
				"guide_shortGridContent_"
			},
			"1084/heroinfo"
		},
		mask_scale = {},
		talk_position = {}
	},
	[1804] = {
		talk_anchors = 4,
		type = "ClickCToggle",
		is_finish = false,
		id = 1804,
		talk_content = "神格对应着修正者使用神力的方式，是「盖亚」系统赋予修正者权能的一部分。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"toggle6_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1805] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 1805,
		talk_content = "通过调整神格，可以让修正者具备不同的作战能力。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				5,
				"adjustBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1806] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 1806,
		talk_content = "与神格共鸣可以增强修正者的技能，使之拥有更加强力的效果。",
		params = {},
		guide_component = {
			"common",
			"astrolabeAdjust",
			{
				"guideComponents",
				"guide_message"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			774,
			133
		}
	},
	[1807] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 1807,
		talk_content = "每个修正者最多可以共鸣三个神格，可以通过重置的方式重新选择其他神格进行共鸣。",
		params = {},
		guide_component = {
			"common",
			"astrolabeAdjust",
			{
				"guideComponents",
				"guide_reset"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			774,
			133
		}
	},
	[1808] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 1808,
		talk_content = "解锁神格后即可与相应神格进行共鸣，为修正者选择你认为最适合的神格搭配吧。",
		params = {},
		guide_component = {
			"common",
			"astrolabeAdjust",
			{
				"guideComponents",
				"guide_unlockBtn"
			}
		},
		mask_component = {
			"common",
			"astrolabeAdjust",
			{
				"guideComponents",
				"guide_unlockBtn_bg"
			}
		},
		mask_scale = {},
		talk_position = {
			774,
			133
		}
	},
	[1901] = {
		talk_anchors = 0,
		type = "JumpTo",
		is_finish = false,
		id = 1901,
		talk_content = "",
		params = {
			101
		},
		guide_component = {},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[1902] = {
		talk_anchors = 2,
		type = "ClickButton",
		is_finish = false,
		id = 1902,
		talk_content = "新人，管理喵的作战用开发已经完成了，去看看吧。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_menu"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-377,
			-305.6
		}
	},
	[1903] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 1903,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"menuPop",
			{
				"chipBtn_"
			}
		},
		mask_component = {
			"common",
			"menuPop",
			{
				"guideComponents",
				"guide_chip"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[1904] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 1904,
		talk_content = "管理喵所拥有的强大算力，可以在作战中承担一部分的指挥工作。",
		params = {},
		guide_component = {
			"child_getcom",
			"chipManager",
			{
				"guideComponents",
				"guide_listContent"
			},
			"6",
			"Button"
		},
		mask_component = {
			"child",
			"chipManager",
			{
				"guideComponents",
				"guide_listContent"
			},
			"6/sel"
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[1905] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 1905,
		talk_content = "每只管理喵都有擅长的演算方向，启用后可以在作战中产生特别的效果。",
		params = {},
		guide_component = {
			"common",
			"chipManager",
			{
				"guideComponents",
				"guide_info"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1906] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 1906,
		talk_content = "当满足一定研发条件后，即可将对应的管理喵应用到作战中。",
		params = {},
		guide_component = {
			"common",
			"chipManager",
			{
				"guideComponents",
				"guide_unlock"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1907] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 1907,
		talk_content = "解锁后，还可以为管理喵安装最多2个的管理芯片。",
		params = {},
		guide_component = {
			"common",
			"chipManager",
			{
				"guideComponents",
				"guide_bth1"
			}
		},
		mask_component = {
			"common",
			"chipManager",
			{
				"guideComponents",
				"guide_chip"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1908] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 1908,
		talk_content = "通过安装管理芯片，管理喵的战术决策也将得到扩展。",
		params = {},
		guide_component = {
			"child_getcom",
			"chipInfo",
			{
				"guideComponents",
				"guide_listContent"
			},
			"105/bg",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[1909] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 1909,
		talk_content = "每种芯片都有不同的效果，不同的组合给管理喵的战术带来了丰富的可能性。",
		params = {},
		guide_component = {
			"common",
			"chipInfo",
			{
				"guideComponents",
				"guide_explain"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1910] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 1910,
		talk_content = "同样，在满足一定研发条件后，就可以解锁对应的管理芯片。",
		params = {},
		guide_component = {
			"common",
			"chipInfo",
			{
				"guideComponents",
				"guide_btnUnlock"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1911] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 1911,
		talk_content = "解锁后，将选中的管理芯片为管理喵安装上吧。",
		params = {},
		guide_component = {
			"common",
			"chipInfo",
			{
				"useBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1912] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 1912,
		talk_content = "点击返回。",
		params = {},
		guide_component = {
			"windowBar",
			"backBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			378,
			-218
		}
	},
	[1913] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = true,
		id = 1913,
		talk_content = "现在管理喵的功能更加强大了，立刻启用试试看吧。",
		params = {},
		guide_component = {
			"common",
			"chipManager",
			{
				"guideComponents",
				"guide_btnUse"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[1914] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 1914,
		talk_content = "管理喵装备完毕，继续执行任务吧。",
		params = {},
		guide_component = {
			"windowBar",
			"homeBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			581,
			-218
		}
	},
	[1915] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 1915,
		talk_content = "选择继续作战。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-360,
			292
		}
	},
	[2001] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 2001,
		talk_content = "新人，已经通过了的战斗区域，偶尔也会有异象再生。",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"equipToggle_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2002] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 2002,
		talk_content = "参加战场清扫，有可能会找到稀有的遗落刻印。",
		params = {},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				3,
				"itemParent_"
			},
			"202",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2003] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 2003,
		talk_content = "管理员可以选择一个刻印套装进行UP，掉落必是该套装的一个部位。",
		params = {},
		guide_component = {
			"common",
			"equipSection",
			{
				"guideComponents",
				"guide_equip"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[2004] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 2004,
		talk_content = "更加详细的内容，就参考下这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[2101] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 2101,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"mainToggle_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[2102] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 2102,
		talk_content = "新人，高难度任务的情报已经更新，从这里确认一下吧。",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"contentView_",
				1,
				"hardLevelView_",
				"selectDifficultBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2103] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 2103,
		talk_content = "在这里可以切换任务的难度。",
		params = {},
		guide_component = {
			"common",
			"chapterMap",
			{
				"contentView_",
				1,
				"hardLevelView_",
				"hardLevelItems_",
				2,
				"btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2201] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 2201,
		talk_content = "新人，「科尔盖」那边似乎有任务委派给你，现在去看看吧。",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"equipToggle_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2202] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 2202,
		talk_content = "与「科尔盖」的联合特勤任务已经开放了，根据他们提供的情报，也许会从任务中找到稀有的刻印赋能模组。",
		params = {},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				3,
				"itemParent_"
			},
			"203",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2203] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 2203,
		talk_content = "更加详细的内容，就参考下这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[2301] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 2301,
		talk_content = "矩阵公会现已开放。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btnGuild_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			1424,
			272
		}
	},
	[2401] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 2401,
		talk_content = "欢迎来到餐厅，现在来看看如何查看菜品以及存储的食材，首先点击菜谱，这里有记录已解锁的菜品信息。",
		params = {},
		guide_component = {
			"common",
			"restaurantMain",
			{
				"recipebtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			295,
			-60
		}
	},
	[2402] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 2402,
		talk_content = "左侧这里可以看到菜品对应的厨具类型，上架的时候也可以考虑尽量搭配不同类型的菜品。",
		params = {},
		guide_component = {
			"common",
			"restaurantFoodMenuView",
			{
				"guideComponents",
				"guide_typelist"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-150,
			10
		}
	},
	[2403] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 2403,
		talk_content = "这里会显示厨具可制作的菜品列表，有些菜品需要达到更高的餐厅等级后才能制作。",
		params = {},
		guide_component = {
			"common",
			"restaurantFoodMenuView",
			{
				"guideComponents",
				"guide_foodmenu"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			460,
			10
		}
	},
	[2404] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 2404,
		talk_content = "选中菜品后，可以查看具体信息。",
		params = {},
		guide_component = {
			"child_getcom",
			"restaurantFoodMenuView",
			{
				"guideComponents",
				"guide_content"
			},
			"foodItem(Clone)/itemButton",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			100,
			0
		}
	},
	[2405] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 2405,
		talk_content = "这里可以看到菜品的预计收益以及菜品口味。",
		params = {},
		guide_component = {
			"common",
			"restaurantFoodMenuView",
			{
				"guideComponents",
				"guide_foodtitle"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			490,
			0
		}
	},
	[2406] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 2406,
		talk_content = "该菜品制作需要的食材以及数量会在这里显示。",
		params = {},
		guide_component = {
			"common",
			"restaurantFoodMenuView",
			{
				"guideComponents",
				"guide_mater"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			520,
			50
		}
	},
	[2407] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 2407,
		talk_content = "前往仓库可以查看当前库存的食材以及数量。",
		params = {},
		guide_component = {
			"common",
			"restaurantFoodMenuView",
			{
				"bagBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-150,
			-150
		}
	},
	[2408] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 2408,
		talk_content = "食材的信息以及数量都会在这里显示，可以通过完成委托任务获得更多食材。",
		params = {},
		guide_component = {
			"common",
			"restaurantFoodMenuView",
			{
				"baguilistUilist_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			460,
			10
		}
	},
	[2501] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 2501,
		talk_content = "管理员，食材已经准备好了，点击菜单准备将菜品上架吧。",
		params = {},
		guide_component = {
			"common",
			"restaurantMain",
			{
				"foodtitleBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			200,
			-350
		}
	},
	[2502] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 2502,
		talk_content = "这里是已经解锁的菜品，点击上架，已经上架的菜品会全天候自动售卖，上架上限会随餐厅等级提升而变多。",
		params = {},
		guide_component = {
			"child_getcom",
			"chooseSignFoodView",
			{
				"guideComponents",
				"guide_content"
			},
			"foodItem(Clone)/food/shelvesBtn",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			450,
			100
		}
	},
	[2503] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 2503,
		talk_content = "这里是菜品消耗的食材，如果食材不够，菜品就会进入售罄状态并且无法盈利。",
		params = {},
		guide_component = {
			"common",
			"PopSetFoodView",
			{
				"guideComponents",
				"bg_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			420,
			-220
		}
	},
	[2504] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = true,
		id = 2504,
		talk_content = "餐厅想要能妥善经营则上架的菜品可不能少，先上架一道菜品吧。",
		params = {},
		guide_component = {
			"common",
			"PopSetFoodView",
			{
				"confirmbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			300,
			-330
		}
	},
	[2505] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 2505,
		talk_content = "第二道菜品的食材也已经准备好了，一并点击上架吧。",
		params = {},
		guide_component = {
			"child_getcom",
			"chooseSignFoodView",
			{
				"guideComponents",
				"guide_content"
			},
			"foodItem(Clone)/food/shelvesBtn",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			200,
			-350
		}
	},
	[2506] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 2506,
		talk_content = "上架完后，餐厅的准备工作就完成了，只需要等待客人前来用餐就可以盈利了~",
		params = {},
		guide_component = {
			"common",
			"PopSetFoodView",
			{
				"confirmbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			300,
			-330
		}
	},
	[2601] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 2601,
		talk_content = "既然菜品已经上架完毕，那也不能干等着食材耗尽，可以通过完成委托任务来积累食材。",
		params = {},
		guide_component = {
			"common",
			"restaurantMain",
			{
				"taskbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			295,
			-60
		}
	},
	[2602] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 2602,
		talk_content = "这是收到的委托请求，完成这些请求可以获得由委托人送来的食材，并且餐厅等级提升后有机会接到全新的委托。",
		params = {},
		guide_component = {
			"child_getcom",
			"dormTaskDispatchView",
			{
				"guideComponents",
				"guide_content"
			},
			"taskItem(Clone)/bg",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			150,
			10
		}
	},
	[2603] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 2603,
		talk_content = "了解完委托的信息后就可以准备派遣啦，委托完成后会立刻获得新的委托任务。",
		params = {},
		guide_component = {
			"child_getcom",
			"dormTaskDispatchView",
			{
				"guideComponents",
				"guide_content"
			},
			"taskItem(Clone)/taskBtn",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			-290
		}
	},
	[2604] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 2604,
		talk_content = "完成委托会消耗体力，这里可以看到修正者的体力信息，如果体力为空或是已被派遣就无法再派遣了。",
		params = {},
		guide_component = {
			"child_getcom",
			"chooseCharacterView",
			{
				"guideComponents",
				"guide_content"
			},
			"heroHeadPrefab(Clone)/heroinfo/bg",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			115,
			90
		}
	},
	[2605] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 2605,
		talk_content = "没有被派遣的修正者的体力会随着时间恢复，记得合理规划修正者的作息~",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"characteruilistUilist_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			250,
			-290
		}
	},
	[2606] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 2606,
		talk_content = "这里可以看到本次委托需要消耗的总体力，选择的修正者的体力之和需要不小于这部分才能进行派遣",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"battlebtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			100,
			-150
		}
	},
	[2607] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 2607,
		talk_content = "每次委托可能会有不一样的推荐类型，搭配对应的修正者时可以增加委托大成功的概率。",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"recuilistUilist_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			320,
			-370
		}
	},
	[2608] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 2608,
		talk_content = "当前委托的大成功完成的实时概率，如果大成功达成委托则会获得额外的奖励~",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"guideComponents",
				"guide_probability"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			-290
		}
	},
	[2701] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 2701,
		talk_content = "和诗蔻蒂一起出游吧。“出游日记”现已开放。",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"skuldbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			164,
			-410
		}
	},
	[2702] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 2702,
		talk_content = "诗蔻蒂正在房间里休息。",
		params = {},
		guide_component = {
			"common",
			"skuldTravelView",
			{
				"guideComponents",
				"guide_skuld"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2703] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 2703,
		talk_content = "今天要去哪里游玩呢？来为诗蔻蒂安排出游行程吧。",
		params = {},
		guide_component = {
			"common",
			"skuldTravelView",
			{
				"gototravelbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			96,
			-422
		}
	},
	[2704] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 2704,
		talk_content = "选择本次出游的地点。",
		params = {},
		guide_component = {
			"common",
			"skuldTravelMapView",
			{
				"btn_1"
			}
		},
		mask_component = {
			"common",
			"skuldTravelMapView",
			{
				"guideComponents",
				"guide_item_btn1"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2705] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 2705,
		talk_content = "选择本次出游携带的物品。携带不同的物品去往同一地点，会有不同的见闻哦。",
		params = {},
		guide_component = {
			"child_getcom",
			"skuldTravelItemSelectView",
			{
				"guideComponents",
				"guide_item"
			},
			"Item(Clone)/bg_common",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2706] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 2706,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"skuldTravelItemSelectView",
			{
				"travelbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[2801] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 2801,
		talk_content = "游玩结束，我们回来啦。",
		params = {},
		guide_component = {
			"common",
			"skuldTravelResultView",
			{
				"guideComponents",
				"guide_skuld"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2802] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 2802,
		talk_content = "出游会为诗蔻蒂带来见闻的增长~",
		params = {},
		guide_component = {
			"common",
			"skuldTravelResultView",
			{
				"guideComponents",
				"guide_skuld"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2803] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 2803,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"skuldTravelResultView",
			{
				"btn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2804] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 2804,
		talk_content = "来看看在本次出游中发生的事件吧。",
		params = {},
		guide_component = {
			"common",
			"skuldTravelPlotView",
			{
				"bgbtn_"
			}
		},
		mask_component = {
			"common",
			"skuldTravelPlotView",
			{
				"guideComponents",
				"guide_bg"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[2805] = {
		talk_anchors = 2,
		type = "HighLight",
		is_finish = false,
		id = 2805,
		talk_content = "出游事件都被诗蔻蒂收藏在了这里，管理员可以随时进行查看。",
		params = {},
		guide_component = {
			"common",
			"skuldTravelView",
			{
				"plotbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-396,
			-294
		}
	},
	[2806] = {
		talk_anchors = 2,
		type = "ClickButton",
		is_finish = false,
		id = 2806,
		talk_content = "经过几次出游，诗蔻蒂会把自己的所思所想记录在这里。",
		params = {},
		guide_component = {
			"common",
			"skuldTravelView",
			{
				"finalresultbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-396,
			-294
		}
	},
	[2807] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 2807,
		talk_content = "诗蔻蒂并不擅长表达，因此，这些内容需要诗蔻蒂的见闻满足一定条件，且收录特定的出游事件后才能开启哦~",
		params = {},
		guide_component = {
			"listIndex",
			"skuldTravelFinalResultView",
			{
				"list_"
			},
			2,
			{
				"transform_"
			}
		},
		mask_component = {
			"listIndex",
			"skuldTravelFinalResultView",
			{
				"list_"
			},
			2,
			{
				"guideComponents",
				"guide_opt"
			}
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[2808] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 2808,
		talk_content = "点击返回。",
		params = {},
		guide_component = {
			"windowBar",
			"backBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			378,
			-218
		}
	},
	[2809] = {
		talk_anchors = 2,
		type = "HighLight",
		is_finish = false,
		id = 2809,
		talk_content = "别忘了领取出游奖励~",
		params = {},
		guide_component = {
			"common",
			"skuldTravelView",
			{
				"rewardbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-396,
			-294
		}
	},
	[2810] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 2810,
		talk_content = "更加详细的内容，就在这里查看吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[2901] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 2901,
		talk_content = "出游时获得的相片，似乎发生了变化。",
		params = {},
		guide_component = {
			"common",
			"chapterSection",
			{
				"skuldbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			164,
			-410
		}
	},
	[2902] = {
		talk_anchors = 2,
		type = "ClickButton",
		is_finish = false,
		id = 2902,
		talk_content = "相片都存放在这里……怎么多出来了一张？",
		params = {},
		guide_component = {
			"common",
			"skuldTravelView",
			{
				"finalresultbtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-396,
			-294
		}
	},
	[3001] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 3001,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"springFestivalMain",
			{
				"canteenGo_"
			},
			"Button"
		},
		mask_component = {
			"common",
			"springFestivalMain",
			{
				"guideComponents",
				"guide_canteen"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[3101] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 3101,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"springFestivalMain",
			{
				"btn5_"
			},
			"Button"
		},
		mask_component = {
			"common",
			"springFestivalMain",
			{
				"guideComponents",
				"guide_btn5"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[3201] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 3201,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"springFestivalMain",
			{
				"btn4_"
			},
			"Button"
		},
		mask_component = {
			"common",
			"springFestivalMain",
			{
				"guideComponents",
				"guide_btn4"
			}
		},
		mask_scale = {},
		talk_position = {}
	},
	[3301] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 3301,
		talk_content = "新人，物资关卡现已开启，可以在这里获取各种修正者的培养材料。",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"resourceToggle_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[3401] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 3401,
		talk_content = "新人，经过初步学习后，物资获取权限已经全部为你开启。",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"resourceToggle_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[3501] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 3501,
		talk_content = "隐科组对于刻印的研究有了重大突破，发现了可以使权钥与刻印再次突破的神秘能源。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-360,
			292
		}
	},
	[3502] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 3502,
		talk_content = "报告显示源层深处极少数泉水会有产生伴生的透明结晶，其提取物可用于突破权钥与刻印的桎梏。",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"equipToggle_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[3503] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 3503,
		talk_content = "这些结晶存在的地方附近都游荡着数量不等的强大视骸，想要采集必须要先清理掉它们。",
		params = {},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				3,
				"itemParent_"
			},
			"205",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[3504] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 3504,
		talk_content = "作为第一次深入源层深处，我们先谨慎勘探……就选择这个前进方向吧！",
		params = {},
		guide_component = {
			"listIndex",
			"equipBreakThroughMaterialMode",
			{
				"modeUIList_"
			},
			1,
			{
				"btn_"
			}
		},
		mask_component = {
			"listIndex",
			"equipBreakThroughMaterialMode",
			{
				"modeUIList_"
			},
			1,
			{
				"guideComponents",
				"guide_item"
			}
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[3505] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 3505,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"equipBreakThroughMaterialMode",
			{
				"chooseBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[3506] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 3506,
		talk_content = "源层的干扰让我只能陪你到这了，还有什么其他不懂的地方就点击这里查看回顾吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[3601] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = true,
		id = 3601,
		talk_content = "新人，你结识了一位能力强劲的同伴呢，快来与这位修正者一起熟悉一下基础的战斗操作吧！",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-360,
			292
		}
	},
	[3602] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 3602,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"challengeToggle_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[3603] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 3603,
		talk_content = "",
		params = {},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"402",
			"Button"
		},
		mask_component = {
			"child",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"402/guide_mask"
		},
		mask_scale = {},
		talk_position = {}
	},
	[3604] = {
		talk_anchors = 4,
		type = "ClickCToggle",
		is_finish = false,
		id = 3604,
		talk_content = "基础教学可以让你了解一些经常会用到的战斗知识。",
		params = {},
		guide_component = {
			"common",
			"teachStage",
			{
				"guideComponents",
				"guide_baseBtn"
			}
		},
		mask_component = {
			"common",
			"teachStage",
			{
				"guideComponents",
				"guide_base"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[3605] = {
		talk_anchors = 4,
		type = "ClickCToggle",
		is_finish = false,
		id = 3605,
		talk_content = "角色教学可以让你更了解与自己并肩作战的修正者，最大效率的协助对方发挥出全部力量。",
		params = {},
		guide_component = {
			"common",
			"teachStage",
			{
				"guideComponents",
				"guide_heroBtn"
			}
		},
		mask_component = {
			"common",
			"teachStage",
			{
				"guideComponents",
				"guide_role"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[3701] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 3701,
		talk_content = "哼哼~不要惊慌，是本大人我。这次是来告诉你一个重要消息的，那就是可以通过对刻印进行「赋能」，对刻印进行提升哦。",
		params = {},
		guide_component = {
			"common",
			"equipCultureView",
			{
				"btn_enchant"
			}
		},
		mask_component = {
			"common",
			"equipCultureView",
			{
				"guideComponents",
				"guide_enchant"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[3702] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 3702,
		talk_content = "刻印满足等级需求后，将直接解锁一个固定的「赋能效果」。",
		params = {},
		guide_component = {
			"common",
			"equipEnchantMainView",
			{
				"skillFixedTrs_"
			}
		},
		mask_component = {
			"common",
			"equipEnchantMainView",
			{
				"guideComponents",
				"guide_skillfixed"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[3703] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 3703,
		talk_content = "同时解锁一个新的赋能位置，可以消耗「赋能模块」进行主动赋能，获取额外的「赋能效果」。",
		params = {},
		guide_component = {
			"common",
			"equipEnchantMainView",
			{
				"enchantItems",
				1,
				"gameObject"
			}
		},
		mask_component = {
			"common",
			"equipEnchantMainView",
			{
				"guideComponents",
				"guide_skillenabing"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[3704] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 3704,
		talk_content = "本大人知道的讯息已经全部同步给你了，如果想要了解更多刻印「赋能」相关的内容，就打开这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[3801] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 3801,
		talk_content = "本喵刚刚得到隐科组传来讯息，在源层深处中的遗迹里发现可以强化刻印的材料。",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"equipToggle_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[3802] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 3802,
		talk_content = "只不过前进的路上遍布游荡的视骸，消灭它们然后获取更多的启示录吧！",
		params = {},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				3,
				"itemParent_"
			},
			"204",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[3901] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 3901,
		talk_content = "新人，隐科组对刻印有些了新的研究成果，让我们去看看吧！",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_goddess"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-918,
			300
		}
	},
	[3902] = {
		talk_anchors = 4,
		type = "ClickCToggle",
		is_finish = false,
		id = 3902,
		talk_content = "利用高品质的刻印核心制成独立模块，可以对「中继之环」进行一定程度的增幅，这种增幅被命名为「跃迁」。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"toggle8_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[3903] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 3903,
		talk_content = "「跃迁核心」的位置与刻印装载位置一一对应，当对应的刻印位置装备的刻印等级达到40级时，「跃迁核心」被激活。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				7,
				"item_1"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[4001] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4001,
		talk_content = "「跃迁核心」被成功激活后，可以对修正者的多项能力进行专项增幅。",
		params = {},
		guide_component = {
			"common",
			"transitionSkill",
			{
				"guideComponents",
				"guide_list"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[4002] = {
		talk_anchors = 2,
		type = "HighLight",
		is_finish = false,
		id = 4002,
		talk_content = "每个「跃迁核心」最多得到2种能力增幅，不过不用担心，增幅效果可以随时来这里进行更换。",
		params = {},
		guide_component = {
			"common",
			"transitionSkill",
			{
				"guideComponents",
				"guide_reset"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-866,
			-118
		}
	},
	[4003] = {
		talk_anchors = 2,
		type = "HighLight",
		is_finish = false,
		id = 4003,
		talk_content = "「跃迁核心」的专项增幅可以大幅度提升修正者的实力。",
		params = {},
		guide_component = {
			"common",
			"transitionSkill",
			{
				"guideComponents",
				"guide_desc"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-997,
			-243
		}
	},
	[4004] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4004,
		talk_content = "「跃迁技能」装备以及升级需要消耗「跃迁因子」。",
		params = {},
		guide_component = {
			"common",
			"transitionSkill",
			{
				"guideComponents",
				"guide_cost"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-997,
			258
		}
	},
	[4005] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4005,
		talk_content = "「跃迁因子」的持有数量和当前可持有的数量上限可以在这里查看。",
		params = {},
		guide_component = {
			"common",
			"transitionSkill",
			{
				"guideComponents",
				"guide_point"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1004,
			126
		}
	},
	[4006] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4006,
		talk_content = "管理员需要先获取「跃迁因子」，才能顺利装备「跃迁技能」哦~",
		params = {},
		guide_component = {
			"common",
			"transitionSkill",
			{
				"addBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1004,
			126
		}
	},
	[4007] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 4007,
		talk_content = "「跃迁因子」的数量可以通过消耗权能材料进行提升，这种材料可以在黑区净化的Ω难度获取。",
		params = {},
		guide_component = {
			"common",
			"transitionGiftPt",
			{
				"guideComponents",
				"guide_list"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[4101] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 4101,
		talk_content = "通过对普通五星刻印进行神力融合，可以为修正者进行能力增幅。",
		params = {},
		guide_component = {
			"common",
			"equipCultureView",
			{
				"btn_race"
			}
		},
		mask_component = {
			"common",
			"equipCultureView",
			{
				"guideComponents",
				"guide_race"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[4102] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 4102,
		talk_content = "「神系重构」可以将普通的五星刻印「重构」为随机神系刻印，为其提供对应神系额外的属性加成。",
		params = {},
		guide_component = {
			"common",
			"equipRaceView",
			{
				"raceRebuildBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[4103] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 4103,
		talk_content = "「显晰重构」可以将神系刻印「重构」为专属刻印，为对应修正者提供更多的属性加成。",
		params = {},
		guide_component = {
			"common",
			"equipRaceView",
			{
				"heroRebuildBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[4104] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 4104,
		talk_content = "这么重要的消息本大人可第一时间就过来告诉你了哦~如果想要了解更多刻印重构相关的内容，就打开这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[4201] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = true,
		id = 4201,
		talk_content = "新人，科尔盖用于研究骸能原理搭建的高能试验场爆炸了，科尔盖正在请求各原质区修正者进行支援。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-360,
			292
		}
	},
	[4202] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 4202,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"challengeToggle_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[4203] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4203,
		talk_content = "由爆炸产生的空洞就像是黑洞一样不受控制，且呈现出崩溃的迹象，因此这里也被称为“失序深阱”。",
		params = {},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"502",
			"Button"
		},
		mask_component = {
			"child",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"502/guide_mask"
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[4204] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 4204,
		talk_content = "失序深阱中存在多个阶层，当一个阶层内的所有区域清理完毕后，便可解锁后续阶层。",
		params = {},
		guide_component = {
			"common",
			"abyssMain",
			{
				"uiListGo_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			-100
		}
	},
	[4205] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 4205,
		talk_content = "每个区域根据难易程度有不同的评级，如果是评级为Ω的区域则可以反复挑战积累清理进度。",
		params = {},
		guide_component = {
			"common",
			"abyssMain",
			{
				"levelItems_",
				1,
				"gameObject_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			-100
		}
	},
	[4206] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 4206,
		talk_content = "点击可以选中该区域。",
		params = {},
		guide_component = {
			"common",
			"abyssMain",
			{
				"levelItems_",
				1,
				"button_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			-100
		}
	},
	[4207] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 4207,
		talk_content = "当前区域的相关信息会在这里显示，点击区域目标的头像可以查看其具体信息。",
		params = {},
		guide_component = {
			"common",
			"abyssMain",
			{
				"bossGo_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			50
		}
	},
	[4208] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 4208,
		talk_content = "想要了解更多有关失序深阱相关的内容，就参考这里的说明手册吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[4301] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4301,
		talk_content = "经过隐科组最终的调试，修正者与权钥「同调」装置现已正式启用。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_goddess"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-918,
			300
		}
	},
	[4302] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 4302,
		talk_content = "",
		params = {},
		guide_component = {
			"child_getcom",
			"newHero",
			{
				"guideComponents",
				"guide_shortGridContent_"
			},
			"1084",
			"Button"
		},
		mask_component = {
			"child",
			"newHero",
			{
				"guideComponents",
				"guide_shortGridContent_"
			},
			"1084/heroinfo"
		},
		mask_scale = {},
		talk_position = {}
	},
	[4303] = {
		talk_anchors = 0,
		type = "ClickCToggle",
		is_finish = false,
		id = 4303,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"toggle4_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[4304] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4304,
		talk_content = "「同调」是指让修正者与自己的权钥进行深度力场共频，以此来提升能力增幅。",
		params = {},
		guide_component = {
			"common",
			"newHero",
			{
				"pages_",
				3,
				"moduleView_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1128,
			133
		}
	},
	[4305] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4305,
		talk_content = "调动起深刻的记忆及情绪对「同调」的效果有较为明显的增幅。此处摆放的是由修正者自己提供的，对自身影响较大的物品。",
		params = {},
		guide_component = {
			"common",
			"weaponModuleView",
			{
				"guideComponents",
				"guide_pic"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[4306] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4306,
		talk_content = "点击「同调预览」可以查看权钥同调能提升的效果。",
		params = {},
		guide_component = {
			"common",
			"weaponModuleView",
			{
				"infoBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1140,
			170
		}
	},
	[4307] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 4307,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"weaponModuleView",
			{
				"levelupBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[4308] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4308,
		talk_content = "此处可以查看「同调」后可获得的提升。",
		params = {},
		guide_component = {
			"common",
			"weaponModuleUnlockView",
			{
				"guideComponents",
				"guide_list"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-387,
			148
		}
	},
	[4309] = {
		talk_anchors = 2,
		type = "HighLight",
		is_finish = false,
		id = 4309,
		talk_content = "解锁该修正者的「同调」需要完成对应的专属任务。",
		params = {},
		guide_component = {
			"common",
			"weaponModuleUnlockView",
			{
				"guideComponents",
				"guide_mission"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1120,
			-210
		}
	},
	[4310] = {
		talk_anchors = 2,
		type = "HighLight",
		is_finish = false,
		id = 4310,
		talk_content = "同时开启「同调」需要满足一定的解锁条件。",
		params = {},
		guide_component = {
			"common",
			"weaponModuleUnlockView",
			{
				"guideComponents",
				"guide_condition"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1120,
			-422
		}
	},
	[4311] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 4311,
		talk_content = "若是想了解更多关于「同调」相关的信息，就点开这里的说明手册进行查看吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[4401] = {
		talk_anchors = 1,
		type = "ClickCToggle",
		is_finish = false,
		id = 4401,
		talk_content = "新人，完成入职签到可以结识新的修正者，获取大量探测凭证哦。",
		params = {},
		guide_component = {
			"treeGroup",
			"activityNoob",
			{
				"tree_"
			},
			1
		},
		mask_component = {
			"common",
			"activityNoob",
			{
				"guideComponents",
				"guide_1"
			}
		},
		mask_scale = {},
		talk_position = {
			730,
			-228
		}
	},
	[4402] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = true,
		id = 4402,
		talk_content = "点击此处领取今日的奖励吧！",
		params = {},
		guide_component = {
			"listIndex",
			"activityNoob",
			{
				"pages_",
				1,
				"contenViewList_",
				1,
				"uiList_"
			},
			1,
			{
				"button_"
			}
		},
		mask_component = {
			"listIndex",
			"activityNoob",
			{
				"pages_",
				1,
				"contenViewList_",
				1,
				"uiList_"
			},
			1,
			{
				"guideComponents",
				"guide_item"
			}
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[4403] = {
		talk_anchors = 0,
		type = "ClickButtonNoMask",
		is_finish = false,
		id = 4403,
		talk_content = "",
		params = {},
		guide_component = {
			"common",
			"switchHeroReward",
			{
				"bgBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[4404] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4404,
		talk_content = "明天也有可以领取的奖励不要忘记了哦！",
		params = {},
		guide_component = {
			"listIndex",
			"activityNoob",
			{
				"pages_",
				1,
				"contenViewList_",
				1,
				"uiList_"
			},
			2,
			{
				"guideComponents",
				"guide_item"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[4405] = {
		talk_anchors = 1,
		type = "ClickCToggle",
		is_finish = false,
		id = 4405,
		talk_content = "新人课程将会引导管理员熟悉日后需要处理的事务。",
		params = {},
		guide_component = {
			"treeGroup",
			"activityNoob",
			{
				"tree_"
			},
			2
		},
		mask_component = {
			"common",
			"activityNoob",
			{
				"guideComponents",
				"guide_2"
			}
		},
		mask_scale = {},
		talk_position = {
			730,
			-505
		}
	},
	[4406] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4406,
		talk_content = "完成全部课程任务，可以将修正者「潮音·波塞冬」神识超越至Ω。",
		params = {},
		guide_component = {
			"common",
			"activityNoob",
			{
				"pages_",
				2,
				"guideComponents",
				"guide_pt"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-372,
			364
		}
	},
	[4407] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4407,
		talk_content = "课程任务每天逐步解锁。",
		params = {},
		guide_component = {
			"common",
			"activityNoob",
			{
				"pages_",
				2,
				"guideComponents",
				"guide_task"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1392,
			326
		}
	},
	[4408] = {
		talk_anchors = 1,
		type = "ClickCToggle",
		is_finish = false,
		id = 4408,
		talk_content = "管理员达到一定等级时，可领取对应的等级奖励。",
		params = {},
		guide_component = {
			"treeGroup",
			"activityNoob",
			{
				"tree_"
			},
			3
		},
		mask_component = {
			"common",
			"activityNoob",
			{
				"guideComponents",
				"guide_3"
			}
		},
		mask_scale = {},
		talk_position = {
			730,
			-455
		}
	},
	[4409] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4409,
		talk_content = "当管理员等级达到60级时，可以将「朝约·薇儿丹蒂」神识超越至SSS，并获得圣树5星通用钥从「妖精·盖拉德丽尔」。",
		params = {},
		guide_component = {
			"common",
			"activityNoob",
			{
				"pages_",
				3,
				"guideComponents",
				"guide_reward"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-886,
			145
		}
	},
	[4410] = {
		talk_anchors = 1,
		type = "ClickCToggle",
		is_finish = false,
		id = 4410,
		talk_content = "当然，作为新加入的成员，管理员也可以在日常委托中获取丰厚奖励哦。",
		params = {},
		guide_component = {
			"treeGroup",
			"activityNoob",
			{
				"tree_"
			},
			4
		},
		mask_component = {
			"common",
			"activityNoob",
			{
				"guideComponents",
				"guide_4"
			}
		},
		mask_scale = {},
		talk_position = {
			730,
			-566
		}
	},
	[4411] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 4411,
		talk_content = "完成当天的委托任务后，次日05:00会解锁新的委托任务。",
		params = {},
		guide_component = {
			"listIndex",
			"activityNoob",
			{
				"pages_",
				4,
				"scrollHelper_"
			},
			1,
			{
				"transform_"
			}
		},
		mask_component = {
			"listIndex",
			"activityNoob",
			{
				"pages_",
				4,
				"scrollHelper_"
			},
			1,
			{
				"guideComponents",
				"guide_infoitem"
			}
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[4412] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4412,
		talk_content = "完成全部委托任务后，可以将「追炎·前鬼坊天狗」神识超越至SSS，并获得专属换装「校园时光」。",
		params = {},
		guide_component = {
			"common",
			"activityNoob",
			{
				"pages_",
				4,
				"guideComponents",
				"guide_pic"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[4501] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 4501,
		talk_content = "相信管理员现在已经对自己的基本职责非常熟悉了，那就让我们开启进修企划吧！",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_newbie_task"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_newbie_task"
			}
		},
		mask_scale = {},
		talk_position = {
			528,
			-394
		}
	},
	[4601] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4601,
		talk_content = "得到大国主的最新消息，演算终端机调试完毕，多维变量模拟已启动。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_combat"
			}
		},
		mask_component = {
			"common",
			"home",
			{
				"guideComponents",
				"guide_combat"
			}
		},
		mask_scale = {},
		talk_position = {
			-360,
			292
		}
	},
	[4602] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 4602,
		talk_content = "",
		params = {},
		guide_component = {
			"common_getcom",
			"chapterMap",
			{
				"challengeToggle_"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {}
	},
	[4603] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 4603,
		talk_content = "演算终端机是大国主为了演算盖亚世界变动率而领导研发的模拟装置，但目前只作为战术决策的训练场所而存在。",
		params = {},
		guide_component = {
			"child_getcom",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"303",
			"Button"
		},
		mask_component = {
			"child",
			"chapterMap",
			{
				"contentView_",
				4,
				"itemParent_"
			},
			"303/guide_mask"
		},
		mask_scale = {},
		talk_position = {
			386,
			133
		}
	},
	[4604] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4604,
		talk_content = "在多维变量的挑战中可以使用「多维信标」协助探索。",
		params = {},
		guide_component = {
			"common",
			"polyhedronLobby",
			{
				"m_beaconBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[4605] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4605,
		talk_content = "「多维信标」需要足够的数据支撑才能顺利解锁激活，获取后可以为接下来的探索带来便利。",
		params = {},
		guide_component = {
			"listIndex",
			"polyhedronBeaconOperate",
			{
				"list_"
			},
			1,
			{
				"transform_"
			}
		},
		mask_component = {
			"listIndex",
			"polyhedronBeaconOperate",
			{
				"list_"
			},
			1,
			{
				"guideComponents",
				"guide_beaconitem"
			}
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[4606] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4606,
		talk_content = "解锁一个「多维信标」试试吧。",
		params = {},
		guide_component = {
			"listIndex",
			"polyhedronBeaconOperate",
			{
				"list_"
			},
			1,
			{
				"m_unlockBtn"
			}
		},
		mask_component = {
			"listIndex",
			"polyhedronBeaconOperate",
			{
				"list_"
			},
			1,
			{
				"guideComponents",
				"guide_beaconitemunlock"
			}
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[4607] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 4607,
		talk_content = "点击返回。",
		params = {},
		guide_component = {
			"windowBar",
			"backBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			378,
			-218
		}
	},
	[4608] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4608,
		talk_content = "「多维终端」中记录着你探索的脚步，不断累积的经验会使你的探索更加顺遂。",
		params = {},
		guide_component = {
			"common",
			"polyhedronLobby",
			{
				"m_terminalBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[4609] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 4609,
		talk_content = "提升「多维终端」的等级，可以获得天赋点数激活加成，提供探索助力。",
		params = {},
		guide_component = {
			"common",
			"polyhedronTerminal",
			{
				"m_levelBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			-325
		}
	},
	[4610] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 4610,
		talk_content = "为了更有效的探索多维空间，「多维终端」所选天赋每周可重置1次。",
		params = {},
		guide_component = {
			"common",
			"polyhedronTerminal",
			{
				"guideComponents",
				"guide_resetBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-260,
			-424
		}
	},
	[4611] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 4611,
		talk_content = "点击返回。",
		params = {},
		guide_component = {
			"windowBar",
			"backBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			378,
			-218
		}
	},
	[4612] = {
		talk_anchors = 4,
		type = "ClickButton",
		is_finish = false,
		id = 4612,
		talk_content = "点击此处可以选择映射出跟随你探索多维空间的修正者。",
		params = {},
		guide_component = {
			"common",
			"polyhedronLobby",
			{
				"m_heroBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			805,
			475
		}
	},
	[4613] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4613,
		talk_content = "",
		params = {},
		guide_component = {
			"listIndex",
			"polyhedronHero",
			{
				"shortScrollHelper_"
			},
			2,
			{
				"selfBtn_"
			}
		},
		mask_component = {
			"listIndex",
			"polyhedronHero",
			{
				"shortScrollHelper_"
			},
			2,
			{
				"guideComponents",
				"guide_hero"
			}
		},
		mask_scale = {},
		talk_position = {
			-386,
			133
		}
	},
	[4614] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4614,
		talk_content = "在多维空间映射出对应的修正者，需要消耗「映射仪」。",
		params = {},
		guide_component = {
			"common",
			"polyhedronHero",
			{
				"pages_",
				1,
				"guideComponents",
				"guide_unlock"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-870,
			162
		}
	},
	[4615] = {
		talk_anchors = 2,
		type = "HighLight",
		is_finish = false,
		id = 4615,
		talk_content = "「映射仪」每周四5:00自动生成，日常最大持有数为1。",
		params = {},
		guide_component = {
			"windowBarCurrency",
			44,
			{
				"transform_"
			}
		},
		mask_component = {
			"windowBarCurrency",
			44,
			{
				"guideComponents",
				"guide_currency"
			}
		},
		mask_scale = {},
		talk_position = {
			-692,
			-117
		}
	},
	[4616] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 4616,
		talk_content = "点击返回。",
		params = {},
		guide_component = {
			"windowBar",
			"backBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			378,
			-218
		}
	},
	[4617] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 4617,
		talk_content = "通过「维度曲线」可以获取「偏移记录」。「维度曲线」会在固定周期重置，任务内容也会根据时间推移进行更迭。",
		params = {},
		guide_component = {
			"common",
			"polyhedronLobby",
			{
				"m_taskBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			805,
			379
		}
	},
	[4618] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 4618,
		talk_content = "影响「维度偏移」幅度，探索到更多不同的信息可以领取相应的奖励。",
		params = {},
		guide_component = {
			"common",
			"polyhedronLobby",
			{
				"m_policyBtn"
			}
		},
		mask_component = {
			"common",
			"polyhedronLobby",
			{
				"guideComponents",
				"guide_score"
			}
		},
		mask_scale = {},
		talk_position = {
			864,
			646
		}
	},
	[4619] = {
		talk_anchors = 4,
		type = "HighLight",
		is_finish = false,
		id = 4619,
		talk_content = "在「维度偏移」中获得的「幸运之证」，可以在「因幡万事屋」中兑换各种物品。",
		params = {},
		guide_component = {
			"common",
			"polyhedronLobby",
			{
				"m_shopBtn"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			805,
			180
		}
	},
	[4620] = {
		talk_anchors = 1,
		type = "ClickButton",
		is_finish = false,
		id = 4620,
		talk_content = "若是想了解更多关于「多维变量」相关的信息，就点开这里的说明手册进行查看吧。",
		params = {},
		guide_component = {
			"windowBar",
			"infoBtn_"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			692,
			-218
		}
	},
	[4701] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4701,
		talk_content = "管理员，隐科组的心居开发企划似乎有新的进展了。",
		params = {},
		guide_component = {
			"common",
			"home",
			{
				"btn_dorm_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-400,
			292
		}
	},
	[4801] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4801,
		talk_content = "先看看深空之眼大楼中的心居区域。",
		params = {},
		guide_component = {
			"common",
			"backHomeEnterView",
			{
				"dormBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-660,
			592
		}
	},
	[4802] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4802,
		talk_content = "这里是心居中的宿舍大厅，可以安排修正者来到这里休息。",
		params = {},
		guide_component = {
			"common",
			"dorm",
			{
				"btn_menuBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-631,
			157
		}
	},
	[4803] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4803,
		talk_content = "点击可以查看当前可以来到大厅休息的修正者。",
		params = {},
		guide_component = {
			"common",
			"dorm",
			{
				"characterplacebtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-609,
			625
		}
	},
	[4804] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = true,
		id = 4804,
		talk_content = "当前修正者的信息都会在这里显示。",
		params = {},
		guide_component = {
			"common",
			"dormHeroDeployView",
			{
				"uilistGo_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-547,
			364
		}
	},
	[4805] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4805,
		talk_content = "选中修正者后，长按可以将修正者拖拽放入大厅中。",
		params = {},
		guide_component = {
			"child_getcom",
			"dormHeroDeployView",
			{
				"guideComponents",
				"guide_content"
			},
			"heroItem(Clone)/bg",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1142,
			145
		}
	},
	[4901] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4901,
		talk_content = "大厅的仓库里有一些还未放置的家具，试着摆放看看吧。",
		params = {},
		guide_component = {
			"common",
			"dorm",
			{
				"btn_menuBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-631,
			157
		}
	},
	[4902] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 4902,
		talk_content = "点击编辑按钮，可以重新布置当前场景，部分家具需要赠送后才能在编辑中摆放。",
		params = {},
		guide_component = {
			"common",
			"dorm",
			{
				"fureidbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-637,
			316
		}
	},
	[4903] = {
		talk_anchors = 3,
		type = "ClickCToggle",
		is_finish = true,
		id = 4903,
		talk_content = "通过切换类型可以查看当前持有的各种家具，当然现在已经准备好一些家具了。",
		params = {},
		guide_component = {
			"common",
			"roomEdit",
			{
				"item_22Tgl_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-923,
			433
		}
	},
	[4904] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 4904,
		talk_content = "嗯…看起来大厅的门窗还得自己动手安装，通过长按的方式可以将家具拖动放入场景内。",
		params = {},
		guide_component = {
			"child_getcom",
			"roomEdit",
			{
				"guideComponents",
				"guide_content"
			},
			"furItem(Clone)/bg",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1052,
			149
		}
	},
	[5001] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 5001,
		talk_content = "可以点击设置将当前房间设置为展示房间，其他管理员可以参观当前房间的布置。",
		params = {},
		guide_component = {
			"common",
			"dorm",
			{
				"exhib"
			},
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-425,
			845
		}
	},
	[5002] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 5002,
		talk_content = "点击打开宿舍区域的视图，并且可以在视图中为修正者分配单人的宿舍房间。",
		params = {},
		guide_component = {
			"common",
			"dorm",
			{
				"positionBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-791,
			148
		}
	},
	[5003] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 5003,
		talk_content = "有许多宿舍房间还未开放，通过餐厅经营积累的小窝资金扩展宿舍房间。",
		params = {},
		guide_component = {
			"child_getcom",
			"dormChooseRoomView",
			{
				"guideComponents",
				"guide_content"
			},
			"DormRoomItem(Clone)/itempanel/itemList/item5/lock/icon",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-400,
			810
		}
	},
	[5004] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 5004,
		talk_content = "已经有可以入住的宿舍房间了，当修正者好感度达到5级时即可安排入住。",
		params = {},
		guide_component = {
			"child_getcom",
			"dormChooseRoomView",
			{
				"guideComponents",
				"guide_content"
			},
			"DormRoomItem(Clone)/itempanel/itemList/item3/movein/icon",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-845,
			651
		}
	},
	[5005] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 5005,
		talk_content = "当修正者入住后，可以给入住的修正者赠送家具来布置房间，并且房间将会和该修正者绑定。",
		params = {},
		guide_component = {
			"child_getcom",
			"dormChooseRoomView",
			{
				"guideComponents",
				"guide_content"
			},
			"DormRoomItem(Clone)/itempanel/itemList/item3/movein/icon",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-845,
			651
		}
	},
	[5006] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 5006,
		talk_content = "拖动或点击切换按钮可以将视图切换到其他的区域。",
		params = {},
		guide_component = {
			"common",
			"dormChooseRoomView",
			{
				"btnupBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-581,
			722
		}
	},
	[5007] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = true,
		id = 5007,
		talk_content = "如果想查看其他管理员的房间布置，可以随时通过参观功能查看。",
		params = {},
		guide_component = {
			"common",
			"dormChooseRoomView",
			{
				"visitBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1231,
			181
		}
	},
	[5008] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 5008,
		talk_content = "点击返回可以随时退出宿舍区域视图。",
		params = {},
		guide_component = {
			"common",
			"dormChooseRoomView",
			{
				"buttonreturnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-605,
			161
		}
	},
	[5101] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 5101,
		talk_content = "当前修正者体力详情，在大厅中恢复速度是固定的，在宿舍中会随着宿舍等级上升而加快。",
		params = {},
		guide_component = {
			"common",
			"heroInteractView",
			{
				"guideComponents",
				"guide_obj"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-886,
			347
		}
	},
	[5102] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 5102,
		talk_content = "邀请修正者进餐可以增加修正者的体力，需要注意相同修正者存在每日次数限制。",
		params = {},
		guide_component = {
			"common",
			"heroInteractView",
			{
				"feedfoodbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-369,
			376
		}
	},
	[5103] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = true,
		id = 5103,
		talk_content = "当修正者有自己的宿舍后，可以为其赠送家具，家具赠送后可以在大厅或该修正者宿舍中摆放。",
		params = {},
		guide_component = {
			"common",
			"heroInteractView",
			{
				"giftbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-388,
			186
		}
	},
	[5104] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 5104,
		talk_content = "尝试抚摸修正者或许能看到其意想不到的一面。",
		params = {},
		guide_component = {
			"common",
			"heroInteractView",
			{
				"touchbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-388,
			612
		}
	},
	[5201] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 5201,
		talk_content = "游园街的餐厅也开放了，可以通过经营餐厅来赚取报酬。",
		params = {},
		guide_component = {
			"common",
			"backHomeEnterView",
			{
				"canteenBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-541,
			132
		}
	},
	[5202] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 5202,
		talk_content = "想经营好餐厅首先就要将修正者分配到合适的岗位，点击可以为每个岗位派遣修正者。",
		params = {},
		guide_component = {
			"common",
			"restaurantMain",
			{
				"jobSetBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-670,
			270
		}
	},
	[5203] = {
		talk_anchors = 3,
		type = "ClickButton",
		is_finish = false,
		id = 5203,
		talk_content = "先尝试选择看看负责制作菜品的厨师吧。",
		params = {},
		guide_component = {
			"child_getcom",
			"restaurantJobView",
			{
				"guideComponents",
				"guide_job_content"
			},
			"heroItem(Clone)/click",
			"Button"
		},
		mask_component = {
			"common",
			"restaurantJobView",
			{
				"guideComponents",
				"guide_mask"
			}
		},
		mask_scale = {},
		talk_position = {
			-746,
			424
		}
	},
	[5204] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 5204,
		talk_content = "点击可以选择想要派遣的修正者，修正者头像会显示对应技能加成。",
		params = {},
		guide_component = {
			"child_getcom",
			"restaurantJobSetView",
			{
				"guideComponents",
				"guide_herolist"
			},
			"heroitem(Clone)/bg",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-1060,
			749
		}
	},
	[5205] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 5205,
		talk_content = "修正者的体力以及等级信息可以通过这里查看。",
		params = {},
		guide_component = {
			"common",
			"restaurantJobSetView",
			{
				"guideComponents",
				"guide_heroinfo"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-390,
			691
		}
	},
	[5206] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = true,
		id = 5206,
		talk_content = "这里会显示技能详情，技能需要达到特定等级才能解锁。",
		params = {},
		guide_component = {
			"child_getcom",
			"restaurantJobSetView",
			{
				"guideComponents",
				"guide_skillinfo"
			},
			"itemSkillInfo(Clone)",
			"RectTransform"
		},
		mask_component = {
			"common",
			"restaurantJobSetView",
			{
				"guideComponents",
				"guide_mask"
			}
		},
		mask_scale = {},
		talk_position = {
			-600,
			502
		}
	},
	[5207] = {
		talk_anchors = 3,
		type = "HighLight",
		is_finish = false,
		id = 5207,
		talk_content = "如果确认无误，可以设置当前选中的修正者，需要所有岗位都派遣完毕后才能开始经营。",
		params = {},
		guide_component = {
			"common",
			"restaurantJobSetView",
			{
				"confirmBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			-420,
			108
		}
	},
	[5301] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 5301,
		talk_content = "管理员，食材已经准备好了，点击菜单准备将菜品上架吧。",
		params = {},
		guide_component = {
			"common",
			"restaurantMain",
			{
				"foodtitleBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			200,
			-350
		}
	},
	[5302] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 5302,
		talk_content = "这里是已经解锁的菜品，点击上架，已经上架的菜品会全天候自动售卖。",
		params = {},
		guide_component = {
			"child_getcom",
			"chooseSignFoodView",
			{
				"guideComponents",
				"guide_content"
			},
			"foodItem(Clone)/food/shelvesBtn",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			450,
			100
		}
	},
	[5303] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 5303,
		talk_content = "这里是菜品消耗的食材，最大制作数量会受到可使用的食材数量的限制。",
		params = {},
		guide_component = {
			"common",
			"reviseSignFoodNumView",
			{
				"guideComponents",
				"guide_cost"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			140,
			-145
		}
	},
	[5304] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 5304,
		talk_content = "可以设定菜品售卖的预期数量，设定后如果想重新调整数量则需要先将设定好的订单下架。",
		params = {},
		guide_component = {
			"common",
			"reviseSignFoodNumView",
			{
				"guideComponents",
				"guide_set"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			200,
			-350
		}
	},
	[5305] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 5305,
		talk_content = "根据设定的数量，可以看到订单完成的预计耗时与预计收益。",
		params = {},
		guide_component = {
			"common",
			"reviseSignFoodNumView",
			{
				"guideComponents",
				"guide_info"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			300,
			-330
		}
	},
	[5401] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 5401,
		talk_content = "菜品所需的食材可以通过完成委托任务来积累。",
		params = {},
		guide_component = {
			"common",
			"restaurantMain",
			{
				"taskbtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			325,
			233
		}
	},
	[5402] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 5402,
		talk_content = "这是收到的委托请求，完成这些请求可以获得由委托人送来的食材，并且随厨具等级提升后有机会接到全新的委托。",
		params = {},
		guide_component = {
			"child_getcom",
			"dormTaskDispatchView",
			{
				"guideComponents",
				"guide_content"
			},
			"taskItem(Clone)/bg",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			37,
			125
		}
	},
	[5403] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 5403,
		talk_content = "了解完委托的信息后就可以准备派遣啦，委托完成后会立刻获得新的委托任务。",
		params = {},
		guide_component = {
			"child_getcom",
			"dormTaskDispatchView",
			{
				"guideComponents",
				"guide_content"
			},
			"taskItem(Clone)/unlock/taskBtn",
			"Button"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			0,
			-290
		}
	},
	[5404] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 5404,
		talk_content = "这里可以看到修正者的信息，当修正者适合该委托时对应类型标签会亮起。",
		params = {},
		guide_component = {
			"child_getcom",
			"chooseCharacterView",
			{
				"guideComponents",
				"guide_content"
			},
			"heroHeadPrefabN(Clone)/heroinfo/bg",
			"RectTransform"
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			115,
			90
		}
	},
	[5405] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 5405,
		talk_content = "这里可以看到本次委托需要消耗的总体力，选择的修正者的体力之和需要不小于所需总体里才能进行派遣。",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"battlebtnBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			100,
			-150
		}
	},
	[5406] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 5406,
		talk_content = "每次委托可能会有不一样的推荐类型，搭配对应的修正者时可以增加委托大成功的概率。",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"recuilistUilist_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			320,
			-370
		}
	},
	[5407] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 5407,
		talk_content = "当前委托的大成功完成的实时概率，如果大成功达成委托则会获得额外的奖励~",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"guideComponents",
				"guide_probability"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			380,
			-290
		}
	},
	[5408] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 5408,
		talk_content = "在委托中可以快速选择当前任务最适合委派的修正者。",
		params = {},
		guide_component = {
			"common",
			"chooseCharacterView",
			{
				"quickBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			463,
			-360
		}
	},
	[5501] = {
		talk_anchors = 0,
		type = "ClickButton",
		is_finish = false,
		id = 5501,
		talk_content = "通过不断经营餐厅，可以提升餐厅中的设施等级。",
		params = {},
		guide_component = {
			"common",
			"restaurantMain",
			{
				"cookBtn_"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			309,
			-290
		}
	},
	[5502] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 5502,
		talk_content = "设施等级提升能解锁新的菜品以及提高对应菜系的收益，同时还能增加餐厅的人气值。",
		params = {},
		guide_component = {
			"common",
			"restaurantCookUpView",
			{
				"uitreeGo_"
			}
		},
		mask_component = {
			"common",
			"restaurantCookUpView",
			{
				"guideComponents",
				"guide1_mask"
			}
		},
		mask_scale = {},
		talk_position = {
			110,
			-179
		}
	},
	[5503] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 5503,
		talk_content = "设施的收益效果会在这里显示，等级上升后对应数值也会增加。",
		params = {},
		guide_component = {
			"common",
			"restaurantCookUpView",
			{
				"guideComponents",
				"guide_skill"
			}
		},
		mask_component = {},
		mask_scale = {},
		talk_position = {
			278,
			-67
		}
	},
	[5504] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 5504,
		talk_content = "当餐厅经营满足条件后，相应的设施才能提升等级。",
		params = {},
		guide_component = {
			"common",
			"restaurantCookUpView",
			{
				"guideComponents",
				"guide_condition"
			}
		},
		mask_component = {
			"common",
			"restaurantCookUpView",
			{
				"guideComponents",
				"guide2_mask"
			}
		},
		mask_scale = {},
		talk_position = {
			320,
			-270
		}
	},
	[5505] = {
		talk_anchors = 0,
		type = "HighLight",
		is_finish = false,
		id = 5505,
		talk_content = "满足升级条件后需要消耗一定的材料才能升级。",
		params = {},
		guide_component = {
			"common",
			"restaurantCookUpView",
			{
				"guideComponents",
				"guide_cost"
			}
		},
		mask_component = {
			"common",
			"restaurantCookUpView",
			{
				"guideComponents",
				"guide3_mask"
			}
		},
		mask_scale = {},
		talk_position = {
			490,
			-90
		}
	},
	all = {
		101,
		102,
		103,
		104,
		105,
		106,
		201,
		202,
		203,
		204,
		205,
		206,
		301,
		302,
		303,
		304,
		305,
		306,
		307,
		308,
		309,
		310,
		311,
		312,
		313,
		314,
		315,
		316,
		317,
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
		411,
		412,
		413,
		414,
		501,
		502,
		503,
		504,
		505,
		506,
		507,
		508,
		509,
		510,
		511,
		601,
		602,
		603,
		604,
		605,
		606,
		607,
		801,
		802,
		803,
		804,
		805,
		806,
		807,
		808,
		809,
		810,
		811,
		812,
		813,
		814,
		815,
		901,
		902,
		1001,
		1002,
		1003,
		1004,
		1005,
		1101,
		1102,
		1103,
		1104,
		1105,
		1201,
		1202,
		1203,
		1204,
		1301,
		1302,
		1303,
		1304,
		1305,
		1601,
		1602,
		1701,
		1702,
		1703,
		1704,
		1801,
		1802,
		1803,
		1804,
		1805,
		1806,
		1807,
		1808,
		1901,
		1902,
		1903,
		1904,
		1905,
		1906,
		1907,
		1908,
		1909,
		1910,
		1911,
		1912,
		1913,
		1914,
		1915,
		2001,
		2002,
		2003,
		2004,
		2101,
		2102,
		2103,
		2201,
		2202,
		2203,
		2301,
		2401,
		2402,
		2403,
		2404,
		2405,
		2406,
		2407,
		2408,
		2501,
		2502,
		2503,
		2504,
		2505,
		2506,
		2601,
		2602,
		2603,
		2604,
		2605,
		2606,
		2607,
		2608,
		2701,
		2702,
		2703,
		2704,
		2705,
		2706,
		2801,
		2802,
		2803,
		2804,
		2805,
		2806,
		2807,
		2808,
		2809,
		2810,
		2901,
		2902,
		3001,
		3101,
		3201,
		3301,
		3401,
		3501,
		3502,
		3503,
		3504,
		3505,
		3506,
		3601,
		3602,
		3603,
		3604,
		3605,
		3701,
		3702,
		3703,
		3704,
		3801,
		3802,
		3901,
		3902,
		3903,
		4001,
		4002,
		4003,
		4004,
		4005,
		4006,
		4007,
		4101,
		4102,
		4103,
		4104,
		4201,
		4202,
		4203,
		4204,
		4205,
		4206,
		4207,
		4208,
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
		4311,
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
		4412,
		4501,
		4601,
		4602,
		4603,
		4604,
		4605,
		4606,
		4607,
		4608,
		4609,
		4610,
		4611,
		4612,
		4613,
		4614,
		4615,
		4616,
		4617,
		4618,
		4619,
		4620,
		4701,
		4801,
		4802,
		4803,
		4804,
		4805,
		4901,
		4902,
		4903,
		4904,
		5001,
		5002,
		5003,
		5004,
		5005,
		5006,
		5007,
		5008,
		5101,
		5102,
		5103,
		5104,
		5201,
		5202,
		5203,
		5204,
		5205,
		5206,
		5207,
		5301,
		5302,
		5303,
		5304,
		5305,
		5401,
		5402,
		5403,
		5404,
		5405,
		5406,
		5407,
		5408,
		5501,
		5502,
		5503,
		5504,
		5505
	}
}
