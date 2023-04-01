slot0 = class("LeviathanGameRewardItem", ReduxView)

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

	slot0.rewardList_ = {}
	slot0.receiveCon_ = ControllerUtil.GetController(slot0.transform_, "receiveCon")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		SummerLittleGameAction.GetLeviathanReward(uv0.activityID_)
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.activityID_ = slot1
	slot0.cfg_ = ActivityBubblesCfg[slot0.activityID_]

	slot0:RefreshTitle()
	slot0:RefreshReward()
	slot0:RefreshType()
end

function slot0.RefreshTitle(slot0)
	slot0.title_.text = slot0.cfg_.desc
end

function slot0.RefreshReward(slot0)
	for slot5, slot6 in ipairs(slot0.cfg_.reward_item_list) do
		if not slot0.rewardList_[slot5] then
			slot0.rewardList_[slot5] = RewardItem.New(slot0.rewardItem_, slot0.rewardParent_, true)

			slot0.rewardList_[slot5]:UpdateCommonItemAni()
		end

		slot0.rewardList_[slot5]:SetData(slot6)
	end

	for slot5 = #slot1 + 1, #slot0.rewardList_ do
		slot0.rewardList_[slot5]:Show(false)
	end
end

function slot0.RefreshType(slot0)
	if SummerLittleGameData:GetLeviathanState(slot0.activityID_) == 0 then
		slot0.receiveCon_:SetSelectedState("unfinished")
	elseif slot1 == 1 then
		slot0.receiveCon_:SetSelectedState("success")
	elseif slot1 == 2 then
		slot0.receiveCon_:SetSelectedState("rewarded")
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.rewardList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
