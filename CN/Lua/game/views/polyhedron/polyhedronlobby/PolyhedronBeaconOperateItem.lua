slot0 = class("PolyhedronBeaconOperateItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
	slot0:AddUIListener()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_unlockBtn, nil, function ()
		PolyhedronAction.QueryUnlockBeacon(uv0.id)
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.id = slot1
	slot0.transform_.name = slot1

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot1 = PolyhedronBeaconCfg[slot0.id]
	slot0.m_icon.sprite = getSpriteWithoutAtlas(PolyhedronConst.BEACON_ICON_PATH .. slot1.icon)
	slot0.m_name.text = slot1.name
	slot0.m_des.text = slot1.desc

	if PolyhedronData:GetBeaconIsLock(slot0.id) then
		slot3, slot4, slot5 = PolyhedronTools.GetBeaconIsUnlockCondition(slot0.id)

		if not slot3 then
			slot0.stateController_:SetSelectedIndex(1)

			slot4 = slot4 or 0
			slot5 = slot5 or 0
			slot0.m_processText.text = slot4 .. "/" .. slot5
			slot0.m_processImg.fillAmount = slot5 == 0 and 0 or slot4 / slot5
			slot0.m_lockTip.text = ConditionCfg[slot1.condition].desc
		else
			slot0.stateController_:SetSelectedIndex(2)
		end
	else
		slot0.stateController_:SetSelectedIndex(0)
	end
end

return slot0
