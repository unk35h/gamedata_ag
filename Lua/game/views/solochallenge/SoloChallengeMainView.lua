slot0 = class("SoloChallengeMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerSoloChallengeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.switchItemList_ = {}
	slot0.rewardItemList_ = {}
	slot0.onClickHandler_ = handler(slot0, slot0.OnClick)
	slot0.adaptImg_ = slot0:FindCom("SelfAdaptImage", nil, slot0.roleTras_)
	slot0.rewardState_ = ControllerUtil.GetController(slot0.rewardTrans_, "rewardState")
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.difficultyIndex_ = 1
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:AddTimer()
	slot0:RefreshUI()
	slot0:RefreshActivityDesc()

	if SoloChallengeData:GetContentPosX(slot0.activityID_) ~= nil then
		slot3 = slot0.switchPanelTrans_.localPosition
		slot3.x = slot2
		slot0.switchPanelTrans_.localPosition = slot3
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SOLO_CHALLENGE_DESCRIPE")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SoloChallengeAction.RequireReceive(uv0.selectActivityID_, 1, function (slot0)
			if isSuccess(slot0.result) then
				getReward(ActivitySoloChallengeCfg[uv0.selectActivityID_].reward_item_list[1][2])
				SoloChallengeData:SetReceivedActivityList(uv0.selectActivityID_, uv0.difficultyIndex_)
				uv0:RefreshReward()
			else
				ShowTips(slot0.result)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SoloChallengeData:SetSelectedDifficultyIndex(uv0.selectActivityID_, uv0.difficultyIndex_)
		SoloChallengeAction.SaveDifficulty(uv0.selectActivityID_, uv0.difficultyIndex_, handler(uv0, uv0.OnStart))
	end)
end

function slot0.OnStart(slot0)
	slot0:Go("/soloChallengeSelect", {
		activityID = slot0.selectActivityID_,
		difficultyIndex = slot0.difficultyIndex_
	})
end

function slot0.RefreshUI(slot0)
	slot0.subActivityList_ = ActivityCfg[slot0.activityID_].sub_activity_list
	slot1 = SoloChallengeData:GetSelectActivityID(slot0.activityID_) or slot0.subActivityList_[1]
	slot0.selectActivityID_ = slot1

	if slot1 == nil then
		return
	end

	SoloChallengeData:SetSelectActivityID(slot0.activityID_, slot1)
	slot0:RefreshSwitchItem()
	slot0:RefreshReward()
	slot0:RefreshRoleImage()
	slot0:RefreshDesc()
end

function slot0.RefreshSwitchItem(slot0)
	slot1 = slot0.selectActivityID_

	for slot6, slot7 in ipairs(slot0.subActivityList_) do
		slot8 = slot0:GetSwitchItemClass()

		if slot0.switchItemList_[slot6] == nil then
			slot0.switchItemList_[slot6] = slot8.New(slot0.switchItem_, slot0.switchPanel_, slot7, slot0.activityID_)

			slot0.switchItemList_[slot6]:RegisterClickListener(slot0.onClickHandler_)
		end

		slot0.switchItemList_[slot6]:SetActivityID(slot7, slot0.activityID_)
	end

	for slot6 = #slot0.switchItemList_, #slot2 + 1, -1 do
		slot0.switchItemList_[slot6]:Dispose()

		slot0.switchItemList_[slot6] = nil
	end

	slot0:RefreshSelectactivity(slot1)
end

function slot0.GetSwitchItemClass(slot0)
	return SoloChallengeSwitchItem
end

function slot0.RefreshReward(slot0)
	for slot5, slot6 in ipairs(ActivitySoloChallengeCfg[slot0.selectActivityID_].reward_item_list[slot0.difficultyIndex_][2]) do
		if slot0.rewardItemList_[slot5] then
			slot0.rewardItemList_[slot5]:SetData(slot6, false)
		else
			slot0.rewardItemList_[slot5] = RewardPoolItem.New(slot0.goRewardPanel_, slot6)
		end
	end

	for slot5 = #slot1 + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot5]:Show(false)
	end

	slot5 = table.keyof(SoloChallengeData:GetReceivedActivityList()[slot0.selectActivityID_], slot0.difficultyIndex_) ~= nil

	if not (table.keyof(SoloChallengeData:GetCompletedActivityList()[slot0.selectActivityID_], slot0.difficultyIndex_) ~= nil) then
		slot0.rewardState_:SetSelectedState("uncompleted")
	elseif not slot5 then
		slot0.rewardState_:SetSelectedState("unreceived")
	else
		slot0.rewardState_:SetSelectedState("received")
	end
end

function slot0.RefreshRoleImage(slot0)
	slot0.roleImage_.sprite = getSpriteWithoutAtlas("Textures/SummerUI/" .. ActivitySoloChallengeCfg[slot0.selectActivityID_].background)

	slot0.adaptImg_:AdaptImg()
end

function slot0.RefreshActivityDesc(slot0)
	slot0.activityDescText_.text = GetTips("ACTIVITY_SOLO_CHALLENGE_CONTENT")
end

function slot0.RefreshDesc(slot0)
	slot0.nameText_.text = ActivitySoloChallengeCfg[slot0.selectActivityID_].name
	slot0.descText_.text = ActivitySoloChallengeCfg[slot0.selectActivityID_].desc
end

function slot0.OnClick(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshSelectactivity(slot0, slot1)
	for slot5, slot6 in pairs(slot0.switchItemList_) do
		slot6:OnSelect(slot1)
	end
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	slot0:StopTimer()

	if slot0.switchItemList_ then
		for slot4, slot5 in ipairs(slot0.switchItemList_) do
			slot5:RefreshLock()
		end
	end

	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		if uv0.switchItemList_ then
			for slot3, slot4 in ipairs(uv0.switchItemList_) do
				slot4:RefreshLock()
			end
		end

		uv0.textTime_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopTimer()
	SoloChallengeData:SetContentPosX(slot0.activityID_, slot0.switchPanelTrans_.localPosition.x)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:StopTimer()

	slot0.onClickHandler_ = nil

	for slot4, slot5 in pairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil

	for slot4, slot5 in pairs(slot0.switchItemList_) do
		slot5:Dispose()
	end

	slot0.switchItemList_ = nil
end

return slot0
