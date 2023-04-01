slot0 = class("StrategyMatrixMapView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/StrategyMatrix/Map/StrategyMatrixMap_" .. slot1), slot2)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.mapId = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.node_list = {}
	slot1 = StrategyMatrixMapCfg.get_id_list_by_map_id[slot0.mapId] or {}

	for slot5, slot6 in ipairs(slot1) do
		slot8 = StrategyMatrixMapNode.New(slot0.m_nodes:Find(tostring(slot6)), slot6)

		slot8:RegistCallBack(handler(slot0, slot0.SetSelectNode))

		slot0.node_list[slot6] = slot8
	end

	slot0.animator = slot0:FindCom(typeof(Animator), "", slot0.transform_)
end

function slot0.PlayerAnim(slot0, slot1)
	if not slot0.animator then
		return
	end

	if slot1 then
		slot0.animator:Play("StrategyMatrixMap", 0, 0)
	else
		slot0.animator:Play("StrategyMatrixMap", 0, 9999999)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		if uv0:IsOpenSectionInfo() then
			uv0:SetSelectNode(0)
			JumpTools.Back()
		end
	end)

	slot1 = slot0.m_scrollEvent

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0:IsOpenSectionInfo() then
			uv0:SetSelectNode(0)
			JumpTools.Back()
		end
	end))
end

function slot0.SetData(slot0, slot1)
	slot0.matrix_activity_id = slot1
	slot2 = nil

	for slot7, slot8 in pairs(StrategyMatrixData:GetNodeList(slot0.matrix_activity_id)) do
		slot0.node_list[slot7]:SetData(slot0.matrix_activity_id, slot8)
		slot0.node_list[slot7]:SetSelect(slot7 == slot0.selectNodeId)

		if slot8.state == StrategyMatrixConst.NODE_STATE.CURRENT then
			slot2 = slot7
		end
	end

	if slot0.selectNodeId == nil or slot0.selectNodeId == 0 then
		slot0.selectNodeId = slot2
	end

	if slot0.selectNodeId and slot0.selectNodeId ~= 0 then
		slot0.m_scrollContent.localPosition = Vector3(slot0:GetPosition(slot0.selectNodeId), 0, 0)

		if slot0:IsOpenSectionInfo() then
			slot0.m_scrollCom.horizontal = false
		else
			slot0.m_scrollCom.horizontal = true
		end
	else
		slot0:SetSelectNode(0)

		slot0.m_scrollContent.localPosition = Vector3(0, 0, 0)
	end
end

function slot0.OnTop(slot0)
	slot0:SetSelectNode(0)
end

function slot0.Exit(slot0)
	slot0:RemoveTween()
end

function slot0.GetMapId(slot0)
	return slot0.mapId
end

function slot0.SetSelectNode(slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = true
	end

	if slot1 == slot0.selectNodeId then
		slot2 = false
	end

	slot0.selectNodeId = slot1

	if slot0.node_list[slot1] then
		slot4 = slot0:GetPosition(slot1)
		slot0.m_scrollCom.horizontal = false

		slot0:RemoveTween()

		if slot2 then
			slot5 = LeanTween.value(slot0.m_scrollContent.gameObject, slot0.m_scrollContent.localPosition.x, slot4, 0.2)
			slot0.tween_ = slot5:setOnUpdate(LuaHelper.FloatAction(function (slot0)
				uv0.m_scrollContent.localPosition = Vector3(slot0, 0, 0)
			end))
		else
			slot0.m_scrollContent.localPosition = Vector3(slot4, 0, 0)
		end
	else
		slot0.m_scrollCom.horizontal = true
	end

	if slot0.selectNodeId ~= 0 then
		slot0:Go("strategyMatrixInfo", {
			nodeId = slot0.selectNodeId
		})
	end

	for slot7, slot8 in pairs(slot0.node_list) do
		slot8:SetSelect(slot8:GetNodeId() == slot0.selectNodeId)
	end
end

function slot0.GetPosition(slot0, slot1)
	if slot0.node_list[slot1] then
		return slot0.m_scrollView.rect.width / 2 - (slot0.m_scrollContent.rect.width / 2 + slot2.transform_.localPosition.x)
	else
		return 0
	end
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil)
		LeanTween.cancel(slot0.m_scrollContent.gameObject)

		slot0.tween_ = nil
	end
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("strategyMatrixInfo")
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.node_list) do
		slot5:Dispose()
	end

	slot0.m_scrollEvent:RemoveAllListeners()
	uv0.super.Dispose(slot0)

	if not isNil(slot0.gameObject_) then
		Object.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
		slot0.transform_ = nil
	end
end

return slot0
