slot0 = class("PassportTaskView", ReduxView)

function slot0.UIName(slot0)
	return PassportData:GetUIRoot() .. "Passport/PassportTaskUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.curGroup_ = 1

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.receiveBtnController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "receiveBtn_all")
	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, PassportTaskItemView)
	slot0.tree_ = LuaTree.New(slot0.treeGo_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect))
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	slot0.curGroup_ = slot1

	if slot2 == 1 then
		slot0:SetTaskType(TaskConst.TASK_TYPE.PASSPORT_DAILY)
	elseif slot2 == 2 then
		slot0:SetTaskType(TaskConst.TASK_TYPE.PASSPORT_WEEKLY)
	elseif slot2 == 3 then
		slot0:SetTaskType(TaskConst.TASK_TYPE.PASSPORT_CHALLENGE)
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskDataList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.buyLevelBtn_, nil, function ()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_bp_level = PassportData:GetLevel()
		})
		JumpTools.OpenPageByJump("passportBuyLevel", nil, ViewConst.SYSTEM_ID.PASSPORT_BUY_LEVEL)
	end)
	slot0:AddBtnListener(slot0.oneKeyGetBtn_, nil, function ()
		if #TaskData:GetFinishTaskIds(7) + #TaskData:GetFinishTaskIds(8) + #TaskData:GetFinishTaskIds(9) <= 0 then
			return
		end

		slot3 = true

		if getData("passport_task", "tip_deadline") and manager.time:GetServerTime() < tonumber(slot4) then
			slot3 = false
		end

		if slot3 and #slot0 + #slot1 > 0 and GameSetting.battlepass_exp_limit_weekly.value[1] <= PassportData:GetExpWeekly() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("PASSPORT_WEEKLY_EXP_LIMIT_TIP"),
				toggleText = GetTips("WEEKLY_MUTE_TIP"),
				OkCallback = function ()
					TaskAction:TryToSubmitPassportTaskList(uv0, uv1, uv2)
				end,
				ToggleCallback = function (slot0)
					if slot0 then
						saveData("passport_task", "tip_deadline", tostring(_G.gameTimer:GetNextWeekFreshTime()))
					end
				end
			})
		else
			TaskAction:TryToSubmitPassportTaskList(slot0, slot1, slot2)
		end
	end)
end

function slot0.RegisterRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(1), RedPointConst.PASSPORT_TASK_BONUS_7, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(2), RedPointConst.PASSPORT_TASK_BONUS_8, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(3), RedPointConst.PASSPORT_TASK_BONUS_9, {
		x = 0,
		y = 0
	})
end

function slot0.UnRegisterRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(1), RedPointConst.PASSPORT_TASK_BONUS_7)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(2), RedPointConst.PASSPORT_TASK_BONUS_8)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(3), RedPointConst.PASSPORT_TASK_BONUS_9)
end

