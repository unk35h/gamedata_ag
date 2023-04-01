slot0 = class("StrategyMatrixMapNode", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.node_id = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeController = ControllerUtil.GetController(slot0.gameObject_.transform, "event")
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		slot2 = uv0.state

		if uv0:GetMatrixPhaseData():GetPhase() == 1 and StrategyMatrixConst.NODE_STATE.SELECT == slot2 then
			if uv0.callback_ then
				uv0.callback_(uv0.node_id)
			end

			return
		end

		if slot1 == 2 and StrategyMatrixConst.NODE_STATE.CURRENT == slot2 then
			if uv0.callback_ then
				uv0.callback_(uv0.node_id)
			end

			return
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.matrix_activity_id = slot1
	slot0.event_id = slot2.event_id
	slot0.state = slot2.state

	if StrategyMatrixEventTemplateCfg[slot0.event_id] then
		slot0.typeController:SetSelectedIndex(slot3.event_type - 1)

		slot0.m_name.text = slot3.name
	end

	slot0.stateController:SetSelectedIndex(slot0.state - 1)

	if StrategyMatrixConst.NODE_STATE.INVALID == slot0.state or StrategyMatrixConst.NODE_STATE.STATELESS == slot0.state then
		manager.effect:SetGrey(slot0.m_icon, true)
	else
		manager.effect:SetGrey(slot0.m_icon, false)
	end
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectController:SetSelectedIndex(slot1 and 1 or 0)
end

function slot0.GetNodeId(slot0)
	return slot0.node_id
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.GetMatrixPhaseData(slot0)
	return StrategyMatrixData:GetMatrixPhaseData(slot0.matrix_activity_id)
end

function slot0.GetTierID(slot0)
	return StrategyMatrixData:GetTierID(slot0.matrix_activity_id)
end

return slot0
