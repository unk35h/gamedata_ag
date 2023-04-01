slot0 = class("MatrixTerminalLevelView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/Terminal/MatrixTerminalTalentPreviewUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.id = slot0.params_.id
	slot0.lv = slot0.params_.lv
	slot1 = MatrixTerminalGiftCfg[slot0.id]
	slot0.m_nameLab.text = slot1.name
	slot0.m_curLevel.text = slot0.lv
	slot2 = slot0.lv + 1
	slot0.m_nextLevel.text = slot2
	slot0.m_desLab.text = MatrixDescCfg[slot1.desc_list[slot2]] and MatrixDescCfg[slot3].desc or ""
end

return slot0
