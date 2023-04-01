slot0 = class("ActivityCultivateHeroMainView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/VersionUI/XuHeng1stUI/XH1stReceivedUI/XH1stReceivedUI"), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.activityID_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.switchItemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.switchListGo_, slot0:GetSwitchItemClass())
	slot0.heroTaskList_ = LuaList.New(handler(slot0, slot0.IndexHeroTask), slot0.heroTaskListGo_, slot0:GetHeroTaskClass())
	slot0.accumulateRewardList_ = {}
	slot0.clickSwitchItemHandler_ = handler(slot0, slot0.OnClickSwitchItem)
	slot0.receivedHeroTaskHandler_ = handler(slot0, slot0.OnReceiveHeroTask)
	slot0.accumulateRewardState_ = ControllerUtil.GetController(slot0.transform_, "accumulateRewardState")
	slot0.dailyRewardState_ = ControllerUtil.GetController(slot0.transform_, "dailyRewardState")
	slot0.allReceiveBtnState_ = ControllerUtil.GetController(slot0.transform_, "allReceive")
	slot0.heroLockState_ = ControllerUtil.GetController(slot0.transform_, "heroLock")
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:AddTimer()
	slot0:RefreshUI()
	slot0:BindRedPoint()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.unlockHeroBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.JumpToPage2(ActivityCultivateHeroCfg[uv0.activityID_].source[table.indexof(uv0.heroList_, uv0.selectHeroID_) or 1])
	end)
	slot0:AddBtnListener(slot0.rewardPreviewBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("cultivateAccumulateReward", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.receiveAccumulateBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		CultivateHeroAction.RequireReceiveAccumulateTask(uv0.activityID_, uv0.firstAccumulateTaskID_, function ()
			uv0:RefreshAccumulateTask()
		end)
	end)
	slot0:AddBtnListener(slot0.receiveDailyBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		slot0 = ActivityCultivateHeroCfg[uv0.activityID_].daily_reward

		if uv0.canReceiveDaily_ == true then
			CultivateHeroAction.RequireReceiveDailyTask(uv0.activityID_, function ()
				uv0:RefreshDailyTask()
				uv0:RefreshAccumulateTask()
			end)
		else
			JumpTools.OpenPageByJump("rewardPreview", {
				rewardList = slot0
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
	slot0:AddBtnListener(slot0.receiveAllHeroTaskBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		slot0 = CultivateHeroData:GetHeroTaskInfoList(uv0.activityID_)
		slot2 = {}

		for slot6, slot7 in ipairs(CultivateHeroTaskCfg.get_id_list_by_group_id[uv0.selectHeroID_]) do
			if slot0[slot7].isCompleted == true and not slot0[slot7].isReceived then
				slot2[#slot2 + 1] = slot7
			end
		end

		CultivateHeroAction.RequireReceiveHeroTaskList(uv0.activityID_, slot2, function ()
			uv0:OnReceiveHeroTask()
		end)
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "CULTIVATE_HERO_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("CULTIVATE_HERO_DESC")
		})
	end)
end

function slot0.RefreshUI(slot0)
	slot0.heroList_ = ActivityCultivateHeroCfg[slot0.activityID_].group
	slot1 = CultivateHeroData:GetSelectHeroID(slot0.activityID_) or slot0.heroList_[1]
	slot0.selectHeroID_ = slot1

	if slot1 == nil then
		return
	end

	CultivateHeroData:SetSelectHeroID(slot0.activityID_, slot1)
	slot0.heroLockState_:SetSelectedState(tostring(HeroData:GetHeroData(CultivateHeroTaskCfg[CultivateHeroTaskCfg.get_id_list_by_group_id[slot1][1]].hero).unlock == 0))
	slot0:RefreshSwitchItem()
	slot0:RefreshRoleImage()
	slot0:RefreshDesc()
	slot0:RefreshHeroTask()
	slot0:RefreshAccumulateTask()
	slot0:RefreshDailyTask()
end

function slot0.RefreshSwitchItem(slot0)
	slot0.switchItemList_:StartScroll(#slot2, table.indexof(slot0.heroList_, slot0.selectHeroID_) or 1)
end

function slot0.GetSwitchItemClass(slot0)
	return CultivateHeroSwitchItem
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.activityID_, slot0.heroList_[slot1])
	slot2:SetClickCallBack(slot0.clickSwitchItemHandler_)
	slot2:RefreshSelect(slot0.selectHeroID_)
end

function slot0.OnClickSwitchItem(slot0, slot1)
	slot6 = slot1

	CultivateHeroData:SetSelectHeroID(slot0.activityID_, slot6)

	slot0.selectHeroID_ = slot1

	for slot6, slot7 in ipairs(slot0.switchItemList_:GetItemList()) do
		slot7:RefreshSelect(slot1)
	end

	slot0:RefreshRoleImage()
	slot0:RefreshHeroTask()
	slot0.heroLockState_:SetSelectedState(tostring(HeroData:GetHeroData(CultivateHeroTaskCfg[CultivateHeroTaskCfg.get_id_list_by_group_id[slot1][1]].hero).unlock == 0))
end

function slot0.RefreshHeroTask(slot0)
	slot1 = nil
	slot0.sortedTaskIDList_, slot3 = CultivateHeroData:GetSortHeroTaskList(slot0.selectHeroID_, slot0.activityID_)

	slot0.heroTaskList_:StartScroll(#slot0.sortedTaskIDList_)
	slot0.allReceiveBtnState_:SetSelectedState(tostring(slot3))

	slot2 = CultivateHeroTaskCfg[slot0.sortedTaskIDList_[1]].hero
	slot0.heroNameText_.text = string.format("%s·%s", HeroCfg[slot2].name, HeroCfg[slot2].suffix)
end

function slot0.GetHeroTaskClass(slot0)
	return CultivateHeroTaskItem
end

function slot0.IndexHeroTask(slot0, slot1, slot2)
	slot2:SetData(slot0.activityID_, slot0.sortedTaskIDList_[slot1])
	slot2:SetReveivedHandler(slot0.receivedHeroTaskHandler_)
end

function slot0.OnReceiveHeroTask(slot0)
	slot0:RefreshHeroTask()
	slot0:RefreshAccumulateTask()
end

function slot0.RefreshAccumulateTask(slot0)
	slot1 = ActivityCultivateHeroCfg[slot0.activityID_].task_list
	slot2 = ItemTools.getItemNum(ActivityCultivateHeroCfg[slot0.activityID_].coin_id)
	slot3 = CultivateHeroData:GetAccumulateTaskInfoList(slot0.activityID_)
	slot4 = 0
	slot5 = #slot1
	slot6 = 0
	slot0.firstAccumulateTaskID_ = nil

	for slot10, slot11 in ipairs(slot1) do
		slot13 = slot3[slot11] and slot3[slot11].isReceived == true

		if slot2 < ActivityPointRewardCfg[slot11].need then
			slot4 = 0

			if slot0.firstAccumulateTaskID_ == nil then
				slot0.firstAccumulateTaskID_ = slot11
			end
		elseif not slot13 then
			slot4 = 1
			slot0.firstAccumulateTaskID_ = slot11

			break
		else
			slot6 = slot6 + 1
		end

		if slot10 == slot5 and slot13 then
			slot0.firstAccumulateTaskID_ = slot11
			slot4 = 2
		end
	end

	slot0.totalAccumulateProgressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), slot6, slot5)
	slot7 = ActivityPointRewardCfg[slot0.firstAccumulateTaskID_]
	slot14 = slot7.need
	slot0.curAccumulateProgressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), slot2, slot14)
	slot13 = slot0.activityID_
	slot0.coinImage_.sprite = ItemTools.getItemSprite(ActivityCultivateHeroCfg[slot13].coin_id)

	for slot13, slot14 in ipairs(slot7.reward_item_list) do
		if slot0.accumulateRewardList_[slot13] then
			slot0.accumulateRewardList_[slot13]:SetData(slot14, false)
		else
			slot0.accumulateRewardList_[slot13] = CultivateHeroPoolRewardItem.New(slot0.goRewardPanel_, slot0.rewardGo_, slot14, true)
		end
	end

	for slot13 = #slot9 + 1, #slot0.accumulateRewardList_ do
		slot0.accumulateRewardList_[slot13]:Show(false)
	end

	if slot4 == 0 then
		slot0.accumulateRewardState_:SetSelectedState("uncompleted")
	elseif slot4 == 2 then
		slot0.accumulateRewardState_:SetSelectedState("received")
	else
		slot0.accumulateRewardState_:SetSelectedState("unreceived")
	end
