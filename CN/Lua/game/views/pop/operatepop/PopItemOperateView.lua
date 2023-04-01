slot0 = class("PopItemOperateView", import("game.views.pop.sourcePop.PopItemSourceView"))
slot1 = GameSetting.vitality_exchange_id_list.value

function slot0.CustomInitUI(slot0)
	SetActive(slot0.mergeBtn_.gameObject, false)
	SetActive(slot0.operatePanel_, true)
	SetActive(slot0.sourceDesGo_, false)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:RefreshUI()

	slot0[ON_TRY_TO_USE_ITEM] = slot0.UseItemFun
end

function slot0.OnExit(slot0)
	slot0[ON_TRY_TO_USE_ITEM] = nil

	uv0.super.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.addBtn_ = nil
	slot0.delBtn_ = nil
	slot0.materialCntText_ = nil
	slot0.useNumSlider_ = nil
end

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)

	slot1 = slot0.useNumTriggerListener_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		OperationRecorder.Record(uv0.lastRecord_, "operateEndDrag")
	end))
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		OperationRecorder.Record(uv0.lastRecord_, "operateUseBtn")

		slot1 = uv0.itemInfo_[2]
		slot2 = uv0.itemInfo_[4]

		if ItemCfg[uv0.itemInfo_[1]].sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or slot3.sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_MULT then
			JumpTools.Back()
			JumpTools.OpenPageByJump("optionalItemSelect", {
				selectNum = uv0.useNumSlider_.value
			})

			return
		end

		slot4 = uv0.useNumSlider_.value

		if uv0:AddVitalityCnt(slot0) and not (slot4 * slot5 + CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY) <= ItemCfg[CurrencyConst.CURRENCY_TYPE_VITALITY].max) then
			ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

			return
		end

		if not canAddVitalityByProp(slot0) then
			ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

			return
		end

		slot6 = {
			item_id = uv0.itemInfo_[1],
			use_list = {},
			num = slot4
		}

		if slot2 then
			slot6.time_valid = slot2
		end

		CommonAction.TryToUseItem({
			slot6
		})
	end)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		OperationRecorder.Record(uv0.lastRecord_, "operateAddBtn")

		slot0 = uv0.itemInfo_[1]

		if uv0.useNumSlider_.value < uv0:GetMaxNum() then
			if uv0:AddVitalityCnt(slot0) then
				if not ((slot1 + 1) * slot2 + CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY) <= ItemCfg[CurrencyConst.CURRENCY_TYPE_VITALITY].max) then
					ShowTips("ERROR_ITEM_FATIGUE_LIMIT")
				else
					uv0.useNumSlider_.value = slot1 + 1
				end
			else
				uv0.useNumSlider_.value = slot1 + 1
			end
		end
	end)
	slot0:AddBtnListener(slot0.delBtn_, nil, function ()
		OperationRecorder.Record(uv0.lastRecord_, "operateDelBtn")

		if uv0.useNumSlider_.value > 1 then
			uv0.useNumSlider_.value = uv0.useNumSlider_.value - 1
		end

		if uv0.useNumSlider_.value < 1 then
			uv0.useNumSlider_.value = 1
		end
	end)

	slot1 = slot0.useNumSlider_.onValueChanged

	slot1:AddListener(function ()
		uv0:UpdateCount()
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.useNumSlider_.onValueChanged:RemoveAllListeners()
	uv0.super.RemoveListeners(slot0)
end

function slot0.AddVitalityCnt(slot0, slot1)
	if ItemCfg[slot1].sub_type == 401 or slot2.sub_type == 403 then
		return slot2.param[1][2]
	end

	return false
end

function slot0.UseItemFun(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		if #slot2.use_item_list > 0 and ItemCfg[slot2.use_item_list[1].item_id].sub_type ~= ItemConst.ITEM_SUB_TYPE.BIRTHDAY_ITEM then
			MaterialAction.MaterialModify(slot2.use_item_list[1].item_id, -1 * slot2.use_item_list[1].num, slot2.use_item_list[1].time_valid)
		end

		if ItemTools.getItemNum(slot0.itemInfo_[1], slot0.itemInfo_[4]) <= 0 then
			slot0:Back()
		else
			slot0:RefreshUI()
			slot0:RefreshCount()
			slot0:SetCommonItem()
		end

		slot6 = {}

		for slot10, slot11 in ipairs(slot1.drop_list) do
			slot6[slot11.id] = slot6[slot11.id] and slot11.num + slot6[slot11.id] or slot11.num
		end

		slot7 = {}

		for slot11, slot12 in pairs(slot6) do
			table.insert(slot7, {
				slot11,
				slot12
			})
		end

		if ItemCfg[slot2.use_item_list[1].item_id].type == ItemConst.ITEM_TYPE.SKIN_CHANGE then
			slot9 = ItemCfg[slot8].param[1]

			getReward({
				{
					slot9,
					1
				}
			}, {
				ItemConst.ITEM_TYPE.HERO_SKIN
			})
			HeroAction.SkinAdd(slot9)
			HeroAction.UpdateSkinCouponRedPoint(SkinCfg[slot9].hero)
		elseif ItemCfg[slot8].sub_type == ItemConst.ITEM_SUB_TYPE.BIRTHDAY_ITEM then
			manager.story:StartStory(BirthdayCfg[BirthdayCfg.get_id_list_by_commemorative_props_id[slot8][1]].story_id)
		elseif ItemCfg[slot8].sub_type == ItemConst.ITEM_SUB_TYPE.BITRHDAY_LETTER then
			slot9 = BirthdayCfg[BirthdayCfg.get_id_list_by_appendix_id[slot8][1]].story_id

			manager.story:StartStory(slot9)
			IllustratedData:ModifyPlot(slot9)
			getReward(slot7)
			SDKTools.SendMessageToSDK("birthday_received", {
				story_unlock = 1
			})
		else
			getReward(slot7)
		end

		manager.notify:CallUpdateFunc(NOTIFY_FOR_BAG_REFRESH_BUG)
	else
		ShowTips(slot1.result)
	end
end

function slot0.RefreshUI(slot0)
	slot0.useNumSlider_.minValue = 0
	slot0.useNumSlider_.maxValue = slot0:GetMaxNum()
	slot0.useNumSlider_.value = 1

	slot0:UpdateCount()
	SetActive(slot0.operatePanel_, ItemCfg[slot0.itemInfo_[1]] and slot2.use == 1 and MaterialConst.MATERIAL_TYPE.MYTHIC_REFRESH ~= slot2.sub_type)
	SetActive(slot0.operateInfoGo_, slot2.sub_type ~= ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM)
end

function slot0.GetMaxNum(slot0)
	slot2 = slot0.itemInfo_[4]
	slot3 = 0

	if ItemCfg[slot0.itemInfo_[1]].sub_type == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM then
		return 1
	end

	if MaterialData:GetMaterial(slot1, slot2) then
		slot3 = slot5.num
	end

	if slot4.type == ItemConst.ITEM_TYPE.PROPS and (ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY == slot4.sub_type or ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID == slot4.sub_type) then
		return math.max(math.min(math.floor((999 - CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY)) / slot4.param[1][2]), slot3), 1)
	end

	return slot3
end

function slot0.UpdateCount(slot0)
	if slot0.useNumSlider_.value < 1 then
		slot0.useNumSlider_.value = 1
	end

	slot1 = slot0.useNumSlider_.value
	slot0.materialCntText_.text = slot1
	slot0.delBtn_.interactable = slot1 > 1
	slot2 = slot0.itemInfo_[1]
	slot0.addBtn_.interactable = slot0.useNumSlider_.value < slot0:GetMaxNum()
end

return slot0
