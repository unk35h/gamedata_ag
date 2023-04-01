slot0 = class("CommunitySpecialWelfareShopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Shop/ShopBuyUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.refreshUIHandler_ = handler(slot0, slot0.RefreshUI)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
	slot0.useNumTriggerListener_ = slot0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	slot0.typeCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "type")
	slot0.limitText_.text = GetTips("LIMIT_WEEK")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if CommunityData:GetWelfareExchangeCnt() < uv0.useNum_ then
			ShowTips("EXCEED_MAX_CNT")

			return
		end

		CommunityAction:BuySpecialWelfare(uv0.useNum_)
	end)
	slot0:AddPressingByTimeListener(slot0.addBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.useNumSlider_.value < uv0.canUseMaxNum_ then
			uv0.useNumSlider_.value = uv0.useNumSlider_.value + 1

			if uv0.canUseMaxNum_ <= uv0.useNumSlider_.value then
				uv0.useNumSlider_.value = uv0.canUseMaxNum_
			end

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.delBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.useNumSlider_.value > 1 then
			uv0.useNumSlider_.value = uv0.useNumSlider_.value - 1

			if uv0.useNumSlider_.value < 1 or math.floor(uv0.useNumSlider_.value) == 1 then
				uv0.useNumSlider_.value = 1
			end

			return true
		end

		return false
	end)

	slot1 = slot0.useNumSlider_.onValueChanged

	slot1:AddListener(function ()
		uv0.useNum_ = math.floor(uv0.useNumSlider_.value)

		if uv0.useNum_ < 1 then
			uv0.useNum_ = 1
		elseif uv0.canUseMaxNum_ < uv0.useNum_ then
			uv0.useNum_ = uv0.canUseMaxNum_
		end

		if uv0.useNum_ <= 0 then
			uv0.useNum_ = 1
		end

		uv0:UpdateCnt()
	end)

	slot1 = slot0.useNumTriggerListener_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0.useNumSlider_.value = math.floor(uv0.useNumSlider_.value)
	end))
end

function slot0.OnEnter(slot0)
	CommunityAction:RefreshCurrencyA()
	manager.windowBar:SetAsLastSibling()
	slot0.typeCon_:SetSelectedState("club")

	slot0.useNumSlider_.value = 1
	slot0.identity_ = CommunityData:GetIdentity()

	manager.notify:RegistListener(GUILD_WELFRE_CNT_REFRESH, slot0.refreshUIHandler_)
	slot0:RefreshUI()
end

function slot0.RefreshGood(slot0)
	slot1 = ItemCfg[GameSetting.club_special_welfare.value[1]]

	slot0.commonItem_:RefreshData({
		id = slot1.id
	})
	slot0.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
	slot0.commonItem_:SetBottomText("")

	slot0.nameText_.text = slot1.name
	slot0.descText_.text = GetI18NText(slot1.desc) .. "\n\n" .. GetTips("CLUB_SPECIAL_WELFARE")
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A)
end

function slot0.RefreshSlider(slot0)
	slot0.canUseMaxNum_ = math.floor(CommunityData:GetCurrenyA() / GameSetting.club_special_welfare_cost.value[1] or 1)
	slot0.canUseMaxNum_ = math.min(CommunityData:GetWelfareExchangeCnt(), slot0.canUseMaxNum_)
	slot0.useNumSlider_.minValue = math.min(slot0.canUseMaxNum_, 1)
	slot0.useNumSlider_.maxValue = slot0.canUseMaxNum_

	if slot0.useNumSlider_.minValue == slot0.useNumSlider_.maxValue then
		slot0.useNumSlider_.minValue = 0
		slot0.useNumSlider_.maxValue = 1
	end

	slot0.handleGo_.raycastTarget = not slot4
	slot0.fillGo_.raycastTarget = not slot4
	slot0.bgGo_.raycastTarget = not slot4
	slot0.useNum_ = 1

	slot0:UpdateDelAddBtn()
	slot0:UpdatePreview()
end

function slot0.UpdateDelAddBtn(slot0)
	slot0.delBtn_.interactable = slot0.useNum_ > 1
	slot0.addBtn_.interactable = slot0.useNum_ < slot0.canUseMaxNum_
	slot0.delImg_.raycastTarget = slot0.useNum_ > 1
	slot0.addImg_.raycastTarget = slot0.useNum_ < slot0.canUseMaxNum_
end

function slot0.UpdatePreview(slot0)
	slot0.useNumText_.text = slot0.useNum_

	if CommunityData:GetCurrenyA() < slot0.useNum_ * GameSetting.club_special_welfare_cost.value[1] then
		slot0.totalCostText_.text = "<color=#FF0000>" .. slot1 .. "</color>"
	else
		slot0.totalCostText_.text = slot1
	end
end

function slot0.UpdateCnt(slot0)
	slot0:UpdateDelAddBtn()
	slot0:UpdatePreview()
end

function slot0.OnBuyCommunitySpecialWelfare(slot0)
	slot0:Back()
	ShowTips("TIP_CLUB_SPECIAL_WELFARE_BUY")
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(GUILD_WELFRE_CNT_REFRESH, slot0.refreshUIHandler_)
end

function slot0.Dispose(slot0)
	slot0.refreshUIHandler_ = nil

	slot0:RemoveAllListeners()
	slot0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)

	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshGood()
	slot0:RefreshSlider()

	slot1 = GameSetting.club_special_reward_buy_limit_weekly.value[1]
	slot0.limitNumText_.text = string.format("%s/%s", slot1 - CommunityData:GetWelfareExchangeCnt(), slot1)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.totalTransform_)
end

return slot0
