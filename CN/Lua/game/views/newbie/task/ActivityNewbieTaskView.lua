slot0 = class("ActivityNewbieTaskView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Activity/NewbieTaskUI"), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.taskItemScroll_, ActivityNewbieTaskItem)
	slot0.phaseView_ = ActivityNewbieTaskPhase.New(slot0.generalTaskGo_)

	SetActive(slot0.gameObject_, true)

	slot0.newbieTaskUpdateHandler_ = handler(slot0, slot0.NewbieTaskUpdate)
end

function slot0.SetData(slot0)
	slot0.phaseView_:OnEnter()
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	slot0.phaseView_:Dispose()

	slot0.phaseView_ = nil
	slot0.newbieTaskUpdateHandler_ = nil

	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonPrevious_, nil, function ()
		uv0:SwitchPhase(uv0.selectPhase_ - 1)
	end)
	slot0:AddBtnListener(slot0.buttonNext_, nil, function ()
		uv0:SwitchPhase(uv0.selectPhase_ + 1)
	end)
end

function slot0.SetActive(slot0, slot1)
	if slot1 == true then
		slot0:SwitchPhase(TaskData:GetAssignmentPhase())
		manager.notify:RegistListener(NEWBIE_TASK_UPDATE, slot0.newbieTaskUpdateHandler_)
	else
		manager.notify:RemoveListener(NEWBIE_TASK_UPDATE, slot0.newbieTaskUpdateHandler_)
	end

	SetActive(slot0.gameObject_, slot1)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(TaskData:GetNewbieTaskSortList(slot0.selectPhase_)[slot1].id)
end

function slot0.ClearCache(slot0)
	slot0.lastPosition_ = nil
end

function slot0.SwitchPhase(slot0, slot1)
	if slot1 > #TaskData:GetNewbiePhaseTask() then
		slot1 = slot3
	end

	if slot1 < 1 then
		slot1 = 1
	end

	slot0.selectPhase_ = slot1
	slot4 = slot2[slot1].id
	slot0.titleText_.text = GetI18NText(AssignmentCfg[slot4].desc)

	slot0.phaseView_:SetData(slot4)

	if slot0.lastPosition_ then
		slot0.scrollHelper_:StartScrollWithoutAnimator(#TaskData:GetNewbieTaskSortList(slot1), slot0.lastPosition_)
	else
		slot0.scrollHelper_:StartScroll(#TaskData:GetNewbieTaskSortList(slot1))
	end

	if TaskData:GetAssignmentPhase() < slot1 then
		ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), GetI18NText(AssignmentCfg[slot2[slot1 - 1].id].desc)))
	end

	if slot1 <= 1 then
		SetActive(slot0.leftBtn_, false)
		SetActive(slot0.rightBtn_, true)
	elseif slot3 <= slot1 then
		SetActive(slot0.leftBtn_, true)
		SetActive(slot0.rightBtn_, false)
	else
		SetActive(slot0.leftBtn_, true)
		SetActive(slot0.rightBtn_, true)
	end
end

function slot0.RefreshIcon(slot0)
	if ItemCfg[AssignmentCfg[TaskData:GetNewbiePhaseTask()[slot0.selectPhase_].id].reward[1][1]].type == ItemConst.ITEM_TYPE.HERO then
		slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/Character/Icon/" .. slot2)
	else
		slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/Item/Portrait/" .. slot2)
	end
end

function slot0.NewbieTaskUpdate(slot0)
	slot0:SwitchPhase(TaskData:GetAssignmentPhase())
end

return slot0