end

function slot0.RefreshDailyTask(slot0)
	slot1 = 100
	slot2 = ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT)

	if CultivateHeroData:GetDailyTaskStatus()[slot0.activityID_] then
		slot0.dailyRewardState_:SetSelectedState("received")
	elseif slot1 <= slot2 then
		slot0.canReceiveDaily_ = true

		slot0.dailyRewardState_:SetSelectedState("unreceive")
	else
		slot0.canReceiveDaily_ = false

		slot0.dailyRewardState_:SetSelectedState("uncomplete")
	end

	slot0.dailyPrograssText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), slot2, slot1)
end

function slot0.OnActivityPtUpdate(slot0)
	slot0:RefreshDailyTask()
end

function slot0.RefreshRoleImage(slot0)
	slot0.roleImage_.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. CultivateHeroTaskCfg[CultivateHeroTaskCfg.get_id_list_by_group_id[slot0.selectHeroID_][1]].hero)
end

function slot0.RefreshDesc(slot0)
	slot0.descText_.text = GetTips("CULTIVATE_HERO_CONTENT")
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	slot0:StopTimer()

	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.textTime_.text = GetTips("TIME_OVER")

			return
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
	slot0:UnbindRedPoint()
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:StopTimer()

	if slot0.switchItemList_ then
		slot0.switchItemList_:Dispose()

		slot0.switchItemList_ = nil
	end

	if slot0.heroTaskList_ then
		slot0.heroTaskList_:Dispose()

		slot0.heroTaskList_ = nil
	end

	if slot0.accumulateRewardList_ then
		for slot4, slot5 in ipairs(slot0.accumulateRewardList_) do
			slot5:Dispose()
		end

		slot0.accumulateRewardList_ = nil
	end

	slot0.clickSwitchItemHandler_ = nil
	slot0.receivedHeroTaskHandler_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.receiveDailyBtn_.transform, string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, slot0.activityID_))
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.receiveDailyBtn_.transform, string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, slot0.activityID_))
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 == true then
		slot0:RefreshHeroTask()
	end
end

return slot0
