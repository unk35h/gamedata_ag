slot0 = class("AlphaRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItems_ = {}
end

function slot0.AddListeners(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.GetTaskID(slot0)
	return slot0.taskID_
end

function slot0.RefreshReward(slot0, slot1)
	slot0.taskID_ = slot1
	slot0.titleText_.text = AssignmentCfg[slot1].desc

	for slot6, slot7 in ipairs(AssignmentCfg[slot1].reward) do
		if slot0.rewardItems_[slot6] == nil then
			slot0.rewardItems_[slot6] = RewardItem.New(slot0.rewardTemplate_, slot0.rewardParent_, true)

			slot0.rewardItems_[slot6]:UpdateCommonItemAni()
		end

		slot0.rewardItems_[slot6]:SetData(slot7)
	end

	for slot6 = #slot2 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot6]:Show(false)
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot4]:Dispose()

		slot0.rewardItems_[slot4] = nil
	end

	slot0.rewardItems_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
