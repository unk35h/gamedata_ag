slot0 = class("GuildFoundedManagerView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubFoundedUI_new"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.foundedViewList_ = {}
	slot0.goButtonList_ = {
		slot0.goRecommend_,
		slot0.goFounded_
	}
	slot0.toggleList_ = {}

	for slot4, slot5 in pairs(GuildConst.FOUNDED_TYPE) do
		slot0.toggleList_[slot5] = GuildFoundedToggleView.New(slot0.goButtonList_[slot5], slot5)
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back(2)
	end)
	slot0:CheckCooperationInviteEntry()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)

	slot0.selectType_ = slot0.params_.guildFoundedType or GuildConst.FOUNDED_TYPE.RECOMMEND

	for slot4, slot5 in pairs(slot0.foundedViewList_) do
		slot5:OnEnter()
	end

	slot0:RefreshToggle()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	slot0.selectType_ = nil

	for slot4, slot5 in pairs(slot0.foundedViewList_) do
		slot5:OnExit()
	end
end

function slot0.OnUpdate(slot0)
	if slot0.selectType_ == slot0.params_.guildFoundedType then
		return
	end

	slot0.selectType_ = slot0.params_.guildFoundedType or GuildConst.FOUNDED_TYPE.RECOMMEND

	slot0:RefreshToggle()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.toggleList_) do
		slot5:Dispose()
	end

	slot0.toggleList_ = nil
	slot0.goButtonList_ = nil

	for slot4, slot5 in pairs(slot0.foundedViewList_) do
		slot5:Dispose()
	end

	slot0.foundedViewList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_inviteBtn, nil, function ()
		JumpTools.OpenPageByJump("cooperationApply")
	end)
end

function slot0.RefreshToggle(slot0)
	for slot4, slot5 in pairs(slot0.toggleList_) do
		slot5:RefreshSelectType(slot0.selectType_)
	end

	if not slot0.foundedViewList_[slot0.selectType_] then
		if slot0.selectType_ == GuildConst.FOUNDED_TYPE.RECOMMEND then
			slot0.foundedViewList_[slot0.selectType_] = GuildRecommendView.New(slot0.goRecommendPanel_)
		else
			slot0.foundedViewList_[slot0.selectType_] = GuildFoundedView.New(slot0.goFoundedPanel_)
		end
	end

	for slot4, slot5 in pairs(slot0.foundedViewList_) do
		slot5:Show(slot4 == slot0.selectType_)
	end
end

function slot0.GetCooperationInviteEntryGo(slot0)
	return slot0.m_inviteBtn.gameObject
end

return slot0
