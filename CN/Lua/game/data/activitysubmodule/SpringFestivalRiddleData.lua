slot0 = singletonClass("SpringFestivalRiddleData")

function slot0.Init(slot0)
	slot0.activityRiddleList_ = {}
end

function slot0.InitData(slot0, slot1)
	slot2 = slot1.activity_id
	slot3 = {}

	for slot7, slot8 in ipairs(slot1.admitted_award) do
		table.insert(slot3, slot8)
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot1.answer_history) do
		slot10 = {}

		for slot14, slot15 in ipairs(slot9.answer) do
			table.insert(slot10, slot15)
		end

		slot4[slot9.quiz_id] = {
			answerList = slot10,
			correct = slot9.correct == 1
		}
	end

	for slot8, slot9 in ipairs(ActivitySpringFestivalRiddleCfg.get_id_list_by_activity_id[slot2]) do
		if slot4[slot9] == nil then
			slot4[slot9] = {
				correct = false,
				answerList = {}
			}
		end
	end

	slot0.activityRiddleList_[slot2] = {
		canAnswer = slot1.is_today_answer == 0,
		riddleList = slot4,
		rewardList = slot3,
		lastQuestionID = slot1.last_answer_quiz,
		lastAnswerTime = slot1.last_answer_time
	}
end

function slot0.CanAnswer(slot0, slot1)
	return slot0.activityRiddleList_[slot1].canAnswer
end

function slot0.GetQuestionAnswerList(slot0, slot1, slot2)
	return slot0.activityRiddleList_[slot1].riddleList[slot2].answerList or {}
end

function slot0.IsCorrectAnswer(slot0, slot1, slot2)
	return slot0.activityRiddleList_[slot1].riddleList[slot2].correct or false
end

function slot0.GetLastAnswerTime(slot0, slot1)
	return slot0.activityRiddleList_[slot1].lastAnswerTime or 0
end

function slot0.ReceiveReward(slot0, slot1, slot2)
	table.insert(slot0.activityRiddleList_[slot1].rewardList, slot2)
end

function slot0.GetReceiveList(slot0, slot1)
	return slot0.activityRiddleList_[slot1].rewardList
end

function slot0.SubmitRiddle(slot0, slot1, slot2, slot3, slot4)
	table.insert(slot0.activityRiddleList_[slot1].riddleList[slot2].answerList, slot3)

	slot0.activityRiddleList_[slot1].lastQuestionID = slot2
	slot0.activityRiddleList_[slot1].lastAnswerTime = manager.time:GetServerTime()

	if slot4 then
		slot0.activityRiddleList_[slot1].canAnswer = false
		slot0.activityRiddleList_[slot1].riddleList[slot2].correct = true

		if table.keyof(slot0.activityRiddleList_[slot1].rewardList, slot0:GetCorrectCnt(slot1)) == nil then
			table.insert(slot5, slot6)
		end
	end
end

function slot0.GetCorrectCnt(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in pairs(slot0.activityRiddleList_[slot1].riddleList) do
		if slot7.correct == true then
			slot2 = slot2 + 1
		end
	end

	return slot2
end

return slot0
