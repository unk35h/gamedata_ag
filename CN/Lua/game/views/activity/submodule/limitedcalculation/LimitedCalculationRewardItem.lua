slot0 = class("LimitedCalculationRewardItem", ReduxView)

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
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		ActivityAction.ReceivePointReward({
			uv0.id_
		})
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.info_ = slot1
	slot0.activityID_ = slot2
	slot0.id_ = slot1.id
	slot0.cfg_ = ActivityPointRewardCfg[slot0.id_]
	slot0.score_ = LimitedCalculationData:GetScore(slot0.activityID_)
	slot0.need_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_POINT_REACHED"), slot0.cfg_.need)

	slot0:RefreshReward()
	slot0:RefreshState()
end

function slot0.RefreshReward(slot0)
	for slot5, slot6 in ipairs(slot0.cfg_.reward_item_list) do
		if slot0.rewardItems_[slot5] == nil then
			slot0.rewardItems_[slot5] = RewardItem.New(slot0.rewardTemplate_, slot0.rewardParent_, true)

			slot0.rewardItems_[slot5]:UpdateCommonItemAni()
		end

		slot0.rewardItems_[slot5]:SetData(slot6)
	end

	for slot5 = #slot1 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot5]:Show(false)
	end
end

function slot0.RefreshState(slot0)
	if slot0.info_.complete_flag == ActivityConst.LIMITED_CALCULATION_REWARD_STATE.UNFINISHED then
		if slot0.cfg_.need <= slot0.score_ then
			slot0.stateCon_:SetSelectedState("success")
		else
			slot0.stateCon_:SetSelectedState("unfinished")
		end
	else
		slot0.stateCon_:SetSelectedState("rewarded")
	end
end

function slot0.OnExit(slot0)
	for slot4 = #slot0.rewardItems_, 1, -1 do
		slot0.rewardItems_[slot4]:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = #slot0.rewardItems_, 1, -1 do
		slot0.rewardItems_[slot4]:Dispose()

		slot0.rewardItems_[slot4] = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
