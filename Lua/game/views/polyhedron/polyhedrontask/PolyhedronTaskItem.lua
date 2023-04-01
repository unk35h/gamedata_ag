slot0 = class("PolyhedronTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot2, slot1)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.rewardItemList_ = {}
	slot0.rewardState_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		TaskAction:TryToSubmitActivityTaskList({
			uv0.taskID_
		})
	end)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.taskID_ = slot1
	slot0.activityID_ = AssignmentCfg[slot0.taskID_].activity_id

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshDesc()
	slot0:RefreshItem()
	slot0:RefreshState()
	slot0:Show(true)
end

function slot0.RefreshDesc(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]
	slot0.nameText_.text = slot1.name
	slot0.descText_.text = slot1.desc
	slot4 = slot1.need

	if TaskData:GetActivityTask(slot1.activity_id, slot0.taskID_) and slot3.progress and slot3.progress < slot2 then
		slot4 = slot3.progress
	end

	slot0.progressText_.text = string.format("%d/%d", slot4, slot2)
end

function slot0.RefreshItem(slot0)
	slot0.rewardCfg_ = AssignmentCfg[slot0.taskID_].reward

	for slot4, slot5 in ipairs(slot0.rewardCfg_) do
		if not slot0.rewardItemList_[slot4] then
			slot0.rewardItemList_[slot4] = slot0:GetRewardItem(slot5)
		else
			slot0.rewardItemList_[slot4]:SetData(slot5)
		end
	end

	for slot4 = #slot0.rewardCfg_ + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot4]:Show(false)
	end
end

function slot0.RefreshState(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]
	slot4 = slot1.need

	if TaskData:GetActivityTask(slot1.activity_id, slot0.taskID_) and slot3.progress then
		slot4 = slot3.progress
	end

	slot6 = TaskData:GetActivityTaskComplete(slot1.activity_id, slot0.taskID_)

	if not (slot2 <= slot4) then
		slot0.rewardState_:SetSelectedState("uncomplete")
	elseif not slot6 then
		slot0.rewardState_:SetSelectedState("unreceive")
	else
		slot0.rewardState_:SetSelectedState("received")
	end
end

function slot0.GetRewardItem(slot0, slot1)
	return RewardPoolItem.New(slot0.goRewardPanel_, slot1, false)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
