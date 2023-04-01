slot0 = class("GuildActivityRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.rewardItemList_ = {}
	slot0.rewardController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.levelController_ = ControllerUtil.GetController(slot0.transform_, "level")
	slot0.receiveHandler_ = handler(slot0, slot0.OnReceiveReward)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		GuildActivityAction.RequireReceive(uv0.rateID_, uv0.receiveHandler_)
	end)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil
	slot0.receiveHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.rateID_ = slot1
	slot0.activityID_ = slot2
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime
	slot0.rewardList_ = ActivityClubLevelSettingCfg[slot1].reward_item_list

	slot0:RefreshUI()
end

function slot0.setReceiveCallBack(slot0, slot1)
	slot0.receiveCallBack_ = slot1
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityClubLevelSettingCfg[slot0.rateID_]
	slot0.descText_.text = string.format(GetTips("ACTIVITY_CLUB_REWARD"), slot1.user_level)

	slot0.levelController_:SetSelectedState(tostring(slot1.user_level))
	slot0:RefreshRewardItem()
	slot0:RefreshRewardState()
end

function slot0.RefreshRewardItem(slot0)
	for slot4, slot5 in ipairs(slot0.rewardList_) do
		if slot0.rewardItemList_[slot4] then
			slot0.rewardItemList_[slot4]:SetData(slot5, false)
		else
			slot0.rewardItemList_[slot4] = RewardPoolItem.New(slot0.rewardParent_, slot5, true)
		end
	end

	for slot4 = #slot0.rewardList_ + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot4]:Show(false)
	end
end

function slot0.OnReceiveReward(slot0)
	GuildActivityData:SetReceivedList(slot0.activityID_, slot0.rateID_)
	getReward(slot0.rewardList_)
	slot0:RefreshRewardState()

	if slot0.receiveCallBack_ then
		slot0.receiveCallBack_()
	end
end

function slot0.RefreshRewardState(slot0)
	slot3 = ActivityClubLevelSettingCfg[GuildActivityData:GetCurRateID(slot0.activityID_)].user_level

	if table.keyof(GuildActivityData:GetReceivedList(), ActivityClubLevelSettingCfg[slot0.rateID_].user_level) ~= nil then
		slot0.rewardController_:SetSelectedState("received")
	elseif ActivityClubLevelSettingCfg[slot0.rateID_].user_level <= slot3 then
		slot0.rewardController_:SetSelectedState("finish")
	else
		slot0.rewardController_:SetSelectedState("unfinished")
	end
end

return slot0
