slot0 = class("SectionSingleLineItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.lineTf_ = slot0.transform_:GetComponent("RectTransform")
	slot0.lineHeight_ = slot3 or 4
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.lineTf_.localPosition = MathTools.GetMidpoint(slot1, slot2)
	slot0.lineTf_.sizeDelta = Vector2(MathTools.GetDistance(slot1, slot2), slot0.lineHeight_)
	slot0.lineTf_.localEulerAngles = Vector3(0, 0, MathTools.GetAngle(slot1, slot2))

	slot0.lineTf_:SetAsFirstSibling()
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
