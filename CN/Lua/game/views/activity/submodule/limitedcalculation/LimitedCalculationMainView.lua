slot0 = class("LimitedCalculationMainView", ReduxView)

function slot0.UIName(slot0)
	return LimitedCalculationTools.GetMainUIName(slot0.params_.activityId)
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

	slot0.difficultyCon_ = ControllerUtil.GetController(slot0.transform_, "difficulty")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		slot0 = manager.time:GetServerTime()

		if uv0.openState_ == 0 and slot0 < uv0.startTime_ or uv0.stopTime_ <= slot0 then
			ShowTips("ERROR_ACTIVITY_NOT_OPEN")

			return
		end

		uv0:Go("/sectionSelectHero", {
			section = ActivityLimitCalculationCfg[uv0.curDifficulty_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION,
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("limitedCalculationReward", {
			activityId = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.difficultBtn_, nil, function ()
		JumpTools.OpenPageByJump("limitedCalculationDifficulty", {
			activityId = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.rankBtn_, nil, function ()
		JumpTools.OpenPageByJump("/limitedCalculationRank", {
			activityId = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.debuffBtn_, nil, function ()
		JumpTools.OpenPageByJump("buffDescription", {
			type = "debuff",
			activityId = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.buffBtn_, nil, function ()
		JumpTools.OpenPageByJump("buffDescription", {
			type = "buff",
			activityId = uv0.activityID_
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0:GetActivityData()
	slot0:RefreshUI()
	slot0:BindRedPointUI()
	LimitedCalculationAction:QueryRankList(slot0.activityID_)
end

function slot0.GetActivityData(slot0)
	slot0.activityID_ = slot0.params_.activityId
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
	slot0.openState_ = slot0.activityData_.state
end

function slot0.RefreshUI(slot0)
	slot0:RefreshDifficultDes()
	slot0:RefreshLock()
	slot0:RefreshScore()
	slot0:RefreshTime()
	slot0:RefreshRank()
end

function slot0.RefreshDifficultDes(slot0)
	slot0.curDifficulty_ = LimitedCalculationData:GetCurDifficulty(slot0.activityID_)
	slot1 = ActivityLimitCalculationCfg[slot0.curDifficulty_]
	slot0.debuffLv_ = slot1.enemy_level
	slot0.buffLv_ = slot1.player_level
	slot0.oddsDes_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_POINT_RANK"), slot1.reward_point / 100)
	slot0.debuffDes_.text = slot0.debuffLv_
	slot0.buffDes_.text = slot0.buffLv_

	slot0.difficultyCon_:SetSelectedState(slot1.difficulty)
end

function slot0.RefreshLock(slot0)
	SetActive(slot0.debuffLock_, slot0.debuffLv_ <= 0)
	SetActive(slot0.buffLock_, slot0.buffLv_ <= 0)
end

function slot0.RefreshScore(slot0)
	slot0.score_.text = LimitedCalculationData:GetScore(slot0.activityID_) > 0 and slot1 or GetTips("MATRIX_RANK_NO_INFO")
end

function slot0.RefreshTime(slot0)
	slot1 = nil

	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ and slot0.openState_ == 0 then
		slot0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.startTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot0.startTime_ <= slot2 and slot0.openState_ == 0 then
		slot0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			uv0:StopTimer()
			uv0:RefreshTime()
		end, 10, 1)

		slot0.timer_:Start()
	elseif slot2 < slot0.stopTime_ then
		slot0.timeTxt_.text = manager.time:GetLostTimeStr(slot0.stopTime_, true)
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.stopTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end

			uv1.timeTxt_.text = manager.time:GetLostTimeStr(uv1.stopTime_, true)
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function slot0.RefreshRank(slot0)
	SetActive(slot0.rankBtn_.gameObject, LimitedCalculationData:IsRankOpen(slot0.activityID_))
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.BindRedPointUI(slot0)
	LimitedCalculationData:SetIsNeed(slot0.activityID_, false)
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, RedPointConst.LIMITED_CALCULATION_REWARD .. slot0.activityID_)
end

function slot0.UnBindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst.LIMITED_CALCULATION_REWARD .. slot0.activityID_)
end

function slot0.OnLimitedDifficultyChange(slot0)
	slot0:RefreshDifficultDes()
	slot0:RefreshLock()
end

function slot0.OnTop(slot0)
	if LimitedCalculationTools.GetGameHelpKey(slot0.activityID_) ~= "" then
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
	slot0:StopTimer()
	slot0:UnBindRedPointUI()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

return slot0
