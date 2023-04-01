slot0 = class("ActivityPt2TaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItems_ = {}
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
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

function slot0.Refresh(slot0, slot1, slot2)
	slot0.taskID_ = slot1
	slot0.activityID_ = slot2
	slot0.taskActivityID_ = ActivityPt2Tools:GetTaskActivityID(slot0.activityID_)
	slot0.info_ = TaskData:GetActivityTaskList(slot0.taskActivityID_)[slot0.taskID_]
	slot0.cfg_ = AssignmentCfg[slot1]

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshReward()
	slot0:RefreshTask()
end

function slot0.RefreshReward(slot0)
	for slot5, slot6 in ipairs(slot0.cfg_.reward) do
		if not slot0.rewardItems_[slot5] then
			slot0.rewardItems_[slot5] = RewardItem.New(slot0.rewardItem_, slot0.rewardParent_)

			slot0.rewardItems_[slot5]:UpdateCommonItemAni()
		end

		slot0.rewardItems_[slot5]:SetData(slot6)
	end

	for slot5 = #slot1 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot5]:Show(false)
	end
end

function slot0.RefreshTask(slot0)
	slot0.desc_.text = slot0.cfg_.desc
	slot0.progress_.text = slot0.info_.progress .. "/" .. slot0.cfg_.need
	slot0.slider_.value = slot0.info_.progress / slot0.cfg_.need

	if slot0.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		slot0.typeCon_:SetSelectedState("normal")
	else
		slot0.typeCon_:SetSelectedState("challenge")
	end

	if slot0.info_.complete_flag >= 1 then
		slot0.stateCon_:SetSelectedState("received")
	elseif slot0.cfg_.need <= slot0.info_.progress then
		slot0.stateCon_:SetSelectedState("complete")
	else
		slot0.stateCon_:SetSelectedState("unfinish")
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot4]:Dispose()
	end

	slot0.super.Dispose(slot0)
end

return slot0
