slot0 = class("XH1stSeamItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "item")
	slot0.itemtypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "itemtype")
	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.commonItem_

	slot1:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.JumpToPage2(AssignmentCfg[uv0.assignmentId_].source)
	end)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		slot0 = AssignmentCfg[uv0.assignmentId_]

		TaskAction.SubmitTask(uv0.assignmentId_, function (slot0)
			if isSuccess(slot0.result) then
				getReward(uv0.reward)
				TaskData:OsirisTaskSubmit(uv1.assignmentId_)
				manager.notify:Invoke(OSIRIS_TASK_UPDATE)
			else
				ShowTips(slot0.result)
			end
		end)
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.assignmentId_ = slot2
	slot0.assignmentCfg_ = AssignmentCfg[slot2]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.titleLabel_.text = slot0.assignmentCfg_.desc

	if slot0.assignmentCfg_.need < TaskData:GetActivityTask(ActivityConst.ACTIVITY_2_0_SEAL, slot0.assignmentId_).progress then
		slot1 = slot0.assignmentCfg_.need
	end

	slot0.progressBar_.fillAmount = math.min(1, slot1 / slot0.assignmentCfg_.need)
	slot0.progressLabel_.text = slot1 .. "/" .. slot0.assignmentCfg_.need

	slot0.commonItem_:RefreshData({
		id = slot0.assignmentCfg_.reward[1][1],
		number = slot0.assignmentCfg_.reward[1][2]
	})

	if slot0.assignmentCfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		slot0.itemtypeController_:SetSelectedState("daily")
	elseif slot0.assignmentCfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE then
		slot0.itemtypeController_:SetSelectedState("challenge")
	else
		slot0.itemtypeController_:SetSelectedState("daily")
	end

	if TaskData:GetActivityTaskComplete(ActivityConst.ACTIVITY_2_0_SEAL, slot0.assignmentId_) then
		slot0.itemController_:SetSelectedState("received")
	elseif slot0.assignmentCfg_.need <= slot1 then
		slot0.itemController_:SetSelectedState("complete")
	else
		slot0.itemController_:SetSelectedState("normal")
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	slot0.data_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
