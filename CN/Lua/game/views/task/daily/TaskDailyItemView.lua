slot0 = class("TaskDailyItemView", ReduxView)
slot1 = import("game.tools.JumpTools")

function slot0.OnCtor(slot0, slot1)
	slot0.rewardItems_ = {}
	slot0.rewardItemGos_ = {}
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.isShow_ = true

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.ReEnter(slot0, slot1)
	slot0.taskID_ = slot1
	slot0.taskProgress = TaskData:GetTaskProgress(slot1)
	slot0.taskComplete_ = TaskData:GetTaskComplete(slot1)

	slot0:RefreshUI()
	slot0:RefreshProgress()

	slot0.isShow_ = true
end

function slot0.OnExit(slot0)
	slot0.isShow_ = false

	SetActive(slot0.gameObject_, false)
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

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "goBtn")
		uv1.JumpToPage2(AssignmentCfg[uv0.taskID_].source)
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "receiveBtnBtn")
		TaskAction:TryToSubmitTask(uv0.taskID_)
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.goBtn_.onClick:RemoveAllListeners()
	slot0.receiveBtn_.onClick:RemoveAllListeners()
end

function slot0.RefreshUI(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]
	slot0.titleText_.text = slot1.desc
	slot2 = slot1.reward or {}

	for slot6, slot7 in ipairs(slot2) do
		if slot0.rewardItems_[slot6] == nil then
			slot0.rewardItems_[slot6] = RewardItem.New(slot0.rewardItem_, slot0.rewardParent_, true)
			slot8 = slot0.rewardItems_[slot6]

			slot8:UpdateCommonItemAni()

			slot8 = slot0.rewardItems_[slot6].commonItem_

			slot8:RegistCallBack(function ()
				OperationRecorder.Record("task", "task_item")
			end)
		end

		slot0.rewardItems_[slot6]:SetData(slot7)
	end

	for slot6 = #slot1.reward + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot6]:Show(false)
	end
end

function slot0.RefreshProgress(slot0)
	slot2 = slot0.taskProgress

	if AssignmentCfg[slot0.taskID_].need < slot0.taskProgress then
		slot2 = slot1.need
	end

	slot0.progressBar_.fillAmount = slot2 / slot1.need
	slot0.progressText_.text = string.format("%s/%s", slot2, slot1.need)
	slot3 = slot1.need <= slot0.taskProgress

	if slot0.taskComplete_ then
		slot0.controller_:SetSelectedState("2")
	elseif slot3 then
		slot0.controller_:SetSelectedState("1")
	else
		slot0.controller_:SetSelectedState("0")
	end
end

function slot0.RefreshComplete(slot0)
	SetActive(slot0.gameObject_, not slot0.taskComplete_)
end

function slot0.SetSibling(slot0, slot1)
	if AssignmentCfg[slot0.taskID_].condition == GameSetting.task_top_type.value[1] and slot2.additional_parameter[1] == TaskConst.TASK_TYPE.DAILY then
		slot0.transform_:SetSiblingIndex(0)
	else
		slot0.transform_:SetSiblingIndex(slot1)
	end
end

return slot0
