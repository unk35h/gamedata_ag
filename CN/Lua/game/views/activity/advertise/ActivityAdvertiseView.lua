slot0 = class("ActvitiyAdvertiseView", ReduxView)

function slot0.UIName(slot0)
	slot0.activityID_ = ActivityAdvertiseTools.GetOpenActivityID()

	return ActivityAdvertiseCfg[slot0.activityID_].prefab_path
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.rewardItemList_ = {}
end

function slot0.OnEnter(slot0)
	saveData("activityAdvertise", "prompt", false)

	slot0.promptToggle_.isOn = getData("activityAdvertise", "prompt") or false

	ActivityAdvertiseData:SetOpenAdvertiseFlag(slot0.activityID_, true)

	if slot0.activityID_ then
		saveData("activityAdvertise", tostring(slot0.activityID_), manager.time:GetServerTime())
	end

	slot0:RefreshUI()
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil

	slot0.promptToggle_.onValueChanged:RemoveAllListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		slot1, slot2 = JumpTools.GetSystemLockedText(ActivityAdvertiseCfg[uv0.activityID_].jump_system)

		SDKTools.SendMessageToSDK("activity_post_trigger", {
			oper = slot1 and 2 or 1
		})

		if slot1 then
			ShowTips(slot2)

			return
		end

		uv0:Back()
		JumpTools.JumpToPage2(slot0)
	end)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)

	slot1 = slot0.promptToggle_.onValueChanged

	slot1:AddListener(function (slot0)
		saveData("activityAdvertise", "prompt", slot0)
		SDKTools.SendMessageToSDK("activity_post_shield", {
			opt = slot0 and 1 or 0
		})
	end)
end

function slot0.Cacheable(slot0)
	return false
end

function slot0.RefreshUI(slot0)
	for slot5, slot6 in ipairs(ActivityAdvertiseCfg[slot0.activityID_].reward_list) do
		slot7 = {
			slot6,
			0
		}

		if slot0.rewardItemList_[slot5] == nil then
			slot0.rewardItemList_[slot5] = RewardPoolItem.New(slot0.rewardPanel_, slot7, true)

			slot0.rewardItemList_[slot5]:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
			slot0.rewardItemList_[slot5]:HideNum()
		else
			slot0.rewardItemList_[slot5]:SetData(slot7)
		end
	end

	for slot5 = #slot0.rewardItemList_, #slot1.reward_list + 1, -1 do
		slot0.rewardItemList_[slot5]:Dispose()

		slot0.rewardItemList_[slot5] = nil
	end
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.timeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(slot0.activityID_).stopTime, nil, true)
	slot0.timer_ = Timer.New(function ()
		uv0.timeText_.text = manager.time:GetLostTimeStr2(uv1.stopTime, nil, true)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
