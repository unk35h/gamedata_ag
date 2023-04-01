slot0 = class("RaceTrailMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/OsirisUI/OsirisUITrialUI"
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

	slot0.battleList_ = {}
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, RaceTrailBattleItem)
	slot0.receiveCon_ = ControllerUtil.GetController(slot0.transform_, "receiveCon")
	slot0.scoreRewardItem_ = CommonItem.New(slot0.CommonItemGo_)
	slot1 = slot0.scoreRewardItem_

	slot1:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0.reward_)
	end)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.battleList_[slot1], slot0.activityID_)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.firstRewardBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("raceTrailFirstReward", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.scoreRewardBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("raceTrailScoreReward", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrailAction:ReceiveScoreReward(uv0.curLv_)
	end)
	slot0:AddBtnListener(slot0.DivineBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("heroRaceTrailDetails")
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID or ActivityConst.OSIRIS_TRAIL

	slot0:BindRedPointUI()
	slot0:RefreshUI()
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, slot0.params_.activityID))
end

function slot0.RefreshUI(slot0)
	slot0:GetCurLv()
	slot0:RefreshTimeCnt()
	slot0:RefreshList()
	slot0:RefreshScoreItem()
end

function slot0.GetCurLv(slot0)
	slot0.curLv_ = RaceTrailData:GetCurLv(slot0.activityID_)
	slot0.data_ = RaceTrailData:GetScoreRewardByID(slot0.curLv_)
end

function slot0.RefreshTimeCnt(slot0)
	slot1 = nil
	slot3 = slot0:GetActivityEndTime()

	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0:GetActivityStartTime() then
		slot1 = slot2 - slot4
		slot0.timeCntText_.text = GetTips("ERROR_ACTIVITY_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1 - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv2:StopTimer()
				uv2:RefreshUI()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot4 < slot3 then
		slot0.timeCntText_.text = slot0:GetTimeText(slot3 - slot4)
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1 - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv2:StopTimer()
				uv2:RefreshUI()

				return
			end

			uv2.timeCntText_.text = uv2:GetTimeText(uv0)
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeCntText_.text = GetTips("TIME_OVER")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.GetActivityStartTime(slot0)
	return RaceTrailData:GetRaceTrailStartTime(slot0.activityID_)
end

function slot0.GetActivityEndTime(slot0)
	return RaceTrailData:GetRaceTrailEndTime(slot0.activityID_)
end

function slot0.GetTimeText(slot0, slot1)
	slot2 = ""

	return slot1 / 86400 >= 1 and math.ceil(slot1 / 86400) .. GetTips("DAY") or slot1 / 3600 >= 1 and math.ceil(slot1 / 3600) .. GetTips("HOUR") or slot1 / 60 >= 1 and math.ceil(slot1 / 60) .. GetTips("MINUTE") or 1 .. GetTips("MINUTE")
end

function slot0.RefreshList(slot0)
	slot0.battleList_ = ActivityData:GetActivityData(slot0.activityID_).subActivityIdList

	slot0.scrollHelper_:StartScrollByPosition(#slot0.battleList_, Vector2(getData(string.format("RaceTrial_%d", slot0.activityID_), "scrollPosX"), 1))
end

function slot0.RefreshScoreItem(slot0)
	slot0.rewardCfg_ = ActivityPointRewardCfg[slot0.curLv_]
	slot1 = RaceTrailData:GetTotalScore(slot0.activityID_)
	slot0.scoreNeedText_.text = GetTips("ACCUMULATED_POINTS_REACHED") .. slot0.rewardCfg_.need
	slot0.scoreText_.text = slot1 .. "/" .. slot0.rewardCfg_.need
	slot0.progressBar_.fillAmount = slot1 / slot0.rewardCfg_.need
	slot0.reward_ = slot0.rewardCfg_.reward_item_list[1]

	slot0.scoreRewardItem_:RefreshData(formatReward(slot0.rewardCfg_.reward_item_list[1]))

	if slot0.data_.receive_flag then
		slot0.receiveCon_:SetSelectedState("received")
	elseif slot0.rewardCfg_.need <= slot1 then
		slot0.receiveCon_:SetSelectedState("complete")
	else
		slot0.receiveCon_:SetSelectedState("incomplete")
	end
end

function slot0.UnBindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, slot0.params_.activityID))
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE")
end

function slot0.OnPointReceive(slot0)
	slot0:GetCurLv()
	slot0:RefreshScoreItem()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:UnBindRedPointUI()

	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end

	slot0.scoreRewardItem_:OnExit()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	saveData(string.format("RaceTrial_%d", slot0.activityID_), "scrollPosX", slot0.scrollHelper_:GetScrolledPosition().x)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	slot0.scoreRewardItem_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
