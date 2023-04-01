slot0 = class("CultivateAccumulateRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.rewardItemList_ = {}
	slot0.rewardState_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.taskID_ = slot2
	slot0.activityID_ = slot3

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.titleText_.text = string.format(GetTips("CULTIVATE_HERO_REWARD"), slot0.index_)
	slot0.needText_.text = ActivityPointRewardCfg[slot0.taskID_].need
	slot0.icon_.sprite = ItemTools.getItemSprite(ActivityCultivateHeroCfg[slot0.activityID_].coin_id)

	slot0:RefreshReward()
end

function slot0.RefreshReward(slot0)
	for slot5, slot6 in ipairs(ActivityPointRewardCfg[slot0.taskID_].reward_item_list) do
		if slot0.rewardItemList_[slot5] then
			slot0.rewardItemList_[slot5]:SetData(slot6, false)
		else
			slot0.rewardItemList_[slot5] = slot0:GetRewardItem(slot6)
		end
	end

	for slot5 = #slot1 + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot5]:Show(false)
	end

	if (CultivateHeroData:GetAccumulateTaskInfoList(slot0.activityID_)[slot0.taskID_] and slot2[slot0.taskID_].isReceived) == true then
		slot0.rewardState_:SetSelectedState("received")
	else
		slot0.rewardState_:SetSelectedState("none")
	end
end

function slot0.RefreshItem(slot0)
	slot0.rewardCfg_ = ActivityPointRewardCfg[slot0.taskID_].reward_item_list

	slot0.itemList_:StartScroll(#slot0.rewardCfg_)
end

function slot0.Dispose(slot0)
	if slot0.rewardItemList_ then
		for slot4, slot5 in ipairs(slot0.rewardItemList_) do
			slot5:Dispose()
		end

		slot0.rewardItemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.GetRewardItem(slot0, slot1)
	return RewardPoolItem.New(slot0.goRewardPanel_, slot1, false)
end

return slot0
