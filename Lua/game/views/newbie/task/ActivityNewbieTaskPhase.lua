slot0 = class("ActivityNewbieTaskPhase", ReduxView)
slot1 = {
	"lock",
	"receive",
	"received"
}

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")

	slot0:BindCfgUI()
	slot0:AddListener()

	slot0.rewardItemList_ = {}
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		slot0 = AssignmentCfg[uv0.taskID_]
		slot2 = slot0.need <= TaskData:GetNewbiePhaseTask()[slot0.phase].progress

		if TaskData:GetAssignmentPhase() ~= slot1 or not slot2 then
			return
		end

		TaskAction.SubmitTask(uv0.taskID_, function (slot0)
			if isSuccess(slot0.result) then
				getReward(uv0.reward)
				TaskData:NewbieTaskSubmit(uv1.taskID_)
				manager.notify:Invoke(NEWBIE_TASK_UPDATE)
				uv1.stateCon_:SetSelectedState("received")

				if TaskData:GetAssignmentPhase() > #TaskData:GetNewbiePhaseTask() then
					slot1 = #slot2
				end

				uv1:SetData(slot2[slot1].id)
			else
				ShowTips(slot0.result)
			end
		end)
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.taskID_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshState()
	slot0:RefreshReward()
	slot0:RefreshProgress()
end

function slot0.RefreshState(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]
	slot3 = slot1.need <= TaskData:GetNewbiePhaseTask()[slot1.phase].progress

	if slot2 < TaskData:GetAssignmentPhase() then
		slot0.stateCon_:SetSelectedState("received")
	elseif TaskData:GetAssignmentPhase() == slot2 and slot3 then
		slot0.stateCon_:SetSelectedState("receive")
	else
		slot0.stateCon_:SetSelectedState("lock")
	end
end

function slot0.RefreshReward(slot0)
	slot1 = AssignmentCfg[slot0.taskID_].reward

	for slot5 = 1, 2 do
		slot0[string.format("textRewardCnt%s_", slot5)].text = string.format("x%s", slot1[slot5][2])
	end
end

function slot0.RefreshProgress(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]

	if slot1.need < TaskData:GetNewbiePhaseTask()[slot1.phase].progress then
		slot3 = slot2
	end

	if slot1.phase < TaskData:GetAssignmentPhase() then
		slot3 = slot2
	end

	slot0.finishTasks_.text = slot3
	slot0.allTasks_.text = "/" .. slot2
end

return slot0
