slot0 = class("MatrixSelectBeaconItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index = 0

	slot0:initUI()
	slot0:AddUIListener()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.maskController_ = ControllerUtil.GetController(slot0.transform_, "mask")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_clickBtn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.id, uv0)
		end
	end)
end

function slot0.Refresh(slot0, slot1)
	slot0.id = slot1
	slot2 = MatrixBeaconCfg[slot0.id]
	slot0.m_icon.sprite = getSpriteWithoutAtlas("Textures/MatrixItem/MatrixArtifact/" .. slot2.icon)
	slot0.m_name.text = slot2.name
	slot0.m_des.text = slot2.desc
end

function slot0.SetChoice(slot0, slot1)
	slot0.selectController_:SetSelectedIndex(slot1 and 1 or 0)
end

function slot0.SetMask(slot0, slot1)
	slot0.maskController_:SetSelectedIndex(slot1 and 1 or 0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

return slot0
