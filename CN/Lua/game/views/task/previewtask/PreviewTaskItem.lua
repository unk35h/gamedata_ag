slot0 = class("PreviewTaskItem", ReduxView)
slot1 = import("game.tools.JumpTools")

function slot0.OnCtor(slot0, slot1)
	slot0.rewardItems_ = {}
	slot0.rewardItemGos_ = {}
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot2
	slot0.taskID_ = slot1
	slot0.taskProgress = PreviewTaskData:GetTaskProgress(slot1)
	slot0.taskComplete_ = PreviewTaskData:GetTaskComplete(slot1)

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = nil

	for slot4, slot5 in pairs(slot0.rewardItemGos_) do
		Object.Destroy(slot5)
	end

	slot0.rewardItemGos_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		uv1.JumpToPage2(AssignmentCfg[uv0.taskID_].source)
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PreviewTaskAction.TryToSubmitTask(uv0.taskID_)
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.goBtn_.onClick:RemoveAllListeners()
	slot0.receiveBtn_.onClick:RemoveAllListeners()
end

function slot0.RefreshUI(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]
	slot0.titleText_.text = slot1.name
	slot0.contentText_.text = slot1.desc
	slot2 = slot1.reward or {}

	for slot6, slot7 in ipairs(slot2) do
		if slot0.rewardItems_[slot6] == nil then
			slot0.rewardItems_[slot6] = RewardItem.New(slot0.rewardItem_, slot0.rewardParent_, true)

			slot0.rewardItems_[slot6]:UpdateCommonItemAni()
		end

		slot0.rewardItems_[slot6]:SetData(slot7)
	end

	for slot6 = #slot1.reward + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot6]:Show(false)
	end

	slot0:RefreshTime()
	slot0:RefreshProgress()
end

function slot0.RefreshProgress(slot0)
	slot2 = slot0.taskProgress

	if AssignmentCfg[slot0.taskID_].need < slot0.taskProgress then
		slot2 = slot1.need
	end

	slot0.progressBar_.fillAmount = slot2 / slot1.need
	slot0.progressText_.text = string.format("%s/%s", slot2, slot1.need)
	slot3 = slot1.need <= slot0.taskProgress

	if slot0.taskComplete_ == true then
		slot0.controller_:SetSelectedState("received")
	elseif slot3 then
		slot0.controller_:SetSelectedState("completed")
	else
		slot0.controller_:SetSelectedState("incomplete")
	end
end

function slot0.RefreshTime(slot0)
	if AssignmentCfg[slot0.taskID_].type == TaskConst.TASK_TYPE.PREVIEW_DAILY then
		slot0.endTime_ = manager.time:GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0)
		slot0.isDailyTask_ = true

		slot0.typeController_:SetSelectedState("daily")
	else
		slot0.isDailyTask_ = false

		slot0.typeController_:SetSelectedState("normal")
	end
end

return slot0
