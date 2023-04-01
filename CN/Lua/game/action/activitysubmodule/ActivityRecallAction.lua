return {
	Init = function ()
		slot0 = manager.net

		slot0:Bind(64087, function (slot0)
			ActivityRecallData:InitActivityRecallData(slot0)
			manager.notify:CallUpdateFunc(RECALL_REWARD_UPDATE)
		end)

		slot0 = manager.net

		slot0:Bind(64095, function (slot0)
			ActivityRecallData:InitActivityRecalledData(slot0)
		end)

		slot0 = manager.net

		slot0:Bind(64115, function (slot0)
			ActivityRecallData:InitRecalledSignData(slot0)
			manager.notify:CallUpdateFunc(RECALL_SIGN_UPDATE)
		end)
	end,
	RequireRecallReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(64088, {
			activity_id = slot0,
			id = slot1
		}, 64089, uv0.RequireRecallRewardCallback)
	end,
	RequireRecallRewardCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityRecallData:UpdateRecallRewardList(slot1.id)

			slot2 = {}

			for slot7, slot8 in pairs(ActivityRecallData:GetDataByPara("recallReward")[slot1.id]) do
				if type(slot8) ~= "number" then
					table.insert(slot2, slot8)
				end
			end

			JumpTools.GoToSystem("RecallRewardPop", {
				list = slot2
			})
			manager.notify:CallUpdateFunc(RECALL_REWARD_UPDATE)
			ActivityRecallData:UpdateRecallRewardRedPoint()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	RequireRecallInfo = function (slot0)
		manager.net:SendWithLoadingNew(64090, {
			activity_id = slot0
		}, 64091, uv0.RequireRecallInfoCallback)
	end,
	RequireRecallInfoCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityRecallData:UpdateUserInfoList(slot0)
			JumpTools.GoToSystem("RecallInfoPop", nil)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	RequireRecallShareCode = function (slot0)
		manager.net:SendWithLoadingNew(64092, {
			activity_id = slot0
		}, 64093, uv0.RequireRecallShareCodeCallback)
	end,
	RequireRecallShareCodeCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ShowTips("COPY_SUCCESS")

			UnityEngine.GUIUtility.systemCopyBuffer = ActivityRecallData:GetDataByPara("recallCode")

			ActivityRecallData:UpdateTaskData()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	RequireWriteRecallCode = function (slot0, slot1)
		manager.net:SendWithLoadingNew(64096, {
			activity_id = slot0,
			recall_code = slot1
		}, 64097, uv0.RequireWriteRecallCodeCallback)
	end,
	RequireWriteRecallCodeCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityRecallData:UpdateRecallUserInfo(slot0)
			manager.notify:CallUpdateFunc(RECALL_CODE_UPDATE)
			JumpTools.GoToSystem("RecallRewardPop", {
				list = ActivityRecallData:GetDataByPara("recalledReward")
			})
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	RequireRecalledSign = function (slot0, slot1)
		manager.net:SendWithLoadingNew(64098, {
			activity_id = slot0,
			sign_day = slot1
		}, 64099, uv0.RequireRecalledSignCallback)
	end,
	RequireRecalledSignCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityRecallData:UpdateSignData(slot1.sign_day)
			JumpTools.GoToSystem("RecallRewardPop", {
				list = {
					ActivityRecallData:GetDataByPara("signData")[slot1.sign_day].reward
				}
			})
			ActivityRecallData:UpdateSignRedPoint()
			manager.notify:CallUpdateFunc(RECALL_SIGN_UPDATE)
		else
			ShowTips(GetTips(slot0.result))
		end
	end
}
