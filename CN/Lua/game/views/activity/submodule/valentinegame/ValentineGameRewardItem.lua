slot0 = class("ValentineGameRewardItem", ReduxView)

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
	slot0.stateCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if ActivityData:GetActivityData(uv0.activityID_):IsActivitying() then
			ValentineGameAction:GetReward(uv0.activityID_)
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.activityID_ = slot1

	slot0:RefreshReward()
	slot0:RefreshState()
end

function slot0.RefreshReward(slot0)
	slot0.cfg_ = ActivityValentineCfg[slot0.activityID_]

	for slot5, slot6 in ipairs(slot0.cfg_.reward_item_list) do
		if not slot0.rewardItems_[slot5] then
			slot0.rewardItems_[slot5] = RewardItem.New(slot0.rewardItem_, slot0.rewardParent_)

			slot0.rewardItems_[slot5]:UpdateCommonItemAni()
		end

		slot0.rewardItems_[slot5]:SetData(slot6)
	end

	for slot5 = #slot1 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot5]:Show(false)
	end

	slot0.text_.text = string.format(GetTips("ACTIVITY_VALENTINE_REWARD_NEED_DESC"), slot0.cfg_.name)
end

function slot0.RefreshState(slot0)
	if ValentineGameData:GetData(slot0.activityID_) and slot1.isReward then
		slot0.stateCon_:SetSelectedState("received")
	elseif slot1 and slot1.isClear then
		slot0.stateCon_:SetSelectedState("complete")
	else
		slot0.stateCon_:SetSelectedState("uncomplete")
	end
end

function slot0.OnExit(slot0)
	for slot4 = 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot4]:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot4]:Dispose()
	end

	slot0.super.Dispose(slot0)
end

return slot0
