slot0 = class("ActivityRaceTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.rewardItemList_ = {}
	slot0.rewardController_ = ControllerUtil.GetController(slot0.transform_, "reward")
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

		ActivityRaceAction.RequireReceive(uv0.activityID_, uv0.taskID_, uv0.receiveHandler_)
	end)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil
	slot0.receiveHandler_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.taskID_ = slot1
	slot0.isAccumulated_ = slot3
	slot0.activityID_ = slot2
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime
	slot0.rewardList_ = ActivityPointRewardCfg[slot1].reward_item_list

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.isAccumulated_ then
		slot0.desctext_.text = string.format(GetTips("ACTIVITY_RACE_AMOUNT_REWARD"), tostring(ActivityPointRewardCfg[slot0.taskID_].need))
	else
		slot0.desctext_.text = string.format(GetTips("ACTIVITY_RACE_HIGHEST_REWARD"), tostring(ActivityPointRewardCfg[slot0.taskID_].need))
	end

	slot0:RefreshRewardItem()
	slot0:RefreshRewardState()
end

function slot0.RefreshRewardItem(slot0)
	for slot4, slot5 in ipairs(slot0.rewardList_) do
		if slot0.rewardItemList_[slot4] then
			slot0.rewardItemList_[slot4]:SetData(slot5, false)
		else
			slot0.rewardItemList_[slot4] = RewardPoolItem.New(slot0.goRewardPanel_, slot5)
		end
	end

	for slot4 = #slot0.rewardList_ + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot4]:Show(false)
	end
end

function slot0.OnReceiveReward(slot0)
	ActivityRaceData:SetReceivedTaskList(slot0.activityID_, slot0.taskID_)
	getReward(slot0.rewardList_)
	slot0:RefreshRewardState()
end

function slot0.RefreshRewardState(slot0)
	slot2 = ActivityRaceData:GetReceivedTaskList(slot0.activityID_)[slot0.taskID_]
	slot0.score_ = 0

	if ActivityRaceData:GetStateList()[slot0.activityID_] then
		if not slot0.isAccumulated_ then
			slot0.score_ = slot3.score
		else
			slot0.score_ = tonumber(slot3.accumulativeScore)
		end
	end

	if slot2 then
		slot0.rewardController_:SetSelectedState("received")
	elseif ActivityPointRewardCfg[slot0.taskID_].need <= slot0.score_ then
		slot0.rewardController_:SetSelectedState("complete")
	elseif not slot0.isAccumulated_ then
		slot0.rewardController_:SetSelectedState("incomplete")
	else
		slot0.rewardController_:SetSelectedState("accumulateIncomplete")

		slot0.processText_.text = string.format("%d/%d", slot0.score_, ActivityPointRewardCfg[slot0.taskID_].need)
	end
end

return slot0
