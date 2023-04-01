slot0 = class("StrategyMatrixRwardItem", ReduxView)

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

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, CommonItem)
	slot0.buttonController = ControllerUtil.GetController(slot0.m_btnController, "stateBtn")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_receiveBtn, nil, function ()
		TaskAction:TryToSubmitTask(uv0.taskID_)
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.taskID_ = slot1
	slot0.taskProgress = TaskData:GetTaskProgress(slot1)
	slot0.taskComplete_ = TaskData:GetTaskComplete(slot1)

	slot0:RefreshUI()
	slot0:RefreshProgress()
end

function slot0.RefreshUI(slot0)
	slot0.rewards = AssignmentCfg[slot0.taskID_].reward or {}

	slot0.list:StartScroll(#slot0.rewards)
end

function slot0.RefreshProgress(slot0)
	slot2 = slot0.taskProgress

	if AssignmentCfg[slot0.taskID_].need < slot0.taskProgress then
		slot2 = slot1.need
	end

	slot3 = AssignmentCfg[slot0.taskID_]
	slot0.m_pointLab.text = slot3.desc .. string.format("(%s/%s)", slot2, slot3.need)
	slot4 = slot3.need <= slot0.taskProgress

	if slot0.taskComplete_ then
		slot0.buttonController:SetSelectedIndex("2")
	elseif slot4 then
		slot0.buttonController:SetSelectedIndex("0")
	else
		slot0.buttonController:SetSelectedIndex("1")
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.rewards[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
