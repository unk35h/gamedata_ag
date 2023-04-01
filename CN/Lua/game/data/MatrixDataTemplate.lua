MatrixConst = {
	MATRIX_UNLOCK_SPECIAL_DIFFICULTY_CONDITION = 20401,
	MATRIX_UNLOCK_DIFFICULTY_CONDITION = 20301,
	MATRIX_UNLOCK_CUSTOM_AFFIX_CONDITION = 20401,
	EVENT_TYPE = {
		CURRENCY = 5,
		TREASURE_ELITE = 8,
		TREASURE = 7,
		EQUIP = 2,
		BOSS = 9,
		INCIDENT = 12,
		SHOP = 11,
		FINAL = 10,
		ASTROLABE = 1,
		CURRENCY_ELITE = 6,
		WEAPON_SERVANT_ELITE = 4,
		WEAPON_SERVANT = 3
	},
	ITEM_TYPE = {
		TREASURE = 5,
		ASTROLABE = 1,
		EQUIP = 2,
		ITEM = 4,
		EFFECT = 6,
		WEAPON_SERVANT = 3
	},
	STATE_TYPE = {
		SUCCESS = 3,
		STARTED = 2,
		NOTSTARTED = 1,
		FAIL = 4
	},
	PHASE_TYPE = {
		UNDEFINE = 0,
		REWARD = 3,
		CHOSE = 1,
		ACTION = 2
	},
	MATRIX_ATTRIBUTE_TYPE = {
		GIVE_UP_REWARD_ADDITION = 14,
		MAX_EQUIP_COUNT = 2,
		MAX_ASTROLABE_COUNT = 3,
		SHOP_REFRESH_TIMES = 9,
		SHOP_FRESS_REFRESH_TIMES = 10,
		SCORE_ADDITION = 17,
		CHANGE_TEAM_LEADER = 15,
		SHOP_FIRST_GOODS_DISCOUNT = 11,
		WEAPON_LEVEL = 1
	},
	EFFECT_ACTION = {
		AFFIX = 4,
		CURRENCY = 7,
		ATTRIBUTE = 5
	},
	DIFFICULTY_COLOR = {
		"E7E7E7",
		"F25353",
		"F25353"
	},
	DIFFICULTY_OVER_COLOR = {
		"0077B9",
		"B73E3E",
		"B73E3E"
	},
	ARTIFACT_RARE_IMAGE_COLOR = {
		Color.New(0.3921569, 0.5843138, 0.1058824, 0.2),
		Color.New(0, 0.4666667, 0.7254902, 0.2),
		Color.New(0.6901961, 0.2901961, 0.8, 0.2),
		Color.New(0.8470588, 0.682353, 0, 0.2)
	},
	ARTIFACT_RARE_TEXT = {
		"MATRIX_ARTIFACT_RARE1",
		"MATRIX_ARTIFACT_RARE2",
		"MATRIX_ARTIFACT_RARE3",
		"MATRIX_ARTIFACT_RARE4"
	},
	ARTIFACT_RARE_TEXT_COLOR = {
		"97BF5E",
		"008DDB",
		"D190E8",
		"FFEE36"
	},
	MATRIX_GAME_HELP_PAGES = {
		"Textures/ChapterPaint/chapter/matrix_courses_01",
		"Textures/ChapterPaint/chapter/matrix_courses_02",
		"Textures/ChapterPaint/chapter/matrix_courses_03",
		"Textures/ChapterPaint/chapter/matrix_courses_04",
		"Textures/ChapterPaint/chapter/matrix_courses_05",
		"Textures/ChapterPaint/chapter/matrix_courses_06",
		"Textures/ChapterPaint/chapter/matrix_courses_07",
		"Textures/ChapterPaint/chapter/matrix_courses_08"
	},
	MatirxRankType = {
		ALL = 1,
		GUILD = 2
	},
	MatirxRankSubType = {
		SPECIAL = 2,
		COMMON = 1
	}
}
MatrixTools = {
	GetMatrixItemSprite = function (slot0)
		if MatrixItemCfg[slot0].matrix_item_type == MatrixConst.ITEM_TYPE.TREASURE or slot1.matrix_item_type == MatrixConst.ITEM_TYPE.EFFECT then
			return getSpriteWithoutAtlas("Textures/MatrixItem/MatrixArtifact/" .. slot1.icon)
		elseif slot1.matrix_item_type == MatrixConst.ITEM_TYPE.WEAPON_SERVANT then
			return getSpriteWithoutAtlas(SpritePathCfg.ServantIcon.path .. slot1.icon)
		elseif slot1.matrix_item_type == MatrixConst.ITEM_TYPE.EQUIP then
			return getSpriteWithoutAtlas(SpritePathCfg.EquipIcon.path .. slot1.icon)
		elseif slot1.matrix_item_type == MatrixConst.ITEM_TYPE.ITEM then
			return ItemTools.getItemSprite(tonumber(slot1.icon))
		elseif slot1.matrix_item_type == MatrixConst.ITEM_TYPE.ASTROLABE then
			if slot1.icon == "red" then
				return getSprite("Atlas/Common", "icon_red_a")
			elseif slot1.icon == "blue" then
				return getSprite("Atlas/Common", "icon_blue_a")
			elseif slot1.icon == "yellow" then
				return getSprite("Atlas/Common", "icon_yellow_a")
			end
		end

		return nil
	end,
	GetMatrixItemDes = function (slot0, slot1, slot2)
		if MatrixItemCfg[slot0].matrix_item_type == MatrixConst.ITEM_TYPE.ASTROLABE then
			slot5 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot3.params[1]]

			if slot1 then
				return GetCfgDescription(AstrolabeEffectCfg[slot5[math.min(3, slot1)]].desc[1], 1)
			end
		elseif slot3.matrix_item_type == MatrixConst.ITEM_TYPE.EQUIP then
			return EquipTools.GetEffectDesc(EquipSuitCfg[slot3.params[1]].suit_effect[1])
		elseif slot3.matrix_item_type == MatrixConst.ITEM_TYPE.WEAPON_SERVANT then
			slot7 = WeaponEffectCfg[WeaponServantCfg[slot3.params[1]].effect[1]]
			slot8 = nil

			if slot2 and slot2 ~= 0 then
				if ActivityTools.GetActivityType(slot2) == ActivityTemplateConst.SUB_SINGLE_MATRIX then
					slot8 = ActivityMatrixData:GetWeaponServantLevel(slot2)
				elseif slot9 == ActivityTemplateConst.STRATEGY_MATRIX then
					slot8 = StrategyMatrixData:GetWeaponServantLevel(slot2)
				else
					error("GetMatrixItemDes can not find current weapon level")

					slot8 = 1
				end
			else
				slot8 = MatrixData:GetWeaponServantLevel()
			end

			return GetCfgDescription(slot7.description[1], slot8)
		elseif slot3.matrix_item_type == MatrixConst.ITEM_TYPE.TREASURE and MatrixConst.EFFECT_ACTION.AFFIX == MatrixEffectCfg[slot3.params[1]].action then
			return getAffixDesc(slot5.params)
		end

		return slot3.desc
	end,
	GetWeaponSpecHero = function (slot0)
		return WeaponEffectCfg[WeaponServantCfg[slot0].effect[1]].spec_char[1] or 0
	end,
	MatrixExpToLevel = function (slot0)
		slot2 = 1
		slot3 = #MatrixTerminalLevelCfg.all
		slot4 = -1

		while slot2 <= slot3 do
			if slot0 < MatrixTerminalLevelCfg[slot1[slot2 + math.floor((slot3 - slot2) / 2)]].exp then
				slot3 = slot5 - 1
			else
				slot4 = slot5
				slot2 = slot5 + 1
			end
		end

		return slot1[slot4], slot0 - MatrixTerminalLevelCfg[slot1[slot4]].exp
	end
}
slot0 = {}

