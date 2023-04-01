slot0 = class("AlphaActivityView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Alpha/PhaseActivityUI"
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

	slot0.taskItems_ = {}
	slot0.generalTask_ = AlphaStageTaskItem.New(slot0.generalTaskGo_)
	slot0.itemPool_ = Pool.New(slot0.taskItemTemplate_, slot0.taskItemContent_, 0)
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.taskItemScroll_, AlphaTaskItem)
end

function slot0.AddUIListeners(slot0)
	slot4 = slot0.leftBtn_

	slot0:AddBtnListener(slot4:GetComponent(typeof(Button)), nil, function ()
		uv0:RefreshContent(uv0.stage_ - 1)
	end)

	slot4 = slot0.rightBtn_

	slot0:AddBtnListener(slot4:GetComponent(typeof(Button)), nil, function ()
		uv0:RefreshContent(uv0.stage_ + 1)
	end)
	slot0:AddBtnListener(slot0.phaseBtn_, nil, function ()
		JumpTools.OpenPageByJump("PopupPhaseActivityUI")
	end)
	slot0:AddDragListener(slot0.scrollGo_, function ()
	end, function ()
	end, function (slot0, slot1)
		uv0:RefreshContentByDrag(slot0, slot1)
	end)
	slot0:AddDragListener(slot0.backGo_, function ()
	end, function ()
	end, function (slot0, slot1)
		uv0:RefreshContentByDrag(slot0, slot1)
	end)
end

function slot0.OnEnter(slot0)
	slot0.stage_ = slot0:GetAlphaTaskStage()

	slot0.generalTask_:OnEnter()

	for slot4 = 1, #slot0.taskItems_ do
		slot0.taskItems_[slot4]:OnEnter()
	end

	slot0:RefreshContent(slot0.stage_)
end

function slot0.GetAlphaTaskStage(slot0)
	return TaskData:GetAssignmentPhase()
end

function slot0.GetTaskList(slot0)
	slot1 = {
		stageTask = {}
	}
	slot4 = TaskData
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetTaskList(slot6)) do
		if AssignmentCfg[slot6.id].type == TaskConst.TASK_TYPE.ALPHA then
			if not slot1[AssignmentCfg[slot6.id].phase] then
				slot1[slot7] = {}
			end

			if AssignmentCfg[slot6.id].condition == TaskConst.STAGE_TASK_ID and AssignmentCfg[slot6.id].additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
				slot1.stageTask[slot7] = slot6.id
			else
				slot1[slot7][#slot1[slot7] + 1] = TaskData:GetTask(slot6.id)
			end
		end
	end

	return slot1
end

function slot0.GetTaskIDByStage(slot0, slot1)
	return slot0:GetTaskList().stageTask[slot1]
end

function slot0.GetStage(slot0)
	return slot0.stage_
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.sortedList_[slot1].id)
end

function slot0.RefreshContentByDrag(slot0, slot1, slot2)
	if slot1 == 0 then
		return
	end

	if UnityEngine.Screen.width < math.abs(slot1) then
		return
	end

	if UnityEngine.Screen.height < math.abs(slot2) then
		return
	end

	if math.abs(slot2 / slot1) < 0.5773 then
		if slot1 > 0 then
			slot0:RefreshContent(slot0.stage_ + 1)

			return
		end

		if slot1 < 0 then
			slot0:RefreshContent(slot0.stage_ - 1)

			return
		end
	end
end

function slot0.RefreshContent(slot0, slot1)
	if TaskConst.ALPHA_LAST_STAGE < slot1 then
		slot0:RefreshContent(TaskConst.ALPHA_LAST_STAGE)

		return
	end

	if slot1 < 1 then
		slot0:RefreshContent(1)

		return
	end

	slot0.sortedList_ = slot0:SortedTask(slot1)
	slot0.stage_ = slot1
	slot0.titleText_.text = AssignmentCfg[slot0:GetTaskIDByStage(slot1)].desc

	slot0.generalTask_:RefreshUI(slot0:GetTaskIDByStage(slot1))
	slot0.scrollHelper_:StartScroll(#slot0.sortedList_)

	if slot0:GetAlphaTaskStage() < slot1 then
		ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), AssignmentCfg[slot0:GetTaskList().stageTask[slot1 - 1]].desc))
	end

	if slot1 <= 1 then
		SetActive(slot0.leftBtn_, false)
	elseif TaskConst.ALPHA_LAST_STAGE <= slot1 then
		SetActive(slot0.rightBtn_, false)
	else
		SetActive(slot0.leftBtn_, true)
		SetActive(slot0.rightBtn_, true)
	end
end

function slot0.SortedTask(slot0, slot1)
	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(slot0:GetTaskList()[slot1]) do
		if slot10.complete_flag < 1 then
			if AssignmentCfg[slot10.id].need <= slot10.progress then
				table.insert(slot3, slot10)
			else
				table.insert(slot4, slot10)
			end
		else
			table.insert(slot5, slot10)
		end
	end

	slot6 = {}

	function slot7(slot0, slot1)
		return slot0.id < slot1.id
	end

	table.sort(slot3, slot7)
	table.sort(slot4, slot7)
	table.sort(slot5, slot7)
	table.insertto(slot6, slot3)
	table.insertto(slot6, slot4)
	table.insertto(slot6, slot5)

	return slot6
end

function slot0.RefreshIcon(slot0)
	if ItemCfg[AssignmentCfg[slot0:GetTaskIDByStage(slot0.stage_)].reward[1][1]].type == ItemConst.ITEM_TYPE.HERO then
		slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/Character/Icon/" .. slot1)
	else
		slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/Item/Portrait/" .. slot1)
	end
end

function slot0.OnTaskListChange(slot0)
	if TaskConst.ALPHA_LAST_STAGE < slot0:GetAlphaTaskStage() then
		slot0:RefreshContent(TaskConst.ALPHA_LAST_STAGE)

		return
	end

	slot0:RefreshContent(slot0:GetAlphaTaskStage())
end

function slot0.OnTop(slot0)
	slot0:ShowDefaultBar()
end

function slot0.OnExit(slot0)
	slot0.generalTask_:OnExit()

	for slot4 = 1, #slot0.taskItems_ do
		slot0.taskItems_[slot4]:OnExit()
	end

	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = 1, #slot0.taskItems_ do
		slot0.taskItems_[slot4]:Dispose()
	end

	slot0.generalTask_:Dispose()
	slot0.itemPool_:Dispose()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
