slot0 = class("PolyhedronInteractiveView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PolyhedronBattle/PolyhedronInteractiveUI"
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
		PolyhedronAction.QuerySelectStagePolyhedron(uv0.index)
	end)
end

function slot0.OnEnter(slot0)
	slot0.index = slot0.params_.index

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	slot1 = slot0.polyhedronInfo:GetGateData(slot0.index)
	slot0.m_des.text = PolyhedronTools.GetGateCfg(slot1.id, slot1.reward_type).gate_des

	if PolyhedronTierCfg[slot0.polyhedronInfo:GetTierId() + 1] == nil and PolyhedronTierCfg.get_id_list_by_tier[PolyhedronTierCfg[slot5].tier + 1] then
		slot7 = PolyhedronTierCfg[PolyhedronTierCfg.get_id_list_by_tier[slot8 + 1][1]]
	end

	if slot7 then
		if slot4.gate_title then
			slot0.m_btnLab.text = string.format(slot4.gate_title, slot7.tier, slot7.level)
		else
			slot0.m_btnLab.text = GetTips("GO_UP_TO") .. slot7.tier .. "-" .. slot7.level
		end
	else
		slot0.m_btnLab.text = GetTips("GO_UP_TO")
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_titleTextTrans)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_titleContentTrans)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_desTrs)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_contentTrs)
end

return slot0
