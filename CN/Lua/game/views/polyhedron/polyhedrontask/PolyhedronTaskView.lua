slot0 = class("PolyhedronTaskView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Polyhedron/PolyhedronTaskUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.taskList_ = {}
	slot0.tipsList_ = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.seasonBtn_, nil, function ()
		uv0:RefreshUI(1)
	end)
	slot0:AddBtnListener(slot0.achievmentBtn_, nil, function ()
		uv0:RefreshUI(2)
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0:RefreshTaskActivityIDList()
	slot0:BindRedPoint()

	slot0.curType_ = nil

	slot0:RefreshUI(1)
end

function slot0.OnExit(slot0)
	slot0.curType_ = nil

	slot0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.taskList_) do
		slot5:Dispose()
	end

	slot0.taskList_ = nil

	for slot4, slot5 in ipairs(slot0.tipsList_) do
		slot5:Dispose()
	end

	slot0.tipsList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 == slot0.curType_ then
		return
	end

	slot0.curType_ = slot1

	slot0.typeController_:SetSelectedIndex(slot0.curType_ - 1)
	slot0:RefreshTaskList(slot1)
	slot0:RefreshTipsList(slot1)
end

function slot0.RefreshTaskList(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:GetSortedTask(slot1)) do
		if not slot0.taskList_[slot6] then
			slot0.taskList_[slot6] = PolyhedronTaskItem.New(slot0.taskPanelTrans_, slot0.taskItemGo_)
		end

		slot0.taskList_[slot6]:SetData(slot7)
	end

	for slot6 = #slot2 + 1, #slot0.taskList_ do
		slot0.taskList_[slot6]:Show(false)
	end
end

function slot0.RefreshTipsList(slot0, slot1)
	slot2 = {}
	slot3 = {}
	slot3 = (slot1 ~= 1 or slot0.curSeasonActivityList_) and slot0.curAchievementActivityList_

	for slot7, slot8 in ipairs(slot3) do
		if not ActivityData:GetActivityIsOpen(slot8) then
			slot2[#slot2 + 1] = slot8
		end
	end

	for slot7, slot8 in ipairs(slot2) do
		if not slot0.tipsList_[slot7] then
			slot0.tipsList_[slot7] = PolyhedronTaskTipsItem.New(slot0.tipsPanelTrans_, slot0.tipsItemGo_)
		end

		slot0.tipsList_[slot7]:SetData(slot8)
	end

	for slot7 = #slot2 + 1, #slot0.tipsList_ do
		slot0.tipsList_[slot7]:Show(false)
	end

	slot0:RefreshTipsPosition(slot1)
end

function slot0.RefreshTipsPosition(slot0, slot1)
	if slot0:IsAllReceived(slot1) == true then
		slot0.tipsPanelTrans_:SetAsFirstSibling()
	else
		slot0.tipsPanelTrans_:SetAsLastSibling()
	end
end

function slot0.IsAllReceived(slot0, slot1)
	slot2 = {}
	slot2 = (slot1 ~= 1 or slot0.curSeasonActivityList_) and slot0.curAchievementActivityList_

	for slot6, slot7 in ipairs(slot2) do
		if ActivityData:GetActivityIsOpen(slot7) == true then
			for slot12, slot13 in ipairs(AssignmentCfg.get_id_list_by_activity_id[slot7]) do
				if not TaskData:GetActivityTaskComplete(slot7, slot13) then
					return false
				end
			end
		end
	end

	return true
end

function slot0.OnTaskListChange(slot0)
	slot0:RefreshTaskList(slot0.curType_)
	slot0:RefreshTipsPosition(slot0.curType_)
end

function slot0.RefreshTaskActivityIDList(slot0)
	slot1 = PolyhedronData:GetActivityID()
	slot0.curSeasonActivityList_ = ActivityCfg[slot1].season_task_activity_list
	slot0.curAchievementActivityList_ = ActivityCfg[slot1].achievement_task_activity_list
end

function slot0.GetSortedTask(slot0, slot1)
	slot2 = {}
	slot2 = (slot1 ~= 1 or slot0.curSeasonActivityList_) and slot0.curAchievementActivityList_
	slot3 = {}

	for slot7, slot8 in ipairs(slot2) do
		if ActivityData:GetActivityIsOpen(slot8) == true then
			table.insertto(slot3, AssignmentCfg.get_id_list_by_activity_id[slot8])
		end
	end

	slot4 = {}
	slot5 = {}
	slot6 = {}
	slot7 = {}
	slot8 = {}
	slot9 = nil
	slot10 = {}

	for slot14, slot15 in pairs(slot3) do
		if TaskData:GetActivityTask(AssignmentCfg[slot15].activity_id, slot15).complete_flag == 0 then
			if slot8.progress < slot10.need then
				table.insert(slot6, slot15)
			else
				table.insert(slot5, slot15)
			end
		elseif slot8.complete_flag >= 1 then
			table.insert(slot7, slot15)
		end
	end

	table.sort(slot5, function (slot0, slot1)
		return AssignmentCfg[slot0].id < AssignmentCfg[slot1].id
	end)
	table.sort(slot6, function (slot0, slot1)
		return AssignmentCfg[slot0].id < AssignmentCfg[slot1].id
	end)
	table.sort(slot7, function (slot0, slot1)
		return AssignmentCfg[slot0].id < AssignmentCfg[slot1].id
	end)
	table.insertto(slot4, slot5)
	table.insertto(slot4, slot6)
	table.insertto(slot4, slot7)

	return slot4
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.seasonBtn_.transform, RedPointConst.POLYHEDRON_TASK_SEASON)
	manager.redPoint:bindUIandKey(slot0.achievmentBtn_.transform, RedPointConst.POLYHEDRON_TASK_ACHIEVEMENT)
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.seasonBtn_.transform, RedPointConst.POLYHEDRON_TASK_SEASON)
	manager.redPoint:unbindUIandKey(slot0.achievmentBtn_.transform, RedPointConst.POLYHEDRON_TASK_ACHIEVEMENT)
end

return slot0
