slot0 = class("ActivityNewbieView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Activity/NewbieAdvanceTaskUI"
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

	slot0.tree_ = LuaTree.New(slot0.uiTreeGo_)
	slot0.taskList_ = LuaList.New(handler(slot0, slot0.IndexTaskItem), slot0.uiListGo_, NoobAdvanceTaskItem)

	slot0:GreatTree()

	slot0.noobTaskUpdateHandler_ = handler(slot0, slot0.OnTaskUpdate)
	slot0.allReceiveBtnState_ = ControllerUtil.GetController(slot0.transform_, "allReceive")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.receiveAllBtn_, nil, function ()
		slot0 = {}

		for slot4, slot5 in ipairs(uv0.taskDataList_) do
			if AssignmentCfg[slot5.id].need <= slot5.progress and slot5.complete_flag < 1 then
				slot0[#slot0 + 1] = slot5.id
			else
				break
			end
		end

		slot1 = TaskAction

		slot1:TryToSubmitTaskListWithCallback(slot0, TaskConst.TASK_TYPE.NOOB_ADVANCE, function (slot0)
			if isSuccess(slot0.result) then
				slot1 = {}

				for slot5, slot6 in ipairs(uv0) do
					table.insertto(slot1, AssignmentCfg[slot6].reward)
				end

				getReward(mergeReward(slot1))
				TaskData:NoobAdvanceTaskSubmit(uv0)
				uv1:OnTaskUpdate()
			else
				ShowTips(slot0.result)
			end
		end)
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if slot0.params_.isEnter == true then
		slot1, slot2 = slot0:GetSelectIndex()

		slot0.tree_:SelectItem(slot1, slot2)

		slot0.params_.isEnter = false
	elseif slot0.params_.groupIndex and slot0.params_.itemIndex then
		slot0.tree_:SelectItem(slot0.params_.groupIndex, slot0.params_.itemIndex)
	else
		slot0.tree_:SelectItem(1, 1)
	end

	manager.notify:RegistListener(NEWBIE_TASK_UPDATE, slot0.noobTaskUpdateHandler_)
	slot0:BindRedPoint()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(NEWBIE_TASK_UPDATE, slot0.noobTaskUpdateHandler_)

	slot0.params_.groupIndex = slot0.curSelectedGroupIndex_
	slot0.params_.itemIndex = slot0.curSelectedItemIndex_
	slot0.curSlectedItemID_ = nil

	slot0:UnbindRedPoint()
end

function slot0.IndexTaskItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskDataList_[slot1].id)
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	slot0.curSelectedGroupIndex_ = slot1
end

function slot0.OnItemSelect(slot0, slot1, slot2, slot3, slot4)
	if slot0.curSlectedItemID_ == slot2 then
		return
	end

	slot0.curSelectedItemIndex_ = slot1
	slot0.curSlectedItemID_ = slot2
	slot0.taskDataList_ = TaskData:GetNoobAdvanceTaskSortList(slot2)

	slot0.taskList_:StartScroll(#slot0.taskDataList_)
	slot0:RefreshReceiveBtn()
end

function slot0.RefreshReceiveBtn(slot0)
	for slot4, slot5 in ipairs(slot0.taskDataList_) do
		if AssignmentCfg[slot5.id].need <= slot5.progress and slot5.complete_flag < 1 then
			slot0.allReceiveBtnState_:SetSelectedState("true")

			return
		end
	end

	slot0.allReceiveBtnState_:SetSelectedState("false")
end

function slot0.Dispose(slot0)
	slot0.tree_:Dispose()

	slot0.tree_ = nil

	slot0.taskList_:Dispose()

	slot0.taskList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.GreatTree(slot0)
	slot0.tree_:SetSelectedHandler(nil, )

	slot2 = UITreeData.New()

	for slot7, slot8 in ipairs(GameSetting.advanced_task_tad.value) do
		slot9 = UITreeGroupData.New()
		slot9.id = slot7
		slot9.text = GetTips(slot8[1])

		for slot14, slot15 in ipairs(slot8[2]) do
			slot16 = UITreeItemData.New()
			slot16.id = slot15[1]
			slot16.text = GetTips(slot15[2])

			slot9.itemDatas:Add(slot16)
		end

		slot2.groupDatas:Add(slot9)
	end

	slot1:SetData(slot2)
	slot1:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect), handler(slot0, slot0.OnItemSelect))
end

function slot0.GetSelectIndex(slot0)
	slot2 = 1
	slot3 = 1

	for slot7, slot8 in ipairs(GameSetting.advanced_task_tad.value) do
		slot2 = slot7

		for slot12, slot13 in ipairs(slot8[2]) do
			slot3 = slot12

			for slot18, slot19 in pairs(TaskData:GetNoobAdvanceTaskByPhase(slot13[1])) do
				if slot19.progress < AssignmentCfg[slot19.id].need or slot19.complete_flag == 0 then
					return slot2, slot3
				end
			end
		end
	end

	return slot2, slot3
end

function slot0.OnTaskUpdate(slot0)
	slot0.taskDataList_ = TaskData:GetNoobAdvanceTaskSortList(slot0.curSlectedItemID_)

	slot0.taskList_:StartScroll(#slot0.taskDataList_)
	slot0:RefreshReceiveBtn()
end

function slot0.BindRedPoint(slot0)
	for slot5, slot6 in ipairs(GameSetting.advanced_task_tad.value) do
		slot10 = slot0.tree_:GetGroupRedPointContainerById(slot5)
		slot11 = string.format

		manager.redPoint:bindUIandKey(slot10, slot11("%s_%d", RedPointConst.NOOB_ADVANCE, slot5))

		for slot10, slot11 in ipairs(slot6[2]) do
			manager.redPoint:bindUIandKey(slot0.tree_:GetItemRedPointContainerById(slot5, slot11[1]), string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, slot5, slot11[1]))
		end
	end
end

function slot0.UnbindRedPoint(slot0)
	for slot5, slot6 in ipairs(GameSetting.advanced_task_tad.value) do
		slot10 = slot0.tree_:GetGroupRedPointContainerById(slot5)
		slot11 = string.format

		manager.redPoint:unbindUIandKey(slot10, slot11("%s_%d", RedPointConst.NOOB_ADVANCE, slot5))

		for slot10, slot11 in ipairs(slot6[2]) do
			manager.redPoint:unbindUIandKey(slot0.tree_:GetItemRedPointContainerById(slot5, slot11[1]), string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, slot5, slot11[1]))
		end
	end
end

return slot0
