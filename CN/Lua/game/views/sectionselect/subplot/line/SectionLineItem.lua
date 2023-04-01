slot0 = class("SectionLineItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.lineTf_ = slot0.transform_:GetComponent("RectTransform")
	slot0.pointGo1_ = Object.Instantiate(slot3, slot2.transform)
	slot0.pointTf1_ = slot0.pointGo1_:GetComponent("RectTransform")
	slot0.pointGo2_ = Object.Instantiate(slot3, slot2.transform)
	slot0.pointTf2_ = slot0.pointGo2_:GetComponent("RectTransform")
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.lineTf_.localPosition = MathTools.GetMidpoint(slot1, slot2)
	slot0.lineTf_.sizeDelta = Vector2(MathTools.GetDistance(slot1, slot2), 4)
	slot0.lineTf_.localEulerAngles = Vector3(0, 0, MathTools.GetAngle(slot1, slot2))

	slot0.lineTf_:SetAsFirstSibling()

	slot0.pointTf1_.localPosition = Vector3(slot1.x, slot1.y, 0)

	slot0.pointTf1_:SetAsFirstSibling()

	slot0.pointTf2_.localPosition = Vector3(slot2.x, slot2.y, 0)

	slot0.pointTf2_:SetAsFirstSibling()
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
	SetActive(slot0.pointGo1_, slot1)
	SetActive(slot0.pointGo2_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.pointGo1_)
	Object.Destroy(slot0.pointGo2_)

	slot0.pointTf1_ = nil
	slot0.pointTf2_ = nil
	slot0.pointGo1_ = nil
	slot0.pointGo2_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
