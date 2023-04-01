slot0 = class("CurrencyBuyGoldView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/GoldExchangeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
	slot0.propsBonds = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND]
	slot0.selectNum_ = 0
	slot0.canUseMaxNum_ = 1
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_itemList, CommonItem)
	slot0.viewController_ = ControllerUtil.GetController(slot0.m_viewController, "view")
	slot0.useNumTriggerListener_ = slot0.useNumSlider_.gameObject.transform:GetComponent(typeof(EventTriggerListener))
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = slot0.propsBonds[slot1]

	slot2:RefreshData({
		id = slot3,
		number = ItemTools.getItemNum(slot3),
		type = ItemConst.ITEM_TYPE.PROPS
	})
	slot2:SetSelectType("equip")
	slot2:ShowSelect(slot1 == slot0.selectInex and 1 or 0)
	slot2:RegistCallBack(function (slot0)
		if uv0 > 0 then
			uv1.selectInex = uv2
			uv1.selectNum_ = 1
			uv1.canUseMaxNum_ = uv0

			uv1.scrollHelper:Refresh()
			uv1:UpdateSliderPositionBySelectNum()
			uv1:UpdatePreview()
		end

		OperationRecorder.Record("exchange", "goldcoin_bond_type")
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] then
			slot2 = GameCurrencyBuySetting[slot0 + 1].diamond_to_money

			if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < GameCurrencyBuySetting[slot0 + 1].cost_diamond_to_money then
				JumpTools.OpenPopUp("rechargeDiamondExchange", {
					getBaseNum = 1,
					useBaseNum = 1,
					useId = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
					getId = CurrencyConst.CURRENCY_TYPE_DIAMOND,
					defaultNum = slot1 - slot3
				}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)

				return
			end

			slot4 = SettingData:GetRemindSettingData()

			if not _G.SkipTip.SkipDiamondBuyGoldTip and slot4.diamond_buy_gold_reminder == 1 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = string.format(GetTips("PAY_FOR_POWER"), slot1, ItemCfg[CurrencyIdMapCfg.CURRENCY_TYPE_GOLD.item_id].name, slot2),
					OkCallback = function ()
						_G.SkipTip.SkipDiamondBuyGoldTip = uv0.SkipDiamondBuyGoldTip_

						CurrencyAction.BuyCoin()
					end,
					ToggleCallback = function (slot0)
						uv0.SkipDiamondBuyGoldTip_ = slot0
					end
				})
			else
				CurrencyAction.BuyCoin()
			end
		else
			ShowTips("ERROR_SHOP_BUY_TIMES_LIMIT")
		end
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.cancelBtn2_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		CommonAction.TryToUseItem({
			{
				item_id = uv0.propsBonds[uv0.selectInex],
				use_list = {},
				num = uv0.selectNum_
			}
		})
	end)

	slot1 = slot0.useNumTriggerListener_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		OperationRecorder.Record("exchange", "goldcoin_bond_slide")
	end))

	slot1 = slot0.useNumSlider_.onValueChanged

	slot1:AddListener(function ()
		uv0.selectNum_ = math.floor(uv0.canUseMaxNum_ * uv0.useNumSlider_.value + 1e-05)

		if uv0.selectNum_ < 1 then
			uv0.selectNum_ = 1

			uv0:UpdateSliderPositionBySelectNum()
		end

		uv0:UpdatePreview()
	end)
	slot0:AddPressingByTimeListener(slot0.delBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ > 1 then
			uv0.selectNum_ = uv0.selectNum_ - 1

			uv0:UpdateSliderPositionBySelectNum()
			uv0:UpdatePreview()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.addBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ < uv0.canUseMaxNum_ then
			uv0.selectNum_ = uv0.selectNum_ + 1

			uv0:UpdateSliderPositionBySelectNum()
			uv0:UpdatePreview()

			return true
		end

		return false
	end)
	slot0:AddToggleListener(slot0.toggle_, function (slot0)
		OperationRecorder.Record("exchange", "goldcoin_material")

		if slot0 then
			uv0.viewController_:SetSelectedIndex(1)
		else
			uv0.viewController_:SetSelectedIndex(0)
		end
	end)
