slot0 = class("AntitheticalCoupletMainView", ReduxView)

function slot0.UIName(slot0)
	return AntitheticalCoupletTools.GetMainUIName(slot0.params_.activityId)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.levelData_ = {}
	slot0.rewardList_ = {}
	slot0.levelList_ = ActivityCfg[slot0.params_.activityId].sub_activity_list or {}
	slot0.toggles_ = {}
	slot0.tglLock_ = {}
	slot0.toggleCon_ = {}
	slot0.cToggleCon_ = {}
	slot0.toggleTime_ = {}

	for slot4, slot5 in ipairs(slot0.levelList_) do
		slot0.toggles_[slot4] = slot0["tgl_" .. slot4]
		slot0.tglLock_[slot4] = slot0["lock_" .. slot4]
		slot0.toggleCon_[slot4] = ControllerUtil.GetController(slot0.toggles_[slot4].transform, "state")
		slot0.cToggleCon_[slot4] = ControllerUtil.GetController(slot0.toggles_[slot4].transform, "toggle")
		slot0.toggleTime_[slot4] = slot0["tglTime_" .. slot4]
	end

	slot0.rewardCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "reward")
	slot0.stateCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.titleCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "title")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if ActivityData:GetActivityData(uv0.curId_):IsActivitying() then
			AntitheticalCoupletAction:GetReward(uv0.curId_)
		else
			ShowTips("TIME_OVER")
		end
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if uv0.levelData_[table.indexof(uv0.levelList_, uv0.curId_)].startTime <= manager.time:GetServerTime() and slot1 < slot2.stopTime then
			slot5 = manager.story

			slot5:StartStoryById(ActivitySpringFestivalCoupletsCfg[uv0.curId_].story_id, function (slot0)
				JumpTools.OpenPageByJump("/antitheticalCoupletResult", {
					activityId = uv0.activityID_,
					id = uv0.curId_
				})
			end, true)
		elseif slot2.stopTime <= slot1 then
			ShowTips("TIME_OVER")
		end
	end)

	slot4 = slot0.reviewBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		if uv0.levelData_[table.indexof(uv0.levelList_, uv0.curId_)].startTime <= manager.time:GetServerTime() and slot1 < slot2.stopTime then
			JumpTools.OpenPageByJump("/antitheticalCoupletResult", {
				isComplet = true,
				activityId = uv0.activityID_,
				id = uv0.curId_
			})
		elseif slot2.stopTime <= slot1 then
			ShowTips("TIME_OVER")
		end
	end)

	for slot4, slot5 in ipairs(slot0.toggles_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				uv0.curId_ = uv0.levelList_[uv1]

				uv0:RefreshReward()
				AntitheticalCoupletData:SetOpen(uv0.levelList_[uv1])
			end
		end)
		slot0:AddBtnListener(slot0.tglLock_[slot4], nil, function ()
			if manager.time:GetServerTime() < uv0.levelData_[uv1].startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot1)))
			end
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0:BindUIRedPoint()
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.RefreshData(slot0)
	slot0.activityID_ = slot0.params_.activityId
	slot4 = slot0.activityID_
	slot0.activityData_ = ActivityData:GetActivityData(slot4)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime

	for slot4, slot5 in ipairs(slot0.levelList_) do
		slot0.levelData_[slot4] = ActivityData:GetActivityData(slot5)
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshTime()
	slot0:RefreshList()
	slot0:RefreshReward()
end

