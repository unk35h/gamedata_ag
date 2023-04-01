slot0 = class("MatrixSelectAffixItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
	slot0:AddUIListener()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_clickBtn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.id)
		end
	end)
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.id = slot1

	slot0.selectController_:SetSelectedIndex(slot2)

	slot3 = MatrixAffixCfg[slot0.id].affix
	slot0.m_name.text = ({
		"Ⅰ",
		"Ⅱ",
		"Ⅲ",
		"Ⅳ",
		"Ⅴ",
		"Ⅵ",
		"Ⅶ",
		"Ⅷ",
		"Ⅸ"
	})[slot3[2]]
	slot0.m_icon.sprite = getAffixSprite(slot3)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

return slot0