end

function slot0.OnBuyCoin(slot0, slot1, slot2)
	if slot1.result == 0 then
		slot3 = CurrencyData:GetGoldBuyTimes()

		CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_DIAMOND, -GameCurrencyBuySetting[slot3 + 1].cost_diamond_to_money)
		CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_GOLD, GameCurrencyBuySetting[slot3 + 1].diamond_to_money)
		ShowTips("TRANSACTION_SUCCESS")
		slot0:Back()
	else
		ShowTips(slot1.result)

		return
	end
end

function slot0.OnTryToUseItem(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		if #slot2.use_item_list > 0 then
			MaterialAction.MaterialModify(slot2.use_item_list[1].item_id, -1 * slot2.use_item_list[1].num, slot2.use_item_list[1].time_valid)
		end

		slot0:Back()

		slot3 = {}

		for slot7, slot8 in ipairs(slot1.drop_list) do
			slot3[slot8.id] = slot3[slot8.id] and slot8.num + slot3[slot8.id] or slot8.num
		end

		slot4 = {}

		for slot8, slot9 in pairs(slot3) do
			table.insert(slot4, {
				slot8,
				slot9
			})
		end

		getReward(slot4)
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnEnter(slot0)
	slot0.selectInex = 0
	slot0.selectNum_ = 1
	slot0.canUseMaxNum_ = 1
	slot1 = false
	slot2 = false
	slot0.toggle_.isOn = true

	slot0:RefreshTexts()

	if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] then
		slot0.toggle_.isOn = true

		slot0.viewController_:SetSelectedIndex(1)

		slot2 = true
	end

	for slot6, slot7 in ipairs(slot0.propsBonds) do
		if ItemTools.getItemNum(slot7) > 0 then
			slot0.selectInex = slot6
			slot0.selectNum_ = 1
			slot0.canUseMaxNum_ = slot8

			slot0.scrollHelper:StartScroll(#slot0.propsBonds)
			slot0:UpdateSliderPositionBySelectNum()
			slot0:UpdatePreview()

			slot0.toggle_.isOn = false

			slot0.viewController_:SetSelectedIndex(0)

			slot1 = true

			break
		end
	end

	if slot1 and slot2 then
		SetActive(slot0.toggleGo_, true)
	else
		SetActive(slot0.toggleGo_, false)
	end
end

function slot0.RefreshTexts(slot0)
	slot1 = CurrencyData:GetGoldBuyTimes()
	slot4 = GameSetting.coin_max_buy_time.value[1]
	slot0.limitTotal_.text = "/" .. slot4
	slot0.limitNum_.text = slot4 - slot1
	slot0.use_.text = GameCurrencyBuySetting[slot1 + 1].cost_diamond_to_money
	slot0.get_.text = GameCurrencyBuySetting[slot1 + 1].diamond_to_money
	slot0.currencyGold_.text = NumberTools.RetractNumberForWindBar(CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD))
end

function slot0.UpdateSliderPositionBySelectNum(slot0)
	slot0.useNumSlider_.value = slot0.selectNum_ / slot0.canUseMaxNum_
end

function slot0.UpdatePreview(slot0)
	slot0.useNumText_.text = tostring(slot0.selectNum_)
	slot2 = 0
	slot3 = pairs
	slot5 = ItemCfg[slot0.propsBonds[slot0.selectInex]].param or {}

	for slot6, slot7 in slot3(slot5) do
		if slot7[1] == CurrencyConst.CURRENCY_TYPE_GOLD then
			slot2 = slot7[2]
		end
	end

	slot3 = slot2 * slot0.selectNum_

	if slot0.selectNum_ > 0 then
		slot0.getVitalityText_.text = string.format(GetTips("GET_GOLD"), slot3)
	else
		slot0.getVitalityText_.text = ""
	end

	slot0.delBtn_.interactable = slot0.selectNum_ > 1
	slot0.addBtn_.interactable = slot0.selectNum_ < slot0.canUseMaxNum_
end

function slot0.Dispose(slot0)
	slot0.scrollHelper:Dispose()
	slot0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	uv0.super.Dispose(slot0)
end

return slot0