function MatrixTools.GetGiftListByGroup(slot0)
	if uv0[slot0] then
		return uv0[slot0]
	end

	uv0[slot0] = {}
	slot1 = MatrixTerminalGiftCfg.get_id_list_by_group[slot0] or {}
	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		if MatrixTerminalGiftCfg[slot7].pre_id and slot9 ~= 0 then
			slot2[slot9] = true
		end
	end

	slot3 = {}

	for slot7, slot8 in pairs(slot1) do
		if not slot2[slot8] then
			slot9 = {}

			if MatrixTerminalGiftCfg[slot8].pre_id and slot10.pre_id ~= 0 then
				while slot8 and slot8 ~= 0 do
					table.insert(slot9, 1, slot8)

					slot8 = MatrixTerminalGiftCfg[slot8] and slot11.pre_id or nil
				end

				table.insert(uv0[slot0], {
					type = 1,
					list = slot9
				})
			else
				table.insert(slot3, slot8)
			end
		end
	end

	slot4 = #slot3
	slot5 = math.floor(slot4 / 5) * 2

	if slot4 % 5 == 0 then
		-- Nothing
	elseif slot4 % 5 >= 4 then
		slot5 = slot5 + 2
	else
		slot5 = slot5 + 1
	end

	for slot9 = 1, slot5 do
		slot10 = 0
		slot11 = #slot3
		slot11 = (slot9 % 2 ~= 0 or math.min(#slot3, math.max(1, slot9 / 2 * 5 - 1) + 1)) and math.min(#slot3, math.max(1, math.ceil(slot9 / 2) * 5 - 4) + 2)
		slot12 = {}

		for slot16 = slot10, slot11 do
			table.insert(slot12, slot3[slot16])
		end

		table.insert(uv0[slot0], {
			type = 2,
			list = slot12,
			row = slot9 % 2 == 0
		})
	end

	return uv0[slot0]
end

function MatrixTools.GetAffixByEffectId(slot0, slot1)
	if MatrixEffectCfg[slot0] and MatrixConst.EFFECT_ACTION.AFFIX == slot2.action then
		if slot1 then
			return {
				slot2.params[1],
				slot1,
				slot2.params[3]
			}
		else
			return slot2.params
		end
	end

	return nil
end

function MatrixTools.GetAttrByEffectId(slot0, slot1)
	if MatrixEffectCfg[slot1] and MatrixConst.EFFECT_ACTION.ATTRIBUTE == slot2.action then
		for slot6, slot7 in ipairs(slot2.params) do
			slot9 = slot7[2]

			if slot0[slot7[1]] == nil then
				slot0[slot8] = 0
			end

			slot0[slot8] = slot0[slot8] + slot9
		end
	end
end

function MatrixTools.UpdateSortScoreList()
	slot0 = MatrixData
	slot1 = MatrixData
	slot1 = slot1:GetTerminalLevel()

	table.sort(slot0:GetPointRewardList(), function (slot0, slot1)
		slot2 = slot0.need_level <= uv0
		slot3 = slot1.need_level <= uv0

		if slot1.is_got_reward == slot0.is_got_reward then
			if slot2 == slot3 then
				return slot0.rank < slot1.rank
			end

			return slot2
		else
			return slot0.is_got_reward < slot1.is_got_reward
		end
	end)
end

function MatrixTools.GetBeaconIsUnlockCondition(slot0)
	if MatrixBeaconCfg[slot0] and slot1.new_condition ~= 0 then
		return IsConditionAchieved(slot1.new_condition)
	end

	return true
end

MatrixDifficultyTemplate = class("MatrixHeroTemplate")

function MatrixDifficultyTemplate.Ctor(slot0, slot1)
	slot0.difficulty = slot1.difficulty
	slot0.regularAffixs = {}

	for slot5, slot6 in ipairs(slot1.regular_affix_list) do
		table.insert(slot0.regularAffixs, slot6)
	end

	slot0.allCustomAffixs = {}

	for slot5, slot6 in ipairs(slot1.custom_affix_list) do
		table.insert(slot0.allCustomAffixs, slot6)
	end

	slot0.affixs = nil
	slot0.chipManagerID_ = slot1.ai_chip_list[1] or 0
	slot0.chipIDList_ = {}

	for slot6 = 2, 3 do
		slot0.chipIDList_[slot6 - 1] = slot2[slot6] or 0
	end

	slot0.price_template_id = slot1.price_template_id
end

function MatrixDifficultyTemplate.GetDifficulty(slot0)
	return slot0.difficulty
end

function MatrixDifficultyTemplate.GetRegularAffix(slot0)
	return slot0.regularAffixs
end

function MatrixDifficultyTemplate.GetAllCustomAffix(slot0)
	return slot0.allCustomAffixs
end

function MatrixDifficultyTemplate.GetChipManagerID(slot0)
	return slot0.chipManagerID_
end

function MatrixDifficultyTemplate.GetChipIDList(slot0)
	return slot0.chipIDList_
end

MatrixHeroTemplate = class("MatrixHeroTemplate")

function MatrixHeroTemplate.Ctor(slot0, slot1, slot2)
	slot0.hero_id = slot1
	slot0.heroStandardId = slot2
	slot0.health_point = 0
	slot0.max_health_point = 0
	slot0.astrolabe_list = {}
	slot0.equip_list = {}
	slot0.weapon_servant = 0
	slot0.buff_list = {}
	slot0.astrolabe_count_list = {}
	slot0.astrolabe_effect_list = nil
end

function MatrixHeroTemplate.InitData(slot0, slot1)
	slot0.health_point = slot1.health_point
	slot0.max_health_point = slot1.max_health_point
	slot0.astrolabe_list = {}
	slot0.astrolabe_count_list = {}
	slot0.astrolabe_effect_list = nil

	for slot5, slot6 in ipairs(slot1.astrolabe_list) do
		table.insert(slot0.astrolabe_list, slot6)

		if not slot0.astrolabe_count_list[MatrixItemCfg[slot6] and slot7.params[1]] then
			slot0.astrolabe_count_list[slot8] = 0
		end

		slot0.astrolabe_count_list[slot8] = slot0.astrolabe_count_list[slot8] + 1
	end

	function slot5(slot0, slot1)
		return slot0 < slot1
	end

	table.sort(slot0.astrolabe_list, slot5)

	slot0.equip_list = {}

	for slot5, slot6 in ipairs(slot1.equip_list) do
		table.insert(slot0.equip_list, slot6)
	end

	function slot5(slot0, slot1)
		return slot0 < slot1
	end

	table.sort(slot0.equip_list, slot5)

	slot0.weapon_servant = slot1.weapon_servant
	slot0.effect_list = {}

	for slot5, slot6 in ipairs(slot1.effect_list) do
		table.insert(slot0.effect_list, slot6)
	end

	slot0.totalDamage_ = slot1.total_damage or 0
	slot0.totalHurt_ = slot1.total_injured or 0
	slot0.totalHeal_ = slot1.total_heal or 0
end

function MatrixHeroTemplate.GetAstrolabeNum(slot0, slot1)
	return slot0.astrolabe_count_list[slot1] or 0
end

function MatrixHeroTemplate.GetStandardId(slot0)
	return slot0.heroStandardId
end

function MatrixHeroTemplate.GetAstrolabeList(slot0)
	return slot0.astrolabe_list
end

function MatrixHeroTemplate.GetAstrolabeEffectList(slot0)
	if slot0.astrolabe_effect_list then
		return slot0.astrolabe_effect_list
	end

	slot0.astrolabe_effect_list = {}

	for slot4, slot5 in pairs(slot0.astrolabe_count_list) do
		if HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot4] then
			for slot10 = 1, slot5 do
				table.insert(slot0.astrolabe_effect_list, slot6[slot10])
			end
		end
	end

	return slot0.astrolabe_effect_list
end

function MatrixHeroTemplate.GetEquipList(slot0)
	return slot0.equip_list
end

function MatrixHeroTemplate.GetEquipEffectList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.equip_list) do
		table.insert(slot1, MatrixItemCfg[slot6] and slot7.params[1])
	end

	return slot1
