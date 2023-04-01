StrategyMatrixConst = {
	NODE_STATE = {
		COMPLETE = 2,
		INVALID = 3,
		CURRENT = 1,
		SELECT = 4,
		STATELESS = 5
	}
}
StrategyMatrixTools = {
	GetCoinItem = function (slot0)
		if ActivityMatrixSettingTemplateCfg.get_id_list_by_template_id[StrategyMatrixCfg[slot0] and slot1.setting_template_id] then
			for slot7, slot8 in ipairs(slot3) do
				if ActivityMatrixSettingTemplateCfg[slot8].type == 15 then
					return ActivityMatrixSettingTemplateCfg[slot8].value[1] or 0
				end
			end
		end

		return 26
	end,
	GetGameTipKey = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.VOLUME_DOWN then
			return "ACTIVITY_STRATEGY_MATRIX_DESCRIBE"
		elseif slot1 == ActivityConst.THEME.DREAM then
			return "ACTIVITY_THOR_STRATEGY_MATRIX_DESCRIBE"
		end

		return ""
	end
}
StrategyMatrixHeroTemplate = class("StrategyMatrixHeroTemplate", MatrixHeroTemplate)

function StrategyMatrixHeroTemplate.Ctor(slot0, slot1, slot2, slot3)
	slot0.activity_id = slot1

	StrategyMatrixHeroTemplate.super.Ctor(slot0, slot2, slot3)
end

function StrategyMatrixHeroTemplate.GetWeaponServantEffectLevel(slot0)
	return StrategyMatrixData:GetWeaponServantLevel(slot0.activity_id) or 1
end

StrategyMatrixPhaseTemplate = class("StrategyMatrixPhaseTemplate")

function StrategyMatrixPhaseTemplate.Ctor(slot0, slot1, slot2)
	slot0.activity_id = slot1
	slot0.phase_id = slot2.phase_id
	slot3 = slot2.event
	slot0.cur_event_id = slot3.event_id
	slot0.envent_params = {}

	for slot7, slot8 in ipairs(slot3.params) do
		table.insert(slot0.envent_params, slot8)
	end

	slot0.reward_items = {}

	for slot8, slot9 in ipairs(slot2.reward.matrix_item_id_list) do
		table.insert(slot0.reward_items, slot9)
	end

	slot0.give_up_item_id = slot4.give_up_matrix_item_id
end

function StrategyMatrixPhaseTemplate.GetPhase(slot0)
	return slot0.phase_id
end

function StrategyMatrixPhaseTemplate.GetParams(slot0)
	if MatrixConst.PHASE_TYPE.ACTION == slot0.phase_id then
		return {
			slot0.cur_event_id
		}
	elseif MatrixConst.PHASE_TYPE.REWARD == slot0.phase_id then
		return slot0.reward_items
	else
		return {}
	end
end

function StrategyMatrixPhaseTemplate.GetData(slot0)
	if MatrixConst.EVENT_TYPE.SHOP == StrategyMatrixEventTemplateCfg[slot0.cur_event_id].event_type then
		slot2 = slot0.envent_params[1]
		slot3 = {}

		for slot8 = 2, #slot0.envent_params do
			if slot0.envent_params[slot8] and slot9 ~= 0 then
				slot11 = MatrixItemCfg[slot9].price[1]
				slot12 = slot11[1]
				slot13 = slot11[2]
				slot14 = 1

				if slot8 - 1 == 1 then
					slot14 = 1 - StrategyMatrixData:GetFirstGoodsDiscount(slot0.activity_id) / 1000
					slot13 = math.floor(slot13 - slot13 * StrategyMatrixData:GetFirstGoodsDiscount(slot0.activity_id) / 1000)
				end

				table.insert(slot3, {
					index = slot15,
					id = slot9,
					discount = slot14,
					priceId = slot12,
					priceNum = slot13,
					priceOriginal = slot11[2]
				})
			end
		end

		return slot2, slot3
	else
		return slot0.envent_params[1] or 0
	end
end

function StrategyMatrixPhaseTemplate.GetShops(slot0)
	return {}
end

function StrategyMatrixPhaseTemplate.GetGiveUpItemId(slot0)
	return slot0.give_up_item_id or 0
end

StrategyMartixUserTemplata = class("StrategyMartixUserTemplata")

function StrategyMartixUserTemplata.Ctor(slot0, slot1)
	slot0.SetData(slot0, slot1)

	slot0.battle_hero_id_list_cache = nil
end

function StrategyMartixUserTemplata.SetData(slot0, slot1)
	slot0.activity_id = slot1.activity_id
	slot2 = slot1.matrix
	slot0.game_state = slot2.game_state
	slot3 = slot2.best_performance
	slot0.success_times = slot3.success_times
	slot0.min_clear_time = slot3.min_clear_time

	slot0:UpdateProcess(slot2.progress)
end

function StrategyMartixUserTemplata.UpdateProcess(slot0, slot1)
	if MatrixConst.STATE_TYPE.NOTSTARTED == slot0.game_state then
		return
	end

	slot0.tier_id = slot1.tier_id
	slot0.artifact_list = {}

	for slot5, slot6 in ipairs(slot1.artifact_list) do
		table.insert(slot0.artifact_list, {
			id = slot6.id,
			wins = slot6.wins
		})
	end

	slot5 = slot1.phase
	slot0.phase = StrategyMatrixPhaseTemplate.New(slot0.activity_id, slot5)
	slot0.matrix_hero_net_rec = {}
	slot0.matrix_hero_id_net_rec = {}

	for slot5, slot6 in ipairs(slot1.hero_list) do
		if HeroStandardSystemCfg[slot6.hero_id] then
			slot9 = slot8.hero_id
			slot10 = StrategyMatrixHeroTemplate.New(slot0.activity_id, slot9, slot7)

			slot10:InitData(slot6)

			slot0.matrix_hero_net_rec[slot9] = slot10

			table.insert(slot0.matrix_hero_id_net_rec, slot9)
		end
	end

	slot0.custom_affix_id_list = {}

	for slot5, slot6 in ipairs(slot1.custom_affix_id_list) do
		table.insert(slot0.custom_affix_id_list, slot6)
	end

	slot0.attribute_list = {}

	for slot5, slot6 in ipairs(slot1.attribute_list) do
		slot0.attribute_list[slot6.id] = slot6.value
	end

	slot0.stackable_item_list = {}

	for slot5, slot6 in ipairs(slot1.stackable_item_list) do
		slot0.stackable_item_list[slot6.stackable_item_type] = slot6.stackable_item_num
	end

	slot2 = slot1.map
	slot0.map_id = slot2.map_id
	slot0.node_list = {}

	for slot6, slot7 in ipairs(slot2.node_list) do
		slot0.node_list[slot7.id] = {
			event_id = slot7.event_id,
			state = slot7.state
		}
	end

	slot0.effect_list = {}

	for slot6, slot7 in ipairs(slot1.effect_list) do
		table.insert(slot0.effect_list, {
			id = slot7.id,
			level = slot7.level
		})
	end
end

function StrategyMartixUserTemplata.GetMatrixCoint(slot0)
	return slot0.stackable_item_list and slot0.stackable_item_list[1] or 0
end

function StrategyMartixUserTemplata.GetIsClearance(slot0)
	if slot0.success_times == nil then
		return false
	end

	return slot0.success_times > 0
end

function StrategyMartixUserTemplata.GetMapId(slot0)
	return slot0.map_id
end

function StrategyMartixUserTemplata.GetNodeList(slot0)
	return slot0.node_list
end

function StrategyMartixUserTemplata.GetEffectList(slot0)
	return slot0.effect_list or {}
end
