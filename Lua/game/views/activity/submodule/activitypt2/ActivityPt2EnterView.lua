ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ActivityPt2EnterView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return ActivityPt2Tools.GetEnterUIName(slot0.activityID_)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.clearCon_ = ControllerUtil.GetController(slot0.transform_, "clear")
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ActivityPt2TaskItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.list_[slot1], slot0.activityID_)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.exchangeBtn_, nil, function ()
		slot1 = {}
		slot5 = ActivityShopCfg[uv0.activityID_].activity_theme

		for slot5, slot6 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[slot5]) do
			if ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[slot6].shop_id].activity_id) and slot8:IsActivitying() then
				table.insert(slot1, ActivityShopCfg[slot6].shop_id)
			end
		end

		slot2, slot3 = ShopTools.IsShopOpen(slot0.shop_id)

		if slot2 then
			JumpTools.GoToSystem("/shop", {
				shopId = slot0.shop_id,
				showShops = slot1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif slot3 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif slot3 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.OpenPageByJump("/activityPt2", {
			mainActivityId = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.allReceiveBtn_, nil, function ()
		slot0 = {}
		slot1 = ActivityPt2Tools:GetTaskActivityID(uv0.activityID_)

		for slot5, slot6 in ipairs(uv0.list_) do
			slot7 = AssignmentCfg[slot6]

			if TaskData:GetActivityTaskList(slot1)[slot6].complete_flag < 1 and slot7.need <= slot8.progress then
				table.insert(slot0, slot6)
			end
		end

		TaskAction:TryToSubmitActivityTaskList(slot0)
	end)
	slot0:AddBtnListener(slot0.tipBtn_, nil, function ()
		if ActivityPt2Tools.GetHelpKey(uv0.activityID_) ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(slot0),
				key = slot0
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(slot0, slot0.RefreshTask))
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_2_OPEN .. "_" .. slot0.activityID_, 0)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshActivityData()
	slot0:RefreshTime()
	slot0:RefreshTask()
end

function slot0.RefreshActivityData(slot0)
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
	slot0.lock_.text = string.format(GetTips("ACTIVITY_XUHENG_PT_LOCK"), ChapterCfg[ActivityCfg[slot0.activityID_].unlock_condition[2][1]].subhead)
	slot0.isLock_ = not ActivityTools.IsUnlockActivity(slot0.activityID_)
	slot0.challengeCurrencyID_ = ActivityPt2Tools.GetChallengeCurrencyID(slot0.activityID_)
end

function slot0.RefreshTime(slot0)
	slot1 = nil
	slot3 = nil
	slot6 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[slot0.activityID_].shop_id].activity_id).stopTime

	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ then
		slot0.stateCon_:SetSelectedState("close")

		slot0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.startTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot2 < slot0.stopTime_ or slot2 < slot6 then
		if slot2 < slot0.stopTime_ then
			slot0.timeLable_.text = manager.time:GetLostTimeStr2(slot0.stopTime_)
		else
			slot0.timeLable_.text = GetTips("TIME_OVER")
		end

		if slot6 - slot2 < GameSetting.time_remaining_show.value[1] * 86400 then
			slot0.shopTimeLable_.text = manager.time:GetLostTimeStr2(slot6)

			SetActive(slot0.shopTimeGo_, true)
		else
			SetActive(slot0.shopTimeGo_, false)
		end

		if slot0.stopTime_ <= slot2 then
			if slot3 > 0 then
				slot0.stateCon_:SetSelectedState("onlyShop")
			else
				slot0.stateCon_:SetSelectedState("close")
			end
		elseif slot0.isLock_ then
			slot0.stateCon_:SetSelectedState("lock")
		else
			slot0.stateCon_:SetSelectedState("unlock")
		end

		slot0.timer_ = Timer.New(function ()
			uv0 = manager.time:GetServerTime()
			uv1 = uv2.startTime_ - uv0
			uv3 = uv4 - uv0

			if uv1 <= 0 and uv3 <= 0 then
				uv2:StopTimer()
				uv2:RefreshTime()

				return
			end

			if uv0 < uv2.stopTime_ then
				uv2.timeLable_.text = manager.time:GetLostTimeStr2(uv2.stopTime_)
			else
				uv2.timeLable_.text = GetTips("TIME_OVER")
			end

			uv3 = uv4 - uv0

			if uv3 < GameSetting.time_remaining_show.value[1] * 86400 then
				uv2.shopTimeLable_.text = manager.time:GetLostTimeStr2(uv4)

				SetActive(uv2.shopTimeGo_, true)
			else
				SetActive(uv2.shopTimeGo_, false)
			end

			if uv2.stopTime_ <= uv0 then
				if uv3 > 0 then
					uv2.stateCon_:SetSelectedState("onlyShop")
				else
					uv2.stateCon_:SetSelectedState("close")
				end
			elseif uv2.isLock_ then
				uv2.stateCon_:SetSelectedState("lock")
			else
				uv2.stateCon_:SetSelectedState("unlock")
			end
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeLable_.text = GetTips("TIME_OVER")
		slot0.shopTimeLable_.text = GetTips("TIME_OVER")

		slot0.stateCon_:SetSelectedState("close")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshTask(slot0)
	slot0.list_ = {}
	slot2 = TaskData:GetActivityTaskList(ActivityPt2Tools:GetTaskActivityID(slot0.activityID_)) or {}

	function slot3(slot0, slot1)
		if AssignmentCfg[slot0].type ~= AssignmentCfg[slot1].type then
			return slot2.type < slot3.type
		end

		return slot0 < slot1
	end

	slot4 = {}
	slot5 = {}
	slot6 = {}

	for slot10, slot11 in pairs(slot2) do
		taskID = slot11.id

		if AssignmentCfg[taskID].activity_id == slot1 then
			if slot11.complete_flag >= 1 then
				table.insert(slot6, taskID)
			elseif slot12.need <= slot11.progress then
				table.insert(slot4, taskID)
			else
				table.insert(slot5, taskID)
			end
		end
	end

	table.sort(slot4, slot3)
	table.sort(slot5, slot3)
	table.sort(slot6, slot3)
	table.insertto(slot0.list_, slot4)
	table.insertto(slot0.list_, slot5)
	table.insertto(slot0.list_, slot6)
	slot0.scrollHelper_:StartScroll(#slot0.list_)

	if #slot4 > 0 then
		slot0.clearCon_:SetSelectedState("true")
	else
		slot0.clearCon_:SetSelectedState("false")
	end
end

function slot0.Show(slot0, slot1)
	uv0.super.Show(slot0, slot1)

	if slot1 then
		slot0:RefreshTask()
	end
end

function slot0.UpdateBar(slot0)
	slot1 = ActivityPt2Tools.GetChallengeCurrencyID(slot0.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		slot1
	})
	manager.windowBar:SetBarCanAdd(slot1, true)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