function slot0.RefreshTime(slot0)
	slot1 = nil

	slot0:StopTimer()
	slot0:RefreshLevelTime()

	if manager.time:GetServerTime() < slot0.startTime_ then
		slot0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.startTime_ - manager.time:GetServerTime()

			uv1:RefreshLevelTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot2 < slot0.stopTime_ then
		slot0.timeTxt_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.stopTime_ - manager.time:GetServerTime()

			uv1:RefreshLevelTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end

			uv1.timeTxt_.text = manager.time:GetLostTimeStr(uv1.stopTime_)
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function slot0.RefreshLevelTime(slot0)
	slot1 = manager.time:GetServerTime()

	for slot5, slot6 in ipairs(slot0.levelList_) do
		if slot1 < slot0.levelData_[slot5].startTime then
			slot0.toggles_[slot5].interactable = false

			slot0.toggleCon_[slot5]:SetSelectedState("lock")

			slot0.toggleTime_[slot5].text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(slot7))
		else
			slot0.toggles_[slot5].interactable = true

			if AntitheticalCoupletData:GetData(slot0.levelList_[slot5]) and slot8.chooseID ~= 0 then
				slot0.toggleCon_[slot5]:SetSelectedState("complete")
			else
				slot0.toggleCon_[slot5]:SetSelectedState("nor")
			end
		end
	end
end

function slot0.RefreshList(slot0)
	slot0.curId_ = AntitheticalCoupletData:GetLastLevel(slot0.activityID_) or slot0.levelList_[1]
	slot1 = table.indexof(slot0.levelList_, slot0.curId_)
	slot0.toggles_[slot1].isOn = true

	AntitheticalCoupletData:SetOpen(slot0.levelList_[slot1])
end

function slot0.RefreshReward(slot0)
	slot1 = ActivitySpringFestivalCoupletsCfg[slot0.curId_]
	slot0.desc_.text = slot1.desc

	slot0.titleCon_:SetSelectedState(table.indexof(slot0.levelList_, slot0.curId_))

	for slot7, slot8 in ipairs(slot1.reward_item_list) do
		if slot0.rewardList_[slot7] then
			slot0.rewardList_[slot7]:SetData(slot8)
		else
			slot0.rewardList_[slot7] = RewardPoolItem.New(slot0.rewardPanel_, slot8, true, POP_SOURCE_ITEM)
		end
	end

	for slot7 = #slot3 + 1, #slot0.rewardList_ do
		slot0.rewardList_[slot7]:Show(false)
	end

	slot0.curData_ = AntitheticalCoupletData:GetData(slot0.curId_)

	slot0:RefreshRewardType()
	slot0:RefreshStateType()
end

function slot0.RefreshRewardType(slot0)
	if slot0.curData_ and slot0.curData_.isReward then
		slot0.rewardCon_:SetSelectedState("finish")
	elseif slot0.curData_ and slot0.curData_.chooseID ~= 0 then
		slot0.rewardCon_:SetSelectedState("complete")
	else
		slot0.rewardCon_:SetSelectedState("false")
	end
end

function slot0.RefreshStateType(slot0)
	if slot0.curData_ and slot0.curData_.chooseID ~= 0 then
		slot0.stateCon_:SetSelectedState("true")
	else
		slot0.stateCon_:SetSelectedState("false")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.BindUIRedPoint(slot0)
	for slot4, slot5 in ipairs(slot0.levelList_) do
		manager.redPoint:bindUIandKey(slot0["tglPos_" .. slot4], RedPointConst.ANTITHETICAL_COUPLET .. "_" .. slot5, {
			x = 0,
			y = 0
		})
	end
end

function slot0.UnBindUIRedPoint(slot0)
	for slot4, slot5 in ipairs(slot0.levelList_) do
		manager.redPoint:unbindUIandKey(slot0["tglPos_" .. slot4], RedPointConst.ANTITHETICAL_COUPLET .. "_" .. slot5)
	end
end

function slot0.OnAntitheticalCoupletReward(slot0)
	slot0:RefreshRewardType()
end

function slot0.OnTop(slot0)
	if AntitheticalCoupletTools.GetGameHelpKey(slot0.activityID_) ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(slot1)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:UnBindUIRedPoint()
	manager.windowBar:HideBar()
	AntitheticalCoupletData:SaveLastSelect(slot0.activityID_, slot0.curId_)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