function slot0.SetTaskType(slot0, slot1)
	if slot0.curType_ then
		-- Nothing
	end

	slot0.curType_ = slot1

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.levelLabel_.text = PassportData:GetLevel()
	slot1 = PassportData:GetCurrentExp()
	slot2 = PassportData:GetUpgradeNeedExp()

	if PassportData:GetMaxLevel() <= PassportData:GetLevel() then
		slot1 = slot2
	end

	if slot2 < slot1 then
		slot1 = slot2
	end

	slot0.expProgress_.value = slot1 / slot2
	slot0.expLabel_.text = string.format("%d/%d", slot1, slot2)
	slot7 = PassportData
	slot9 = slot7
	slot8 = GameSetting.battlepass_exp_limit_weekly.value[1]
	slot0.expLimitLabel_.text = string.format("%d/%d", slot7.GetExpWeekly(slot9), slot8)
	slot4 = manager.time:GetServerTime()
	slot0.taskDataList_ = {}

	for slot8, slot9 in ipairs(TaskData:GetTaskIDList(slot0.curType_)) do
		if (TaskData:GetTask(slot9).expired_timestamp or 0) > 0 and slot11 - slot4 > 0 or slot11 == 0 then
			table.insert(slot0.taskDataList_, slot9)
		end
	end

	table.sort(slot0.taskDataList_, function (slot0, slot1)
		if uv0:GetTaskStatus(slot0) ~= uv0:GetTaskStatus(slot1) then
			return slot2 < slot3
		end

		return slot1 < slot0
	end)
	slot0.list_:StartScroll(#slot0.taskDataList_)

	slot5 = TaskData:GetFinishTaskIds(7)

	table.insertto(slot5, TaskData:GetFinishTaskIds(8))

	slot9 = TaskData
	slot11 = slot9

	table.insertto(slot5, slot9.GetFinishTaskIds(slot11, 9))

	slot6 = 0

	for slot10, slot11 in ipairs(slot5) do
		slot12 = TaskData:GetTask(slot11)

		if table.indexof(slot0.taskDataList_, slot11) then
			slot6 = slot6 + 1
		end
	end

	if slot6 <= 0 then
		slot0.receiveBtnController_:SetSelectedState("ash")
	else
		slot0.receiveBtnController_:SetSelectedState("select")
	end

	if PassportData:GetMaxLevel() <= PassportData:GetLevel() then
		SetActive(slot0.buyLevelBtn_.gameObject, false)
	else
		SetActive(slot0.buyLevelBtn_.gameObject, true)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.bglvTransform_)
	TaskAction:UpdatePassportTaskRedTip()
end

function slot0.OnEnter(slot0)
	if not slot0.timer_ then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot1 = slot0.timer_

	slot1:Start()
	slot0:AdaptScreen()

	slot1 = slot0.tree_

	slot1:SelectGroup(slot0.curGroup_)
	slot0:RegisterRedPoint()
	slot0:UpdateTimer()
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		if slot0 == CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP then
			uv0:UpdateView()
		end
	end)
end

function slot0.UpdateTimer(slot0)
	slot0.lastDayLabel_.text = string.format(GetTips("TIME_DISPLAY_6"), manager.time:GetLostTimeStr(PassportData:GetEndTimestamp()))
	slot7 = manager.time:STimeDescS(PassportData:GetStartTimestamp(), "!%Y/%m/%d %H:%M:%S")
	slot8 = manager.time:STimeDescS(PassportData:GetEndTimestamp(), "!%Y/%m/%d %H:%M:%S")
	slot0.duringLabel1_.text = string.format("%s-%s", slot7, slot8)

	slot0:CheckOutofDate()

	slot3 = manager.time:GetServerTime()

	for slot7, slot8 in ipairs(slot0.taskDataList_) do
		if (TaskData:GetTask(slot8).expired_timestamp or 0) > 0 and slot10 - slot3 <= 0 then
			slot0:UpdateView()

			break
		end
	end
end

function slot0.RemoveTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.CheckOutofDate(slot0)
	slot1 = manager.time:GetServerTime()

	if not PassportData:IsOpen() or PassportData:GetEndTimestamp() <= slot1 then
		TimeTools.StartAfterSeconds(0.1, function ()
			uv0:Go("/home")
			ShowTips("BATTLEPASS_EXPIRED")
		end, {})

		return true
	end

	return false
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "passportNote",
		type = "jump",
		params = {}
	})
end

function slot0.OnExit(slot0)
	slot0:UnRegisterRedPoint()
	slot0:RemoveTimer()
	manager.windowBar:HideBar()
end

function slot0.OnTaskListChange(slot0)
	slot0:UpdateView()
end

function slot0.GetTaskStatus(slot0, slot1)
	slot4 = TaskData:GetTaskProgress(slot1)
	slot5 = AssignmentCfg[slot1].need

	if TaskData:GetTask(slot1).complete_flag == 1 then
		return 3
	elseif slot5 <= slot4 then
		return 1
	else
		return 2
	end
end

function slot0.OnMainHomeViewTop(slot0)
	slot0.curGroup_ = 1
end

function slot0.Dispose(slot0)
	if slot0.tree_ then
		slot0.tree_:Dispose()

		slot0.tree_ = nil
	end

	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	slot0:RemoveTimer()
	uv0.super.Dispose(slot0)
end

return slot0
