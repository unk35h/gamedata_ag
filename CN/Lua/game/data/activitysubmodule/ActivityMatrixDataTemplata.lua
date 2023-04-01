ActivityMatrixTools = {
	GetCoinItem = function (slot0)
		if ActivityMatrixSettingTemplateCfg.get_id_list_by_template_id[ActivityMatrixCfg[slot0] and slot1.setting_template_id] then
			for slot7, slot8 in ipairs(slot3) do
				if ActivityMatrixSettingTemplateCfg[slot8].type == 15 then
					return ActivityMatrixSettingTemplateCfg[slot8].value[1] or 0
				end
			end
		end

		return 26
	end
}
ActivityMatrixHeroTemplate = class("ActivityMatrixHeroTemplate", MatrixHeroTemplate)

function ActivityMatrixHeroTemplate.Ctor(slot0, slot1, slot2, slot3)
	slot0.activity_id = slot1

	ActivityMatrixHeroTemplate.super.Ctor(slot0, slot2, slot3)
end

function ActivityMatrixHeroTemplate.GetWeaponServantEffectLevel(slot0)
	return ActivityMatrixData:GetWeaponServantLevel(slot0.activity_id) or 1
end

ActivityMatrixPhaseTemplate = class("ActivityMatrixPhaseTemplate")

function ActivityMatrixPhaseTemplate.Ctor(slot0, slot1, slot2)
	slot0.activity_id = slot1
	slot0.phase_id = slot2.phase_id
	slot0.event_id_list = {}

	for slot6, slot7 in ipairs(slot2.event_id_list) do
		table.insert(slot0.event_id_list, slot7)
	end

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

function ActivityMatrixPhaseTemplate.GetPhase(slot0)
	return slot0.phase_id
end

function ActivityMatrixPhaseTemplate.GetParams(slot0)
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

function ActivityMatrixPhaseTemplate.GetData(slot0)
	if MatrixConst.EVENT_TYPE.SHOP == ActivityMatrixEventTemplateCfg[slot0.cur_event_id].event_type then
		slot2 = slot0.envent_params[1]
		slot3 = {}

		for slot8 = 2, #slot0.envent_params do
			if slot0.envent_params[slot8] and slot9 ~= 0 then
				slot11 = MatrixItemCfg[slot9].price[1]
				slot12 = slot11[1]
				slot13 = slot11[2]
				slot14 = 1

				if slot8 - 1 == 1 then
					slot14 = 1 - ActivityMatrixData:GetFirstGoodsDiscount(slot0.activity_id) / 1000
					slot13 = math.floor(slot13 - slot13 * ActivityMatrixData:GetFirstGoodsDiscount(slot0.activity_id) / 1000)
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

function ActivityMatrixPhaseTemplate.GetShops(slot0)
	return {}
end

function ActivityMatrixPhaseTemplate.GetGiveUpItemId(slot0)
	return slot0.give_up_item_id or 0
end

ActivityMartixUserTemplata = class("ActivityMartixUserTemplata")

function ActivityMartixUserTemplata.Ctor(slot0, slot1)
	slot0.SetData(slot0, slot1)

	slot0.battle_hero_id_list_cache = nil
end

function ActivityMartixUserTemplata.SetData(slot0, slot1)
	slot0.activity_id = slot1.activity_id
	slot0.game_state = slot1.game_state
	slot0.got_reward_list = {}
	slot2 = slot1.got_reward_list or {}

	for slot6, slot7 in ipairs(slot2) do
		table.insert(slot0.got_reward_list, slot7)
	end

	slot0.point = slot1.point
	slot0.success_times = slot1.success_times

	slot0.UpdateProcess(slot0, slot1.progress)
end

function ActivityMartixUserTemplata.UpdateProcess(slot0, slot1)
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
	slot0.phase = ActivityMatrixPhaseTemplate.New(slot0.activity_id, slot5)
	slot0.matrix_hero_net_rec = {}
	slot0.matrix_hero_id_net_rec = {}

	for slot5, slot6 in ipairs(slot1.hero_list) do
		if HeroStandardSystemCfg[slot6.hero_id] then
			slot9 = slot8.hero_id
			slot10 = ActivityMatrixHeroTemplate.New(slot0.activity_id, slot9, slot7)

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
end

function ActivityMartixUserTemplata.GetMatrixCoint(slot0)
	return slot0.stackable_item_list and slot0.stackable_item_list[1] or 0
end

function ActivityMartixUserTemplata.GetMatrixScore(slot0)
	return slot0.point
end

function ActivityMartixUserTemplata.OnReceivePointReward(slot0, slot1)
	table.insert(slot0.got_reward_list, slot1)
end

function ActivityMartixUserTemplata.GetIsClearance(slot0)
	if slot0.success_times == nil then
		return false
	end

	return slot0.success_times > 0
end

ActivityMartixOverTemplata = class("ActivityMartixUserTemplata")

function ActivityMartixOverTemplata.Ctor(slot0, slot1)
	slot0.SetData(slot0, slot1)
end

function ActivityMartixOverTemplata.SetData(slot0, slot1)
	slot0.currencyList_ = {}

	for slot5, slot6 in ipairs(slot1.item_list) do
		slot0.currencyList_[slot6.stackable_item_type] = slot6.stackable_item_num
	end

	slot0.currentClearTime_ = slot1.clear_time
	slot0.minClearTime_ = slot1.min_clear_time or slot1.clear_time
	slot0.point = slot1.point
	slot0.success_times = slot1.success_times
end
