slot0 = class("AlphaTaskItem", ReduxView)
slot1 = {
	"complete",
	"incomplete",
	"lock",
	"finish"
}

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItems_ = {}
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.JumpToPage2(AssignmentCfg[uv0:GetTaskID()].source)
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		TaskAction:TryToSubmitTask(uv0:GetTaskID())
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.GetTaskID(slot0)
	return slot0.taskID_
end

function slot0.GetAlphaTaskStage(slot0)
	return TaskData:GetAssignmentPhase()
end

function slot0.GetTaskComplete(slot0)
	return TaskData:GetTask(slot0.taskID_) == nil or slot1.complete_flag >= 1
end

function slot0.GetTaskProgress(slot0)
	return TaskData:GetTask(slot0.taskID_) and slot1.progress or 0
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot0.taskID_ = slot1
	end

	slot0:RefreshTitle()
	slot0:RefreshState()
	slot0:RefreshReward()
	slot0:RefreshProgress()
end

function slot0.RefreshTitle(slot0)
	slot0.titleText_.text = AssignmentCfg[slot0:GetTaskID()].desc
end

function slot0.RefreshState(slot0)
	slot0.state_ = slot0:GetItemState()

	slot0:ChangeState(slot0.state_)
end

function slot0.ChangeState(slot0, slot1)
	slot0.stateCon_:SetSelectedState(slot1)
end

function slot0.GetItemState(slot0)
	if slot0:GetAlphaTaskStage() < AssignmentCfg[slot0:GetTaskID()].phase then
		return uv0[3]
	end

	if slot0:GetTaskComplete() then
		return uv0[4]
	end

	if slot0:GetTaskProgress() < AssignmentCfg[slot0:GetTaskID()].need then
		return uv0[2]
	else
		return uv0[1]
	end
end

function slot0.RefreshReward(slot0)
	for slot5, slot6 in ipairs(AssignmentCfg[slot0:GetTaskID()].reward) do
		if slot0.rewardItems_[slot5] == nil then
			slot0.rewardItems_[slot5] = RewardItem.New(slot0.rewardTemplate_, slot0.rewardParent_, true)
			slot7 = slot0.rewardItems_[slot5]

			slot7:UpdateCommonItemAni()

			slot7 = slot0.rewardItems_[slot5].commonItem_

			slot7:RegistCallBack(function ()
				OperationRecorder.Record("test_activity", "test_item")
			end)
		end

		slot0.rewardItems_[slot5]:SetData(slot6)
	end

	for slot5 = #slot1 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot5]:Show(false)
	end
end

function slot0.RefreshProgress(slot0)
	if AssignmentCfg[slot0:GetTaskID()].need < slot0:GetTaskProgress() then
		slot2 = slot1
	end

	if slot0:GetTaskComplete() then
		slot2 = slot1
	end

	slot0.progressBar_.fillAmount = slot2 / slot1
	slot0.progressText_.text = string.format("%s/%s", slot2, slot1)
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.OnExit(slot0)
end

function slot0.SetSiblingIndex(slot0, slot1)
	slot0.transform_:SetSiblingIndex(slot1)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.rewardItems_ then
		for slot4 = #slot0.rewardItems_, 1, -1 do
			slot0.rewardItems_[slot4]:Dispose()

			slot0.rewardItems_[slot4] = nil
		end

		slot0.rewardItems_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
