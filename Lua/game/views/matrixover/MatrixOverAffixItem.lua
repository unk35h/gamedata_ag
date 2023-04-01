slot0 = class("MatrixOverAffixItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		slot0 = uv0.transform_.position

		manager.matrixPop:ShowMatrixAiffixPopItem(uv0.affixData, Vector3(-1, slot0.y + 0.1, slot0.z))
	end)
end

function slot0.Refresh(slot0, slot1)
	slot0.affixData = slot1
	slot0.m_icon.sprite = getAffixSprite(slot1)
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
	})[slot1[2]] or ""
end

return slot0
