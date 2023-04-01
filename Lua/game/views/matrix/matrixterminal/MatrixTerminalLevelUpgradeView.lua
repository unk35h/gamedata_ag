slot0 = class("MatrixTerminalLevelUpgradeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/Terminal/MatrixTerminalLevelUpgradeUI"
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

	slot0.desController_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_.newLv
	slot2 = MatrixTerminalLevelCfg[slot1]
	slot0.m_levelLab.text = "" .. slot1
	slot0.m_giftLab.text = slot2.point

	if slot2.desc and slot2.desc ~= "" then
		slot0.desController_:SetSelectedIndex(1)

		slot0.m_desLab.text = slot2.desc
	else
		slot0.desController_:SetSelectedIndex(0)
	end
end

return slot0
