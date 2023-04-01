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

		RaceTrailAction:ReceiveScoreReward(uv0.id_)
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.id_ = slot1
	slot0.activityID_ = slot3
	slot0.cfg_ = ActivityPointRewardCfg[slot1]
	slot0.data_ = RaceTrailData:GetScoreRewardByID(slot0.id_)
	slot0.score_ = slot2

	slot0:RefreshReward()
	slot0:RefreshTitle()
	slot0:RefreshState()
end

function slot0.RefreshTitle(slot0)
	slot0.title_.text = GetTips("ACCUMULATED_POINTS_REACHED") .. slot0.cfg_.need
end

function slot0.RefreshReward(slot0)
	for slot4, slot5 in ipairs(slot0.cfg_.reward_item_list) do
		if slot0.rewardList_[slot4] == nil then
			slot0.rewardList_[slot4] = RewardItem.New(slot0.rewardItem_, slot0.rewardParent_, false)

			slot0.rewardList_[slot4]:UpdateCommonItemAni()
		end

		slot0.rewardList_[slot4]:SetData(slot5)
	end

	for slot4 = #slot0.cfg_.reward_item_list + 1, #slot0.rewardList_ do
		slot0.rewardList_[slot4]:Show(false)
	end
end

function slot0.RefreshState(slot0)
	if slot0.data_.receive_flag then
		slot0.receiveCon_:SetSelectedState("received")
	elseif slot0.cfg_.need <= slot0.score_ then
		slot0.receiveCon_:SetSelectedState("complete")
	else
		slot0.receiveCon_:SetSelectedState("incomplete")
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
