slot0 = class("TaskPlotPhaseView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.rectAcdept_, "conName")
	slot0.rewardItems_ = {}
	slot0.goRewardParent_ = {
		slot0.goItem1_,
		slot0.goItem2_,
		slot0.goItem3_
	}

	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonAccept_, nil, function ()
		TaskAction:TryToSubmitTask(uv0.taskID_)
	end)
end

function slot0.RefreshUI(slot0)
	slot0.taskID_ = TaskData:GetPlotPhaseID()

	if slot0.taskID_ == nil then
		return
	end

	slot1 = TaskData:GetTask(slot0.taskID_)
	slot2 = AssignmentCfg[slot0.taskID_]
	slot3 = slot1.progress

	if slot1.complete_flag >= 1 then
		slot3 = slot2.need

		slot0.controller_:SetSelectedState("2")
	elseif slot3 < slot2.need then
		slot0.controller_:SetSelectedState("1")
	else
		slot3 = slot2.need

		slot0.controller_:SetSelectedState("0")
	end

	slot0.imageProgress_.fillAmount = slot3 / slot2.need
	slot0.textNum_.text = string.format("<color=#FFA456><size=56>%s</size></color>/%s", slot3, slot2.need)
	slot0.textTitle_.text = slot2.name
	slot0.textContent_.text = slot2.desc

	slot0:RefreshReward(slot2.reward)
end

function slot0.RefreshReward(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		SetActive(slot0.goRewardParent_[slot5], true)

		if slot0.rewardItems_[slot5] then
			slot0.rewardItems_[slot5]:SetData(slot6)
		else
			slot0.rewardItems_[slot5] = RewardPoolItem.New(slot0.goRewardParent_[slot5], slot6, false)
		end
	end

	for slot5 = #slot1 + 1, #slot0.rewardItems_ do
		SetActive(slot0.goRewardParent_[slot5], false)
		slot0.rewardItems_[slot5]:Show(false)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = nil
end

return slot0
