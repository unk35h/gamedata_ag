slot0 = class("PaperCutMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/PaperCut/PaperCutMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.clickSwitchItemHandler_ = handler(slot0, slot0.OnClickSwitchItem)
	slot0.onSenceLoadedHandler_ = handler(slot0, slot0.OnSceneLoaded)

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.sceneLoaded_ = false
	slot0.switchList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, PaperCutSelectItem)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("paperCutReward", {
			activityID = uv0.activityID_
		})
	end)
end

function slot0.OnEnter(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	slot1 = manager.windowBar

	slot1:SetGameHelpKey("ACTIVITY_CUT_DESCRIPE")

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		uv0:UnLoadPaperCutScene()
		uv0:Back()
	end)

	slot1 = manager.windowBar

	slot1:RegistHomeCallBack(function ()
		uv0:UnLoadPaperCutScene()
		gameContext:Go("/home", nil, , true)
	end)

	if slot0.sceneLoaded_ == false then
		slot0:LoadPaperCutScene()
	end

	slot0.activityID_ = slot0.params_.activityID
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:RefreshUI()
	slot0:AddTimer()
	manager.redPoint:bindUIandKey(slot0.rewardBtnTrans_, string.format("%s_%s_Reward", RedPointConst.PAPER_CUT, slot0.activityID_))
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopTimer()
	manager.redPoint:unbindUIandKey(slot0.rewardBtnTrans_, string.format("%s_%s_Reward", RedPointConst.PAPER_CUT, slot0.activityID_))

	slot0.scrollPos_ = slot0.switchList_:GetScrolledPosition()
end

function slot0.Dispose(slot0)
	slot0.onSenceLoadedHandler_ = nil
	slot0.clickSwitchItemHandler_ = nil

	slot0.switchList_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.LoadPaperCutScene(slot0)
	manager.ui:SetMainCamera("paperCut")

	manager.ui.mainCameraCom_.orthographic = true

	PaperCutTool:LoadScene(slot0.onSenceLoadedHandler_)
end

function slot0.OnSceneLoaded(slot0)
	slot0.sceneLoaded_ = true
end

function slot0.UnLoadPaperCutScene(slot0)
	slot0.sceneLoaded_ = false

	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	PaperCutTool:UnLoadScene()
end

function slot0.RefreshUI(slot0)
	slot0.subActivityList_ = ActivityCfg[slot0.activityID_].sub_activity_list

	if slot0.scrollPos_ ~= nil then
		slot0.switchList_:StartScrollByPosition(#slot0.subActivityList_, slot0.scrollPos_)
	else
		slot0.switchList_:StartScroll(#slot0.subActivityList_)
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.activityID_, slot0.subActivityList_[slot1])
	slot2:SetClickCallBack(slot0.clickSwitchItemHandler_)
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	slot5 = slot0.stopTime_
	slot0.remainTimeText_.text = manager.time:GetLostTimeStr(slot5)

	for slot5, slot6 in ipairs(slot0.switchList_:GetItemList()) do
		slot6:RefreshLock()
	end

	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		uv1 = uv0.switchList_:GetItemList()

		for slot3, slot4 in ipairs(uv1) do
			slot4:RefreshLock()
		end

		uv0.remainTimeText_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnClickSwitchItem(slot0, slot1)
	slot0.selectActivityID_ = slot1

	slot0:Go("/paperCutPlay", {
		activityID = slot1,
		mainActivityID = slot0.activityID_,
		goHomeHandler = handler(slot0, slot0.OnGoHome)
	})
	PaperCutTool:GameStart(slot1)
end

function slot0.OnGoHome(slot0)
	slot0:UnLoadPaperCutScene()
	gameContext:Go("/home", nil, , true)
end

return slot0
