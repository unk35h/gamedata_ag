slot0 = class("RaceTrailScoreRewardItem", ReduxView)

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
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrailAction:ReceiveFirstReward(uv0.id_)
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.id_ = slot1
	slot0.activityID_ = slot2
	slot0.cfg_ = ActivityRaceTrialCfg[slot1]
	slot6 = slot0.id_
	slot0.data_ = RaceTrailData:GetBattleData(slot6)

	for slot6, slot7 in ipairs(slot0.cfg_.reward_item_list) do
		if slot0.rewardList_[slot6] == nil then
			slot0.rewardList_[slot6] = RewardItem.New(slot0.rewardItem_, slot0.rewardParent_, false)

			slot0.rewardList_[slot6]:UpdateCommonItemAni()
		end

		slot0.rewardList_[slot6]:SetData(slot7)
	end

	for slot6 = #slot0.cfg_.reward_item_list + 1, #slot0.rewardList_ do
		slot0.rewardList_[slot6]:Show(false)
	end

	slot0.title_.text = slot0.cfg_.reward_desc

	if slot0.data_.state == 1 then
		slot0.receiveCon_:SetSelectedState("incomplete")
	elseif slot0.data_.state == 2 then
		slot0.receiveCon_:SetSelectedState("complete")
	elseif slot0.data_.state == 3 then
		slot0.receiveCon_:SetSelectedState("received")
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = 1, #slot0.rewardList_ do
		slot0.rewardList_[slot4]:Dispose()

		slot0.rewardList_[slot4] = nil
	end

	slot0.rewardList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
