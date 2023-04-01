slot0 = class("GuildActivityRateView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivityUI/GuildActivityRatePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.premissItemList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, GuildActivityRatePremissItem)
	slot0.levelController_ = ControllerUtil.GetController(slot0.transform_, "level")
	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnEnter(slot0)
	GuildActivityLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true

	manager.windowBar:HideBar()
	slot0:AddEventListeners()

	slot0.activityID_ = slot0.params_.activityID
	slot0.curRateID_ = GuildActivityData:GetCurRateID(slot0.activityID_)

	if table.keyof(ActivityClubLevelSettingCfg.get_id_list_by_activity[slot0.activityID_], slot0.curRateID_) then
		slot0.nextRateID_ = slot1[slot2 + 1]
	end

	if slot0.nextRateID_ ~= nil then
		slot0.premissIDList_ = ActivityClubLevelSettingCfg[slot0.nextRateID_].condition

		slot0.stateController_:SetSelectedState("false")
	else
		slot0.premissIDList_ = {}

		slot0.stateController_:SetSelectedState("true")
	end

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	slot0.premissItemList_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.premissItemList_:StartScroll(#slot0.premissIDList_)

	slot1 = ActivityClubLevelSettingCfg[slot0.curRateID_]

	slot0.levelController_:SetSelectedState(tostring(slot1.user_level))

	slot0.titleText_.text = slot1.desc
	slot0.domainMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_DOMAIN"), slot1.max_domain)
	slot0.heroMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_HERO"), slot1.max_hero)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot0.premissIDList_[slot1], slot0.activityID_)
end

return slot0
