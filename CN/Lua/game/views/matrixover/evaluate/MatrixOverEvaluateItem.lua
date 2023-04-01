slot0 = class("MatrixOverEvaluateItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
end

function slot0.SetEvaluateID(slot0, slot1)
	slot2 = MatrixEvaluateCfg[slot1]
	slot0.titleText_.text = slot2.title
	slot0.infoText_.text = slot2.condition
	slot3 = "icon_matrix_assess_b"

	if slot2.class == 3 then
		slot3 = "icon_matrix_assess_s"
	elseif slot2.class == 2 then
		slot3 = "icon_matrix_assess_a"
	end

	slot0.icon_.sprite = getSprite("Atlas/Matrix", slot3)

	slot0:Show(true)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
