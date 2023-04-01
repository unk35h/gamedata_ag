slot0 = class("SpringFestivalRiddleAnswerItem", ReduxView)
slot0.STATE = {
	CAN_CHOICE = 1,
	FINISH = 4,
	LOCK = 2,
	PENALTY = 3
}

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "Abtn")
end

function slot0.OnEnter(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.questionID_ = slot2
	slot0.answerText_.text = ActivitySpringFestivalRiddleCfg[slot2].answer_list[slot0.index_]
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.state_ == uv1.STATE.FINISH then
			return
		end

		if not SpringFestivalRiddleData:CanAnswer(uv0.activityID_) then
			ShowTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_FINISH")

			return
		end

		if uv0.state_ == uv1.STATE.PENALTY then
			if manager.time:GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0) < SpringFestivalRiddleData:GetLastAnswerTime(uv0.activityID_) + GameSetting.activity_spring_festival_riddle_punish_time.value[1] * 60 then
				slot1 = slot3
			end

			if manager.time:GetServerTime() < slot1 then
				ShowTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_BAN")

				return
			end
		end

		SpringFestivalRiddleAction.ChoiceAnswer(uv0.activityID_, uv0.questionID_, uv0.index_, function (slot0)
			if isSuccess(slot0.result) then
				slot2 = ActivitySpringFestivalRiddleCfg[uv0.questionID_].correct_answer == uv0.index_

				SpringFestivalRiddleData:SubmitRiddle(uv0.activityID_, uv0.questionID_, uv0.index_, slot2)

				if slot2 then
					slot4 = ActivityPointRewardCfg.get_id_list_by_activity_id[uv0.activityID_][#SpringFestivalRiddleData:GetReceiveList(uv0.activityID_)]

					SpringFestivalRiddleData:ReceiveReward(uv0.activityID_, slot4)
					getReward(ActivityPointRewardCfg[slot4].reward_item_list)
				else
					manager.audio:PlayUIAudio(7)
					manager.notify:Invoke(SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR)
				end

				SpringFestivalRiddleAction.RefreshRedPoint(uv0.activityID_)
				manager.notify:Invoke(SPRING_FESTIVAL_RIDDLE_UPDATE)
			else
				ShowTips(slot0.result)
			end
		end)
	end)
end

function slot0.RefreshItemEnabled(slot0, slot1)
	slot2 = SpringFestivalRiddleData:GetQuestionAnswerList(slot0.activityID_, slot0.questionID_)

	if SpringFestivalRiddleData:IsCorrectAnswer(slot0.activityID_, slot0.questionID_) then
		if ActivitySpringFestivalRiddleCfg[slot0.questionID_].correct_answer == slot0.index_ then
			slot0.controller_:SetSelectedState("correct")
		else
			slot0.controller_:SetSelectedState("normal")
		end

		slot0:FinishState()

		return
	end

	if table.keyof(slot2, slot0.index_) then
		if ActivitySpringFestivalRiddleCfg[slot0.questionID_].correct_answer == slot0.index_ then
			slot0.controller_:SetSelectedState("correct")
		else
			slot0.controller_:SetSelectedState("error")
		end
	else
		slot0.controller_:SetSelectedState("normal")
	end

	if table.keyof(slot2, slot0.index_) then
		slot0:FinishState()

		return
	end

	if not SpringFestivalRiddleData:CanAnswer(slot0.activityID_) then
		slot0:LockState()

		return
	end

	if slot1 == false then
		slot0:PenaltyState()
	else
		slot0:CanChoiceState()
	end
end

function slot0.FinishState(slot0)
	slot0.btn_.interactable = false
	slot0.state_ = uv0.STATE.FINISH
end

function slot0.LockState(slot0)
	slot0.btn_.interactable = true
	slot0.state_ = uv0.STATE.LOCK
end

function slot0.PenaltyState(slot0)
	slot0.btn_.interactable = true
	slot0.state_ = uv0.STATE.PENALTY
end

function slot0.CanChoiceState(slot0)
	slot0.btn_.interactable = true
	slot0.state_ = uv0.STATE.CAN_CHOICE
end

return slot0
