slot1 = manager.net

slot1:Bind(40005, function (slot0)
	SurveyData:InitData(slot0)
	RegressionAction.ChcekSurveyRedPoint()
end)

slot1 = manager.net

slot1:Bind(40009, function (slot0)
	SurveyData:FinishSurvey(slot0.id)
	uv0.UpdateSurveyRedPoint(true)
	manager.notify:CallUpdateFunc(FINISH_SURVEY, slot0)
	RegressionAction.ChcekSurveyRedPoint()
end)

slot1 = manager.net

slot1:Bind(40023, function (slot0)
	SurveyData:ReservationGame(slot0.state == 1)
end)

slot1 = manager.net

slot1:Bind(40011, function (slot0)
	SurveyData:SetPraise(true)
	SurveyData:SetSourceId(slot0.source_id)
end)

return {
	Praise = function (slot0)
		manager.net:Push(40012, {
			btn = slot0
		})
	end,
	GetReward = function (slot0)
		manager.net:SendWithLoadingNew(40006, {
			id = slot0
		}, 40007, uv0.OnGetReward)
	end,
	OnGetReward = function (slot0, slot1)
		if isSuccess(slot0.result) then
			SurveyData:GotReward(slot1.id)
			manager.notify:CallUpdateFunc(GET_SURVEY_GIFT, slot0, slot1)
			uv0.UpdateSurveyRedPoint()
			RegressionAction.ChcekSurveyRedPoint()
		else
			ShowTips(slot0.result)
		end
	end,
	ReservationGame = function ()
		manager.net:SendWithLoadingNew(40024, {
			state = 1
		}, 40025, uv0.OnReservationGame)
	end,
	OnReservationGame = function (slot0, slot1)
		if isSuccess(slot0.result) then
			SurveyData:ReservationGame(true)
			manager.notify:CallUpdateFunc(RESERVATION_GAME, slot0)
		else
			ShowTips(slot0.result)
		end
	end,
	SetSurveyRedPointData = function ()
		slot5 = manager.time:GetServerTime()

		saveData("SDK", "survey", slot5)

		slot1 = {}
		slot4 = SurveyData
		slot6 = slot4

		for slot5, slot6 in pairs(slot4.GetSurveyList(slot6)) do
			table.insert(slot1, slot6.id)
		end

		saveData("SDK", "surveyList", slot1)
		uv0.UpdateSurveyRedPoint()
	end,
	UpdateSurveyRedPoint = function (slot0)
		slot1 = nil

		if not slot0 and getData("SDK", "survey") and manager.time:IsSameDay(slot2 - 18000, manager.time:GetServerTime() - 18000) then
			slot1 = 0
		end

		slot2 = getData("SDK", "surveyList") or {}
		slot7 = SurveyData

		for slot6, slot7 in pairs(slot5.GetSurveyList(slot7)) do
			if slot7.type ~= 2 and not table.keyof(slot2, slot6) then
				slot1 = 1

				break
			end
		end

		for slot7, slot8 in pairs(SurveyData:GetSurveyList()) do
			if slot8.type ~= 2 and slot8.status == 1 then
				slot1 = 1

				break
			end
		end

		if not table.keyof(OperationData:GetOperationOpenList(), OperationConst.QUESTIONNAIRE) then
			slot1 = 0
		end

		manager.redPoint:setTip(RedPointConst.SURVEY, slot1)
	end,
	FollowPlatform = function (slot0)
		manager.net:SendWithLoadingNew(40026, {
			type = slot0
		}, 40027, uv0.OnFollowPlatform)
	end,
	OnFollowPlatform = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if OperationConst.PLATFORM.BILIBILI == slot1.type then
				SurveyData:CacheFollowTip(GetTips("WEIBO_REWARD_SENT"))
			elseif OperationConst.PLATFORM.YOUTUBE == slot1.type then
				SurveyData:CacheFollowTip(GetTips("WEIBO_REWARD_SENT"))
			else
				ShowTips("WEIBO_REWARD_SENT")
			end
		elseif OperationConst.PLATFORM.BILIBILI == slot1.type then
			SurveyData:CacheFollowTip(GetTips("ERROR_WEIBO_REWARD_COLLECTED"))
		elseif OperationConst.PLATFORM.YOUTUBE == slot1.type then
			SurveyData:CacheFollowTip(GetTips("ERROR_WEIBO_REWARD_COLLECTED"))
		else
			ShowTips("ERROR_WEIBO_REWARD_COLLECTED")
		end
	end
}
