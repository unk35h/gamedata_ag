slot0 = class("StrategyMatrixInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/StrategyMatrix/StrategyMatrixInfoUI"
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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		uv0:OnEventAction()
	end)
end

function slot0.OnEnter(slot0)
	slot0.nodeId = slot0.params_.nodeId
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	slot0:RefreshUI()
end

function slot0.OnUpdate(slot0)
	slot0.nodeId = slot0.params_.nodeId
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if StrategyMatrixData:GetNodeList(slot0.matrix_activity_id)[slot0.nodeId] then
		slot4 = StrategyMatrixEventTemplateCfg[slot2.event_id]
		slot0.m_name.text = slot4.name
		slot0.m_info.text = slot4.op_info

		SetSpriteWithoutAtlasAsync(slot0.m_bg, SpritePathCfg.Stage.path .. slot4.op_bg)
	end
end

function slot0.Check(slot0, slot1)
	if slot0:GetMatrixPhaseData():GetPhase() == 1 and StrategyMatrixConst.NODE_STATE.SELECT == slot1 then
		return true
	end

	if slot3 == 2 and StrategyMatrixConst.NODE_STATE.CURRENT == slot1 then
		return true
	end

	return false
end

function slot0.OnEventAction(slot0)
	if not StrategyMatrixData:GetNodeList(slot0.matrix_activity_id)[slot0.nodeId] then
		return
	end

	if not slot0:Check(slot2.state) then
		return
	end

	if not StrategyMatrixEventTemplateCfg[slot2.event_id] then
		return
	end

	slot7 = slot0:GetMatrixPhaseData():GetPhase()

	if MatrixConst.EVENT_TYPE.SHOP == slot5.event_type or MatrixConst.EVENT_TYPE.INCIDENT == slot5.event_type then
		if slot7 == 2 then
			StrategyMatrixAction.DoEvent(slot0.matrix_activity_id)
		else
			StrategyMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
				slot0.nodeId
			})
		end
	else
		JumpTools.OpenPageByJump("/sectionSelectHeroStrategyMatrix", {
			section = 0,
			sectionType = BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX,
			eventId = slot4,
			matrix_activity_id = slot0.matrix_activity_id,
			activityID = slot0.matrix_activity_id,
			nodeId = slot0.nodeId
		})
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.GetMatrixPhaseData(slot0)
	return StrategyMatrixData:GetMatrixPhaseData(slot0.matrix_activity_id)
end

return slot0
