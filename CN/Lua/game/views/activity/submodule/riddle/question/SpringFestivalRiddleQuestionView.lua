slot0 = class("SpringFestivalQuestionView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/Riddle/RiddleQuestionUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.answerItemList_ = {}

	for slot4 = 1, 4 do
		slot0.answerItemList_[slot4] = SpringFestivalRiddleAnswerItem.New(slot0[string.format("answerGo%s_", slot4)], slot4)
	end

	slot0.riddleUpdateHandler_ = handler(slot0, slot0.RefreshRiddleItem)
	slot0.riddleAnswerTipsHandler_ = handler(slot0, slot0.ShowAnswerTips)
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.questionID_ = slot0.params_.questionID

	for slot4, slot5 in ipairs(slot0.answerItemList_) do
		slot5:OnEnter(slot0.activityID_, slot0.questionID_)
	end

	slot0.questionText_.text = ActivitySpringFestivalRiddleCfg[slot0.questionID_].question

	SetActive(slot0.tipsGo_, false)
	slot0:AddTimer()
	manager.notify:RegistListener(SPRING_FESTIVAL_RIDDLE_UPDATE, slot0.riddleUpdateHandler_)
	manager.notify:RegistListener(SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR, slot0.riddleAnswerTipsHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(SPRING_FESTIVAL_RIDDLE_UPDATE, slot0.riddleUpdateHandler_)

	slot4 = SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR
	slot5 = slot0.riddleAnswerTipsHandler_

	manager.notify:RemoveListener(slot4, slot5)
	slot0:StopTimer()
	slot0:StopTipsTimer()

	for slot4, slot5 in ipairs(slot0.answerItemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.riddleUpdateHandler_ = nil
	slot0.riddleAnswerTipsHandler_ = nil

	for slot4, slot5 in ipairs(slot0.answerItemList_) do
		slot5:Dispose()
	end

	slot0.answerItemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RefreshRiddleItem(slot0)
	slot0:AddTimer()
end

function slot0.RefreshItemEnabled(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.answerItemList_) do
		slot6:RefreshItemEnabled(slot1)
	end
end

function slot0.ShowAnswerTips(slot0)
	slot0.tipsText_.text = string.format(GetTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_ERROR_CD"), GameSetting.activity_spring_festival_riddle_punish_time.value[1])

	SetActive(slot0.tipsGo_, true)
	slot0:AddTipsTimer()
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	if manager.time:GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0) < SpringFestivalRiddleData:GetLastAnswerTime(slot0.activityID_) + GameSetting.activity_spring_festival_riddle_punish_time.value[1] * 60 then
		slot2 = slot4
	end

	if slot2 <= manager.time:GetServerTime() or slot4 - slot1 > 86400 then
		slot0:RefreshItemEnabled(true)
		slot0.controller_:SetSelectedState("false")

		return
	end

	slot0:RefreshItemEnabled(false)

	if SpringFestivalRiddleData:CanAnswer(slot0.activityID_) then
		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end

	slot0.timeText_.text = string.format(GetTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_CD"), manager.time:GetLostTimeStr(slot2, true))
	slot0.timer_ = Timer.New(function ()
		uv0 = manager.time:GetNextTime(uv1, 0, 0)

		if uv2 <= manager.time:GetServerTime() or uv0 - uv3 > 86400 then
			uv4:RefreshItemEnabled(true)
			uv4.controller_:SetSelectedState("false")
			uv4:StopTimer()

			return
		end

		uv4.timeText_.text = string.format(GetTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_CD"), manager.time:GetLostTimeStr(uv2, true))
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.AddTipsTimer(slot0)
	slot0:StopTipsTimer()

	slot0.tipsTimer_ = Timer.New(function ()
		uv0:StopTipsTimer()
		SetActive(uv0.tipsGo_, false)
	end, 1, 1)

	slot0.tipsTimer_:Start()
end

function slot0.StopTipsTimer(slot0)
	if slot0.tipsTimer_ then
		slot0.tipsTimer_:Stop()

		slot0.tipsTimer_ = nil
	end
end

return slot0
