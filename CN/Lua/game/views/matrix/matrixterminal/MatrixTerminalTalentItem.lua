slot0 = class("MatrixTerminalTalentItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
	slot0:AddUIListener()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_clickBtn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.id, uv0)
		end
	end)
end

function slot0.Refresh(slot0, slot1, slot2, slot3, slot4)
	slot0.id = slot1

	slot0.selectController_:SetSelectedIndex(slot1 == slot3 and 1 or 0)
	slot0:RefreshData(slot2, slot4)
end

function slot0.RefreshData(slot0, slot1, slot2)
	if not slot0.id then
		return
	end

	slot4 = slot1[slot0.id] or 0
	slot5 = MatrixTerminalGiftCfg[slot3]
	slot6 = getSpriteWithoutAtlas("Textures/MatrixItem/MatrixTerminal/" .. slot5.icon)
	slot0.m_grayIcon.sprite = slot6
	slot0.m_icon.sprite = slot6
	slot9 = slot7 ~= 0 and (slot1[slot5.pre_id] or 0) == 0

	if MatrixData:GetTerminalLevel() < slot5.limit_level or slot9 then
		slot0.stateController_:SetSelectedIndex(0)

		return
	end

	if slot4 >= #slot5.effect_id_list then
		slot0.stateController_:SetSelectedIndex(2)

		slot0.m_levelLab.text = "MAX"
	else
		slot0.m_levelLab.text = slot4 .. "/" .. slot12

		slot0.stateController_:SetSelectedIndex(slot2 < (slot5.cost[slot4 + 1] or 0) and 2 or 1)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.SetChoice(slot0, slot1)
	slot0.selectController_:SetSelectedIndex(slot0.id == slot1 and 1 or 0)
end

function slot0.SetScrollEnable(slot0, slot1)
	slot0.m_scroll.enabled = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