end

function MatrixHeroTemplate.GetWeaponServant(slot0)
	return slot0.weapon_servant
end

function MatrixHeroTemplate.GetWeaponServantEffect(slot0)
	return MatrixItemCfg[slot0.weapon_servant] and slot1.params[1] or 0
end

function MatrixHeroTemplate.GetWeaponServantEffectLevel(slot0)
	return MatrixData:GetWeaponServantLevel() or 1
end

function MatrixHeroTemplate.IsDead(slot0)
	return slot0.health_point <= 0
end

function MatrixHeroTemplate.GetHeroHP(slot0)
	return slot0.health_point
end

function MatrixHeroTemplate.GetHeroMaxHP(slot0)
	return slot0.max_health_point
end

function MatrixHeroTemplate.GetEffectCount(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in ipairs(slot0.effect_list) do
		if slot1 == slot7 then
			slot2 = slot2 + 1
		end
	end

	return slot2
end

function MatrixHeroTemplate.GetIsOwnerHero(slot0)
	return false
end

MatrixOwnerHeroTemplate = class("MatrixOwnerHeroTemplate", MatrixHeroTemplate)

function MatrixOwnerHeroTemplate.Ctor(slot0, slot1, slot2)
	MatrixOwnerHeroTemplate.super.Ctor(slot0, slot1, slot2)

	slot0.entry_snapshot = nil
end

function MatrixOwnerHeroTemplate.InitData(slot0, slot1)
	MatrixOwnerHeroTemplate.super.InitData(slot0, slot1)

	slot2 = slot1.entry_snapshot
	slot3 = {
		skin = 0,
		trialID = 0,
		id = slot2.hero_id,
		star = slot2.star,
		exp = slot2.exp,
		level = HeroTools.CheckExp(1, slot2.exp),
		equip_list = {},
		using_astrolabe = {},
		skill = {},
		break_level = slot2.break_level,
		weapon_info = {
			exp = slot2.weapon.exp,
			breakthrough = slot2.weapon.breakthrough
		}
	}

	if slot2.weapon.servant then
		slot3.servant = {
			id = slot2.weapon.servant.id,
			stage = slot2.weapon.servant.stage
		}
	else
		slot3.servant = {}
	end

	if slot2.equip_list then
		for slot7, slot8 in ipairs(slot2.equip_list) do
			slot9 = {}

			if slot8.enchant_slot_list then
				for slot13, slot14 in ipairs(slot8.enchant_slot_list) do
					slot15 = slot14.id
					slot17 = {}

					for slot21, slot22 in ipairs(slot14.effect_list) do
						table.insert(slot17, {
							id = slot22.id,
							num = slot22.level
						})
					end

					if #slot17 > 0 then
						slot9[slot13] = slot17
					end
				end
			end

			slot10 = {}
			slot11 = {}

			if slot2.hero_id == slot8.race and slot8.hero_exclusive_skill then
				for slot15, slot16 in ipairs(slot8.hero_exclusive_skill) do
					table.insert(slot10, slot16.id)

					slot11[slot16.id] = {
						id = slot16.id,
						level = slot16.skill_level
					}
				end
			end

			slot3.equip_list[slot7] = {
				equip_id = 1,
				prefab_id = slot8.prefab_id,
				exp = slot8.exp,
				now_break_level = slot8.now_break_level or 0,
				enchant = slot9,
				useList = slot10,
				skillList = slot11,
				race = slot8.race
			}
		end
	end

	if slot2.astrolabe_list then
		for slot7, slot8 in ipairs(slot2.astrolabe_list) do
			slot3.using_astrolabe[slot7] = slot8
		end
	end

	if slot2.skill_list then
		for slot7, slot8 in ipairs(slot2.skill_list) do
			slot3.skill[slot7] = {
				skill_id = slot8.id,
				skill_level = slot8.level
			}
		end
	end

	slot0.entry_snapshot = slot3
end

function MatrixOwnerHeroTemplate.GetIsOwnerHero(slot0)
	return true
end

function MatrixOwnerHeroTemplate.GetEntrySnapShot(slot0)
	return slot0.entry_snapshot
end

MatrixPhaseTemplate = class("MatrixPhaseTemplate")

function MatrixPhaseTemplate.Ctor(slot0, slot1, slot2)
	slot0.phase_id = slot1.phase_id
	slot0.event_id_list = {}

	for slot6, slot7 in ipairs(slot1.event_id_list) do
		table.insert(slot0.event_id_list, slot7)
	end

	slot3 = slot1.event
	slot0.cur_event_id = slot3.event_id
	slot0.envent_params = {}

	for slot7, slot8 in ipairs(slot3.params) do
		table.insert(slot0.envent_params, slot8)
	end

	slot0.reward_items = {}

	for slot8, slot9 in ipairs(slot1.reward.matrix_item_id_list) do
		table.insert(slot0.reward_items, slot9)
	end

	slot0.give_up_item_id = slot4.give_up_matrix_item_id
	slot0.price_template_id = slot2
end

function MatrixPhaseTemplate.GetPhase(slot0)
	return slot0.phase_id
end

function MatrixPhaseTemplate.GetParams(slot0)
	if MatrixConst.PHASE_TYPE.CHOSE == slot0.phase_id then
		return slot0.event_id_list
	elseif MatrixConst.PHASE_TYPE.ACTION == slot0.phase_id then
		return {
			slot0.cur_event_id
		}
	elseif MatrixConst.PHASE_TYPE.REWARD == slot0.phase_id then
		return slot0.reward_items
	else
		return {}
	end
end

function MatrixPhaseTemplate.GetData(slot0)
	slot2 = MatrixPriceTemplateCfg.get_id_list_by_template_id[slot0.price_template_id] or {}

	if MatrixConst.EVENT_TYPE.SHOP == MatrixEventCfg[slot0.cur_event_id].event_type then
		slot3 = slot0.envent_params[1]
		slot4 = {}

		for slot9 = 2, #slot0.envent_params do
			if slot0.envent_params[slot9] and slot10 ~= 0 then
				slot12 = MatrixItemCfg[slot10].price[1]
				slot13 = slot12[1]
				slot14 = slot12[2]

				for slot18, slot19 in ipairs(slot2) do
					if slot10 == MatrixPriceTemplateCfg[slot19].matrix_item_id then
						slot12 = slot20.price[1]
						slot13 = slot12[1]
						slot14 = slot12[2]
					end
				end

				slot15 = 1

				if slot9 - 1 == 1 then
					slot15 = 1 - MatrixData:GetFirstGoodsDiscount() / 1000
					slot14 = math.floor(slot14 - slot14 * MatrixData:GetFirstGoodsDiscount() / 1000)
				end

				table.insert(slot4, {
					index = slot16,
					id = slot10,
					discount = slot15,
					priceId = slot13,
					priceNum = slot14,
					priceOriginal = slot12[2]
				})
			end
		end

		return slot3, slot4
	else
		return slot0.envent_params[1] or 0
	end
end

function MatrixPhaseTemplate.GetShops(slot0)
	return {}
end

function MatrixPhaseTemplate.GetGiveUpItemId(slot0)
	return slot0.give_up_item_id or 0
end

MatrixRankTemplate = class("MatrixRankTemplate")

function MatrixRankTemplate.Ctor(slot0, slot1)
	slot0.user_id = slot1.user_id
	slot0.score = slot1.score
	slot0.difficulty = slot1.difficulty
	slot0.rank = slot1.rank
	slot0.timestamp = slot1.timestamp

	if PlayerData:GetPlayerInfo() and tonumber(slot0.user_id) == slot2.userID then
		slot0.nick = slot2.nick
		slot0.icon = slot2.portrait
		slot0.icon_frame = slot2.icon_frame
	else
		slot0.nick = slot1.nick
		slot0.icon = slot1.portrait
		slot0.icon_frame = slot1.frame
	end

	slot0.select_hero_id_list = {}
	slot3 = slot1.team_info[1] and slot1.team_info[1].hero_info_list or {}

	for slot7, slot8 in ipairs(slot3) do
		table.insert(slot0.select_hero_id_list, {
			id = slot8.hero_id,
			skin_id = slot8.skin_id
		})
	end
end
