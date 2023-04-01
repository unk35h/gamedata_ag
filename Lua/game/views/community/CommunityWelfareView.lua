slot0 = class("CommunityWelfareView", ReduxView)

function slot0.UIName(slot0)
	return "UI/CommunityUI/Clubwelfare"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.CommunityCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "community")
	slot0.welfareCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "welfare")
	slot0.welfare_ = CommonItem.New(slot0.commonItemGo_)
	slot1 = slot0.welfare_

	slot1:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			GameSetting.club_welfare.value[1]
		})
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.openBtn_, nil, function ()
		if GameSetting.club_welfare_cost.value[1] <= CommunityData:GetCurrenyA() then
			CommunityAction:OpenWelfare()
		else
			ShowTips("ERROR_CLUB_COIN_NO_ENOUGH")
		end
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if uv0.identity_ == CommunityConst.MEMBER_TYPE.NEWBIE or uv0.identity_ == CommunityConst.MEMBER_TYPE.STRANGER then
			ShowTips("ERROR_CLUB_REWARD_ONLY_FORMAT_RECEIVE")
		else
			CommunityAction:ReceiveWelfare()
		end
	end)
	slot0:AddBtnListener(slot0.welfareBtn_, nil, function ()
		if CommunityData:GetWelfareExchangeCnt() <= 0 then
			ShowTips("EXCEED_MAX_CNT")

			return
		end

		JumpTools.OpenPageByJump("communitySpecialWelfareShop")
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:RestoreBar()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:SaveBar()
	CommunityAction:RefreshCurrencyA()
	slot0:RefreshUI()
end

function slot0.SaveBar(slot0)
	slot0.lastHomeFunc_ = manager.windowBar:GetLastHomeFunc()
	slot0.lastBackFunc_ = manager.windowBar:GetLastBackFunc()
	slot0.lastBarList_ = manager.windowBar:GetLastBarList()
	slot0.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	slot0.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()
	slot0.lastBarTypeList_ = manager.windowBar:GetLastBarTypeList()
end

function slot0.RefreshUI(slot0)
	manager.windowBar:SetAsLastSibling()

	slot0.identity_ = CommunityData:GetIdentity()
	slot0.welfareType_ = CommunityData:GetWelfareType()

	if slot0.identity_ == CommunityConst.MEMBER_TYPE.HEAD or slot0.identity_ == CommunityConst.MEMBER_TYPE.DEPUTY then
		SetActive(slot0.priceGo_, slot0.welfareType_ == CommunityConst.WELFARE_TYPE.CLOSE)

		slot0.openBtn_.interactable = true

		slot0.CommunityCon_:SetSelectedState("type1")
		slot0:RefreshType1Bar()
	elseif slot0.identity_ == CommunityConst.MEMBER_TYPE.MEMBER or slot0.identity_ == CommunityConst.MEMBER_TYPE.NEWBIE or slot0.identity_ == CommunityConst.MEMBER_TYPE.STRANGER then
		slot0.openBtn_.interactable = false

		slot0.CommunityCon_:SetSelectedState("type2")
		slot0:RefreshType2Bar()
	else
		print("暂未设计")
	end

	if slot0.welfareType_ == CommunityConst.WELFARE_TYPE.CLOSE then
		slot0.welfareCon_:SetSelectedState("close")
	elseif slot0.welfareType_ == CommunityConst.WELFARE_TYPE.RECEIVE then
		slot0.receiveBtn_.interactable = true

		slot0.welfareCon_:SetSelectedState("receive")
	elseif slot0.welfareType_ == CommunityConst.WELFARE_TYPE.FINISH then
		slot0.receiveBtn_.interactable = false

		slot0.welfareCon_:SetSelectedState("finish")
	else
		print("暂未设计")
	end

	slot0:RefreshCost()
	slot0:RefreshWelfare()
end

function slot0.RefreshType1Bar(slot0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function slot0.RefreshType2Bar(slot0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function slot0.RefreshCost(slot0)
	slot0.priceImg_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A)

	if GameSetting.club_welfare_cost.value[1] <= CommunityData:GetCurrenyA() then
		slot0.cost_.text = "<color='#28282B'>X" .. slot1 .. "</color>"
	else
		slot0.cost_.text = "<color='#FF0000'>X" .. slot1 .. "</color>"
	end
end

function slot0.RefreshWelfare(slot0)
	slot0.welfare_:RefreshData(ItemCfg[GameSetting.club_welfare.value[1]])
	slot0.welfare_:HideNum()
	slot0.welfare_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
end

function slot0.RestoreBar(slot0)
	slot4 = slot0.lastBarList_

	manager.windowBar:SwitchBar(slot4)

	for slot4, slot5 in ipairs(slot0.lastAddBarList_) do
		manager.windowBar:SetBarCanAdd(slot5, true)
	end

	for slot4, slot5 in ipairs(slot0.lastCanClickBarList_) do
		manager.windowBar:SetBarCanClick(slot5, true)
	end

	for slot4, slot5 in pairs(slot0.lastBarTypeList_) do
		manager.windowBar:SetBarType(slot4, slot5)
	end

	manager.windowBar:RegistHomeCallBack(slot0.lastHomeFunc_)
	manager.windowBar:RegistBackCallBack(slot0.lastBackFunc_)
end

function slot0.OnReceiveWelfare(slot0)
	slot0:RefreshUI()
end

function slot0.OnRefreshWelfare(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0.lastHomeFunc_ = nil
	slot0.lastBackFunc_ = nil
	slot0.lastBarList_ = nil
	slot0.lastAddBarList_ = nil
	slot0.lastCanClickBarList_ = nil
	slot0.lastBarTypeList_ = nil
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.welfare_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
