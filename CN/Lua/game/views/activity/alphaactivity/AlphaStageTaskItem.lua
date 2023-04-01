slot0 = class("AlphaStageTaskItem", ReduxView)
slot1 = {
	"lock",
	"receive",
	"received"
}

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")

	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItemS_ = {}
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		TaskAction:TryToSubmitTask(uv0.taskID_)
		uv0:ChangeState("received")
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.GetTaskID(slot0)
	return slot0.taskID_
end

function slot0.GetTaskProgress(slot0)
	return TaskData:GetTask(slot0.taskID_) and slot1.progress or 0
end

function slot0.RefreshUI(slot0, slot1)
	slot0.taskID_ = slot1

	SetActive(slot0.gameObject_, true)
	slot0:RefreshState()
	slot0:RefreshReward()
	slot0:RefreshProgress()
end

function slot0.RefreshState(slot0)
	slot0.stage_ = AssignmentCfg[slot0.taskID_].phase

	if slot0.stage_ < TaskData:GetAssignmentPhase() then
		slot0:ChangeState("received")
	elseif TaskData:GetAssignmentPhase() == slot0.stage_ and slot0:IsTaskFinish() then
		slot0:ChangeState("receive")
	else
		slot0:ChangeState("lock")
	end
end

function slot0.ChangeState(slot0, slot1)
	slot0.stateCon_:SetSelectedState(slot1)
end

function slot0.IsTaskFinish(slot0)
	return AssignmentCfg[slot0.taskID_].need <= TaskData:GetTask(slot0.taskID_).progress
end

function slot0.RefreshReward(slot0)
	for slot5, slot6 in ipairs(AssignmentCfg[slot0:GetTaskID()].reward) do
		if slot0.rewardItemS_[slot5] == nil then
			slot0.rewardItemS_[slot5] = RewardItem.New(slot0.rewardTemplates_, slot0.rewardParent_, true)

			slot0.rewardItemS_[slot5]:UpdateCommonItemAni()
		end

		slot0.rewardItemS_[slot5]:SetData(slot6)
	end

	for slot5 = #slot1 + 1, #slot0.rewardItemS_ do
		slot0.rewardItemS_[slot5]:Show(false)
	end
end

function slot0.RefreshProgress(slot0)
	if AssignmentCfg[slot0:GetTaskID()].need < slot0:GetTaskProgress() then
		slot2 = slot1
	end

	if slot0.stage_ < TaskData:GetAssignmentPhase() then
		slot2 = slot1
	end

	slot0.finishTasks_.text = slot2
	slot0.allTasks_.text = "/" .. slot1
end

function slot0.OnSubcribe(slot0)
	slot0:RefreshProgress()
	slot0:RefreshState()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = 1, 3 do
		slot0[uv0[slot4]] = nil
	end

	for slot4 = 1, #slot0.rewardItemS_ do
		slot0.rewardItemS_[slot4]:Dispose()

		slot0.rewardItemS_[slot4] = nil
	end

	slot0.rewardItemS_ = nil

	uv1.super.Dispose(slot0)
end

return slot0
