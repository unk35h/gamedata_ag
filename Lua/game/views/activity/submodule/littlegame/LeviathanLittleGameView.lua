slot0 = class("LeviathanLittleGameView", ReduxView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerzoawdUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.scrollMoveView_ = ScrollMoveView.New(slot0, slot0.scrollViewGo_, true)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.buttonBtn_, nil, function ()
		if uv0:IsOpenSectionInfo() then
			JumpTools.Back()
		else
			JumpTools.OpenPageByJump("leviathanGameReward")
		end
	end)
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("leviathanSectionInfo")
end

function slot0.InitBtns(slot0)
	if not slot0.itemView_ then
		slot0.itemView_ = {}
		slot4 = slot0.activityID_

		for slot4, slot5 in ipairs(ActivityCfg[slot4].sub_activity_list) do
			slot0.itemView_[slot5] = LeviathanLittleGameItem.New(slot0[string.format("itemGo_%d", slot4)], slot5, slot0.activityID_, slot4)
			slot6 = slot0.itemView_[slot5]

			slot6:AddClickFunc(function (slot0)
				uv0.selIndex_ = slot0

				uv0.scrollMoveView_:RefreshUI(uv0:GetScrollPos(), uv0:GetScrollWidth())
			end)
		end
	end
end

function slot0.OnUpdate(slot0)
	slot0.scrollMoveView_:RefreshUI(slot0:GetScrollPos(), slot0:GetScrollWidth())
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = ActivityConst.LEVIATHAN_GAME

	if ActivityTools.GetGameHelpKey(slot0.activityID_) ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(slot1)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	slot0:InitBtns()

	for slot5, slot6 in pairs(slot0.itemView_) do
		slot6:OnEnter()
	end

	slot0.descText_.text = GetTips("ACTIVITY__BUBBLES_CONTENT")
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:AddTimer()
	manager.redPoint:setTip(RedPointConst.LEVIATHAN_LITTLE_GAME_LEVEL, 0)
	manager.redPoint:bindUIandKey(slot0.buttonBtn_.transform, RedPointConst.LEVIATHAN_LITTLE_GAME_REWARD)
	slot0.scrollMoveView_:RefreshUI(slot0:GetScrollPos(), slot0:GetScrollWidth())
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.windowBar:HideBar()
	slot0.scrollMoveView_:OnExit()

	for slot4, slot5 in pairs(slot0.itemView_) do
		slot5:OnExit()
	end

	manager.redPoint:unbindUIandKey(slot0.buttonBtn_.transform, RedPointConst.LEVIATHAN_LITTLE_GAME_REWARD)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.itemView_) do
		slot5:Dispose()
	end

	slot0.itemView_ = nil

	slot0.scrollMoveView_:Dispose()

	slot0.scrollMoveView_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.GetScrollWidth(slot0)
	return 2777
end

function slot0.GetScrollPos(slot0)
	return slot0.selIndex_ and slot0[string.format("itemGo_%d", slot0.selIndex_)].transform.localPosition.x or 0
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.remainText_.text = GetTips("TIME_OVER")

		return
	end

	slot0.remainText_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.remainText_.text = GetTips("TIME_OVER")

			return
		end

		uv0.remainText_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 0.33, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
