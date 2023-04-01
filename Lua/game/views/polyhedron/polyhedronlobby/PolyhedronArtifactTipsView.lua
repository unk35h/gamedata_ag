slot0 = class("PolyhedronArtifactTipsView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Polyhedron/PolyhedronTreasureUI"
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

	slot0.list = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.id = slot0.params_.artifact_id
	slot1 = PolyhedronArtifactCfg[slot0.id]
	slot0.m_name.text = slot1.name
	slot0.m_story.text = slot1.story or ""
	slot0.affix_id = slot1.affix_id
	slot0.max_level = math.min(slot1.max_level, AffixTypeCfg[slot0.affix_id].max_level)

	for slot5 = 1, slot0.max_level do
		if not slot0.list[slot5] then
			slot0.list[slot5] = PolyhedronArtifactTipsItem.New(slot0.m_explainGo, slot0.m_content)
		end

		slot0.list[slot5]:SetData(slot0.affix_id, slot5)
	end

	for slot5 = slot0.max_level + 1, #slot0.list do
		slot0.list[slot5]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_content)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.list) do
		slot5:Dispose()
	end

	slot0.list = nil

	uv0.super.Dispose(slot0)
end

return slot0
