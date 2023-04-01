slot0 = class("ActivityTaskBaseItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.rewardItems_ = {}

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "conName")
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:StopTimer()

	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItem_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnGo_, nil, function ()
		JumpTools.JumpToPage2(AssignmentCfg[uv0.taskID_].source)
	end)
	slot0:AddBtnListener(slot0.btnReceive_, nil, function ()
		slot0 = AssignmentCfg[uv0.taskID_]

		TaskAction.SubmitTask(uv0.taskID_, function (slot0)
			if isSuccess(slot0.result) then
				getReward(uv0.reward)
				TaskData:OsirisTaskSubmit(uv1.taskID_)
				manager.notify:Invoke(OSIRIS_TASK_UPDATE)
			else
				ShowTips(slot0.result)
			end
		end)
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.taskID_ = slot1

	slot0:RefreshUI()
	slot0:RefreshReward(slot1)
	slot0:RefreshState()
	slot0:AddTimer()
end

function slot0.RefreshUI(slot0)
	slot1 = slot0.taskID_
	slot2 = AssignmentCfg[slot1]
	slot0.textContent_.text = slot2.name
	slot0.textDesc_.text = slot2.desc

	if slot2.need < (TaskData:GetActivityTaskList(slot2.activity_id)[slot1].progress or 0) then
		slot4 = slot5
	end

	slot0.imageProgress_.fillAmount = slot4 / slot5
	slot0.textProgress_.text = string.format("%s/%s", slot4, slot5)

	if slot2.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		slot0.typeController_:SetSelectedState("daily")
	else
		slot0.typeController_:SetSelectedState("challenge")
	end
end

function slot0.RefreshReward(slot0, slot1)
	for slot6, slot7 in ipairs(AssignmentCfg[slot1].reward) do
		if slot0.rewardItems_[slot6] == nil then
			slot0.rewardItems_[slot6] = slot0:GetRewardItem(slot7)
		else
			slot0.rewardItems_[slot6]:SetData(slot7)
		end
	end

	for slot6 = #slot2 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot6]:Show(false)
	end
end

function slot0.GetRewardItem(slot0, slot1)
	return RewardPoolItem.New(slot0.goItemParent_, slot1)
end

function slot0.RefreshState(slot0)
	slot0.stateController_:SetSelectedState(slot0:GetItemState())
end

function slot0.GetItemState(slot0)
	slot3 = TaskData:GetActivityTaskList(AssignmentCfg[slot0.taskID_].activity_id)[slot0.taskID_].progress or 0

	if slot2.complete_flag >= 1 then
		return 2
	end

	if slot1.need <= slot3 then
		return 1
	else
		return 0
	end
end

function slot0.AddTimer(slot0)
	if slot0.timer_ then
		slot0:StopTimer()
	end

	slot4 = manager.time:GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0)

	if TaskData:GetActivityTaskList(AssignmentCfg[slot0.taskID_].activity_id)[slot0.taskID_].expired_timestamp == nil or slot5 == 0 then
		slot5 = slot4
	end

	if slot0.textTime_ then
		slot0.textTime_.text = manager.time:GetLostTimeStr(slot5)
	end

	slot0.timer_ = Timer.New(function ()
		if uv0 <= manager.time:GetServerTime() then
			if uv1 and uv1.expired_timestamp then
				uv0 = uv1.expired_timestamp
			else
				uv0 = manager.time:GetNextTime(uv2, 0, 0)
			end
		end

		if uv3.textTime_ then
			uv3.textTime_.text = manager.time:GetLostTimeStr(uv0)
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
