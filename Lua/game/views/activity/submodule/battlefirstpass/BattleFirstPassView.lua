slot0 = class("BattleFirstPassView", ReduxView)

function slot0.UIName(slot0)
	return ActivityTools.GetUIName(slot0.params_.activityId)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, BattleFirstPassItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.battleList_[slot1]

	slot2:RefreshUI(slot0.activityID_, slot3)
	slot2:SetSelected(slot0:IsSelect(slot3))
	slot2:RegisterClickListener(function (slot0)
		BattleFirstPassData:SetLastBattleID(uv0.activityID_, slot0)
		uv0:SetCurBattleID(slot0)
	end)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("ERROR_ACTIVITY_NOT_OPEN")

			return
		end

		uv0:Go("/sectionSelectHero", {
			section = ActivityFirstClearCfg[uv0.curBattleID_].stage_id,
			sectionType = ActivityTools.GetSectionType(uv0.activityID_),
			activityID = uv0.curBattleID_
		})
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("firstPassRewardPop", {
			activityId = uv0.activityID_
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0:GetActivityData()
	slot0:BindRedPointUI()
	slot0:RefreshUI()
	slot0:SetCurBattleID(BattleFirstPassData:GetLastBattleID(slot0.activityID_) or slot0.battleList_[1])
	slot0.scrollHelper_:StartScroll(#slot0.battleList_)
end

function slot0.GetActivityData(slot0)
	slot0.activityID_ = slot0.params_.activityId
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, RedPointConst.BATTLE_FIRST_PASS_REWARD .. slot0.activityID_)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshTime()
	slot0:RefreshList()
end

function slot0.RefreshTime(slot0)
	slot1 = nil

	slot0:StopActivityTimer()

	if manager.time:GetServerTime() < slot0.startTime_ then
		slot0.activityTimeCnt_.text = GetTips("ERROR_NOT_TIME")
		slot0.activityTimer_ = Timer.New(function ()
			uv0 = uv1.startTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopActivityTimer()
				uv1:RefreshTime()
				uv1.scrollHelper_:StartScrollByPosition(#uv1.battleList_, uv1.scrollHelper_:GetScrolledPosition())

				return
			end
		end, 1, -1)

		slot0.activityTimer_:Start()
	elseif slot2 < slot0.stopTime_ then
		slot0.activityTimeCnt_.text = manager.time:GetLostTimeStr(slot0.stopTime_, true)
		slot0.activityTimer_ = Timer.New(function ()
			uv0 = uv1.stopTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopActivityTimer()
				uv1:RefreshTime()
				uv1.scrollHelper_:StartScrollByPosition(#uv1.battleList_, uv1.scrollHelper_:GetScrolledPosition())

				return
			end

			uv1.activityTimeCnt_.text = manager.time:GetLostTimeStr(uv1.stopTime_, true)
		end, 1, -1)

		slot0.activityTimer_:Start()
	else
		slot0.activityTimeCnt_.text = GetTips("TIME_OVER")
	end
end

function slot0.RefreshList(slot0)
	slot0.battleList_ = BattleFirstPassData:GetBattleList(slot0.activityID_)
end

function slot0.SetCurBattleID(slot0, slot1)
	slot2 = nil
	slot0.curBattleID_ = slot1
	slot0.title_.text = ActivityFirstClearCfg[slot1].name
	slot5 = slot0.scrollHelper_
	slot7 = slot5

	for slot6, slot7 in pairs(slot5.GetItemList(slot7)) do
		slot7:SetSelected(slot0:IsSelect(slot7:GetID()))
	end
end

function slot0.IsSelect(slot0, slot1)
	return slot0.curBattleID_ == slot1
end

function slot0.StopActivityTimer(slot0)
	if slot0.activityTimer_ then
		slot0.activityTimer_:Stop()

		slot0.activityTimer_ = nil
	end
end

function slot0.UnBindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst.BATTLE_FIRST_PASS_REWARD .. slot0.activityID_)
end

function slot0.OnTop(slot0)
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
end

function slot0.OnExit(slot0)
	slot0:StopActivityTimer()
	slot0:UnBindRedPointUI()

	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end

	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
