slot0 = class("SoloChallengeRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.rewardItemList_ = {}
	slot0.rewardState_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.RefreshData(slot0, slot1)
	slot0.activityID_ = slot1.activityID
	slot0.difficultyIndex_ = slot1.difficultyIndex

	slot0:RefreshUI()
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

		SoloChallengeAction.RequireReceive(uv0.activityID_, uv0.difficultyIndex_, function (slot0)
			if isSuccess(slot0.result) then
				getReward(ActivitySoloChallengeCfg[uv0.activityID_].reward_item_list[uv0.difficultyIndex_][2])
				SoloChallengeData:SetReceivedActivityList(uv0.activityID_, uv0.difficultyIndex_)
				uv0:RefreshState()
			else
				ShowTips(slot0.result)
			end
		end)
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = ""
	slot0.descText_.text = (slot0.difficultyIndex_ ~= 1 or GetTips("CLEAR_NORMAL_DIFFICULTY")) and (slot0.difficultyIndex_ ~= 2 or GetTips("CLEAR_DIFFICULTY")) and GetTips("CLEAR_EXTREME_DIFFICULTY")

	slot0:RefreshState()
	slot0:RefreshItem()
end

function slot0.RefreshState(slot0)
	slot4 = table.keyof(SoloChallengeData:GetReceivedActivityList()[slot0.activityID_], slot0.difficultyIndex_) ~= nil

	if not (table.keyof(SoloChallengeData:GetCompletedActivityList()[slot0.activityID_], slot0.difficultyIndex_) ~= nil) then
		slot0.rewardState_:SetSelectedState("uncompleted")
	elseif not slot4 then
		slot0.rewardState_:SetSelectedState("unreceived")
	else
		slot0.rewardState_:SetSelectedState("received")
	end
end

function slot0.RefreshItem(slot0)
	for slot5, slot6 in ipairs(ActivitySoloChallengeCfg[slot0.activityID_].reward_item_list[slot0.difficultyIndex_][2]) do
		if slot0.rewardItemList_[slot5] then
			slot0.rewardItemList_[slot5]:SetData(slot6, false)
		else
			slot0.rewardItemList_[slot5] = slot0:GetRewardItem().New(slot0.goRewardPanel_, slot6, true)
		end
	end

	for slot5 = #slot1 + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot5]:Show(false)
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.rewardCfg_[slot1], POP_ITEM)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.GetRewardItem(slot0)
	return RewardPoolFactoryItem
end

function slot0.GetCommonItem(slot0, slot1)
	return slot1:GetCommonItem()
end

return slot0
