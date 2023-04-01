slot0 = class("TaskView", ReduxView)
slot1 = import("game.const.TaskConst")
slot2 = import("game.tools.TaskTools")

function slot0.UIName(slot0)
	return "UI/Task/TaskUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.taskSwitchView_ = {}
	slot0.taskContentView_ = {}
	slot0.taskSwitchView_[uv0.TASK_TYPE.DAILY] = TaskSwitchView.New(slot0.dailyTask_, uv0.TASK_TYPE.DAILY)
	slot0.taskSwitchView_[uv0.TASK_TYPE.PLOT] = TaskSwitchView.New(slot0.plotTask_, uv0.TASK_TYPE.PLOT)
	slot0.taskSwitchView_[uv0.TASK_TYPE.WEEK] = TaskSwitchView.New(slot0.weekTask_, uv0.TASK_TYPE.WEEK)

	slot0.taskSwitchView_[uv0.TASK_TYPE.DAILY]:SetBtnFunc(handler(slot0, slot0.RefreshSelect))
	slot0.taskSwitchView_[uv0.TASK_TYPE.PLOT]:SetBtnFunc(handler(slot0, slot0.RefreshSelect))
	slot0.taskSwitchView_[uv0.TASK_TYPE.WEEK]:SetBtnFunc(handler(slot0, slot0.RefreshSelect))
end

function slot0.OnTop(slot0)
	slot0:ShowDefaultBar()
	slot0:RefreshSelect(slot0.params_.taskIndex)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot4 = slot0.params_.taskIndex

	slot0:RefreshSelect(slot4)

	for slot4, slot5 in pairs(slot0.taskSwitchView_) do
		slot5:OnEnter()
	end
end

function slot0.OnMainHomeViewTop(slot0)
	for slot4, slot5 in pairs(slot0.taskContentView_) do
		slot5:ClearCache()
	end
end

function slot0.OnExit(slot0)
	slot0.selectIndex_ = nil

	slot0:RemoveAllEventListener()

	for slot4, slot5 in pairs(slot0.taskContentView_) do
		slot5:OnExit()
	end

	for slot4, slot5 in pairs(slot0.taskSwitchView_) do
		slot5:OnExit()
	end

	manager.windowBar:HideBar()
	slot0:RecordStay(slot0.params_.taskIndex)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.taskSwitchView_) do
		slot5:Dispose()
	end

	slot0.taskSwitchView_ = nil

	for slot4, slot5 in pairs(slot0.taskContentView_) do
		slot5:Dispose()
	end

	slot0.taskContentView_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnTaskListChange(slot0)
	for slot4, slot5 in pairs(slot0.taskContentView_) do
		if slot5.OnTaskListChange then
			slot5:OnTaskListChange()
		end
	end
end

function slot0.OnActivityPtUpdate(slot0)
	for slot4, slot5 in pairs(slot0.taskContentView_) do
		if slot5.OnActivityPtUpdate then
			slot5:OnActivityPtUpdate()
		end
	end
end

function slot0.RefreshSelect(slot0, slot1, slot2)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TASK_DAILY) then
		slot1 = uv0.TASK_TYPE.PLOT
	end

	for slot6, slot7 in pairs(slot0.taskSwitchView_) do
		slot7:SwitchButton(slot1)
	end

	if slot0.taskContentView_[slot1] == nil then
		if slot1 == uv0.TASK_TYPE.DAILY then
			slot0.taskContentView_[slot1] = TaskDailyContentView.New(slot0.dailyContent_, uv0.TASK_TYPE.DAILY, ActivityPtConst.TASK_DAILY_ACTIVITY_PT)
		elseif slot1 == uv0.TASK_TYPE.PLOT then
			slot0.taskContentView_[slot1] = TaskPlotContentView.New(slot0.plotContent_)
		elseif slot1 == uv0.TASK_TYPE.WEEK then
			slot0.taskContentView_[slot1] = TaskWeekContentView.New(slot0.weekContent_, uv0.TASK_TYPE.WEEK, ActivityPtConst.TASK_WEEK_ACTIVITY_PT)
		end
	end

	if slot0.selectIndex_ == slot1 then
		return
	end

	slot0.selectIndex_ = slot1

	for slot6, slot7 in pairs(slot0.taskContentView_) do
		if slot6 == slot1 then
			slot0.params_.taskIndex = slot1
		else
			slot0:RecordStay(slot6)
		end

		slot7:Show(slot6 == slot1, slot2)
	end
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(PLAYER_LEVEL_UP, handler(slot0, slot0.OnLevelUp))
end

function slot0.OnLevelUp(slot0)
	slot0.mask_.raycastTarget = true

	if PlayerData:GetlevelUpInfos() and #slot1 > 0 then
		if not slot0.levelUpTimer_ then
			slot0.levelUpTimer_ = Timer.New(function ()
				PlayerAction.LevelUpFinish()
				uv0:Go("levelUp", {
					levelUpInfoList = uv1
				})

				uv0.mask_.raycastTarget = false
				uv0.levelUpTimer_ = nil
			end, 0.2, 0)
		end

		slot0.levelUpTimer_:Start()
	end
end

function slot0.RecordStay(slot0, slot1)
	if slot0:GetStayTime() == 0 then
		return
	end

	slot3 = 0

	if slot1 == uv0.TASK_TYPE.DAILY then
		slot3 = 10801
	elseif slot1 == uv0.TASK_TYPE.PLOT then
		slot3 = 10802
	end

	OperationRecorder.RecordStayView("STAY_VIEW_TASK", slot2, slot3)
	slot0:UpdateLastOpenTime()
end

return slot0
