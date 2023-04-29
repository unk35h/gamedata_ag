return {
	[1050101] = {
		element_type = 0,
		name = "五蕴绯想斩",
		cd = 0,
		simpleDesc = "连续挥动太刀斩击敌人，造成物理伤害。\n\n<color=#0068C3>印记：最后一段攻击命中后获得印记。</color>",
		MaxUseCount = 0,
		id = 1050101,
		EnergyChange = 0,
		desc = {
			101050101
		},
		strengthen_desc = {
			105021,
			211050101
		},
		abilities = {
			1050101
		}
	},
	[1050201] = {
		element_type = 0,
		name = "绯·缨白",
		cd = 9000,
		simpleDesc = "对目标进行三段攻击，造成物理伤害。\n\n<color=#0068C3>印记：每次施放命中后，获得印记。</color>",
		MaxUseCount = 0,
		id = 1050201,
		EnergyChange = 1,
		desc = {
			101050201
		},
		strengthen_desc = {
			105022,
			211050201
		},
		abilities = {
			1050201
		}
	},
	[1050202] = {
		element_type = 0,
		name = "绯·云水",
		cd = 9000,
		simpleDesc = "向目标斩出十字刀光，造成物理伤害。\n\n<color=#0068C3>印记：每次施放命中后，获得印记。</color>",
		MaxUseCount = 0,
		id = 1050202,
		EnergyChange = 1,
		desc = {
			101050202
		},
		strengthen_desc = {
			105023,
			211050202
		},
		abilities = {
			1050053
		}
	},
	[1050221] = {
		element_type = 0,
		name = "绯·苍星",
		cd = 9000,
		simpleDesc = "向锁定的敌人斩出可以飞行一段距离的十字刀光，造成物理伤害，对命中的敌人附加破甲状态。\n\n<color=#0068C3>印记：攻击第一次命中后获得印记，刀光飞行命中时额外获得印记。</color>",
		MaxUseCount = 0,
		abilities = "",
		id = 1050221,
		EnergyChange = 1,
		desc = {
			101050221
		},
		strengthen_desc = {
			105041,
			211050221
		}
	},
	[1050203] = {
		element_type = 0,
		name = "绯·散华",
		cd = 0,
		simpleDesc = "进行一次居合斩，对锁定的敌人施放刀阵，造成物理伤害。施放后的一段时间内，可消耗印记施放「绯·散华」的下一式，造成物理伤害，刀阵的攻击范围提高。",
		MaxUseCount = 0,
		id = 1050203,
		EnergyChange = -1,
		desc = {
			101050203
		},
		strengthen_desc = {
			105024,
			211050203
		},
		abilities = {
			1050056
		}
	},
	[1050209] = {
		element_type = 0,
		name = "绯·千鸩",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "向锁定方向突进并挥斩，对范围内的敌人造成物理伤害；施放时进入零时空间。\n\n自身或者队友的技能和奥义造成会心时，获得奥义值。",
		MaxUseCount = 0,
		id = 1050209,
		EnergyChange = 0,
		desc = {
			101050209
		},
		abilities = {
			1050209
		}
	},
	[1050305] = {
		element_type = 16,
		name = "绯·胧影",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间；获得奥义值。",
		MaxUseCount = 2,
		abilities = "",
		id = 1050305,
		EnergyChange = 0,
		desc = {
			101050305
		}
	},
	[1071101] = {
		element_type = 2,
		name = "太昊剑法",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
孟章参悟星宿而习得的五式剑法，造成风属性伤害，处于「青巽」姿态时，施放每段普通攻击时会获得「勿」标记。

被动：
切换为「苍震」姿态时，根据自身拥有的风属性伤害提高，对应获得雷属性伤害提高；切换为「青巽」姿态时，根据自身拥有的雷属性伤害提高，对应获得风属性伤害提高。

<color=#0068C3>神能：处于「青巽」姿态时，普通攻击命中后会获得神能。</color>]],
		MaxUseCount = 0,
		id = 1071101,
		EnergyChange = 0,
		desc = {
			101071101
		},
		abilities = {
			1071101
		}
	},
	[1071201] = {
		element_type = 2,
		name = "风雷引",
		cd = 8000,
		strengthen_desc = "",
		simpleDesc = [[
处于「青巽」姿态：施放「风雷引」，急速后撤，造成风属性伤害。「风雷引」处于冷却状态时，会替换为「风雷突」。
「风雷突」：急速突进，造成风属性伤害，命中时消耗全部「勿」标记，根据消耗「勿」标记的数量召唤「玉剑」攻击锁定的敌人。
切换至「苍震」姿态时，该技能会替换为「风雷破」；切换至「青巽」姿态时，该技能会替换为「风雷引」。
「风雷破」：消耗神能造成雷属性伤害，可以在施放「益动势合·震」或「恒出运昌·震」的过程中穿插施放该技能，穿插施放时会改变攻击模式并改变「益动势合·震」或「恒出运昌·震」的后续伤害，衍生出更强力的招式；穿插施放时，「风雷破」、「益动势合·震」和「恒出运昌·震」的剩余冷却时间缩短；穿插施放后，下一次直接施放该技能时会改变攻击模式、不会进入冷却也不会打断普通攻击的连段。

<color=#0068C3>神能：处于「青巽」姿态时，每次命中敌人会获得神能。</color>]],
		MaxUseCount = 0,
		id = 1071201,
		EnergyChange = 0,
		desc = {
			101071201
		},
		abilities = {
			1071201,
			1071059,
			1071060
		}
	},
	[1071202] = {
		element_type = 2,
		name = "益动势合",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = [[
处于「青巽」姿态：该技能替换为「益动势合·巽」。施放时格挡受到的伤害，召唤多把「玉剑」攻击锁定的敌人。该技能处于冷却状态时，每次普通攻击命中后会召唤不同数量的「玉剑」攻击锁定的敌人。
「玉剑」：造成风属性伤害，并提高风属性伤害。
处于「苍震」姿态：该技能替换为「益动势合·震」。消耗神能施放二段攻击造成伤害，根据穿插「风雷破」的时机，又演化出二式剑术，造成不同的雷属性伤害。
第一式：直接施放；
第二式：在第二段前穿插施放「风雷破」。]],
		MaxUseCount = 0,
		id = 1071202,
		EnergyChange = 0,
		desc = {
			101071202
		},
		abilities = {
			1071053
		}
	},
	[1071203] = {
		element_type = 2,
		name = "恒出运昌",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = [[
处于「青巽」姿态：该技能替换为「恒出运昌·巽」。神能达到满值后才可施放，造成风属性伤害，自身切换为「苍震」姿态、移除全部「勿」标记、重置「恒出运昌·震」的冷却时间，召唤数道「云雷」攻击锁定的目标，造成雷属性伤害。当神能耗尽时，自身切换为「青巽」姿态。
处于「苍震」姿态：该技能替换为「恒出运昌·震」。消耗神能施放三段攻击造成伤害，最后一段攻击在前方召唤数道「云雷」，根据穿插「风雷破」的时机，又演化出四式剑术，造成不同的雷属性伤害。
第一式：直接施放；
第二式：仅在第二段前穿插施放「风雷破」；
第三式：仅在第三段前穿插施放「风雷破」；
第四式：在第二段前和第三段前都穿插施放「风雷破」。]],
		MaxUseCount = 0,
		id = 1071203,
		EnergyChange = 0,
		desc = {
			101071203
		},
		abilities = {
			1071056
		}
	},
	[1071209] = {
		element_type = 14,
		name = "苍龙七宿",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "援引风雷之力，造成雷属性伤害；施放时根据当前的姿态，提高自身风属性或雷属性伤害。\n\n自身或者队友施放奥义、自身切换姿态时，获得奥义值。",
		MaxUseCount = 0,
		id = 1071209,
		EnergyChange = 0,
		desc = {
			101071209
		},
		abilities = {
			1071209
		}
	},
	[1071305] = {
		element_type = 16,
		name = "风雷移",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "处于「青巽」姿态的闪避效果：触发多把「玉剑」攻击锁定的敌人；\n处于「苍震」姿态的闪避效果：下一次施放「益动势合·震」或「恒出运昌·震」时，获得硬直和格挡效果。",
		MaxUseCount = 2,
		abilities = "",
		id = 1071305,
		EnergyChange = 0,
		desc = {
			101071305
		}
	},
	[1052101] = {
		element_type = 0,
		name = "暴风突击",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
使用怒蛇进行两轮射击，造成物理伤害，随后呼叫「暴风模式」的无人机对前方区域进行轰炸，造成物理伤害。当拥有「火力覆盖战术」的加成效果时，普通攻击最后一段会呼叫「暴风模式」的无人机并向前方翻滚进行连续三次炮击，造成物理伤害。

被动：
消耗能量或普通攻击第三段结束时会获得「火力计数」。「火力计数」为满时，可以长按普通攻击施放「怒蛇咆吼」。
「怒蛇咆吼」：使用怒蛇向敌人高速倾泻火力，造成物理伤害，期间无法获得「火力计数」。

<color=#0068C3>能量：间歇获得能量，普通攻击和「怒蛇咆吼」每次命中也会获得能量。</color>]],
		MaxUseCount = 0,
		id = 1052101,
		EnergyChange = 0,
		desc = {
			101052101
		},
		abilities = {
			1052068
		}
	},
	[1052201] = {
		element_type = 0,
		name = "火力覆盖战术",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "使用怒蛇对敌人进行连续三次炮击，造成物理伤害。每次炮击命中后，获得能量，全队伍技能一基础伤害提高。技能施放结束时，根据未释放的炮击次数缩短该技能的剩余冷却时间。能量为满时，该技能会替换为「火力支援战术」。\n「火力支援战术」：消耗能量，呼叫远程炮火轰炸前方区域，造成物理伤害；施放「怒蛇咆吼」且能量为满时会自动消耗能量并施放「火力支援战术」。",
		MaxUseCount = 0,
		id = 1052201,
		EnergyChange = 0,
		desc = {
			101052201
		},
		abilities = {
			1052059
		}
	},
	[1052202] = {
		element_type = 0,
		name = "快速反应战术",
		cd = 13000,
		strengthen_desc = "",
		simpleDesc = "用怒蛇轰击敌人，造成物理伤害并对区域内所有敌人附加眩晕状态。命中后呼叫「凶风模式」的无人机对区域内敌人进行攻击，造成物理伤害；施放该技能后「火力计数」消耗降低。 \n自身或者队友每次呼叫该无人机命中时，该技能冷却时间缩短、能量消耗增加。",
		MaxUseCount = 0,
		id = 1052202,
		EnergyChange = -30,
		desc = {
			101052202
		},
		abilities = {
			1052060
		}
	},
	[1052221] = {
		element_type = 0,
		name = "快速反应战术",
		cd = 13000,
		strengthen_desc = "",
		simpleDesc = "用怒蛇轰击敌人，造成物理伤害并对区域内所有敌人附加眩晕状态。命中后呼叫「旋风模式」的无人机轰击区域内敌人；当队友存在时会根据队友的伤害属性种类和数量，分别对敌人附加对应属性抗性降低的状态。 \n自身或者队友每次呼叫该无人机命中时，该技能冷却时间缩短、能量消耗增加。",
		MaxUseCount = 0,
		id = 1052221,
		EnergyChange = -30,
		desc = {
			101052221
		},
		abilities = {
			1052052
		}
	},
	[1052203] = {
		element_type = 0,
		name = "优势围歼战术",
		cd = 13000,
		strengthen_desc = "",
		simpleDesc = "抛出内爆手雷，手雷爆炸后造成物理伤害，并短暂聚集敌人。之后呼叫「恶风模式」的无人机对区域进行攻击，造成物理伤害；施放该技能后「火力计数」获取率提高。\n自身或者队友每次呼叫该无人机命中时，该技能冷却时间缩短、能量消耗增加。",
		MaxUseCount = 0,
		id = 1052203,
		EnergyChange = -30,
		desc = {
			101052203
		},
		abilities = {
			1052057,
			1052053
		}
	},
	[1052231] = {
		element_type = 0,
		name = "优势围歼战术",
		cd = 13000,
		strengthen_desc = "",
		simpleDesc = "抛出内爆手雷，手雷爆炸后造成物理伤害，并短暂聚集敌人。之后呼叫「飓风模式」的无人机向爆炸区域丢下减速陷阱；陷阱持续对敌人造成物理伤害，并使被命中的敌人进入动作迟缓状态。\n自身或者队友每次呼叫该无人机命中时，该技能冷却时间缩短、能量消耗增加。",
		MaxUseCount = 0,
		id = 1052231,
		EnergyChange = -30,
		desc = {
			101052231
		},
		abilities = {
			1052064
		}
	},
	[1052209] = {
		element_type = 0,
		name = "神战的终结",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "呼叫多架「雨洪模式」的无人机对目标区域进行轰炸，造成物理伤害；对命中的敌人附加破甲状态。\n\n自身或者队友成功消耗能量时，获得奥义值。",
		MaxUseCount = 0,
		id = 1052209,
		EnergyChange = 0,
		desc = {
			101052209
		},
		abilities = {
			1052065
		}
	},
	[1052305] = {
		element_type = 16,
		name = "紧急防护",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：根据「火力计数」降低自身受到的伤害。",
		MaxUseCount = 2,
		abilities = "",
		id = 1052305,
		EnergyChange = 0,
		desc = {
			101052305
		}
	},
	[1066101] = {
		element_type = 0,
		name = "兔兔铁拳",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "召唤兔兔铁拳打击敌人，造成物理伤害。\n\n<color=#0068C3>怒气：普通攻击命中后会获得怒气。</color>",
		MaxUseCount = 0,
		id = 1066101,
		EnergyChange = 2,
		desc = {
			101066101
		},
		abilities = {
			1066101
		}
	},
	[1066201] = {
		element_type = 16,
		name = "占卜",
		cd = 11000,
		strengthen_desc = "",
		simpleDesc = [[
抽取塔罗牌获得对应占卜效果。当抽到卡牌与上一次不同时，加成效果提高。
<color=#ad25b5>死神</color>：攻击力提高。
<color=#d7ac00>战车</color>：间歇获得怒气。
<color=#5cb82b>恋人</color>：间歇恢复生命值。]],
		MaxUseCount = 0,
		abilities = "",
		id = 1066201,
		EnergyChange = 0,
		desc = {
			101066201
		}
	},
	[1066202] = {
		element_type = 0,
		name = "兔兔加农",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = "发射兔兔二号攻击前方敌人，造成物理伤害。命中后会继续弹射造成物理伤害。",
		MaxUseCount = 0,
		id = 1066202,
		EnergyChange = -40,
		desc = {
			101066202
		},
		abilities = {
			1066055,
			1066052
		}
	},
	[1066203] = {
		element_type = 0,
		name = "兔兔扫射",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = "跃起攻击前方圆形范围内的敌人，造成物理伤害。",
		MaxUseCount = 0,
		id = 1066203,
		EnergyChange = -60,
		desc = {
			101066203
		},
		abilities = {
			1066203
		}
	},
	[1066231] = {
		element_type = 0,
		name = "兔兔出击",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = "召唤兔兔三号自动攻击周围的敌人，造成物理伤害。兔兔三号攻击时会拉扯附近的敌人。",
		MaxUseCount = 0,
		id = 1066231,
		EnergyChange = -60,
		desc = {
			101066231
		},
		abilities = {
			1066057
		}
	},
	[1066209] = {
		element_type = 0,
		name = "机械降神",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "召唤兔兔三号攻击周围目标，造成物理伤害；重置自身技能三的冷却时间，使队友技能三的剩余冷却时间缩短。\n\n自身或者队友施放奥义时，获得奥义值。",
		MaxUseCount = 0,
		id = 1066209,
		EnergyChange = 0,
		desc = {
			101066209
		},
		abilities = {
			1066053
		}
	},
	[1066305] = {
		element_type = 16,
		name = "预知演算",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间。",
		MaxUseCount = 2,
		abilities = "",
		id = 1066305,
		EnergyChange = 0,
		desc = {
			101066305
		}
	},
	[1048101] = {
		element_type = 12,
		name = "迅捷射击",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "对锁定的敌人连续射击，造成光属性伤害。\n\n<color=#0068C3>能量：间歇获得能量。</color>",
		MaxUseCount = 0,
		id = 1048101,
		EnergyChange = 0,
		desc = {
			101048101
		},
		abilities = {
			1048101
		}
	},
	[1048201] = {
		element_type = 12,
		name = "定点打击",
		cd = 7000,
		strengthen_desc = "",
		simpleDesc = "召唤激光轰炸锁定的敌人，造成光属性伤害，对命中的敌人附加禁锢状态。",
		MaxUseCount = 0,
		id = 1048201,
		EnergyChange = -25,
		desc = {
			101048201
		},
		abilities = {
			1048051
		}
	},
	[1048211] = {
		element_type = 12,
		name = "多轮轰炸",
		cd = 7000,
		strengthen_desc = "",
		simpleDesc = "对前方敌人进行多轮轰炸，造成光属性伤害，对命中的敌人附加禁锢状态，后续轰炸对同一个敌人伤害衰减。",
		MaxUseCount = 0,
		abilities = "",
		id = 1048211,
		EnergyChange = -25,
		desc = {
			101048211
		}
	},
	[1048202] = {
		element_type = 12,
		name = "电导空袭",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "召唤空袭装置对区域内的敌人进行轰炸，造成光属性伤害。",
		MaxUseCount = 0,
		id = 1048202,
		EnergyChange = -40,
		desc = {
			101048202
		},
		abilities = {
			1048054
		}
	},
	[1048203] = {
		element_type = 12,
		name = "终焉脉冲",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "持续释放终焉脉冲，造成多段光属性伤害。",
		MaxUseCount = 0,
		id = 1048203,
		EnergyChange = -65,
		desc = {
			101048203
		},
		abilities = {
			1048203
		}
	},
	[1048209] = {
		element_type = 12,
		name = "导弹连发",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "对范围内敌人发射多枚导弹，造成光属性伤害；每枚导弹命中后全队伍都可以获得能量。\n\n当敌人被附加禁锢状态时，获得奥义值。",
		MaxUseCount = 0,
		id = 1048209,
		EnergyChange = 0,
		desc = {
			101048209
		},
		abilities = {
			1048052,
			1048052,
			1048052,
			1048052,
			1048052,
			1048052,
			1048052,
			1048052,
			1048052
		}
	},
	[1048305] = {
		element_type = 16,
		name = "琥珀时间",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：对攻击者附加禁锢状态。",
		MaxUseCount = 2,
		abilities = "",
		id = 1048305,
		EnergyChange = 0,
		desc = {
			101048305
		}
	},
	[1148101] = {
		element_type = 0,
		name = "拦阻射击",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "对周围目标进行连续射击，造成物理伤害。",
		MaxUseCount = 0,
		id = 1148101,
		EnergyChange = 0,
		desc = {
			101148101
		},
		abilities = {
			1148101
		}
	},
	[1148201] = {
		element_type = 0,
		name = "战术爆弹",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "甩出一颗爆弹，延时爆炸，造成物理伤害。\n\n<color=#0068C3>印记：每次施放命中后，获得印记。</color>",
		MaxUseCount = 0,
		id = 1148201,
		EnergyChange = 1,
		desc = {
			101148201
		},
		abilities = {
			1148051
		}
	},
	[1148202] = {
		element_type = 0,
		name = "连环准星",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "自动锁定并对目标进行连续射击，造成物理伤害。\n\n<color=#0068C3>印记：每次施放命中后，获得印记。</color>",
		MaxUseCount = 0,
		id = 1148202,
		EnergyChange = 1,
		desc = {
			101148202
		},
		abilities = {
			1148202
		}
	},
	[1148203] = {
		element_type = 0,
		name = "狙击模式",
		cd = 6000,
		strengthen_desc = "",
		simpleDesc = "武器展开变为狙击枪，开启「狙击模式」。\n「狙击模式」：禁用移动和自身其他技能，点击技能可对瞄准目标进行射击，造成物理伤害。可通过闪避来结束该模式。",
		MaxUseCount = 0,
		id = 1148203,
		EnergyChange = -1,
		desc = {
			101148203
		},
		abilities = {
			1148203
		}
	},
	[1148209] = {
		element_type = 0,
		name = "贯穿狙击",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "枪械变形为狙击枪，对前方直线路径上的敌人进行贯穿射击，造成物理伤害；命中后自身和队友获得印记。\n\n自身或者队友触发零时空间时，获得奥义值。",
		MaxUseCount = 0,
		id = 1148209,
		EnergyChange = 0,
		desc = {
			101148209
		},
		abilities = {
			1148209
		}
	},
	[1148305] = {
		element_type = 16,
		name = "瞄准时间",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间。",
		MaxUseCount = 0,
		abilities = "",
		id = 1148305,
		EnergyChange = 0,
		desc = {
			101148305
		}
	},
	[1039101] = {
		element_type = 8,
		name = "凝露飞弹",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
召唤露珠攻击前方敌人，造成水属性伤害。

被动：
当神能为满时，技能施放后不会进入冷却状态，但会消耗全部神能。

<color=#0068C3>神能：普通攻击命中后会获得神能。</color>]],
		MaxUseCount = 0,
		id = 1039101,
		EnergyChange = 0,
		desc = {
			101039101
		},
		abilities = {
			1039051
		}
	},
	[1039201] = {
		element_type = 16,
		name = "海之恩泽",
		cd = 14000,
		strengthen_desc = "",
		simpleDesc = "恢复指定范围内所有友方生命值。",
		MaxUseCount = 0,
		abilities = "",
		id = 1039201,
		EnergyChange = 0,
		desc = {
			101039201
		}
	},
	[1039211] = {
		element_type = 16,
		name = "苍澜鲸歌",
		cd = 14000,
		strengthen_desc = "",
		simpleDesc = "恢复指定范围内所有友方生命值，受治疗的自身或者队友对应的机制值获取率提高，并获得对应机制值。",
		MaxUseCount = 0,
		abilities = "",
		id = 1039211,
		EnergyChange = 0,
		desc = {
			101039211
		}
	},
	[1039202] = {
		element_type = 16,
		name = "星离雨散",
		cd = 19000,
		strengthen_desc = "",
		simpleDesc = "全队伍额外攻击力提高。",
		MaxUseCount = 0,
		abilities = "",
		id = 1039202,
		EnergyChange = 0,
		desc = {
			101039202
		}
	},
	[1039203] = {
		element_type = 8,
		name = "激流浪涌",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "召唤一道浪潮向前方缓慢推进，造成水属性伤害。",
		MaxUseCount = 0,
		id = 1039203,
		EnergyChange = 0,
		desc = {
			101039203
		},
		abilities = {
			1039062
		}
	},
	[1039209] = {
		element_type = 16,
		name = "潮之歌",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "全队伍生命值上限提高，并恢复全队伍生命值。\n\n自身或者队友受身时，获得奥义值。",
		MaxUseCount = 0,
		abilities = "",
		id = 1039209,
		EnergyChange = 0,
		desc = {
			101039209
		}
	},
	[1039305] = {
		element_type = 16,
		name = "空幻泡沫",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间；获得神能。",
		MaxUseCount = 2,
		abilities = "",
		id = 1039305,
		EnergyChange = 0,
		desc = {
			101039305
		}
	},
	[1139101] = {
		element_type = 6,
		name = "寒极冰晶",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "召唤冰棱攻击前方敌人，造成冰属性伤害。\n\n<color=#0068C3>能量：间歇获得能量。</color>",
		MaxUseCount = 0,
		id = 1139101,
		EnergyChange = 0,
		desc = {
			101139101
		},
		abilities = {
			1139051
		}
	},
	[1139201] = {
		element_type = 6,
		name = "零度寒芒",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "召唤一根冰刺攻击目标，造成冰属性伤害，施放技能短暂时间后，可再次点击施放「追加吟唱」。\n「追加吟唱」：冰刺碎裂后再次攻击，造成冰属性伤害，并获得「若雪」标记。\n消耗「若雪」标记进入「临渊」状态时，获得以下效果：「零度寒芒」剩余冷却时间缩短，自身冰属性伤害提高。消耗的「若雪」标记数量越多，效果数值越高。",
		MaxUseCount = 0,
		id = 1139201,
		EnergyChange = -20,
		desc = {
			101139201
		},
		abilities = {
			1139057
		}
	},
	[1139202] = {
		element_type = 6,
		name = "事象冰封",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "召唤冰柱穿刺锁定的敌人，造成冰属性伤害，对命中的敌人附加冰冻状态，施放技能短暂时间后，可再次点击施放「追加吟唱」。\n「追加吟唱」：在命中的敌人周围产生连续冰爆，造成冰属性伤害，并获得「寒封」标记。\n消耗「寒封」标记数量进入「临渊」状态时，获得以下效果：「事象冰封」剩余冷却时间缩短，被命中的敌人冰属性抗性降低。消耗的「寒封」标记数量越多，效果数值越高。",
		MaxUseCount = 0,
		id = 1139202,
		EnergyChange = -18,
		desc = {
			101139202
		},
		abilities = {
			1139058
		}
	},
	[1139203] = {
		element_type = 6,
		name = "银雪回响",
		cd = 25000,
		strengthen_desc = "",
		simpleDesc = "施放「零度寒芒」或「事象冰封」后，施放该技能会重复施放上一技能并获得对应的标记，该次施放会附加对应技能的「追加吟唱」攻击。拥有<color=#FF9500>2</color>个任意标记时，「银雪回响」会替换为「银雪星霜」。\n「银雪星霜」：施放时消耗所有标记并获得对应效果，向锁定方向发射三道星霜，对路径上的敌人造成冰属性伤害，重置「零度寒芒」和「事象冰封」的冷却时间，进入「临渊」状态。\n「临渊」：状态期间内禁用技能三，无法获得「若雪」或「寒封」标记；施放「零度寒芒」或「事象冰封」时会附加对应技能的「追加吟唱」攻击。",
		MaxUseCount = 0,
		abilities = "",
		id = 1139203,
		EnergyChange = 0,
		desc = {
			101139203
		}
	},
	[1139209] = {
		element_type = 6,
		name = "霜降星陨",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "召唤多个冰柱攻击锁定的敌人，造成冰属性伤害；根据当前拥有的标记的种类和数量，全队伍技能一和技能二的剩余冷却时间缩短。\n\n当敌人被附加冰冻状态时，获得奥义值。",
		MaxUseCount = 0,
		id = 1139209,
		EnergyChange = 0,
		desc = {
			101139209
		},
		abilities = {
			1139060
		}
	},
	[1139305] = {
		element_type = 16,
		name = "流风旋雪",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间。",
		MaxUseCount = 0,
		abilities = "",
		id = 1139305,
		EnergyChange = 0,
		desc = {
			101139305
		}
	},
	[1035101] = {
		element_type = 8,
		name = "狂鳄激潮",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "使用狂鳄对剑快速攻击敌人，造成水属性伤害。\n\n<color=#0068C3>怒气：普通攻击命中后会获得怒气。</color>",
		MaxUseCount = 0,
		id = 1035101,
		EnergyChange = 2,
		desc = {
			101035101
		},
		abilities = {
			1035101
		}
	},
	[1035201] = {
		element_type = 8,
		name = "蛮勇追猎",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "向前冲刺，攻击路径上的敌人，造成水属性伤害。当冲刺结束或者再次点击技能时可施放终结一击，造成水属性伤害。",
		MaxUseCount = 0,
		abilities = "",
		id = 1035201,
		EnergyChange = -30,
		desc = {
			101035201
		}
	},
	[1035202] = {
		element_type = 8,
		name = "圣河咆哮",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "把对剑插入地面，触发六道圆形涌浪攻击周围的敌人，造成水属性伤害。",
		MaxUseCount = 0,
		id = 1035202,
		EnergyChange = -25,
		desc = {
			101035202
		},
		abilities = {
			1035202,
			1035051
		}
	},
	[1035203] = {
		element_type = 8,
		name = "撼流逐浪",
		cd = 10000,
		strengthen_desc = "",
		simpleDesc = "使用两把对剑钳住敌人摔向地面，造成水属性伤害。当敌人无法被抓取时，则直接造成水属性伤害。",
		MaxUseCount = 0,
		id = 1035203,
		EnergyChange = -20,
		desc = {
			101035203
		},
		abilities = {
			1035203,
			1035052,
			1035053
		}
	},
	[1035209] = {
		element_type = 8,
		name = "巨啸龙卷",
		cd = 22000,
		strengthen_desc = "",
		simpleDesc = "跃起并化作一道龙卷砸向敌人，造成水属性伤害；命中时全队伍近战伤害提高。\n\n当人形敌人被击败时，获得奥义值。",
		MaxUseCount = 0,
		id = 1035209,
		EnergyChange = 0,
		desc = {
			101035209
		},
		abilities = {
			1035209
		}
	},
	[1035305] = {
		element_type = 16,
		name = "沼底暗涌",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间；获得怒气。",
		MaxUseCount = 0,
		abilities = "",
		id = 1035305,
		EnergyChange = 0,
		desc = {
			101035305
		}
	},
	[1036101] = {
		element_type = 12,
		name = "精密射击",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		id = 1036101,
		EnergyChange = 3,
		desc = {
			101036101
		},
		abilities = {
			1036101
		}
	},
	[1036201] = {
		element_type = 12,
		name = "叠光强击",
		cd = 7000,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		id = 1036201,
		EnergyChange = -20,
		desc = {
			101036201
		},
		abilities = {
			1036051,
			1036051
		}
	},
	[1036202] = {
		element_type = 12,
		name = "双重散射",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		id = 1036202,
		EnergyChange = -30,
		desc = {
			101036202
		},
		abilities = {
			1036202
		}
	},
	[1036203] = {
		element_type = 12,
		name = "破袭之矢",
		cd = 14000,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		id = 1036203,
		EnergyChange = -50,
		desc = {
			101036203
		},
		abilities = {
			1036203
		}
	},
	[1036231] = {
		element_type = 12,
		name = "闪耀冲击",
		cd = 14000,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		id = 1036231,
		EnergyChange = -30,
		desc = {
			101036231
		},
		abilities = {
			1036231
		}
	},
	[1036209] = {
		element_type = 12,
		name = "星辰破晓",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		id = 1036209,
		EnergyChange = 0,
		desc = {
			101036209
		},
		abilities = {
			1036054
		}
	},
	[1036305] = {
		element_type = 16,
		name = "羽烁流光",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 2,
		abilities = "",
		id = 1036305,
		EnergyChange = 0,
		desc = {
			101036305
		}
	},
	[1037101] = {
		element_type = 10,
		name = "精密射击",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
对锁定的敌人进行连续射击，造成暗属性伤害。

被动：
自身与敌人距离越远，造成的伤害越高。

<color=#0068C3>怒气：普通攻击命中后会获得怒气。</color>]],
		MaxUseCount = 0,
		id = 1037101,
		EnergyChange = 3,
		desc = {
			101037101
		},
		abilities = {
			1037101
		}
	},
	[1037201] = {
		element_type = 10,
		name = "瞬影幽光",
		cd = 7000,
		strengthen_desc = "",
		simpleDesc = "向后跳跃并向目标敌人发射两团幽光，造成暗属性伤害。",
		MaxUseCount = 0,
		id = 1037201,
		EnergyChange = -20,
		desc = {
			101037201
		},
		abilities = {
			1037051,
			1037051
		}
	},
	[1037202] = {
		element_type = 10,
		name = "双重散射",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "快速发射两波箭雨，对周围敌人造成暗属性伤害。",
		MaxUseCount = 0,
		id = 1037202,
		EnergyChange = -30,
		desc = {
			101037202
		},
		abilities = {
			1037202
		}
	},
	[1037203] = {
		element_type = 10,
		name = "破袭之矢",
		cd = 14000,
		strengthen_desc = "",
		simpleDesc = "进行三次范围性的散射后，再次拉弓对目标进行一次精准射击，造成暗属性伤害。",
		MaxUseCount = 0,
		id = 1037203,
		EnergyChange = -50,
		desc = {
			101037203
		},
		abilities = {
			1037203
		}
	},
	[1037231] = {
		element_type = 10,
		name = "幽离冲击",
		cd = 14000,
		strengthen_desc = "",
		simpleDesc = "使用手套装置进行强力攻击，造成暗属性伤害。",
		MaxUseCount = 0,
		id = 1037231,
		EnergyChange = -50,
		desc = {
			101037231
		},
		abilities = {
			1037231
		}
	},
	[1037209] = {
		element_type = 10,
		name = "永夜流星",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "跃向空中，对目标敌人进行一次强力射击，造成暗属性伤害；全队伍获得怒气，自身根据距离获得的被动加成效果达到最高。\n\n自身或者队友触发零时空间时，获得奥义值。",
		MaxUseCount = 0,
		id = 1037209,
		EnergyChange = 0,
		desc = {
			101037209
		},
		abilities = {
			1037054
		}
	},
	[1037305] = {
		element_type = 16,
		name = "幽暗庇护",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间。",
		MaxUseCount = 2,
		abilities = "",
		id = 1037305,
		EnergyChange = 0,
		desc = {
			101037305
		}
	},
	[1027101] = {
		element_type = 6,
		name = "重锚挥击",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "连续使用船锚打击敌人，造成冰属性伤害。",
		MaxUseCount = 0,
		id = 1027101,
		EnergyChange = 0,
		desc = {
			101027101
		},
		abilities = {
			1027101
		}
	},
	[1027201] = {
		element_type = 6,
		name = "冒失猛撞",
		cd = 7000,
		strengthen_desc = "",
		simpleDesc = "向目标突进并打击敌人，造成冰属性伤害。\n\n<color=#0068C3>印记：每次施放命中后，获得印记。</color>",
		MaxUseCount = 0,
		id = 1027201,
		EnergyChange = 1,
		desc = {
			101027201
		},
		abilities = {
			1027201
		}
	},
	[1027202] = {
		element_type = 6,
		name = "旋冰之弧",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = "挥舞船锚对目标进行一次重击，造成冰属性伤害。可通过长按进行蓄力；当目标敌人在施放技能时处于冰冻状态，可直接达到满蓄力状态。\n\n<color=#0068C3>印记：每次施放命中后，获得印记。</color>",
		MaxUseCount = 0,
		abilities = "",
		id = 1027202,
		EnergyChange = 1,
		desc = {
			101027202
		}
	},
	[1027221] = {
		element_type = 6,
		name = "暴风反击",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "触发闪避效果后，或在闪避效果未处于冷却状态且受身成功后的一段时间内，当反击目标处于攻击范围内时，点击普通攻击会使用重锚施放强力反击，造成冰属性伤害，对命中的敌人附加冰冻状态。\n受身也可以触发闪避效果，并且不会使闪避效果进入冷却状态。\n闪避效果：冰属性伤害提高，下次命中后移除。",
		MaxUseCount = 0,
		abilities = "",
		id = 1027221,
		EnergyChange = 0,
		desc = {
			101027221
		}
	},
	[1027203] = {
		element_type = 6,
		name = "冰刺重击",
		cd = 13000,
		strengthen_desc = "",
		simpleDesc = "挥击船锚向前方击打出一排冰刺，造成冰属性伤害，对命中的敌人附加冰冻状态。",
		MaxUseCount = 0,
		id = 1027203,
		EnergyChange = -3,
		desc = {
			101027203
		},
		abilities = {
			1027203,
			1027051
		}
	},
	[1027209] = {
		element_type = 6,
		name = "极冰鲸跃",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "潜入地下并向锁定的敌人移动，到达目标点后跃起攻击，造成冰属性伤害；命中时对命中的敌人附加冰冻状态。\n\n当敌人被附加冰冻状态时，获得奥义值。",
		MaxUseCount = 0,
		abilities = "",
		id = 1027209,
		EnergyChange = 0,
		desc = {
			101027209
		}
	},
	[1027305] = {
		element_type = 16,
		name = "凌雪折光",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：冰属性伤害提高，下次命中后移除。",
		MaxUseCount = 2,
		abilities = "",
		id = 1027305,
		EnergyChange = 0,
		desc = {
			101027305
		}
	},
	[1127101] = {
		element_type = 8,
		name = "涌浪打击",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "挥舞逆潮鲸歌，与海兽眷属协同进攻敌人，造成水属性伤害。\n\n<color=#0068C3>印记：普通攻击每命中一定次数，获得印记。</color>",
		MaxUseCount = 0,
		id = 1127101,
		EnergyChange = 0,
		desc = {
			101127101
		},
		abilities = {
			1127101
		}
	},
	[1127201] = {
		element_type = 8,
		name = "海兽跃袭",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = [[
向前挥出一道奔涌的海流，随后召唤出海兽眷属从海流末端跃出突袭，造成水属性伤害。施放时获得「逆潮」标记；「海兽跃袭」每段命中时，治疗效果提高；「海兽跃袭」的伤害会根据自身治疗效果的提高而提高。
「逆潮」标记被消耗时，加成效果会在一定时间后移除。

<color=#0068C3>印记：每次施放命中后，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1127201,
		EnergyChange = 1,
		desc = {
			101127201
		},
		abilities = {
			1127052,
			1127053
		}
	},
	[1127202] = {
		element_type = 8,
		name = "鲸歌唤潮",
		cd = 18000,
		strengthen_desc = "",
		simpleDesc = [[
展开权钥在原地召唤两只海兽眷属，海兽眷属存续期间，造成水属性范围伤害。施放时获得「鲸歌」标记；「鲸歌唤潮」每段命中时，会心伤害提高；「鲸歌唤潮」的伤害会根据自身会心伤害的提高而提高。
「鲸歌」标记被消耗后，加成效果会在一定时间后移除。

<color=#0068C3>印记：每次施放命中后，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1127202,
		EnergyChange = 1,
		desc = {
			101127202
		},
		abilities = {
			1127055
		}
	},
	[1127203] = {
		element_type = 8,
		name = "暗潮之力",
		cd = 16000,
		strengthen_desc = "",
		simpleDesc = [[
印记不满时，点击施放获得印记。自身印记为满时，「暗潮之力」会替换为「深海愈疗」。
「深海愈疗」：解放权钥的力量展开愈疗之环，消耗全部印记，恢复附近所有友方生命值。施放「深海愈疗」时会消耗全部标记，并获得额外的技能效果。
消耗「逆潮」标记时，对锁定的敌人造成伤害，该次伤害会根据自身治疗效果的提高而提高。
消耗「鲸歌」标记时，附近所有友方受到的伤害降低，受到的伤害降低会根据自身会心伤害的提高而提高。]],
		MaxUseCount = 0,
		id = 1127203,
		EnergyChange = 0,
		desc = {
			101127203
		},
		abilities = {
			1127058
		}
	},
	[1127209] = {
		element_type = 8,
		name = "眷属加护",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "召唤海洋的力量守护同伴，使全队伍受到的伤害降低。一定时间内「深海愈疗」不会进入冷却，并且下一次施放「深海愈疗」后获得印记。\n\n自身或者队友受到治疗时，获得奥义值。",
		MaxUseCount = 0,
		abilities = "",
		id = 1127209,
		EnergyChange = 0,
		desc = {
			101127209
		}
	},
	[1127305] = {
		element_type = 16,
		name = "海蜃折光",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间。",
		MaxUseCount = 2,
		abilities = "",
		id = 1127305,
		EnergyChange = 0,
		desc = {
			101127305
		}
	},
	[1028101] = {
		element_type = 14,
		name = "轰雷鸣击",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
挥舞「妙尔尼尔」连续攻击，造成雷属性伤害。在施放衍生技能后衔接普通攻击，会从普通攻击第四段开始攻击，衔接施放时获得硬直效果。

被动：
每段普通攻击命中和每次施放技能命中时会获得「雷势」，「雷势」会随时间消耗，根据「雷势」提高自身独立伤害。
施放衍生技能时进入「狂雷」状态，并根据「雷势」延长状态持续时间。
「狂雷」：进入时获得短暂的无敌效果，状态期间「雷势」不会自动消耗，雷属性伤害提高。

<color=#0068C3>印记：普通攻击第五段命中敌人后，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1028101,
		EnergyChange = 0,
		desc = {
			101028101
		},
		abilities = {
			1028101
		}
	},
	[1028201] = {
		element_type = 14,
		name = "大地的奔雷",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = [[
挥舞「妙尔尼尔」朝目标方向突进，造成雷属性伤害。施放后的短暂时间内，该技能会替换为衍生技能「奔雷击」；「奔雷击」仅衔接在「大地的奔雷」之后才可施放。
「奔雷击」：挥舞「妙尔尼尔」攻击周围的敌人，消耗印记，造成雷属性伤害。

<color=#0068C3>印记：施放「大地的奔雷」命中后，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1028201,
		EnergyChange = 1,
		desc = {
			101028201
		},
		abilities = {
			1028201
		}
	},
	[1028202] = {
		element_type = 14,
		name = "远海的风雷",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = [[
大力挥舞「妙尔尼尔」，短暂聚集附近的敌人，造成雷属性伤害。施放后的短暂时间内，该技能会替换为衍生技能「风雷击」；「风雷击」仅衔接在「远海的风雷」之后才可施放。
「风雷击」：旋转「妙尔尼尔」后锤击地面，消耗印记，造成雷属性伤害。

<color=#0068C3>印记：施放「远海的风雷」命中后，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1028202,
		EnergyChange = 1,
		desc = {
			101028202
		},
		abilities = {
			1028202
		}
	},
	[1028203] = {
		element_type = 14,
		name = "深空的落雷",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = [[
挥舞「妙尔尼尔」猛烈锤击地面，造成雷属性伤害。施放后的短暂时间内，该技能会替换为衍生技能「落雷击」；「落雷击」仅衔接在「深空的落雷」之后才可施放。
「落雷击」：挥舞「妙尔尼尔」再次猛击地面，消耗印记，造成雷属性伤害。

<color=#0068C3>印记：施放「深空的落雷」命中后，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1028203,
		EnergyChange = 1,
		desc = {
			101028203
		},
		abilities = {
			1028203
		}
	},
	[1028209] = {
		element_type = 14,
		name = "黄昏的怒雷",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = [[
召唤出铁手套「雅恩格利佩尔」，释放怒雷之力。自身进入「怒雷」状态，全队伍印记型修正者技能伤害提高。
「怒雷」：状态期间免疫一切控制与伤害并禁用移动、技能和闪避，「雷势」提供的加成效果达到最高。清空「雷势」并不再自动消耗，之后间歇获得「雷势」。连续点击攻击键会使用铁手套连续施放技能攻击，造成雷属性伤害。攻击第二段会在前方产生五道落雷，「雷势」为满值时会自动施放最后一拳，之后退出「怒雷」状态。

自身或者队友成功消耗印记时，根据消耗的印记数量，获得奥义值。]],
		MaxUseCount = 0,
		id = 1028209,
		EnergyChange = 0,
		desc = {
			101028209
		},
		abilities = {
			1028209
		}
	},
	[1028305] = {
		element_type = 16,
		name = "雷光远遁",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "获得「雷势」；极限闪避后衔接普通攻击，会从普通攻击第四段开始攻击，衔接施放时获得硬直效果。\n闪避效果：零时空间。",
		MaxUseCount = 0,
		abilities = "",
		id = 1028305,
		EnergyChange = 0,
		desc = {
			101028305
		}
	},
	[1019101] = {
		element_type = 2,
		name = "枪斗乱舞",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "挥舞长枪，对前方敌人进行攻击，造成风属性伤害。",
		MaxUseCount = 0,
		id = 1019101,
		EnergyChange = 0,
		desc = {
			101019101
		},
		abilities = {
			1019101
		}
	},
	[1019201] = {
		element_type = 2,
		name = "翼神穿刺",
		cd = 10000,
		strengthen_desc = "",
		simpleDesc = "凌空跃起，挥舞长枪对敌人进行攻击，造成风属性伤害，并在落地后于前方召唤「风神之柱」，造成风属性伤害。\n\n<color=#0068C3>印记：每次施放命中后，获得印记。</color>",
		MaxUseCount = 0,
		id = 1019201,
		EnergyChange = 1,
		desc = {
			101019201
		},
		abilities = {
			1019201,
			1019053,
			1019053,
			1019053
		}
	},
	[1019202] = {
		element_type = 2,
		name = "涌动之风",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "在前方召唤一道向前快速移动的飓风，造成风属性伤害。\n\n<color=#0068C3>印记：每次施放命中后，获得印记。</color>",
		MaxUseCount = 0,
		id = 1019202,
		EnergyChange = 1,
		desc = {
			101019202
		},
		abilities = {
			1019062
		}
	},
	[1019203] = {
		element_type = 2,
		name = "破势",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = "根据施放时消耗的印记数量对敌人造成风属性伤害。",
		MaxUseCount = 0,
		id = 1019203,
		EnergyChange = -1,
		desc = {
			101019203
		},
		abilities = {
			1019203
		}
	},
	[1019233] = {
		element_type = 2,
		name = "破军",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = "根据施放时消耗的印记数量对敌人造成风属性伤害，当只命中一个敌人时，该技能会心率、会心伤害提高。",
		MaxUseCount = 0,
		id = 1019233,
		EnergyChange = -1,
		desc = {
			101019233
		},
		abilities = {
			1019233
		}
	},
	[1019305] = {
		element_type = 16,
		name = "疾风流转",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：使周围敌人朝自身所在位置聚拢并打断敌人的攻击。",
		MaxUseCount = 2,
		abilities = "",
		id = 1019305,
		EnergyChange = 0,
		desc = {
			101019305
		}
	},
	[1019209] = {
		element_type = 2,
		name = "风蚀螺旋枪",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "进行一定距离的突刺，对路径上的敌人进行攻击，造成风属性伤害；施放后修正等级提高至<color=#FF9500>Ω</color>级。当施放「风蚀螺旋枪」击败敌人时，进入零时空间。\n\n自身或者队友成功消耗印记时，获得奥义值。",
		MaxUseCount = 0,
		id = 1019209,
		EnergyChange = 2,
		desc = {
			101019209
		},
		abilities = {
			1019209
		}
	},
	[1119101] = {
		element_type = 14,
		name = "双枪轮舞",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
连续舞动双枪攻击敌人，造成雷属性伤害。

被动：
自身雷属性伤害会根据自身风属性伤害的提高而提高。

<color=#0068C3>怒气：普通攻击命中后会获得怒气。</color>]],
		MaxUseCount = 0,
		id = 1119101,
		EnergyChange = 3,
		desc = {
			101119101
		},
		abilities = {
			1119101
		}
	},
	[1119201] = {
		element_type = 14,
		name = "风雷易势",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = [[
挥舞长枪，造成雷属性伤害，在进攻姿态和防御姿态之间进行切换。
无论「风雷易势」是否处于冷却、是否替换为「风雷流转」，在施放「雷鸣风啸」、「奔雷疾风」、「风雷流转」或者追击、反击的过程中可以直接点击该技能进行姿态切换。
处于防御姿态时，在施放「雷鸣风啸」、「奔雷疾风」过程中受击时会格挡当前的伤害并触发反击，反击造成雷属性伤害，命中后获得「惊岚」标记。
当标记为满时，「风雷易势」会替换为「风雷流转」。
「风雷流转」：消耗全部标记，造成雷属性伤害。]],
		MaxUseCount = 0,
		id = 1119201,
		EnergyChange = 0,
		desc = {
			101119201
		},
		abilities = {
			1119201
		}
	},
	[1119202] = {
		element_type = 14,
		name = "雷鸣风啸",
		cd = 10000,
		strengthen_desc = "",
		simpleDesc = "挥舞双枪向前突进，随后向敌人发动猛烈的连续突刺，造成雷属性伤害。处于进攻姿态时，命中后会开启一次追击，之后若切换成防御姿态则会关闭追击，追击造成雷属性伤害，命中后获得「雷引」标记。",
		MaxUseCount = 0,
		id = 1119202,
		EnergyChange = -25,
		desc = {
			101119202
		},
		abilities = {
			1119202
		}
	},
	[1119203] = {
		element_type = 14,
		name = "奔雷疾风",
		cd = 10000,
		strengthen_desc = "",
		simpleDesc = "赋予双枪雷电神力后进行大范围的挥舞攻击，随后将双枪幻化为十几道带有雷电神力的幻影，从上方落下打击敌人，造成雷属性伤害。处于进攻姿态时，命中后会开启一次追击，之后若切换成防御姿态则会关闭追击，追击造成雷属性伤害，命中后获得「雷引」标记。",
		MaxUseCount = 0,
		id = 1119203,
		EnergyChange = -25,
		desc = {
			101119203
		},
		abilities = {
			1119203
		}
	},
	[1119209] = {
		element_type = 14,
		name = "风雷破空",
		cd = 25000,
		strengthen_desc = "",
		simpleDesc = "造成雷属性伤害；命中后全队伍机制值获取率提高，每次普通攻击命中敌人时，会心伤害提高，机制值获取率提高的加成结束时会心伤害加成移除。\n\n自身或者队友成功消耗机制值时，获得奥义值。",
		MaxUseCount = 0,
		id = 1119209,
		EnergyChange = 0,
		desc = {
			101119209
		},
		abilities = {
			1119209
		}
	},
	[1119305] = {
		element_type = 16,
		name = "风影雷闪",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：获得怒气。",
		MaxUseCount = 0,
		abilities = "",
		id = 1119305,
		EnergyChange = 0,
		desc = {
			101119305
		}
	},
	[1011101] = {
		element_type = 0,
		name = "虚冥连斩",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "连续挥动镰刀斩击敌人，造成物理伤害。",
		MaxUseCount = 0,
		id = 1011101,
		EnergyChange = 0,
		desc = {
			101011101
		},
		abilities = {
			1011101
		}
	},
	[1011201] = {
		element_type = 0,
		name = "禁忌灾刃",
		cd = 11000,
		strengthen_desc = "",
		simpleDesc = [[
使用镰刀连斩，造成物理伤害。「禁忌灾刃」处于冷却状态时，可再次点击并额外施放一次；该次施放的「禁忌灾刃」会损耗自身部分生命值，并造成更高的伤害，获得奥义值；每次冷却时间内最多额外施放一次「禁忌灾刃」。
「禁忌灾刃」不会打断普通攻击的连段。

<color=#0068C3>印记：每次施放命中后，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1011201,
		EnergyChange = 1,
		desc = {
			101011201
		},
		abilities = {
			1011201
		}
	},
	[1011202] = {
		element_type = 0,
		name = "狱镰回旋",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "向目标抛出镰刀并收回，造成物理伤害。\n\n<color=#0068C3>印记：每次施放命中后，获得印记。</color>",
		MaxUseCount = 0,
		id = 1011202,
		EnergyChange = 1,
		desc = {
			101011202
		},
		abilities = {
			1011051
		}
	},
	[1011203] = {
		element_type = 0,
		name = "断罪之镰",
		cd = 14000,
		strengthen_desc = "",
		simpleDesc = "向锁定的敌人施放强力的斩击，造成物理伤害。当该技能击败敌人时，恢复自身生命值。",
		MaxUseCount = 0,
		id = 1011203,
		EnergyChange = -4,
		desc = {
			101011203
		},
		abilities = {
			1011203
		}
	},
	[1011209] = {
		element_type = 0,
		name = "魂之轮舞",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "跃起甩出镰刀并收回，造成物理伤害；每段攻击造成伤害后，恢复生命值。\n\n自身或者队友受击时，获得奥义值。",
		MaxUseCount = 0,
		id = 1011209,
		EnergyChange = 0,
		desc = {
			101011209
		},
		abilities = {
			1011209
		}
	},
	[1011305] = {
		element_type = 16,
		name = "冥海涟漪",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间。",
		MaxUseCount = 2,
		abilities = "",
		id = 1011305,
		EnergyChange = 0,
		desc = {
			101011305
		}
	},
	[1013101] = {
		element_type = 4,
		name = "炎拳千崩",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
连续攻击锁定目标，造成火属性伤害。
「虚炎行空」：可通过长按普通攻击施放该技能。施放直线攻击，造成火属性伤害。处于「缚炎」状态时，使命中的敌人火属性抗性降低。
强化「虚炎行空」：每次「缚炎」状态结束后，下一次的「虚炎行空」会获得强化，可通过长按普通攻击施放该强化技能。释放重拳，造成火属性伤害。
「虚炎行空」不会打断普通攻击的连段。

<color=#0068C3>能量：间歇获得能量。</color>]],
		MaxUseCount = 0,
		id = 1013101,
		EnergyChange = 0,
		desc = {
			101013101
		},
		abilities = {
			1013051
		}
	},
	[1013111] = {
		element_type = 4,
		name = "炎拳千崩",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
连续攻击锁定目标，造成火属性伤害。
「虚炎行空」：可通过长按普通攻击施放该技能。施放直线攻击，造成火属性伤害。处于「缚炎」状态时，使命中的敌人火属性抗性降低。
强化「虚炎行空」：进入或延长「缚炎」状态时，下一次的「虚炎行空」会获得强化，并且仅处于「缚炎」状态时才可通过长按普通攻击施放该强化技能。把释放的火焰地涌转为对目标的小范围攻击，造成火属性伤害，获得能量，使命中的敌人火属性抗性降低。
「虚炎行空」不会打断普通攻击的连段。

<color=#0068C3>能量：间歇获得能量。</color>]],
		MaxUseCount = 0,
		abilities = "",
		id = 1013111,
		EnergyChange = 0,
		desc = {
			101013111
		}
	},
	[1013201] = {
		element_type = 4,
		name = "咫尺天威",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "进入「缚炎」状态，火属性伤害提高。穿越一定距离，从锁定的敌人周围攻击目标，造成火属性伤害。",
		MaxUseCount = 0,
		id = 1013201,
		EnergyChange = -18,
		desc = {
			101013201
		},
		abilities = {
			1013061
		}
	},
	[1013202] = {
		element_type = 4,
		name = "浮屠困囚",
		cd = 25000,
		strengthen_desc = "",
		simpleDesc = "进入「缚炎」状态，火属性伤害提高。施放力场球束缚范围内敌人，力场球爆炸后对周围敌人造成火属性伤害。",
		MaxUseCount = 0,
		id = 1013202,
		EnergyChange = -35,
		desc = {
			101013202
		},
		abilities = {
			1013062
		}
	},
	[1013203] = {
		element_type = 4,
		name = "擎天撼地",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "进入「缚炎」状态，火属性伤害提高。在锁定的敌人下方制造一道地裂，聚拢周围的敌人，之后对范围内的敌人进行攻击，造成火属性伤害。",
		MaxUseCount = 0,
		id = 1013203,
		EnergyChange = -30,
		desc = {
			101013203
		},
		abilities = {
			1013063
		}
	},
	[1013209] = {
		element_type = 4,
		name = "燎天业火",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "跃起后使用障月砸击目标地面，对范围内的敌人造成火属性伤害；命中时，被命中的敌人火属性抗性降低。\n\n自身或者队友触发零时空间时，获得奥义值。",
		MaxUseCount = 0,
		id = 1013209,
		EnergyChange = 0,
		desc = {
			101013209
		},
		abilities = {
			1013065
		}
	},
	[1013305] = {
		element_type = 16,
		name = "临战应变",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间。",
		MaxUseCount = 2,
		abilities = "",
		id = 1013305,
		EnergyChange = 0,
		desc = {
			101013305
		}
	},
	[1056101] = {
		element_type = 14,
		name = "雷武真拳",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
连续使用拳脚对目标进行攻击，造成雷属性伤害。
施放「神怒·踏鸣」或「神怒·雷织」命中时，「雷武真拳」获得强化效果。
强化的「雷武真拳」最后一段攻击会额外召唤一道落雷对范围内的敌人进行攻击，造成雷属性伤害。

<color=#0068C3>能量：间歇获得能量。</color>]],
		MaxUseCount = 0,
		id = 1056101,
		EnergyChange = 0,
		desc = {
			101056101
		},
		abilities = {
			1056101
		}
	},
	[1056201] = {
		element_type = 14,
		name = "神怒·踏鸣",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "对锁定的敌人使用两段踢击，造成雷属性伤害。\n普通攻击最后一段命中时、施放「神怒·千雳」命中时，该技能获得强化效果。\n强化的「神怒·踏鸣」第二段踢击对会对命中的敌人附加眩晕状态。",
		MaxUseCount = 0,
		id = 1056201,
		EnergyChange = -30,
		desc = {
			101056201
		},
		abilities = {
			1056201
		}
	},
	[1056202] = {
		element_type = 14,
		name = "神怒·雷织",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "对锁定的敌人发动连续的踢击，造成雷属性伤害。\n普通攻击最后一段命中时、施放「神怒·千雳」命中时，该技能获得强化效果。\n强化的「神怒·雷织」可通过连点增加额外踢击次数。",
		MaxUseCount = 0,
		id = 1056202,
		EnergyChange = -30,
		desc = {
			101056202
		},
		abilities = {
			1056202
		}
	},
	[1056203] = {
		element_type = 14,
		name = "神怒·千雳",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "对锁定的敌人发动连续的攻击，造成雷属性伤害，最后再打出一拳，再次造成雷属性伤害。\n施放「神怒·踏鸣」或「神怒·雷织」命中时，该技能获得强化效果。\n强化的「神怒·千雳」最后一拳会自动进行满段蓄力，再次点击或者满蓄力时会施放，根据该技能蓄力段数造成不同的雷属性伤害。",
		MaxUseCount = 0,
		id = 1056203,
		EnergyChange = -30,
		desc = {
			101056203
		},
		abilities = {
			1056203,
			1056052,
			1056053,
			1056054
		}
	},
	[1056209] = {
		element_type = 14,
		name = "轰雷一闪",
		cd = 25000,
		strengthen_desc = "",
		simpleDesc = "蓄积雷电后向目标方向轰击，造成雷属性伤害；施放时全队伍能量型修正者的伤害提高。\n\n自身或者队友触发闪避效果时，获得奥义值。",
		MaxUseCount = 0,
		id = 1056209,
		EnergyChange = 0,
		desc = {
			101056209
		},
		abilities = {
			1056209
		}
	},
	[1056305] = {
		element_type = 16,
		name = "神怒·空舞",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "「神怒·千雳」蓄力期间，极限闪避时会保留已完成的蓄力段数，未受击时可以点击继续蓄力。\n闪避效果：零时空间。",
		MaxUseCount = 0,
		abilities = "",
		id = 1056305,
		EnergyChange = 0,
		desc = {
			101056305
		}
	},
	[1058101] = {
		element_type = 4,
		name = "绯狱舞炎",
		cd = 0,
		simpleDesc = [[
连续斩击敌人，造成火属性伤害。每次攻击命中，自身受到的伤害降低。

被动：
技能命中后一定时间内，下一次点击普通攻击会施放技能「绯狱舞炎·改」。
「绯狱舞炎·改」：造成火属性伤害。施放后自身获得硬直效果。「绯狱舞炎·改」每命中<color=#FF9500>3</color>次，会触发技能「绯狱舞炎·炎爆」。
「绯狱舞炎·炎爆」：造成火属性伤害。

<color=#0068C3>能量：间歇获得能量；「绯狱舞炎·改」命中时获得能量。</color>]],
		MaxUseCount = 0,
		id = 1058101,
		EnergyChange = 0,
		desc = {
			101058101
		},
		strengthen_desc = {
			105821,
			211058101
		},
		abilities = {
			1058101
		}
	},
	[1058201] = {
		element_type = 4,
		name = "烬祸·焚涅",
		cd = 12000,
		simpleDesc = "释放两次横扫，造成火属性伤害。\n处于「染火」状态时，「烬祸·焚涅」施放后会替换为衍生技能「秘剑·焚涅」。\n「秘剑·焚涅」：进行一次上撩攻击，造成火属性伤害。",
		MaxUseCount = 0,
		id = 1058201,
		EnergyChange = -20,
		desc = {
			101058201
		},
		strengthen_desc = {
			105822,
			211058201
		},
		abilities = {
			1058201
		}
	},
	[1058202] = {
		element_type = 4,
		name = "烬祸·牙突",
		cd = 12000,
		simpleDesc = "向锁定的敌人突刺，造成火属性伤害。\n处于「染火」状态时，「烬祸·牙突」施放后会替换为衍生技能「秘剑·牙突」。\n「秘剑·牙突」：进行两次交叉斩，造成火属性伤害。",
		MaxUseCount = 0,
		id = 1058202,
		EnergyChange = -20,
		desc = {
			101058202
		},
		strengthen_desc = {
			105823,
			211058202
		},
		abilities = {
			1058202
		}
	},
	[1058203] = {
		element_type = 4,
		name = "烬祸·熔火",
		cd = 24000,
		simpleDesc = "挥舞大太刀上挑并施放一道刀波，造成火属性伤害，自身进入「染火」状态，并重置「烬祸·焚涅」和「烬祸·牙突」的冷却时间。\n「染火」：每段普通攻击都视为施放技能。",
		MaxUseCount = 0,
		id = 1058203,
		EnergyChange = -20,
		desc = {
			101058203
		},
		strengthen_desc = {
			105824,
			211058203
		},
		abilities = {
			1058203,
			1058051
		}
	},
	[1058209] = {
		element_type = 4,
		name = "苍刃残火",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "挥舞大太刀向周围释放火浪，造成火属性伤害；命中时全队伍火属性伤害提高。\n\n自身或者队友触发闪避效果时，获得奥义值。",
		MaxUseCount = 0,
		id = 1058209,
		EnergyChange = 0,
		desc = {
			101058209
		},
		abilities = {
			1058209
		}
	},
	[1058305] = {
		element_type = 16,
		name = "烬祸·流燐",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "极限闪避时，获得能量。\n闪避效果：零时空间。",
		MaxUseCount = 0,
		abilities = "",
		id = 1058305,
		EnergyChange = 0,
		desc = {
			101058305
		}
	},
	[1059101] = {
		element_type = 12,
		name = "迅矢连射",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
对锁定的敌人进行连续射击，造成光属性伤害。

被动：
每命中敌人一定次数，获得「光矢」标记。

<color=#0068C3>能量：间歇获得能量。</color>]],
		MaxUseCount = 0,
		id = 1059101,
		EnergyChange = 0,
		desc = {
			101059101
		},
		abilities = {
			1059101
		}
	},
	[1059201] = {
		element_type = 12,
		name = "烈阳轰击",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "向后跃起并对目标进行三次射击，造成光属性伤害。",
		MaxUseCount = 0,
		id = 1059201,
		EnergyChange = -20,
		desc = {
			101059201
		},
		abilities = {
			1059201
		}
	},
	[1059202] = {
		element_type = 12,
		name = "耀日光棘",
		cd = 7000,
		strengthen_desc = "",
		simpleDesc = "向敌人冲刺，并进行旋转射击，造成光属性伤害。\n拥有「光矢」标记时，施放「耀日光棘」后的一段时间内，可消耗「光矢」标记，追加一次攻击。\n追加攻击：跃向空中，对目标射出一支光箭，造成光属性伤害。自身处于空中且拥有「光矢」标记时，也可直接衔接施放该追加攻击。",
		MaxUseCount = 0,
		id = 1059202,
		EnergyChange = -15,
		desc = {
			101059202
		},
		abilities = {
			1059202
		}
	},
	[1059203] = {
		element_type = 12,
		name = "辉光交错",
		cd = 14000,
		strengthen_desc = "",
		simpleDesc = "发射四支光箭，每支光箭各自攻击路径上的敌人，造成光属性伤害。\n拥有「光矢」标记时，施放「辉光交错」后一段时间内，可消耗「光矢」标记，追加一次攻击。\n追加攻击：跃向空中，对近处敌人射出一支光箭，造成光属性伤害，对处于中心区域的敌人伤害提高。自身处于空中且拥有「光矢」标记时，也可直接衔接施放该追加攻击。",
		MaxUseCount = 0,
		id = 1059203,
		EnergyChange = -30,
		desc = {
			101059203
		},
		abilities = {
			1059052,
			1059052,
			1059052,
			1059052
		}
	},
	[1059209] = {
		element_type = 12,
		name = "灼尽之光",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "快速向锁定的敌人冲刺，然后跃起发射出一支弹射光箭，造成光属性伤害；自身获得「光矢」标记，全队伍重置闪避效果冷却时间。\n\n自身或者队友触发闪避效果时，获得奥义值。",
		MaxUseCount = 0,
		id = 1059209,
		EnergyChange = 0,
		desc = {
			101059209
		},
		abilities = {
			1059051
		}
	},
	[1059305] = {
		element_type = 16,
		name = "浮光掠影",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间；获得「光矢」标记。",
		MaxUseCount = 0,
		abilities = "",
		id = 1059305,
		EnergyChange = 0,
		desc = {
			101059305
		}
	},
	[1041101] = {
		element_type = 0,
		name = "铃兰剑艺",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
连续挥舞大剑，造成物理伤害。

被动：
「鸣刃」状态时，每段普通攻击后半程会进行「谐律判定」，在合适的时机衔接下一段攻击，即可判定成功，每次判定成功至判定条结束期间，获得硬直效果。普通攻击判定成功时会产生一次「谐律音爆」，对周围的敌人造成伤害。技能判定成功时不会打断普通攻击的连段。

<color=#0068C3>神能：不处于「鸣刃」状态时，普通攻击命中后会获得神能。</color>]],
		MaxUseCount = 0,
		id = 1041101,
		EnergyChange = 0,
		desc = {
			101041101
		},
		abilities = {
			1041101
		}
	},
	[1041201] = {
		element_type = 0,
		name = "和弦三音",
		cd = 6000,
		strengthen_desc = "",
		simpleDesc = "造成物理伤害。「谐律」层数是<color=#FF9500>3</color>的倍数时，造成更高的物理伤害，命中时恢复生命值。「鸣刃」状态期间施放「和弦三音」判定成功时伤害提高。",
		MaxUseCount = 0,
		id = 1041201,
		EnergyChange = 0,
		desc = {
			101041201
		},
		abilities = {
			1041201
		}
	},
	[1041202] = {
		element_type = 0,
		name = "促弦五音",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "造成物理伤害。「谐律」层数是<color=#FF9500>5</color>的倍数时，造成更高的物理伤害，对命中的敌人附加破甲状态。「鸣刃」状态期间施放「促弦五音」判定成功时伤害提高。",
		MaxUseCount = 0,
		id = 1041202,
		EnergyChange = 0,
		desc = {
			101041202
		},
		abilities = {
			1041202
		}
	},
	[1041203] = {
		element_type = 0,
		name = "弦刃协奏",
		cd = 7000,
		strengthen_desc = "",
		simpleDesc = "神能为满时才可施放，施放后对周围敌人造成造成物理伤害，并进入「鸣刃」状态，重置「和弦三音」、「促弦五音」的冷却时间，「弦刃协奏」替换为「急弦七音」。\n「鸣刃」：间歇消耗神能。神能耗完时，退出「鸣刃」状态，之后「弦刃协奏」进入冷却。状态期间施放的「和弦三音」、「促弦五音」、「急弦七音」的后半段也会进行「谐律判定」；每次判定成功都会获得「谐律」；判定未成功时会刷新「谐律」的持续时间。\n「急弦七音」：造成物理伤害。「谐律」层数是<color=#FF9500>7</color>的倍数时，造成更高的物理伤害，每层「谐律」伤害额外提高。施放「急弦七音」判定成功时伤害提高。",
		MaxUseCount = 0,
		id = 1041203,
		EnergyChange = 0,
		desc = {
			101041203
		},
		abilities = {
			1041203
		}
	},
	[1041209] = {
		element_type = 0,
		name = "铃音齐鸣",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "施放时获得满神能，重置「谐律」层数，进入「鸣刃」状态，该次「鸣刃」状态期间普通攻击每次判定成功时，队友周围也会产生一次「谐律音爆」。施放后全队普通攻击伤害提高。\n\n当敌人被附加眩晕状态时，获得奥义值。",
		MaxUseCount = 0,
		abilities = "",
		id = 1041209,
		EnergyChange = 0,
		desc = {
			101041209
		}
	},
	[1041305] = {
		element_type = 0,
		name = "余音游弋",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避不会打断普通攻击的段数；处于「鸣刃」状态时，极限闪避会进行「谐律判定」或重置当前的判定进行一次新的「谐律判定」。\n闪避效果：对攻击者造成物理伤害，并附加眩晕状态。",
		MaxUseCount = 0,
		abilities = "",
		id = 1041305,
		EnergyChange = 0,
		desc = {
			101041305
		}
	},
	[1042101] = {
		element_type = 10,
		name = "冥偶之舞",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
操作两名人偶进行交替攻击，其中琉刻使用利爪，明塔使用拳甲，造成暗属性伤害；当琉刻或明塔不可操作时，会直接用丝线进行攻击，造成暗属性伤害。

被动：
自身神能处于<color=#FF9500>25</color>至<color=#FF9500>75</color>点时，每间歇一段时间获得「冥息」标记，根据「冥息」标记数量，提高自身会心率、会心伤害。

<color=#0068C3>神能：琉刻普通攻击和技能每次命中后消耗神能，明塔普通攻击和技能每次命中后获得神能，琉刻消耗神能和明塔获得神能不受其他属性影响。</color>]],
		MaxUseCount = 0,
		id = 1042101,
		EnergyChange = 0,
		desc = {
			101042101
		},
		abilities = {
			1042051
		}
	},
	[1042201] = {
		element_type = 16,
		name = "冥丝轮转",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "切换操作的人偶，下一次施放「冥偶戏·小序曲」或「冥偶戏·进行曲」时，琉刻和明塔进入「伴舞」状态。「冥息」标记为满时，长按普通攻击消耗全部「冥息」标记，琉刻和明塔进入「共舞」状态。\n「共舞」：自身会心率提高、会心伤害提高、固定伤害提高；琉刻和明塔协同攻击，造成暗属性伤害，期间禁用技能，不会获得「冥息」标记，不会通过琉刻和明塔消耗和获得神能。\n闪避效果不处于冷却状态时，施放「冥丝轮转」时也会使锁定的敌人动作大幅减速，触发后闪避效果会进入冷却。",
		MaxUseCount = 0,
		abilities = "",
		id = 1042201,
		EnergyChange = 0,
		desc = {
			101042201
		}
	},
	[1042202] = {
		element_type = 10,
		name = "冥偶戏·小序曲",
		cd = 6000,
		strengthen_desc = "",
		simpleDesc = "琉刻为当前被操作人偶时，造成暗属性伤害，对命中的敌人附加「暗海」状态。\n明塔为当前被操作人偶时，造成暗属性伤害，对命中的敌人附加「冥泽」状态。\n「伴舞」：「冥偶戏·小序曲」会替换为「冥偶戏·圆舞曲」，琉刻和明塔协同攻击，造成暗属性伤害。",
		MaxUseCount = 0,
		id = 1042202,
		EnergyChange = 0,
		desc = {
			101042202
		},
		abilities = {
			1042055,
			1042065
		}
	},
	[1042203] = {
		element_type = 10,
		name = "冥偶戏·进行曲",
		cd = 6000,
		strengthen_desc = "",
		simpleDesc = "琉刻为当前被操作人偶时，造成暗属性伤害，琉刻会小幅牵引周围敌人。\n明塔为当前被操作人偶时，造成暗属性伤害，明塔会小幅牵引周围敌人。\n「伴舞」：「冥偶戏·进行曲」会替换为「冥偶戏·轮舞曲」，琉刻和明塔协同攻击，造成暗属性伤害。",
		MaxUseCount = 0,
		id = 1042203,
		EnergyChange = 0,
		desc = {
			101042203
		},
		abilities = {
			1042057,
			1042067
		}
	},
	[1042209] = {
		element_type = 10,
		name = "冥偶戏·终幕",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "造成暗属性伤害，且施放奥义时，每隔一段时间触发一次自身神能回到<color=#FF9500>50</color>点的效果；根据「冥息」标记数量，提高全队伍会心率、会心伤害；\n\n自身或者队友造成会心时，获得奥义值。",
		MaxUseCount = 0,
		id = 1042209,
		EnergyChange = 0,
		desc = {
			101042209
		},
		abilities = {
			1042063,
			1042064,
			1042079
		}
	},
	[1042305] = {
		element_type = 16,
		name = "流影移形",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：攻击者动作大幅减速。",
		MaxUseCount = 0,
		abilities = "",
		id = 1042305,
		EnergyChange = 0,
		desc = {
			101042305
		}
	},
	[1038101] = {
		element_type = 4,
		name = "凰炎",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "天后化作数只火凤凰攻击敌人，随着凤凰数量的增加，最后引发范围性的爆炸，造成火属性伤害。",
		MaxUseCount = 0,
		id = 1038101,
		EnergyChange = 0,
		desc = {
			101038101
		},
		abilities = {
			1038101
		}
	},
	[1038201] = {
		element_type = 4,
		name = "圣炎俯冲",
		cd = 8000,
		strengthen_desc = "",
		simpleDesc = "召唤天后沿目标轨迹高速飞行，对路径上的敌人造成火属性伤害。\n\n<color=#0068C3>印记：每次施放命中后，获得印记。</color>",
		MaxUseCount = 1,
		id = 1038201,
		EnergyChange = 1,
		desc = {
			101038201
		},
		abilities = {
			1038051
		}
	},
	[1038202] = {
		element_type = 4,
		name = "炽拥",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "运用权杖在目标脚下造成一次爆破，造成火属性范围伤害。\n\n<color=#0068C3>印记：每次施放命中后，获得印记。</color>",
		MaxUseCount = 1,
		id = 1038202,
		EnergyChange = 1,
		desc = {
			101038202
		},
		abilities = {
			1038064
		}
	},
	[1038221] = {
		element_type = 4,
		name = "灼舞",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "召唤出天后攻击目标，造成火属性伤害，对处于灼烧状态下的敌人伤害提高。\n\n<color=#0068C3>印记：每次施放命中后，获得印记。</color>",
		MaxUseCount = 1,
		id = 1038221,
		EnergyChange = 1,
		desc = {
			101038221
		},
		abilities = {
			1038068
		}
	},
	[1038203] = {
		element_type = 4,
		name = "阳炎风暴",
		cd = 16000,
		strengthen_desc = "",
		simpleDesc = "在周围引发火焰风暴，根据消耗的印记数量对敌人造成火属性伤害。",
		MaxUseCount = 1,
		id = 1038203,
		EnergyChange = -1,
		desc = {
			101038203
		},
		abilities = {
			1038203,
			1038054
		}
	},
	[1038209] = {
		element_type = 4,
		name = "震怒之羽",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "召唤天后在目标的上方聚集敌人，造成火属性伤害。\n\n当敌人被附加灼烧状态时，获得奥义值。",
		MaxUseCount = 1,
		id = 1038209,
		EnergyChange = 0,
		desc = {
			101038209
		},
		abilities = {
			1038053
		}
	},
	[1038305] = {
		element_type = 4,
		name = "流火",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间；对攻击者附加灼烧状态。",
		MaxUseCount = 2,
		abilities = "",
		id = 1038305,
		EnergyChange = 0,
		desc = {
			101038305
		}
	},
	[1084101] = {
		element_type = 0,
		name = "卢恩利刃",
		cd = 0,
		simpleDesc = "挥动卢恩之刃对目标进行连续斩击，造成物理伤害。\n\n<color=#0068C3>神能：普通攻击命中后会获得神能。</color>",
		MaxUseCount = 0,
		id = 1084101,
		EnergyChange = 0,
		desc = {
			101084101
		},
		strengthen_desc = {
			108421,
			211084101
		},
		abilities = {
			1084101
		}
	},
	[1084201] = {
		element_type = 0,
		name = "高速突刺",
		cd = 12000,
		simpleDesc = [[
向前方进行突刺，对沿途敌人造成物理伤害。施放两次后，「高速突刺」会替换为「破晓」。
「破晓」：对沿途敌人造成物理伤害。
该技能命中处于「卢恩标记」状态的敌人结束后，清除「卢恩标记」。

<color=#0068C3>神能：「破晓」命中处于「卢恩标记」状态的敌人时，获得神能。</color>]],
		MaxUseCount = 0,
		id = 1084201,
		EnergyChange = 0,
		desc = {
			101084201
		},
		strengthen_desc = {
			108422,
			211084201
		},
		abilities = {
			1084201
		}
	},
	[1084212] = {
		element_type = 0,
		name = "飓风突刺",
		cd = 12000,
		simpleDesc = [[
向前方进行突刺，对沿途敌人造成物理伤害。施放时自身伤害提高。施放两次后，「飓风突刺」会替换为「启明」。
「启明」：攻击沿途敌人，造成物理伤害。

<color=#0068C3>神能：施放时获得神能；「启明」命中处于「卢恩标记」状态的敌人时，获得神能。</color>]],
		MaxUseCount = 0,
		abilities = "",
		id = 1084212,
		EnergyChange = 0,
		desc = {
			101084212
		},
		strengthen_desc = {
			108425,
			211084212
		}
	},
	[1084202] = {
		element_type = 0,
		name = "迅捷横斩",
		cd = 12000,
		simpleDesc = "向周围敌人进行横斩，造成物理伤害，对命中的敌人附加「卢恩标记」状态，重置技能一的冷却时间。\n自身其他技能对处于「卢恩标记」状态的敌人会心率大幅提高。",
		MaxUseCount = 0,
		id = 1084202,
		EnergyChange = 0,
		desc = {
			101084202
		},
		strengthen_desc = {
			108423,
			211084202
		},
		abilities = {
			1084202
		}
	},
	[1084203] = {
		element_type = 0,
		name = "分光剑影",
		cd = 15000,
		simpleDesc = "施放剑光对敌人进行攻击，造成物理伤害，施放后重置技能一的冷却时间，命中处于「卢恩标记」状态的敌人结束后，清除「卢恩标记」。当神能达到满值时，该技能会替换为「逐光落影」。\n「逐光落影」：消耗全部神能，举剑产生冲击后大范围横斩，造成物理伤害，该技能会心率大幅提高，重置技能一的冷却时间。",
		MaxUseCount = 0,
		id = 1084203,
		EnergyChange = 0,
		desc = {
			101084203
		},
		strengthen_desc = {
			108424,
			211084203
		},
		abilities = {
			1084203
		}
	},
	[1084305] = {
		element_type = 16,
		name = "事象洞悉",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间。",
		MaxUseCount = 2,
		abilities = "",
		id = 1084305,
		EnergyChange = 0,
		desc = {
			101084305
		}
	},
	[1084209] = {
		element_type = 0,
		name = "破却裁断",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "卢恩之刃展开为命运之刃，对目标敌人进行斩击，造成物理伤害；该次奥义攻击修正系数提高。\n\n自身或者队友触发零时空间时，获得奥义值。",
		MaxUseCount = 0,
		id = 1084209,
		EnergyChange = 0,
		desc = {
			101084209
		},
		abilities = {
			1084209
		}
	},
	[1184101] = {
		element_type = 14,
		name = "剑盾猛攻",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "使用剑盾连续攻击敌人，造成雷属性伤害。\n\n<color=#0068C3>神能：普通攻击第三段的盾击命中后，获得神能。</color>",
		MaxUseCount = 0,
		id = 1184101,
		EnergyChange = 0,
		desc = {
			101184101
		},
		abilities = {
			1184101
		}
	},
	[1184201] = {
		element_type = 14,
		name = "盾牌投掷",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "向锁定的敌人挥击并丢出盾牌，挥击对前方敌人造成雷属性伤害，飞盾命中再次造成雷属性伤害。\n\n<color=#0068C3>神能：飞盾每次命中敌人，获得神能。</color>",
		MaxUseCount = 0,
		id = 1184201,
		EnergyChange = 0,
		desc = {
			101184201
		},
		abilities = {
			1184201,
			1184051
		}
	},
	[1184202] = {
		element_type = 14,
		name = "反制打击",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "长按时进行举盾防御并对前方敌人造成雷属性伤害，松开或达到时间上限时会施放一次攻击，造成雷属性伤害。在举盾防御状态下被命中时，会格挡受到的伤害，并施放强力反击，造成雷属性伤害，并进入零时空间。\n\n<color=#0068C3>神能：格挡成功时，获得神能。</color>",
		MaxUseCount = 0,
		id = 1184202,
		EnergyChange = 0,
		desc = {
			101184202
		},
		abilities = {
			1184202
		}
	},
	[1184203] = {
		element_type = 14,
		name = "信念守护",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = "积蓄力量，跃起后向下冲击，消耗全部神能，造成雷属性伤害，给自身施加护盾，根据消耗的神能，护盾值额外提高。",
		MaxUseCount = 0,
		abilities = "",
		id = 1184203,
		EnergyChange = 0,
		desc = {
			101184203
		}
	},
	[1184209] = {
		element_type = 14,
		name = "英勇冲击",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "手持盾牌向锁定的敌人进行冲撞，造成雷属性伤害，同时冲撞路径上存在的敌人，造成雷属性伤害；自身获得神能，全队伍获得奥义值。\n\n自身或者队友触发零时空间时，获得奥义值。",
		MaxUseCount = 0,
		abilities = "",
		id = 1184209,
		EnergyChange = 0,
		desc = {
			101184209
		}
	},
	[1184305] = {
		element_type = 16,
		name = "瞬身回避",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间。",
		MaxUseCount = 0,
		abilities = "",
		id = 1184305,
		EnergyChange = 0,
		desc = {
			101184305
		}
	},
	[1080101] = {
		element_type = 6,
		name = "冰原狩猎",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "连续挥舞战斧攻击敌人，造成冰属性伤害。\n\n<color=#0068C3>怒气：普通攻击命中后会获得怒气。</color>",
		MaxUseCount = 0,
		id = 1080101,
		EnergyChange = 5,
		desc = {
			101080101
		},
		abilities = {
			1080101
		}
	},
	[1080111] = {
		element_type = 6,
		name = "凌霜之牙",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "连续挥舞战斧攻击敌人，造成冰属性伤害。普通攻击时有一定的概率对命中的敌人附加冰冻状态。普通攻击命中处于冰冻状态的敌人时会额外获得怒气。普通攻击命中时，会对一定范围内非自身普通攻击直接命中的敌人造成冰属性技能伤害。\n\n<color=#0068C3>怒气：普通攻击命中后会获得怒气。</color>",
		MaxUseCount = 0,
		abilities = "",
		id = 1080111,
		EnergyChange = 0,
		desc = {
			101080111
		}
	},
	[1080201] = {
		element_type = 6,
		name = "永冻净土",
		cd = 10000,
		strengthen_desc = "",
		simpleDesc = "挥舞战斧攻击周围的敌人，造成冰属性伤害，第二段攻击会对命中的敌人附加冰冻状态。",
		MaxUseCount = 0,
		id = 1080201,
		EnergyChange = -15,
		desc = {
			101080201
		},
		abilities = {
			1080201
		}
	},
	[1080202] = {
		element_type = 6,
		name = "寒潮漩涡",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "身体旋转并舞动战斧，持续攻击周围的敌人，造成冰属性伤害。",
		MaxUseCount = 0,
		abilities = "",
		id = 1080202,
		EnergyChange = -40,
		desc = {
			101080202
		}
	},
	[1080203] = {
		element_type = 6,
		name = "极地猎袭",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "跃起并劈向目标，造成冰属性伤害。施放「极地猎袭」成功击败敌人时，重置该技能的冷却时间。",
		MaxUseCount = 0,
		id = 1080203,
		EnergyChange = -35,
		desc = {
			101080203
		},
		abilities = {
			1080203
		}
	},
	[1080305] = {
		element_type = 16,
		name = "凛冬霜华",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间；冰属性伤害提高。",
		MaxUseCount = 2,
		abilities = "",
		id = 1080305,
		EnergyChange = 0,
		desc = {
			101080305
		}
	},
	[1080209] = {
		element_type = 6,
		name = "雪崩",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "对敌人造成冰属性伤害；命中时，使命中的敌人冰属性抗性降低。\n\n当敌人被附加冰冻状态时，获得的奥义值。",
		MaxUseCount = 0,
		id = 1080209,
		EnergyChange = 0,
		desc = {
			101080209
		},
		abilities = {
			1080209
		}
	},
	[1081101] = {
		element_type = 6,
		name = "斩浪利剑",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
挥动斩浪号上搭载的斩舰刃，配合武装连续进攻敌人，造成冰属性伤害。普通攻击任意一段后都可通过长按衔接施放蓄力技能「霜断」，造成冰属性伤害，且自身不会受到击飞影响。
处于「巡航模式」时，施放普通攻击会自动锁定目标并发射二枚利剑式跟踪导弹，造成冰属性伤害，当锁定的敌人处于冰冻状态时会额外发射二枚利剑式跟踪导弹。

<color=#0068C3>神能：非「巡航模式」时，普通攻击与「霜断」命中后会获得神能；「巡航模式」时，移动与漂移都会获得神能。</color>]],
		MaxUseCount = 0,
		id = 1081101,
		EnergyChange = 0,
		desc = {
			101081101
		},
		abilities = {
			1081101
		}
	},
	[1081201] = {
		element_type = 6,
		name = "破空寒流",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "使用斩舰刃对前方敌人进行高速连斩，造成冰属性伤害，每次施放命中时获得「破冰」标记，根据拥有「破冰」标记的数量，冰属性伤害提高、蓄力技能伤害提高。处于「巡航模式」时，「破空寒流」会替换为「极地冰爆」。\n「极地冰爆」：消耗「破冰」标记向目标发射冻结跟踪导弹，对爆炸范围内的敌人造成冰属性伤害并附加冰冻状态。",
		MaxUseCount = 0,
		id = 1081201,
		EnergyChange = 0,
		desc = {
			101081201
		},
		abilities = {
			1081201
		}
	},
	[1081202] = {
		element_type = 6,
		name = "冰锋闪袭",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = [[
在斩浪号的辅助下高速突进，向前斩出凝聚冰锋的一刀，造成冰属性伤害。处于「巡航模式」时，「冰锋闪袭」会替换为「晶尘飞散」。
「晶尘飞散」：神能为满时才可施放，向锁定的敌人发动一次冲刺攻击，造成冰属性伤害，冲刺过程中会有短暂的闪避，施放后利剑式跟踪导弹的发射速度提高。

<color=#0068C3>神能：「冰锋闪袭」攻击命中后获得神能。</color>]],
		MaxUseCount = 0,
		id = 1081202,
		EnergyChange = 0,
		desc = {
			101081202
		},
		abilities = {
			1081202
		}
	},
	[1081203] = {
		element_type = 6,
		name = "巡航模式",
		cd = 25000,
		strengthen_desc = "",
		simpleDesc = "神能为满时，可消耗全部神能使斩浪号进入「巡航模式」。\n「巡航模式」：获得霸体效果，禁用「大冰川期」。可以通过大幅转向进行漂移快速转向。再次施放该技能或持续时间结束时会退出「巡航模式」并消耗全部神能，随后会短暂潜入冰下并从目标附近跃出，造成冰属性伤害。",
		MaxUseCount = 0,
		abilities = "",
		id = 1081203,
		EnergyChange = 0,
		desc = {
			101081203
		}
	},
	[1081209] = {
		element_type = 6,
		name = "大冰川期",
		cd = 25000,
		strengthen_desc = "",
		simpleDesc = "斩浪号输出力全开，全力运转向斩舰刃供能，短暂蓄力后挥下释放冰霜冲击，对周围敌人造成冰属性伤害；施放时全队伍蓄力技能伤害提高。\n\n当有敌人进入控制抗性状态时，获得奥义值。",
		MaxUseCount = 0,
		id = 1081209,
		EnergyChange = 0,
		desc = {
			101081209
		},
		abilities = {
			1081209
		}
	},
	[1081305] = {
		element_type = 6,
		name = "铁壁潜航",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "非「巡航模式」：\n非移动时长按闪避：消耗闪避值在原地展开屏障，自身受到的伤害降低。屏障持续期间可再次消耗闪避值格挡第一次伤害。当自身拥有「破冰」标记时，成功格挡后的短暂时间内取消点击，会消耗「破冰」标记施放一次「霜断」，该次施放「霜断」期间自身获得无敌效果。\n闪避效果：获得「破冰」标记。",
		MaxUseCount = 0,
		abilities = "",
		id = 1081305,
		EnergyChange = 0,
		desc = {
			101081305
		}
	},
	[1093101] = {
		element_type = 0,
		name = "忍刀千鸟",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
使用忍刀快速斩击，造成物理伤害。
「忍持」：由「天」与「地」两种持组合而成，消耗「忍持」可以施展对应的「忍法」。获得新的「忍持」时会清空已有的「忍持」。当神能为满时，施放「忍法」不会消耗「忍持」而是消耗全部神能。

<color=#0068C3>神能：普通攻击命中后会获得神能。</color>]],
		MaxUseCount = 0,
		id = 1093101,
		EnergyChange = 0,
		desc = {
			101093101
		},
		abilities = {
			1093101
		}
	},
	[1093231] = {
		element_type = 0,
		name = "苦无时雨",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
「忍法」：对周围大范围的敌人进行攻击，造成物理伤害。
消耗「天」与「天」组合的「忍持」施放。

可通过消耗「忍持」施放奥义「真无合参·雨」。对范围内敌人造成物理伤害，使命中的敌人物理抗性降低。]],
		MaxUseCount = 0,
		id = 1093231,
		EnergyChange = 0,
		desc = {
			101093231
		},
		abilities = {
			1093052
		}
	},
	[1093232] = {
		element_type = 14,
		name = "般若惊雷",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
「忍法」：对前方敌人造成雷属性伤害。
消耗「天」与「地」组合的「忍持」施放。

可通过消耗「忍持」施放奥义「真无合参·雷」。对范围内敌人造成雷属性伤害，使命中的敌人雷属性抗性降低。]],
		MaxUseCount = 0,
		id = 1093232,
		EnergyChange = 0,
		desc = {
			101093232
		},
		abilities = {
			1093232
		}
	},
	[1093233] = {
		element_type = 2,
		name = "镰鼬旋风",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
「忍法」：向前方敌人冲刺，造成风属性伤害。
消耗「地」与「天」组合的「忍持」施放。

可通过消耗「忍持」施放奥义「真无合参·风」。对范围内敌人造成风属性伤害，使命中的敌人风属性抗性降低。]],
		MaxUseCount = 0,
		abilities = "",
		id = 1093233,
		EnergyChange = 0,
		desc = {
			101093233
		}
	},
	[1093236] = {
		element_type = 4,
		name = "地爆界法",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
「忍法」：引爆目标敌人，造成火属性伤害，并在目标身上留下间歇爆破造成火属性伤害的界阵。
消耗「地」与「地」组合的「忍持」施放。

可通过消耗「忍持」施放奥义「真无合参·火」。对范围内敌人造成火属性伤害，使命中的敌人火属性抗性降低。]],
		MaxUseCount = 0,
		id = 1093236,
		EnergyChange = 0,
		desc = {
			101093236
		},
		abilities = {
			1093051,
			1093055,
			1093055,
			1093055,
			1093055,
			1093055,
			1093055,
			1093055,
			1093055
		}
	},
	[1093305] = {
		element_type = 16,
		name = "神隐",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间。\n\n自身或者队友触发零时空间时，获得奥义值。",
		MaxUseCount = 2,
		abilities = "",
		id = 1093305,
		EnergyChange = 0,
		desc = {
			101093305
		}
	},
	[1094101] = {
		element_type = 10,
		name = "魔弹之舞",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "展开魔铳，对锁定的敌人进行连续射击，造成暗属性伤害。\n\n<color=#0068C3>神能：普通攻击命中后会获得神能。</color>",
		MaxUseCount = 0,
		id = 1094101,
		EnergyChange = 0,
		desc = {
			101094101
		},
		abilities = {
			1094101
		}
	},
	[1094201] = {
		element_type = 10,
		name = "噩梦收割",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = "展开魔铳，对前方范围内的敌人进行扫射，造成暗属性伤害。\n\n<color=#0068C3>神能：每次施放命中后会获得神能。</color>",
		MaxUseCount = 0,
		id = 1094201,
		EnergyChange = 0,
		desc = {
			101094201
		},
		abilities = {
			1094201
		}
	},
	[1094202] = {
		element_type = 10,
		name = "冥灵爆破",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = "迟钝转变为魔炮形态，向锁定方向进行一次炮击，造成暗属性伤害。\n\n<color=#0068C3>神能：每次施放命中后会获得点神能。</color>",
		MaxUseCount = 0,
		id = 1094202,
		EnergyChange = 0,
		desc = {
			101094202
		},
		abilities = {
			1094202,
			1094052
		}
	},
	[1094203] = {
		element_type = 10,
		name = "归灭裁定",
		cd = 5000,
		strengthen_desc = "",
		simpleDesc = "迟钝转变为炮垒形态，可持续对瞄准方向进行炮击，每次炮击消耗神能，造成暗属性伤害，炮击神能消耗不受其他属性影响。\n在炮垒形态下免疫控制效果，禁用移动、技能和自身奥义，仅可进行左右旋转瞄准；自身受到的伤害减低，每受到一定生命值上限的伤害时会消耗一定的神能；当神能不足或点击取消时会退出炮垒形态。",
		MaxUseCount = 0,
		id = 1094203,
		EnergyChange = 0,
		desc = {
			101094203
		},
		abilities = {
			1094203
		}
	},
	[1094209] = {
		element_type = 10,
		name = "降临审判",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "同时召唤多门魔炮向锁定方向射击，对区域内的敌人进行四次散布炮击，造成暗属性伤害；施放时全队伍暗属性伤害提高。\n\n自身或者队友触发零时空间时，获得奥义值。",
		MaxUseCount = 0,
		id = 1094209,
		EnergyChange = 0,
		desc = {
			101094209
		},
		abilities = {
			1094054
		}
	},
	[1094305] = {
		element_type = 16,
		name = "虚空之隐",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间；获得神能。",
		MaxUseCount = 2,
		abilities = "",
		id = 1094305,
		EnergyChange = 0,
		desc = {
			101094305
		}
	},
	[1096101] = {
		element_type = 2,
		name = "高频连击",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
对锁定的敌人进行连续攻击，造成风属性伤害。

被动：
自身移动时速度会不断加快，直至开启「矢量加速」。

<color=#0068C3>怒气：普通攻击命中后会获得怒气。</color>]],
		MaxUseCount = 0,
		id = 1096101,
		EnergyChange = 2,
		desc = {
			101096101
		},
		abilities = {
			1096101
		}
	},
	[1096201] = {
		element_type = 2,
		name = "苍痕坠星",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "对锁定的敌人使用两段踢击，造成风属性伤害，并对锁定的敌人附加「逐风标记」。\n「逐风标记」：自身从顺风方位攻击时，造成的伤害提高。",
		MaxUseCount = 0,
		id = 1096201,
		EnergyChange = -25,
		desc = {
			101096201
		},
		abilities = {
			1096201
		}
	},
	[1096202] = {
		element_type = 2,
		name = "风驰迹掣",
		cd = 5000,
		strengthen_desc = "",
		simpleDesc = [[
快速位移一段距离。
移动时长按「风驰迹掣」可消耗怒气直接进入「矢量加速」状态。
处于「矢量加速」状态时，可消耗怒气施放一次追加攻击。
追加攻击：在矢量加速过程中对锁定方向释放强力飞踢，造成风属性伤害。]],
		MaxUseCount = 0,
		abilities = "",
		id = 1096202,
		EnergyChange = -5,
		desc = {
			101096202
		}
	},
	[1096203] = {
		element_type = 2,
		name = "闪绝岚破",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "快速机动并连续攻击敌人，造成风属性伤害。",
		MaxUseCount = 0,
		id = 1096203,
		EnergyChange = -25,
		desc = {
			101096203
		},
		abilities = {
			1096203
		}
	},
	[1096209] = {
		element_type = 2,
		name = "羽风苍穹",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = "借助权钥的力量冲刺，到达目标时掀起风暴，造成风属性伤害；对命中的敌人附加风属性抗性降低的状态，并附加「逐风标记」。\n\n自身或者队友的普通攻击造成会心时，获得奥义值。",
		MaxUseCount = 0,
		id = 1096209,
		EnergyChange = 0,
		desc = {
			101096209
		},
		abilities = {
			1096209
		}
	},
	[1096305] = {
		element_type = 16,
		name = "立体机动",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间。",
		MaxUseCount = 2,
		abilities = "",
		id = 1096305,
		EnergyChange = 0,
		desc = {
			101096305
		}
	},
	[1097101] = {
		element_type = 12,
		name = "叠梦虹光",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "对锁定的敌人发射虹光，造成光属性伤害。\n\n<color=#0068C3>能量：间歇获得能量。</color>",
		MaxUseCount = 0,
		id = 1097101,
		EnergyChange = 0,
		desc = {
			101097101
		},
		abilities = {
			1097101
		}
	},
	[1097201] = {
		element_type = 12,
		name = "眠羊游行",
		cd = 8000,
		strengthen_desc = "",
		simpleDesc = "向前抛出小羊，小羊弹跳时对敌人造成光属性伤害，命中处在领域内的敌人时，会对命中的敌人附加禁锢状态。",
		MaxUseCount = 0,
		id = 1097201,
		EnergyChange = -20,
		desc = {
			101097201
		},
		abilities = {
			1097053
		}
	},
	[1097202] = {
		element_type = 12,
		name = "绘梦童话",
		cd = 24000,
		strengthen_desc = "",
		simpleDesc = "生成一片「绘梦领域」。在「绘梦领域」内所有友方受到的伤害降低。",
		MaxUseCount = 0,
		abilities = "",
		id = 1097202,
		EnergyChange = -20,
		desc = {
			101097202
		}
	},
	[1097221] = {
		element_type = 10,
		name = "幽梦乐园",
		cd = 24000,
		strengthen_desc = "",
		simpleDesc = "生成一片「幽梦领域」。在「幽梦领域」持续期间，所有友方受到的伤害降低；对命中的敌人附加「幽梦」状态，每秒自身会对所有处于「幽梦」状态的敌人造成暗属性伤害。",
		MaxUseCount = 0,
		abilities = "",
		id = 1097221,
		EnergyChange = -20,
		desc = {
			101097221
		}
	},
	[1097203] = {
		element_type = 12,
		name = "梦幻泡影",
		cd = 24000,
		strengthen_desc = "",
		simpleDesc = "进入梦游状态并生成一个泡梦。梦游状态期间，可缓慢移动，间歇为处在领域内所有友方恢复生命值。可通过长按进行多段蓄力，蓄力段数越多技能伤害越高。自身停止蓄力、受到攻击或蓄力时间达到上限时，泡梦会破碎并对周围的敌人造成光属性伤害。",
		MaxUseCount = 0,
		abilities = "",
		id = 1097203,
		EnergyChange = -50,
		desc = {
			101097203
		}
	},
	[1097209] = {
		element_type = 12,
		name = "绵绵摇篮曲",
		cd = 25000,
		strengthen_desc = "",
		simpleDesc = "高高抛起小羊，小羊变大后向目标砸落并膨胀爆炸，对范围内的敌人造成光属性伤害；对命中的敌人附加禁锢状态。\n\n自身或者队友施放奥义时，获得奥义值。",
		MaxUseCount = 0,
		id = 1097209,
		EnergyChange = 0,
		desc = {
			101097209
		},
		abilities = {
			1097054
		}
	},
	[1097305] = {
		element_type = 12,
		name = "虚梦之门",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间；对攻击者造成光属性伤害。",
		MaxUseCount = 0,
		id = 1097305,
		EnergyChange = 0,
		desc = {
			101097305
		},
		abilities = {
			1097052
		}
	},
	[1026101] = {
		element_type = 4,
		name = "枪炮强袭",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "对锁定的敌人进行连续攻击，造成火属性伤害。\n\n<color=#0068C3>神能：普通攻击命中后会获得神能。</color>",
		MaxUseCount = 0,
		id = 1026101,
		EnergyChange = 0,
		desc = {
			101026101
		},
		abilities = {
			1026101
		}
	},
	[1026201] = {
		element_type = 4,
		name = "炎弹之雨",
		cd = 10000,
		strengthen_desc = "",
		simpleDesc = "向锁定方向发射大量子弹，对范围内的敌人进行攻击，造成火属性伤害。可通过长按进行蓄力，消耗神能并提高伤害。满蓄力的「炎弹之雨」会对命中的敌人附加灼烧状态。",
		MaxUseCount = 0,
		abilities = "",
		id = 1026201,
		EnergyChange = 0,
		desc = {
			101026201
		}
	},
	[1026202] = {
		element_type = 4,
		name = "地鸣爆弹",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "锤击地面，在锁定的敌人下方产生爆炸，对范围内的敌人进行攻击，造成火属性伤害。可通过长按进行蓄力，消耗神能并提高伤害。满蓄力后施放会额外产生两次更大的环形爆炸，造成火属性伤害。",
		MaxUseCount = 0,
		abilities = "",
		id = 1026202,
		EnergyChange = 0,
		desc = {
			101026202
		}
	},
	[1026203] = {
		element_type = 4,
		name = "重装烈炎",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "向目标方向喷射火焰，对范围内的敌人进行攻击，造成火属性伤害。施放该技能时可进行缓慢移动。",
		MaxUseCount = 0,
		id = 1026203,
		EnergyChange = 0,
		desc = {
			101026203
		},
		abilities = {
			1026203
		}
	},
	[1026209] = {
		element_type = 4,
		name = "高能过载",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = [[
锤击敌人，造成火属性伤害；全队伍获得「高能过载」效果。
「高能过载」：获得硬直效果，受击时对攻击者造成火属性伤害。

当敌人被附加灼烧状态时，获得奥义值。]],
		MaxUseCount = 0,
		id = 1026209,
		EnergyChange = 0,
		desc = {
			101026209
		},
		abilities = {
			1026209
		}
	},
	[1026305] = {
		element_type = 16,
		name = "火线纵横",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：下一次施放的「炎弹之雨」或「地鸣爆弹」可直接达到满蓄力效果且不需要消耗神能。",
		MaxUseCount = 0,
		abilities = "",
		id = 1026305,
		EnergyChange = 0,
		desc = {
			101026305
		}
	},
	[1099101] = {
		element_type = 10,
		name = "朔刃连斩",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "连续挥动朔斩击敌人，造成暗属性伤害。\n\n<color=#0068C3>神能：普通攻击命中后会获得神能。</color>",
		MaxUseCount = 0,
		id = 1099101,
		EnergyChange = 0,
		desc = {
			101099101
		},
		abilities = {
			1099101
		}
	},
	[1099201] = {
		element_type = 10,
		name = "月弧斩",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "连续斩击后掷出朔攻击敌人，造成暗属性伤害。\n\n<color=#0068C3>神能：攻击命中后获得神能。</color>",
		MaxUseCount = 0,
		id = 1099201,
		EnergyChange = 0,
		desc = {
			101099201
		},
		abilities = {
			1099201,
			1099051
		}
	},
	[1099202] = {
		element_type = 10,
		name = "朔望·月蚀",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "当神能为满时，「朔·月蚀」改变为「望·月蚀」，施放「望·月蚀」会消耗全部神能。\n「朔·月蚀」：向前突进，对敌人造成暗属性伤害。\n「望·月蚀」：造成暗属性伤害，对命中的敌人附加受创状态。",
		MaxUseCount = 0,
		id = 1099202,
		EnergyChange = 0,
		desc = {
			101099202
		},
		abilities = {
			1099202
		}
	},
	[1099203] = {
		element_type = 10,
		name = "朔望·月夜见",
		cd = 14000,
		strengthen_desc = "",
		simpleDesc = "当神能为满时，「朔·月夜见」改变为「望·月夜见」，施放「望·月夜见」会消耗全部神能。\n「朔·月夜见」：连续点击施放居合术攻击敌人及其周围处于受创状态的敌人，造成暗属性伤害。\n「望·月夜见」：可通过长按进行蓄力，施放「望」击出一道刀光，造成暗属性伤害。",
		MaxUseCount = 0,
		id = 1099203,
		EnergyChange = 0,
		desc = {
			101099203
		},
		abilities = {
			1099054
		}
	},
	[1099231] = {
		element_type = 10,
		name = "朔望·末月",
		cd = 14000,
		strengthen_desc = "",
		simpleDesc = "当神能为满时，重置「朔望·末月」的冷却时间，「朔·末月」改变为「望·末月」，施放「望·末月」会消耗全部神能。\n「朔·末月」：连续点击施放居合术攻击敌人及其周围处于受创状态的敌人，造成暗属性伤害。\n「望·末月」：可通过长按进行多段蓄力，施放「望」击出三道刀光，造成暗属性伤害。蓄力段数越多，伤害越高。",
		MaxUseCount = 0,
		id = 1099231,
		EnergyChange = 0,
		desc = {
			101099231
		},
		abilities = {
			1099054
		}
	},
	[1099209] = {
		element_type = 10,
		name = "月降之击",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "斩击前方目标，造成暗属性伤害；对命中的敌人附加受创状态，全队伍获得神能。\n\n当敌人被附加受创状态时，获得奥义值。",
		MaxUseCount = 0,
		id = 1099209,
		EnergyChange = 0,
		desc = {
			101099209
		},
		abilities = {
			1099209
		}
	},
	[1099305] = {
		element_type = 16,
		name = "朔月暗夜",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间。",
		MaxUseCount = 2,
		abilities = "",
		id = 1099305,
		EnergyChange = 0,
		desc = {
			101099305
		}
	},
	[1032101] = {
		element_type = 12,
		name = "王棋闪击",
		cd = 0,
		simpleDesc = "操纵巨剑连续攻击敌人，造成光属性伤害。出场时，获得满印记。",
		MaxUseCount = 0,
		id = 1032101,
		EnergyChange = 0,
		desc = {
			101032101
		},
		strengthen_desc = {
			103221,
			211032101
		},
		abilities = {
			1032101
		}
	},
	[1032106] = {
		element_type = 12,
		name = "王棋进军",
		cd = 0,
		simpleDesc = "操纵巨剑连续攻击敌人，造成光属性伤害。出场时，获得满印记。巨剑类型是「巨剑·皇后」时，改变普通攻击的攻击模式。\n「王棋进军」：操纵巨剑·皇后对目标进行攻击，造成光属性伤害。",
		MaxUseCount = 0,
		id = 1032106,
		EnergyChange = 0,
		desc = {
			101032106
		},
		strengthen_desc = {
			103225,
			211032106
		},
		abilities = {
			1032106
		}
	},
	[1032305] = {
		element_type = 16,
		name = "攻守易位",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：获得印记。",
		MaxUseCount = 0,
		abilities = "",
		id = 1032305,
		EnergyChange = 0,
		desc = {
			101032305
		}
	},
	[1032201] = {
		element_type = 12,
		name = "落兵升变",
		cd = 7000,
		simpleDesc = [[
切换巨剑类型，对自身周围的敌人造成光属性伤害。普通攻击过程中也可点击该技能直接施放，不会打断普通攻击，也不会造成伤害，之后剩余冷却时间缩短。
巨剑类型会按照「巨剑·骑士」、「巨剑·城堡」、「巨剑·皇后」顺序循环切换。

<color=#0068C3>印记：施放该技能时，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1032201,
		EnergyChange = 0,
		desc = {
			101032201
		},
		strengthen_desc = {
			103222,
			211032201
		},
		abilities = {
			1032201
		}
	},
	[1032202] = {
		element_type = 12,
		name = "布局弈法",
		cd = 4500,
		simpleDesc = [[
在目标上方降下巨剑，造成光属性伤害，获得当前巨剑类型对应的「王棋标记」，并把「王棋」置放在场上。「王棋」存在于场上时可再次点击施放该技能，消耗印记操纵「王棋」，并根据巨剑类型造成不同的攻击方式。
「巨剑·骑士」：巨剑再次落下，造成光属性伤害。
「巨剑·城堡」：瞬移到巨剑位置，操纵巨剑对目标进行一次攻击，造成光属性伤害。
「巨剑·皇后」：巨剑向目标发射，造成光属性伤害。]],
		MaxUseCount = 0,
		abilities = "",
		id = 1032202,
		EnergyChange = -1,
		desc = {
			101032202
		},
		strengthen_desc = {
			103223,
			211032202
		}
	},
	[1032203] = {
		element_type = 12,
		name = "同翼互攻",
		cd = 12000,
		simpleDesc = "消耗所有「王棋标记」，挥动巨剑向前攻击，造成光属性伤害，施放时禁锢敌人，并根据「王棋标记」数量从目标上方降下巨剑造成额外的伤害，命中后移除禁锢效果。",
		MaxUseCount = 0,
		id = 1032203,
		EnergyChange = -1,
		desc = {
			101032203
		},
		strengthen_desc = {
			103224,
			211032203
		},
		abilities = {
			1032203
		}
	},
	[1032209] = {
		element_type = 12,
		name = "终局定格",
		cd = 25000,
		strengthen_desc = "",
		simpleDesc = "召唤多个巨剑攻击敌人，造成光属性伤害；施放后全队伍奥义伤害提高。\n\n自身修正等级达到Ω级时，获得奥义值。",
		MaxUseCount = 0,
		id = 1032209,
		EnergyChange = 0,
		desc = {
			101032209
		},
		abilities = {
			1032209
		}
	},
	[1033101] = {
		element_type = 12,
		name = "裂空射线",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "连续驱动「循理之环」施放射线攻击前方敌人，造成光属性伤害。\n\n<color=#0068C3>能量：间歇获得能量。</color>",
		MaxUseCount = 0,
		id = 1033101,
		EnergyChange = 0,
		desc = {
			101033101
		},
		abilities = {
			1033101
		}
	},
	[1033305] = {
		element_type = 16,
		name = "重构跃迁",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：间歇获得能量，额外攻击力提高，该效果可共享给最后一次生成的「真理之域」范围内的队友。",
		MaxUseCount = 0,
		abilities = "",
		id = 1033305,
		EnergyChange = 0,
		desc = {
			101033305
		}
	},
	[1033201] = {
		element_type = 12,
		name = "至理裁决",
		cd = 8000,
		strengthen_desc = "",
		simpleDesc = "从敌人身侧召唤出「循理之环」，裁决秩序的破坏者，造成光属性伤害。",
		MaxUseCount = 0,
		id = 1033201,
		EnergyChange = -30,
		desc = {
			101033201
		},
		abilities = {
			1033051
		}
	},
	[1033202] = {
		element_type = 12,
		name = "逆序警诫",
		cd = 11000,
		strengthen_desc = "",
		simpleDesc = "从敌人上空召唤出高速旋转的警诫之轮，造成光属性伤害。当「逆序警诫」最后一段命中时，自身伤害提高，该效果可共享给最后一次生成的「真理之域」范围内的队友。",
		MaxUseCount = 0,
		id = 1033202,
		EnergyChange = -25,
		desc = {
			101033202
		},
		abilities = {
			1033052
		}
	},
	[1033203] = {
		element_type = 12,
		name = "极境光域",
		cd = 18000,
		strengthen_desc = "",
		simpleDesc = "驱动「循理之环」从天而降打击敌人，造成光属性伤害。命中后生成「真理之域」，自身技能、闪避效果及神格获得的加成效果会共享给最后一次生成的「真理之域」范围内的队友。",
		MaxUseCount = 0,
		id = 1033203,
		EnergyChange = -20,
		desc = {
			101033203
		},
		abilities = {
			1033053
		}
	},
	[1033231] = {
		element_type = 12,
		name = "极境神域",
		cd = 18000,
		strengthen_desc = "",
		simpleDesc = "驱动「循理之环」从天而降打击敌人，造成光属性伤害。命中后生成强化的「真理之域」，自身技能、闪避效果及神格获得的加成效果会共享给最后一次生成的「真理之域」范围内的队友。最后一次生成的「真理之域」范围内的队友每间隔一段时间技能伤害提高。",
		MaxUseCount = 0,
		abilities = "",
		id = 1033231,
		EnergyChange = -20,
		desc = {
			101033231
		}
	},
	[1033209] = {
		element_type = 16,
		name = "解限咏唱",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "咏颂至理箴言，释放自身潜能，自身额外攻击力提高，命中时根据自身额外攻击力另外造成一次伤害，以上效果可共享给最后一次生成的「真理之域」范围内的队友。\n\n自身或者队友触发闪避效果时，获得奥义值。",
		MaxUseCount = 0,
		abilities = "",
		id = 1033209,
		EnergyChange = 0,
		desc = {
			101033209
		}
	},
	[1199101] = {
		element_type = 14,
		name = "鸣雷之刃",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "连续挥动太刀斩击敌人，造成雷属性伤害。\n\n<color=#0068C3>怒气：普通攻击命中后会获得怒气。</color>",
		MaxUseCount = 0,
		id = 1199101,
		EnergyChange = 3,
		desc = {
			101199101
		},
		abilities = {
			1199101
		}
	},
	[1199201] = {
		element_type = 14,
		name = "雷殛·烈光",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "向前方突进一段距离并斩击沿途敌人，造成雷属性伤害，对命中的敌人附加「雷殛之印」。",
		MaxUseCount = 0,
		id = 1199201,
		EnergyChange = -20,
		desc = {
			101199201
		},
		abilities = {
			1199201
		}
	},
	[1199202] = {
		element_type = 14,
		name = "雷殛·双流",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "使用双刀对前方敌人进行连斩，造成雷属性伤害，对命中的敌人附加「雷殛之印」。",
		MaxUseCount = 0,
		id = 1199202,
		EnergyChange = -30,
		desc = {
			101199202
		},
		abilities = {
			1199202
		}
	},
	[1199203] = {
		element_type = 14,
		name = "雷殛·荒天",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = [[
使用拔刀术斩击前方敌人，命中处于「雷殛之印」的敌人时，清除「雷殛之印」并开启「雷殛·荒天」的下一式。「雷殛·荒天」共有三式，第三式施放时不会消耗怒气，也不会清除「雷殛之印」。
「雷殛·荒天」第一式：起手斩击，造成雷属性伤害。
「雷殛·荒天」第二式：接续斩击，造成雷属性伤害。
「雷殛·荒天」第三式：施放四道落雷，造成雷属性伤害，后续落雷对同个敌人伤害依次衰减。]],
		MaxUseCount = 0,
		id = 1199203,
		EnergyChange = -10,
		desc = {
			101199203
		},
		abilities = {
			1199203
		}
	},
	[1199209] = {
		element_type = 14,
		name = "雷殛·霹震",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "向锁定的敌人突进并进行斩击，造成雷属性伤害；施放时全队伍雷属性伤害提高。\n\n自身或者队友触发零时空间时，获得奥义值。",
		MaxUseCount = 0,
		id = 1199209,
		EnergyChange = 0,
		desc = {
			101199209
		},
		abilities = {
			1199209
		}
	},
	[1199305] = {
		element_type = 16,
		name = "雷殛·瞬闪",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "极限闪避后点击普通攻击会施放技能攻击，造成雷属性伤害。\n闪避效果：零时空间；该次点击普通攻击施放的技能攻击，会对命中的敌人附加「雷殛之印」。",
		MaxUseCount = 2,
		abilities = "",
		id = 1199305,
		EnergyChange = 0,
		desc = {
			101199305
		}
	},
	[1138101] = {
		element_type = 12,
		name = "闪白流光",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "对锁定的敌人发射流光，造成光属性伤害。\n\n<color=#0068C3>能量：间歇获得能量。</color>",
		MaxUseCount = 0,
		id = 1138101,
		EnergyChange = 0,
		desc = {
			101138101
		},
		abilities = {
			1138101
		}
	},
	[1138201] = {
		element_type = 12,
		name = "陨落晨星",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "在锁定的敌人上方召唤七个流星，对范围内的敌人进行攻击，造成光属性伤害。",
		MaxUseCount = 0,
		id = 1138201,
		EnergyChange = -20,
		desc = {
			101138201
		},
		abilities = {
			1138051,
			1138051,
			1138051,
			1138051,
			1138051,
			1138051,
			1138051
		}
	},
	[1138202] = {
		element_type = 12,
		name = "曙光祈愿",
		cd = 24000,
		strengthen_desc = "",
		simpleDesc = "对自身周围敌人进行攻击，造成光属性伤害；攻击力最高的队友攻击力提高。",
		MaxUseCount = 0,
		id = 1138202,
		EnergyChange = -10,
		desc = {
			101138202
		},
		abilities = {
			1138202
		}
	},
	[1138203] = {
		element_type = 12,
		name = "黄道天枢",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "在目标的上方召唤天枢，对范围内的敌人进行攻击，造成光属性伤害。",
		MaxUseCount = 0,
		id = 1138203,
		EnergyChange = -40,
		desc = {
			101138203
		},
		abilities = {
			1138052
		}
	},
	[1138209] = {
		element_type = 16,
		name = "永昼回响",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "全队伍伤害提高；返还一定时间内全队伍下一次消耗的机制值。\n\n自身或者队友触发零时空间时，获得奥义值。",
		MaxUseCount = 0,
		abilities = "",
		id = 1138209,
		EnergyChange = 0,
		desc = {
			101138209
		}
	},
	[1138305] = {
		element_type = 12,
		name = "光幻瞬变",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间；触发光箭对攻击者进行攻击，造成光属性伤害。",
		MaxUseCount = 0,
		abilities = "",
		id = 1138305,
		EnergyChange = 0,
		desc = {
			101138305
		}
	},
	[1138351] = {
		element_type = 12,
		name = "浮光幻羽",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避必定触发闪避效果；闪避进入冷却时，可以通过长按闪避键，消耗能量额外触发一次闪避效果。\n闪避效果：零时空间；触发光箭对锁定的敌人进行攻击，造成光属性伤害。",
		MaxUseCount = 0,
		abilities = "",
		id = 1138351,
		EnergyChange = 0,
		desc = {
			101138351
		}
	},
	[1111101] = {
		element_type = 2,
		name = "空冥镰斩",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
召唤镰刀连续斩击敌人，造成风属性伤害。
「冥府审判模式」：施放剑翼对锁定的敌人进行切割，造成风属性伤害。

<color=#0068C3>印记：普通攻击第三段和五段命中后，获得印记。「冥府审判模式」普通攻击第四段命中后，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1111101,
		EnergyChange = 0,
		desc = {
			101111101
		},
		abilities = {
			1111101
		}
	},
	[1111305] = {
		element_type = 2,
		name = "噩兆叠影",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "不处于「冥府审判模式」时，闪避的同时会对周围敌人进行攻击，造成风属性伤害。\n闪避效果：零时空间；对闪避攻击命中的敌人附加虚弱状态。",
		MaxUseCount = 0,
		id = 1111305,
		EnergyChange = 0,
		desc = {
			101111305
		},
		abilities = {
			1111054
		}
	},
	[1111201] = {
		element_type = 2,
		name = "幽岚羽刃",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = [[
掷出镰刀，对锁定方向的敌人造成风属性伤害。
「冥府审判模式」：发射剑翼，造成风属性伤害。
「幽岚羽刃」处于冷却状态时，可再次点击技能，消耗印记并施放一次，该次施放不会获得印记，每次冷却时间内最多施放一次。

<color=#0068C3>印记：每次施放命中后，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1111201,
		EnergyChange = 2,
		desc = {
			101111201
		},
		abilities = {
			1111201,
			1111052
		}
	},
	[1111202] = {
		element_type = 2,
		name = "永劫轮舞",
		cd = 8000,
		strengthen_desc = "",
		simpleDesc = "旋转镰刀对周围敌人进行攻击，造成风属性伤害。\n「冥府审判模式」：召唤环绕自身的剑翼，对剑翼路径上的敌人进行攻击，造成风属性伤害。",
		MaxUseCount = 0,
		id = 1111202,
		EnergyChange = -1,
		desc = {
			101111202
		},
		abilities = {
			1111053
		}
	},
	[1111203] = {
		element_type = 2,
		name = "终灵凋落",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "挥舞镰刀进行一次上挑攻击，造成风属性伤害。\n「冥府审判模式」：在前方聚集敌人，造成风属性伤害。",
		MaxUseCount = 0,
		id = 1111203,
		EnergyChange = -2,
		desc = {
			101111203
		},
		abilities = {
			1111203
		}
	},
	[1111209] = {
		element_type = 2,
		name = "冥府神罚",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = [[
短暂解开灵魂束缚进入「冥府审判模式」，自身生命值恢复至满值，全队伍伤害提高。
「冥府审判模式」：改变「空冥镰斩」、「幽岚羽刃」、「永劫轮舞」、「终灵凋落」的攻击模式。自身获得霸体效果和生命移除状态，当生命值为零时退出「冥府审判模式」，恢复至原本状态。退出「冥府审判模式」后，获得与自身预组合连携奥义的修正者相等的奥义值；队伍中无预组合连携奥义的修正者时，退出「冥府审判模式」时也可获得奥义值。
出场时，自身和与自身预组合连携奥义的修正者获得一定的奥义值。

当敌人被附加虚弱状态时，获得奥义值。]],
		MaxUseCount = 0,
		abilities = "",
		id = 1111209,
		EnergyChange = 0,
		desc = {
			101111209
		}
	},
	[1017101] = {
		element_type = 10,
		name = "暗影的利爪",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "挥舞利爪攻击敌人，造成暗属性伤害。普通攻击最后一段命中时，进入「神瞳凝视」状态。",
		MaxUseCount = 0,
		id = 1017101,
		EnergyChange = 0,
		desc = {
			101017101
		},
		abilities = {
			1017101
		}
	},
	[1017201] = {
		element_type = 10,
		name = "残月的奔袭",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "短距离突进，并造成暗属性伤害；处于「神瞳凝视」状态时，该技能获得以下额外效果：命中时对锁定的敌人附加暗属性抗性降低的状态。技能施放后，「神瞳凝视」状态立即结束。\n\n<color=#0068C3>印记：每次施放命中后，获得印记。</color>",
		MaxUseCount = 0,
		id = 1017201,
		EnergyChange = 1,
		desc = {
			101017201
		},
		abilities = {
			1017201
		}
	},
	[1017202] = {
		element_type = 10,
		name = "夜灵的游猎",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = "从地面跃起，暂时隐藏身形，随后现身并用利爪攻击敌人，造成暗属性伤害；处于「神瞳凝视」状态时，该技能获得以下额外效果：对第一个命中的敌人附加眩晕状态。技能施放后，「神瞳凝视」状态立即结束。\n\n<color=#0068C3>印记：每次施放命中后，获得印记。</color>",
		MaxUseCount = 0,
		id = 1017202,
		EnergyChange = 1,
		desc = {
			101017202
		},
		abilities = {
			1017202
		}
	},
	[1017203] = {
		element_type = 10,
		name = "猫神的愚弄",
		cd = 6000,
		strengthen_desc = "",
		simpleDesc = "消耗印记，进入「神瞳凝视」状态，且不会打断普通攻击的段数；每次进入「神瞳凝视」状态，「猫神的愚弄」会替换为「战神的处决」。\n「战神的处决」：释放暗属性神力，造成暗属性范围伤害。技能施放后，「神瞳凝视」状态立即结束。",
		MaxUseCount = 0,
		id = 1017203,
		EnergyChange = -1,
		desc = {
			101017203
		},
		abilities = {
			1017203
		}
	},
	[1017209] = {
		element_type = 10,
		name = "拉之眼的审判",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "释放暗属性神力对敌人进行判罚，造成暗属性伤害；对普通敌人，根据敌人生命值提高奥义伤害；对精英和首领敌人，根据修正值提高奥义伤害。\n\n当敌人被附加暗属性抗性降低的状态时，获得奥义值。",
		MaxUseCount = 0,
		id = 1017209,
		EnergyChange = 0,
		desc = {
			101017209
		},
		abilities = {
			1017209
		}
	},
	[1017305] = {
		element_type = 10,
		name = "暗夜的猫步",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避不会打断普通攻击的段数。\n闪避效果：极限闪避后一段时间内点击普通攻击，会瞬移到锁定的敌人身后施放特殊技能攻击，造成暗属性伤害，命中后进入「神瞳凝视」状态。",
		MaxUseCount = 0,
		abilities = "",
		id = 1017305,
		EnergyChange = 0,
		desc = {
			101017305
		}
	},
	[1068101] = {
		element_type = 2,
		name = "御风术",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
驱动风元素进行攻击，造成风属性伤害。普通攻击最后一段施放后获得「风铃」标记。

被动：
当拥有满「风铃」标记时，施放技能会时消耗全部标记并获得强化效果。

<color=#0068C3>怒气：普通攻击命中后会获得怒气。</color>]],
		MaxUseCount = 0,
		id = 1068101,
		EnergyChange = 2,
		desc = {
			101068101
		},
		abilities = {
			1068051,
			1068052
		}
	},
	[1068201] = {
		element_type = 2,
		name = "疾风冲击",
		cd = 6000,
		strengthen_desc = "",
		simpleDesc = "把大量风元素凝聚成「风箭」进行攻击，造成两段风属性伤害，后段施放后获得「风铃」标记。\n强化的「疾风冲击」：产生数个「风箭」，每个「风箭」造成两段风属性伤害；「飓风回旋」形成的「风眼」被强化的「疾风冲击」产生的「风箭」命中时，「风箭」后段会转变为爆炸，爆炸造成风属性伤害。",
		MaxUseCount = 0,
		id = 1068201,
		EnergyChange = -15,
		desc = {
			101068201
		},
		abilities = {
			1068055,
			1068056,
			1068058,
			1068058,
			1068059,
			1068060,
			1068061
		}
	},
	[1068202] = {
		element_type = 2,
		name = "飓风回旋",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "驱动飓风进行攻击，造成风属性伤害，施放后获得「风铃」标记，命中后形成「风眼」。\n强化的「飓风回旋」：造成风属性伤害，并额外产生数股飓风，造成风属性伤害；强化的「飓风回旋」形成的「风眼」被「疾风冲击」产生的「风箭」命中时，「风箭」后段会转变为气旋，气旋造成风属性伤害。",
		MaxUseCount = 0,
		id = 1068202,
		EnergyChange = -25,
		desc = {
			101068202
		},
		abilities = {
			1068062,
			1068063,
			1068064,
			1068065,
			1068066,
			1068067
		}
	},
	[1068203] = {
		element_type = 2,
		name = "风元异变",
		cd = 25000,
		strengthen_desc = "",
		simpleDesc = [[
可以不消耗怒气直接施放，施放后技能伤害提高，之后该技能剩余冷却时间缩短，持续时间内施放「疾风冲击」、「飓风回旋」会获得以下额外效果。
施放「疾风冲击」时，产生的「风箭」会使命中的敌人风属性抗性降低。
施放「飓风回旋」时，形成的「风眼」会牵引附近敌人。
施放强化的对应技能时，获得的对应效果也会增强。
强化的「风元异变」：自身化为飓风，施放期间禁用技能并获得无敌效果，造成风属性伤害。]],
		MaxUseCount = 0,
		id = 1068203,
		EnergyChange = -50,
		desc = {
			101068203
		},
		abilities = {
			1068203
		}
	},
	[1068209] = {
		element_type = 2,
		name = "风凝爆裂",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "造成风属性伤害；施放后全队伍风属性伤害提高。\n\n自身或者队友触发零时空间时，获得奥义值。",
		MaxUseCount = 0,
		id = 1068209,
		EnergyChange = 0,
		desc = {
			101068209
		},
		abilities = {
			1068068
		}
	},
	[1068305] = {
		element_type = 16,
		name = "风灵游弋",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间；获得「风铃」标记。",
		MaxUseCount = 0,
		abilities = "",
		id = 1068305,
		EnergyChange = 0,
		desc = {
			101068305
		}
	},
	[1070101] = {
		element_type = 4,
		name = "蓬莱剑法",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "连续挥舞十曜，并配合十曜衍生的曜刃进行多段攻击，造成火属性伤害。最后一段每次命中时，获得「曜」标记。",
		MaxUseCount = 0,
		id = 1070101,
		EnergyChange = 0,
		desc = {
			101070101
		},
		abilities = {
			1070101
		}
	},
	[1070201] = {
		element_type = 4,
		name = "降妖斩决",
		cd = 6000,
		strengthen_desc = "",
		simpleDesc = [[
挥舞十曜连续斩击目标，造成火属性伤害。当拥有「曜」标记时，每次斩击命中后会消耗「曜」标记，获得「火羽」，「火羽」可以提高自身技能伤害。当拥有的「曜」标记足够多时，施放时会消耗全部「曜」标记，获得对应层数「火羽」，并额外造成火属性伤害。
处于「日凌」状态时，该技能会替换为「金乌炽空」；退出「日凌」状态时，该技能会替换为「降妖斩决」。
「金乌炽空」：在空中挥舞十曜攻击目标，消耗「曜」标记，造成火属性伤害。

<color=#0068C3>神能：当拥有的「曜」标记足够多时，施放「降妖斩决」会消耗全部「曜」标记，并获得神能；「降妖斩决」每次斩击命中后，也会消耗「曜」标记，并获得神能。当拥有的「曜」标记足够多时，施放「金乌炽空」会消耗全部「曜」标记，获得较多神能；若「曜」标记数量不够，则消耗部分「曜」标记，获得较少神能。</color>]],
		MaxUseCount = 0,
		id = 1070201,
		EnergyChange = 0,
		desc = {
			101070201
		},
		abilities = {
			1070201
		}
	},
	[1070202] = {
		element_type = 4,
		name = "诛邪破击",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = [[
释放曜刃，对目标多次攻击，造成火属性伤害，每次命中敌人获得「曜」标记。「诛邪破击」处于冷却状态时，「诛邪破击」会替换为「伏魔焚灭」。
「伏魔焚灭」：消耗「曜」标记，释放曜刃攻击目标，造成火属性伤害。不会打断当前动作，每次命中敌人获得「曜」标记。
处于「日凌」状态时，该技能会替换为「金乌燎原」；退出「日凌」状态时，该技能会替换为「诛邪破击」。
「金乌燎原」：消耗全部神能，在目标位置展开法阵，对法阵范围内的敌人附加禁锢状态，此外还会根据消耗的神能对敌人依次附加物理、风属性、火属性抗性降低的状态，之后造成火属性伤害。]],
		MaxUseCount = 0,
		id = 1070202,
		EnergyChange = 0,
		desc = {
			101070202
		},
		abilities = {
			1070052
		}
	},
	[1070203] = {
		element_type = 4,
		name = "三足逐日",
		cd = 9000,
		strengthen_desc = "",
		simpleDesc = [[
消耗全部神能，对周围造成火属性伤害，从地面腾空进入「日凌」状态。
「日凌」：获得硬直效果；根据进入时消耗的神能提高自身火属性伤害。连续施放技能或闪避，动作期间可维持「日凌」状态，停止施放后即可回到地面；回到地面后退出「日凌」状态，之后该技能进入冷却。
处于「日凌」状态时，该技能会替换为「金乌焚陨」；改变「蓬莱剑法」的攻击模式；退出「日凌」状态时，该技能会替换为「三足逐日」。
「蓬莱剑法」：施放技能攻击驱使曜刃攻击目标，造成火属性伤害，根据命中敌人的次数获得「曜」标记。
「金乌焚陨」：朝锁定的敌人俯冲，命中时消耗全部「曜」标记，造成火属性伤害，根据消耗「曜」标记的数量，提高该技能的基础伤害，之后退出「日凌」状态。]],
		MaxUseCount = 0,
		id = 1070203,
		EnergyChange = 0,
		desc = {
			101070203
		},
		abilities = {
			1070203
		}
	},
	[1070209] = {
		element_type = 4,
		name = "日出十曜",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "不处于「日凌」状态时才可以施放。释放日曜的威能，造成火属性伤害；根据拥有「曜」标记的数量，自身获得神能。\n\n自身或者队友施放奥义时，获得奥义值。",
		MaxUseCount = 0,
		id = 1070209,
		EnergyChange = 0,
		desc = {
			101070209
		},
		abilities = {
			1070060,
			1070065,
			1070067
		}
	},
	[1070305] = {
		element_type = 16,
		name = "日凌微步",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：触发一次该闪避在「日凌」状态下的曜刃攻击。\n处于「日凌」状态时，可以通过点击闪避在空中进行快速移动，并触发曜刃攻击，造成火属性伤害。",
		MaxUseCount = 0,
		abilities = "",
		id = 1070305,
		EnergyChange = 0,
		desc = {
			101070305
		}
	},
	[1067101] = {
		element_type = 8,
		name = "急流如锋",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
挥舞利剑，引导水流，造成水属性伤害。普通攻击第三段命中时，会触发「激波」。
「激波」：场上的「支流幻影」会朝锁定的敌人冲刺并造成水属性伤害，同时刷新「支流幻影」的持续时间。

被动：
可以通过「长河奔行」、「碎浪逐空」生成「支流幻影」。]],
		MaxUseCount = 0,
		id = 1067101,
		EnergyChange = 0,
		desc = {
			101067101
		},
		abilities = {
			1067101
		}
	},
	[1067201] = {
		element_type = 8,
		name = "长河奔行",
		cd = 6000,
		strengthen_desc = "",
		simpleDesc = [[
向目标冲刺，对敌人造成水属性伤害，命中时生成「支流幻影」并触发「分流」；技能施放结束后，场上所有「支流幻影」对其周围造成水属性伤害，同时刷新「支流幻影」的持续时间并再次触发「分流」。
「分流」：生成幻影时会对周围敌人造成水属性伤害。

<color=#0068C3>印记：每次施放命中后，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1067201,
		EnergyChange = 1,
		desc = {
			101067201
		},
		abilities = {
			1067201
		}
	},
	[1067202] = {
		element_type = 8,
		name = "激潮涌灭",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "自身消失，对前方区域造成水属性伤害，自身拥有不少于<color=#FF9500>2</color>个印记时，消耗场上全部的「支流幻影」，根据消耗幻影数量提高自身近战伤害，然后在锁定的敌人周围重新生成相同数量的「支流幻影」，幻影生成的同时会对周围敌人造成水属性伤害。",
		MaxUseCount = 0,
		id = 1067202,
		EnergyChange = 0,
		desc = {
			101067202
		},
		abilities = {
			1067202
		}
	},
	[1067203] = {
		element_type = 8,
		name = "百川归海",
		cd = 16000,
		strengthen_desc = "",
		simpleDesc = "吸收自身一定范围的「支流幻影」，根据吸收幻影数量提高自身技能伤害；消耗全部印记，根据消耗印记数量提高幻影的伤害；之后自身对敌人造成水属性伤害，每个被吸收的「支流幻影」都会生成一个短暂的幻影对敌人造成水属性伤害。",
		MaxUseCount = 0,
		id = 1067203,
		EnergyChange = 0,
		desc = {
			101067203
		},
		abilities = {
			1067203
		}
	},
	[1067209] = {
		element_type = 8,
		name = "大洋寰宇",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "幻化出水流锋刃进行大范围斩击，造成水属性伤害；施放时根据场上存在「支流幻影」的数量提高全队伍水属性伤害和近战伤害。\n\n自身或者队友极限闪避时，获得奥义值。",
		MaxUseCount = 0,
		id = 1067209,
		EnergyChange = 0,
		desc = {
			101067209
		},
		abilities = {
			1067209
		}
	},
	[1067305] = {
		element_type = 8,
		name = "碎浪逐空",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "极限闪避时生成「支流幻影」触发「分流」并获得印记；极限闪避后一定时间内，当拥有印记时点击普通攻击会消耗印记对敌人施放技能攻击造成水属性伤害，并刷新通过「百川归海」获得的加成效果的持续时间。\n闪避效果：护甲穿透提高。",
		MaxUseCount = 0,
		abilities = "",
		id = 1067305,
		EnergyChange = 0,
		desc = {
			101067305
		}
	},
	[1016101] = {
		element_type = 0,
		name = "爆裂切割",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
挥舞荒獠连续攻击，造成物理伤害。普通攻击到第五段时，长按普通攻击，可施放「爆压碎裂斩」，造成物理伤害。命中后会产生爆炸，造成物理伤害，另外根据「压力槽」层数，会消耗神能并产生额外爆炸，「爆压碎裂斩」不会打断普通攻击的连段。
「高压回旋斩」：消耗全部「压力槽」并发动回旋斩击，造成物理伤害，根据消耗的「压力槽」层数获得「爆裂阈值」层数和神能；根据「爆裂阈值」层数提高自身伤害；施放「高压回旋斩」后一段时间内，施放「突击战术」、「攻坚战术」时会直接施放该技能的电锯模式。
「超频电锯模式」：强化普通攻击，期间不再获得神能，前五段每段攻击命中会消耗神能并额外造成物理伤害，当神能不足时退出该状态。

<color=#0068C3>神能：普通攻击命中后会获得神能。</color>]],
		MaxUseCount = 0,
		id = 1016101,
		EnergyChange = 0,
		desc = {
			101016101
		},
		abilities = {
			1016101
		}
	},
	[1016201] = {
		element_type = 0,
		name = "突击战术",
		cd = 18000,
		strengthen_desc = "",
		simpleDesc = [[
大剑模式：侧身用荒獠撞击，造成物理伤害，撞击时自身获得短暂的霸体效果，命中后该技能切换到电锯模式。
电锯模式：使用荒獠进行突刺攻击，造成物理伤害；命中时可通过长按该技能消耗神能持续施放，根据消耗的神能会获得「压力槽」、提高伤害并额外造成物理伤害；处于修正模式时技能伤害提高。施放后切换回大剑模式。

<color=#0068C3>神能：撞击的霸体效果期间受击时会格挡伤害并获得大量神能。</color>]],
		MaxUseCount = 0,
		id = 1016201,
		EnergyChange = 0,
		desc = {
			101016201
		},
		abilities = {
			1016201
		}
	},
	[1016202] = {
		element_type = 0,
		name = "歼灭战术",
		cd = 14000,
		strengthen_desc = "",
		simpleDesc = "挥舞荒獠进行横向切割和纵向斩击，造成物理伤害。当横向切割和纵向斩击命中了同一个敌人时，获得「压力槽」。横向切割和纵向斩击命中时可分别长按，消耗神能持续切割敌人，并额外造成物理伤害。每消耗一定的神能，获得「压力槽」。",
		MaxUseCount = 0,
		id = 1016202,
		EnergyChange = 0,
		desc = {
			101016202
		},
		abilities = {
			1016202
		}
	},
	[1016203] = {
		element_type = 0,
		name = "攻坚战术",
		cd = 14000,
		strengthen_desc = "",
		simpleDesc = [[
大剑模式：挥舞荒獠连续斩击，造成物理伤害，命中后该技能切换到电锯模式。
电锯模式：把荒獠插入地面切割并释放震荡波，造成物理伤害；命中时可通过长按该技能，消耗神能持续施放，根据消耗的神能获得「压力槽」、提高伤害并额外造成物理伤害；处于修正模式时技能伤害提高。施放后切换回大剑模式。

<color=#0068C3>神能：大剑模式命中后会获得神能。</color>]],
		MaxUseCount = 0,
		id = 1016203,
		EnergyChange = 0,
		desc = {
			101016203
		},
		abilities = {
			1016203
		}
	},
	[1016209] = {
		element_type = 0,
		name = "超频终结",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = "使荒獠超载，造成物理伤害；命中时对命中的敌人附加破甲状态。施放后进入「超频电锯模式」，获得「压力槽」满层数的「爆裂阈值」。\n\n自身或者队友极限闪避时，获得奥义值。",
		MaxUseCount = 0,
		id = 1016209,
		EnergyChange = 0,
		desc = {
			101016209
		},
		abilities = {
			1016209
		}
	},
	[1016305] = {
		element_type = 16,
		name = "高压回旋",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避不会打断普通攻击的段数。施放「突击战术」、「攻坚战术」的电锯模式时，可使用非移动闪避中断技能，并在后续短时间内衔接普通攻击来施放「高压回旋斩」。\n闪避效果：零时空间；获得神能。",
		MaxUseCount = 0,
		abilities = "",
		id = 1016305,
		EnergyChange = 0,
		desc = {
			101016305
		}
	},
	[1024101] = {
		element_type = 10,
		name = "胡狼奔行",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
连续攻击，造成暗属性伤害。
「狼魂」：协同攻击，造成暗属性伤害。

被动：
「狼魂」会自动攻击其锁定的敌人，随机发动普通攻击的协同攻击或技能的协同攻击，直至敌人被击败。当自身与「狼魂」目标不同，自身施放技能命中时，「狼魂」会转移目标攻击自身锁定的敌人。当「狼魂」锁定的敌人被击败后，「狼魂」会立即消失。

<color=#0068C3>怒气：普通攻击命中后会获得怒气。</color>]],
		MaxUseCount = 0,
		id = 1024101,
		EnergyChange = 2,
		desc = {
			101024101
		},
		abilities = {
			1024101
		}
	},
	[1024305] = {
		element_type = 10,
		name = "幽冥穿梭",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "极限闪避后一定时间内衔接普通攻击，会施放技能攻击对敌人造成暗属性伤害，「狼魂」会立即对自身锁定的敌人发动「狼魂狂舞」的协同攻击。\n闪避效果：获得怒气。",
		MaxUseCount = 0,
		abilities = "",
		id = 1024305,
		EnergyChange = 0,
		desc = {
			101024305
		}
	},
	[1024201] = {
		element_type = 10,
		name = "狼魂疾突",
		cd = 10000,
		strengthen_desc = "",
		simpleDesc = "凝聚神力对目标进行远程冲击，造成暗属性伤害，命中时自身会心率提高；当「狼魂」在场上时，该技能额外造成暗属性伤害，命中时「狼魂引渡」会替换为「狼魂凝视」；「狼魂」会立即对自身锁定的敌人发动协同攻击。",
		MaxUseCount = 0,
		id = 1024201,
		EnergyChange = -20,
		desc = {
			101024201
		},
		abilities = {
			1024201
		}
	},
	[1024202] = {
		element_type = 10,
		name = "狼魂狂舞",
		cd = 10000,
		strengthen_desc = "",
		simpleDesc = "凝聚神力对目标进行环形切割，造成暗属性伤害，命中时自身暗属性伤害提高；当「狼魂」在场上时，该技能额外造成暗属性伤害，命中时「狼魂引渡」会替换为「狼魂狂斩」，「狼魂」会立即对自身锁定的敌人发动协同攻击。",
		MaxUseCount = 0,
		id = 1024202,
		EnergyChange = -20,
		desc = {
			101024202
		},
		abilities = {
			1024202
		}
	},
	[1024203] = {
		element_type = 10,
		name = "狼魂引渡",
		cd = 15000,
		strengthen_desc = "",
		simpleDesc = [[
当场上没有「狼魂」时，召唤「狼魂」并攻击自身锁定的敌人，造成暗属性伤害。「狼魂」已经存在于场上时，该技能会替换为「狼魂凝视」。
「狼魂凝视」：造成暗属性伤害，「狼魂」会立即对自身锁定的敌人发动协同攻击，技能命中时会触发射线追击，造成暗属性伤害。
「狼魂狂斩」：造成暗属性伤害，「狼魂」会立即对自身锁定的敌人发动协同攻击，技能命中时会触发狼爪追击，造成暗属性伤害。
当自身施放「狼魂引渡」、「狼魂凝视」或「狼魂狂斩」时，「狼魂」会继承自身当前属性。]],
		MaxUseCount = 0,
		id = 1024203,
		EnergyChange = 0,
		desc = {
			101024203
		},
		abilities = {
			1024203
		}
	},
	[1024209] = {
		element_type = 10,
		name = "亡者审判",
		cd = 25000,
		strengthen_desc = "",
		simpleDesc = [[
仅当「狼魂」在场上时可以施放。自身与「狼魂」合体，造成暗属性伤害；施放时全队伍攻击力提高；重置自身技能的冷却时间。
与「狼魂」合体期间，技能三会固定替换为「狼魂狂斩」；每次施放普通攻击或技能时，会触发额外攻击造成奥义伤害。

队友、「狼魂」击败敌人或「狼魂」的协同攻击命中时，获得奥义值。]],
		MaxUseCount = 0,
		id = 1024209,
		EnergyChange = 0,
		desc = {
			101024209
		},
		abilities = {
			1024209
		}
	},
	[1132101] = {
		element_type = 4,
		name = "炽焰烈击",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
处于「燃剑」姿态：连续挥舞长剑进行强力的斩击，造成火属性伤害。
处于「炽甲」姿态：使用拳甲进行快速而连续的攻击，造成火属性伤害。

<size=28><color=#0068C3>怒气：普通攻击命中后会获得怒气。</color></size>]],
		MaxUseCount = 0,
		id = 1132101,
		EnergyChange = 4,
		desc = {
			101132101
		},
		abilities = {
			1132101
		}
	},
	[1132201] = {
		element_type = 4,
		name = "爆烈强攻",
		cd = 8000,
		strengthen_desc = "",
		simpleDesc = "处于「燃剑」姿态：挥舞长剑向前方斩击，造成火属性伤害，对命中的敌人附加眩晕状态。\n处于「炽甲」姿态：向前突进，使用拳甲重击前方的敌人，消耗怒气，造成火属性伤害，命中时使敌人火属性抗性降低。",
		MaxUseCount = 0,
		id = 1132201,
		EnergyChange = -25,
		desc = {
			101132201
		},
		abilities = {
			1132201
		}
	},
	[1132202] = {
		element_type = 4,
		name = "焚灭掳夺",
		cd = 12000,
		strengthen_desc = "",
		simpleDesc = "处于「燃剑」姿态：挥舞长剑进行大范围的横扫，造成火属性伤害。\n处于「炽甲」姿态：消耗怒气，将旋转长剑移动到锁定的敌人位置并刷新旋转长剑的持续时间，提高旋转长剑造成的伤害。",
		MaxUseCount = 0,
		id = 1132202,
		EnergyChange = -35,
		desc = {
			101132202
		},
		abilities = {
			1132202
		}
	},
	[1132203] = {
		element_type = 4,
		name = "炙炼侵袭",
		cd = 24000,
		strengthen_desc = "",
		simpleDesc = "将长剑向目标位置旋转掷出，自身切换为「炽甲」姿态。长剑命中第一个敌人时会在停留在该位置持续旋转，并持续造成范围火属性伤害，持续时间结束后，旋转长剑消失，自身切换为「燃剑」姿态，之后该技能进入冷却。\n长剑在目标位置持续旋转时，可再次点击该技能，收回长剑。收回长剑后自身切换为「燃剑」姿态，长剑与拳甲合并施放强力攻击，造成火属性伤害。施放强力攻击时自身免疫控制与伤害，之后该技能进入冷却。",
		MaxUseCount = 0,
		abilities = "",
		id = 1132203,
		EnergyChange = 0,
		desc = {
			101132203
		}
	},
	[1132209] = {
		element_type = 4,
		name = "业火重燃",
		cd = 25000,
		strengthen_desc = "",
		simpleDesc = "收回长剑并切换为「燃剑」姿态，以神力凝聚烈焰，进行一次大范围的强力斩击，造成火属性伤害；命中时全队伍技能伤害提高、奥义伤害提高。\n\n自身或者队友施放奥义时，获得奥义值。",
		MaxUseCount = 0,
		id = 1132209,
		EnergyChange = 0,
		desc = {
			101132209
		},
		abilities = {
			1132209
		}
	},
	[1132305] = {
		element_type = 4,
		name = "暗域流火",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：获得怒气；火属性伤害提高。",
		MaxUseCount = 0,
		abilities = "",
		id = 1132305,
		EnergyChange = 0,
		desc = {
			101132305
		}
	},
	[1075101] = {
		element_type = 4,
		name = "天南法门",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
陵光参悟星宿而习得的御火秘法。
造成火属性伤害。在施放任一技能的「起式」、「燃式」后衔接普通攻击，会从普通攻击第四段开始攻击；施放技能「离行不息·起式」、「晋照升明·起式」时可以点击普通攻击键衔接普通攻击第四段，并打断原技能动作。

被动：
普通攻击第四段或第五段命中时、施放「天同人和·起式」命中时，「离行不息」和「晋照升明」会在「起式」、「燃式」之间切换。
施放技能后一定时间内再次施放技能时，判定为连续施放；连续施放多个技能后，进入「烈离」状态。
「烈离」：状态期间所有技能统一切换为「烈式」，并且仅可以施放其中的任意一个，状态结束时所有技能切换为「起式」。

<color=#0068C3>印记：普通攻击第五段命中敌人时，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1075101,
		EnergyChange = 0,
		desc = {
			101075101
		},
		abilities = {
			1075101
		}
	},
	[1075201] = {
		element_type = 4,
		name = "离行不息",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
该技能实战中有三式。
「起式」：突进后挥舞折扇攻击敌人，造成火属性伤害。
「燃式」：疾速突进攻击沿途敌人，造成火属性伤害。
「烈式」：消耗印记，对自身周围造成火属性伤害。施放时全队伍获得「炫铠」。
「炫铠」：获得基于澄心·陵光生命值上限的护盾。

<color=#0068C3>印记：「起式」或「燃式」攻击命中后，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1075201,
		EnergyChange = 1,
		desc = {
			101075201
		},
		abilities = {
			1075201
		}
	},
	[1075202] = {
		element_type = 4,
		name = "晋照升明",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
该技能实战中有三式。
「起式」：挥舞折扇攻击前方敌人，造成火属性伤害。
「燃式」：后跃并留下旋转的折扇攻击敌人，造成火属性伤害。
「烈式」：消耗印记，对自身周围造成共计火属性伤害。施放时全队伍获得「烬火」。
「烬火」：生命值低于一定值时，生命值越低，命中瞬间伤害上升越高。

<color=#0068C3>印记：「起式」或「燃式」攻击命中后，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1075202,
		EnergyChange = 1,
		desc = {
			101075202
		},
		abilities = {
			1075202
		}
	},
	[1075203] = {
		element_type = 4,
		name = "天同人和",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = [[
该技能实战中有三式。
「起式」：挥舞折扇同时突进攻击前方大范围的敌人，造成火属性伤害，命中后，该技能切换为「燃式」。
「燃式」：交叉挥舞折扇攻击前方大范围的敌人，造成火属性伤害，命中后，该技能切换为「起式」。
「烈式」：消耗印记，对自身周围造成火属性伤害。施放时全队伍获得「煌焰」。
「煌焰」：生命值不低于一定值时，生命值越高，命中瞬间伤害上升越高。

<color=#0068C3>印记：「起式」或「燃式」攻击命中后，获得印记。</color>]],
		MaxUseCount = 0,
		id = 1075203,
		EnergyChange = 1,
		desc = {
			101075203
		},
		abilities = {
			1075203
		}
	},
	[1075209] = {
		element_type = 4,
		name = "赤雀星耀",
		cd = 20000,
		strengthen_desc = "",
		simpleDesc = [[
施放任意技能的「烈式」后，全队伍获得「阳炽」；施放奥义后，全队伍获得「烈阳炽」；拥有「烈阳炽」时，「阳炽」的加成效果不生效。
「阳炽」：按照一定概率提高命中瞬间独立伤害。
「烈阳炽」：按照更高的概率提高命中瞬间独立伤害。

自身或者队友造成会心时，获得奥义值。]],
		MaxUseCount = 0,
		abilities = "",
		id = 1075209,
		EnergyChange = 0,
		desc = {
			101075209
		}
	},
	[1075305] = {
		element_type = 16,
		name = "朱羽落",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "闪避效果：零时空间。",
		MaxUseCount = 0,
		abilities = "",
		id = 1075305,
		EnergyChange = 0,
		desc = {
			101075305
		}
	},
	[1027208] = {
		element_type = 6,
		name = "极川冰原",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1027208,
		EnergyChange = 0,
		desc = {
			101027208
		}
	},
	[1011208] = {
		element_type = 0,
		name = "异奏同心",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1011208,
		EnergyChange = 0,
		desc = {
			101011208
		}
	},
	[1093208] = {
		element_type = 0,
		name = "弥月降樱",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1093208,
		EnergyChange = 0,
		desc = {
			101093208
		}
	},
	[1037208] = {
		element_type = 0,
		name = "月面陨击兔",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1037208,
		EnergyChange = 0,
		desc = {
			101037208
		}
	},
	[1039208] = {
		element_type = 0,
		name = "三色协奏",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1039208,
		EnergyChange = 0,
		desc = {
			101039208
		}
	},
	[1050208] = {
		element_type = 0,
		name = "千羽雷葬",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1050208,
		EnergyChange = 0,
		desc = {
			101050208
		}
	},
	[1032208] = {
		element_type = 0,
		name = "煊煌棋阵",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1032208,
		EnergyChange = 0,
		desc = {
			101032208
		}
	},
	[1026208] = {
		element_type = 0,
		name = "鸣河铄炎",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1026208,
		EnergyChange = 0,
		desc = {
			101026208
		}
	},
	[1019208] = {
		element_type = 0,
		name = "风卷潮歌",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1019208,
		EnergyChange = 0,
		desc = {
			101019208
		}
	},
	[1011281] = {
		element_type = 0,
		name = "双生连华",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1011281,
		EnergyChange = 0,
		desc = {
			101011281
		}
	},
	[1026281] = {
		element_type = 0,
		name = "焚烬天陨",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1026281,
		EnergyChange = 0,
		desc = {
			101026281
		}
	},
	[1038208] = {
		element_type = 0,
		name = "霜翼焱舞",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1038208,
		EnergyChange = 0,
		desc = {
			101038208
		}
	},
	[1013208] = {
		element_type = 0,
		name = "星弹豪拳",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1013208,
		EnergyChange = 0,
		desc = {
			101013208
		}
	},
	[1050281] = {
		element_type = 0,
		name = "绯渊裂影",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1050281,
		EnergyChange = 0,
		desc = {
			101050281
		}
	},
	[1019281] = {
		element_type = 0,
		name = "道标之风",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1019281,
		EnergyChange = 0,
		desc = {
			101019281
		}
	},
	[1019282] = {
		element_type = 0,
		name = "磔魂翎岚",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1019282,
		EnergyChange = 0,
		desc = {
			101019282
		}
	},
	[1035208] = {
		element_type = 0,
		name = "狂兽凶火",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1035208,
		EnergyChange = 0,
		desc = {
			101035208
		}
	},
	[1184208] = {
		element_type = 0,
		name = "执誓镌雷",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1184208,
		EnergyChange = 0,
		desc = {
			101184208
		}
	},
	[1096208] = {
		element_type = 0,
		name = "星合寰风",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1096208,
		EnergyChange = 0,
		desc = {
			101096208
		}
	},
	[1048208] = {
		element_type = 0,
		name = "彗星环游",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1048208,
		EnergyChange = 0,
		desc = {
			101048208
		}
	},
	[1027281] = {
		element_type = 0,
		name = "凛冰疾跃",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1027281,
		EnergyChange = 0,
		desc = {
			101027281
		}
	},
	[1080208] = {
		element_type = 0,
		name = "潮涌霜寒",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1080208,
		EnergyChange = 0,
		desc = {
			101080208
		}
	},
	[1056208] = {
		element_type = 0,
		name = "奔雷凌川",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1056208,
		EnergyChange = 0,
		desc = {
			101056208
		}
	},
	[1119208] = {
		element_type = 0,
		name = "雷引惊岚",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1119208,
		EnergyChange = 0,
		desc = {
			101119208
		}
	},
	[1042208] = {
		element_type = 0,
		name = "谑戏梦曲",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1042208,
		EnergyChange = 0,
		desc = {
			101042208
		}
	},
	[1067208] = {
		element_type = 0,
		name = "流影朔风",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1067208,
		EnergyChange = 0,
		desc = {
			101067208
		}
	},
	[1038281] = {
		element_type = 0,
		name = "炽弦协律",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1038281,
		EnergyChange = 0,
		desc = {
			101038281
		}
	},
	[1033208] = {
		element_type = 0,
		name = "环曜星拳兔",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1033208,
		EnergyChange = 0,
		desc = {
			101033208
		}
	},
	[1017208] = {
		element_type = 0,
		name = "幻像猎袭",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1017208,
		EnergyChange = 0,
		desc = {
			101017208
		}
	},
	[1016208] = {
		element_type = 0,
		name = "染火锯链",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1016208,
		EnergyChange = 0,
		desc = {
			101016208
		}
	},
	[1016281] = {
		element_type = 0,
		name = "怒焰狂刃",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1016281,
		EnergyChange = 0,
		desc = {
			101016281
		}
	},
	[1024208] = {
		element_type = 0,
		name = "奔狼狂鳄",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1024208,
		EnergyChange = 0,
		desc = {
			101024208
		}
	},
	[1028208] = {
		element_type = 0,
		name = "光耀雷鸣",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1028208,
		EnergyChange = 0,
		desc = {
			101028208
		}
	},
	[1028281] = {
		element_type = 0,
		name = "冥域惊雷",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1028281,
		EnergyChange = 0,
		desc = {
			101028281
		}
	},
	[1058208] = {
		element_type = 0,
		name = "流炎炽印",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1058208,
		EnergyChange = 0,
		desc = {
			101058208
		}
	},
	[1068208] = {
		element_type = 0,
		name = "清风拂竹",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1068208,
		EnergyChange = 0,
		desc = {
			101068208
		}
	},
	[1070208] = {
		element_type = 0,
		name = "赤炁曜阳",
		cd = 0,
		strengthen_desc = "",
		simpleDesc = "",
		MaxUseCount = 0,
		abilities = "",
		id = 1070208,
		EnergyChange = 0,
		desc = {
			101070208
		}
	},
	all = {
		1050101,
		1050201,
		1050202,
		1050221,
		1050203,
		1050209,
		1050305,
		1071101,
		1071201,
		1071202,
		1071203,
		1071209,
		1071305,
		1052101,
		1052201,
		1052202,
		1052221,
		1052203,
		1052231,
		1052209,
		1052305,
		1066101,
		1066201,
		1066202,
		1066203,
		1066231,
		1066209,
		1066305,
		1048101,
		1048201,
		1048211,
		1048202,
		1048203,
		1048209,
		1048305,
		1148101,
		1148201,
		1148202,
		1148203,
		1148209,
		1148305,
		1039101,
		1039201,
		1039211,
		1039202,
		1039203,
		1039209,
		1039305,
		1139101,
		1139201,
		1139202,
		1139203,
		1139209,
		1139305,
		1035101,
		1035201,
		1035202,
		1035203,
		1035209,
		1035305,
		1036101,
		1036201,
		1036202,
		1036203,
		1036231,
		1036209,
		1036305,
		1037101,
		1037201,
		1037202,
		1037203,
		1037231,
		1037209,
		1037305,
		1027101,
		1027201,
		1027202,
		1027221,
		1027203,
		1027209,
		1027305,
		1127101,
		1127201,
		1127202,
		1127203,
		1127209,
		1127305,
		1028101,
		1028201,
		1028202,
		1028203,
		1028209,
		1028305,
		1019101,
		1019201,
		1019202,
		1019203,
		1019233,
		1019305,
		1019209,
		1119101,
		1119201,
		1119202,
		1119203,
		1119209,
		1119305,
		1011101,
		1011201,
		1011202,
		1011203,
		1011209,
		1011305,
		1013101,
		1013111,
		1013201,
		1013202,
		1013203,
		1013209,
		1013305,
		1056101,
		1056201,
		1056202,
		1056203,
		1056209,
		1056305,
		1058101,
		1058201,
		1058202,
		1058203,
		1058209,
		1058305,
		1059101,
		1059201,
		1059202,
		1059203,
		1059209,
		1059305,
		1041101,
		1041201,
		1041202,
		1041203,
		1041209,
		1041305,
		1042101,
		1042201,
		1042202,
		1042203,
		1042209,
		1042305,
		1038101,
		1038201,
		1038202,
		1038221,
		1038203,
		1038209,
		1038305,
		1084101,
		1084201,
		1084212,
		1084202,
		1084203,
		1084305,
		1084209,
		1184101,
		1184201,
		1184202,
		1184203,
		1184209,
		1184305,
		1080101,
		1080111,
		1080201,
		1080202,
		1080203,
		1080305,
		1080209,
		1081101,
		1081201,
		1081202,
		1081203,
		1081209,
		1081305,
		1093101,
		1093231,
		1093232,
		1093233,
		1093236,
		1093305,
		1094101,
		1094201,
		1094202,
		1094203,
		1094209,
		1094305,
		1096101,
		1096201,
		1096202,
		1096203,
		1096209,
		1096305,
		1097101,
		1097201,
		1097202,
		1097221,
		1097203,
		1097209,
		1097305,
		1026101,
		1026201,
		1026202,
		1026203,
		1026209,
		1026305,
		1099101,
		1099201,
		1099202,
		1099203,
		1099231,
		1099209,
		1099305,
		1032101,
		1032106,
		1032305,
		1032201,
		1032202,
		1032203,
		1032209,
		1033101,
		1033305,
		1033201,
		1033202,
		1033203,
		1033231,
		1033209,
		1199101,
		1199201,
		1199202,
		1199203,
		1199209,
		1199305,
		1138101,
		1138201,
		1138202,
		1138203,
		1138209,
		1138305,
		1138351,
		1111101,
		1111305,
		1111201,
		1111202,
		1111203,
		1111209,
		1017101,
		1017201,
		1017202,
		1017203,
		1017209,
		1017305,
		1068101,
		1068201,
		1068202,
		1068203,
		1068209,
		1068305,
		1070101,
		1070201,
		1070202,
		1070203,
		1070209,
		1070305,
		1067101,
		1067201,
		1067202,
		1067203,
		1067209,
		1067305,
		1016101,
		1016201,
		1016202,
		1016203,
		1016209,
		1016305,
		1024101,
		1024305,
		1024201,
		1024202,
		1024203,
		1024209,
		1132101,
		1132201,
		1132202,
		1132203,
		1132209,
		1132305,
		1075101,
		1075201,
		1075202,
		1075203,
		1075209,
		1075305,
		1027208,
		1011208,
		1093208,
		1037208,
		1039208,
		1050208,
		1032208,
		1026208,
		1019208,
		1011281,
		1026281,
		1038208,
		1013208,
		1050281,
		1019281,
		1019282,
		1035208,
		1184208,
		1096208,
		1048208,
		1027281,
		1080208,
		1056208,
		1119208,
		1042208,
		1067208,
		1038281,
		1033208,
		1017208,
		1016208,
		1016281,
		1024208,
		1028208,
		1028281,
		1058208,
		1068208,
		1070208
	}
}
