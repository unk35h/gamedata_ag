slot0 = class("SectionBranchLineItem", ReduxView)
slot1 = 50

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.lineGo1_ = Object.Instantiate(slot1, slot2.transform)
	slot0.lineTf1_ = slot0.lineGo1_:GetComponent("RectTransform")
	slot0.lineGo2_ = Object.Instantiate(slot1, slot2.transform)
	slot0.lineTf2_ = slot0.lineGo2_:GetComponent("RectTransform")
	slot0.lineGo3_ = Object.Instantiate(slot1, slot2.transform)
	slot0.lineTf3_ = slot0.lineGo3_:GetComponent("RectTransform")
	slot0.pointGo1_ = Object.Instantiate(slot3, slot2.transform)
	slot0.pointTf1_ = slot0.pointGo1_:GetComponent("RectTransform")
	slot0.pointGo2_ = Object.Instantiate(slot3, slot2.transform)
	slot0.pointTf2_ = slot0.pointGo2_:GetComponent("RectTransform")
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0:RefreshLine1(slot1, slot2)
	slot0:RefreshLine2(slot1, slot2)
	slot0:RefreshLine3(slot1, slot2)
end

function slot0.RefreshLine1(slot0, slot1, slot2)
	slot3 = uv0

	if math.abs(slot2.x - slot1.x) < uv0 then
		slot3 = slot4 / 2
	end

	slot0.lineTf1_.localPosition = Vector3(slot2.x - slot3 / 2, slot2.y, 0)
	slot0.lineTf1_.sizeDelta = Vector2(slot3, 4)
	slot0.lineTf1_.localEulerAngles = Vector3(0, 0, 0)

	slot0.lineTf1_:SetAsFirstSibling()

	slot0.pointTf1_.localPosition = Vector3(slot2.x, slot2.y, 0)

	slot0.pointTf1_:SetAsFirstSibling()
end

function slot0.RefreshLine2(slot0, slot1, slot2)
	if slot1.y == slot2.y then
		SetActive(slot0.lineGo2_, false)
	else
		slot3 = uv0

		if math.abs(slot2.x - slot1.x) < uv0 then
			slot3 = slot4 / 2
		end

		slot0.lineTf2_.localPosition = Vector3(slot2.x - slot3, (slot1.y + slot2.y) / 2, 0)
		slot0.lineTf2_.sizeDelta = Vector2(math.abs(slot1.y - slot2.y), 4)
		slot0.lineTf2_.localEulerAngles = Vector3(0, 0, 90)

		slot0.lineTf2_:SetAsFirstSibling()
	end
end

function slot0.RefreshLine3(slot0, slot1, slot2)
	slot3 = uv0
	slot3 = math.abs(slot2.x - slot1.x) < uv0 and slot4 / 2 or slot4 - uv0
	slot0.lineTf3_.localPosition = Vector3(slot1.x + slot3 / 2, slot1.y, 0)
	slot0.lineTf3_.sizeDelta = Vector2(slot3, 4)
	slot0.lineTf3_.localEulerAngles = Vector3(0, 0, 0)

	slot0.lineTf3_:SetAsFirstSibling()

	slot0.pointTf2_.localPosition = Vector3(slot1.x, slot1.y, 0)

	slot0.pointTf2_:SetAsFirstSibling()
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.lineGo1_, slot1)
	SetActive(slot0.lineGo2_, slot1)
	SetActive(slot0.lineGo3_, slot1)
	SetActive(slot0.pointGo1_, slot1)
	SetActive(slot0.pointGo2_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.lineGo1_)
	Object.Destroy(slot0.lineGo2_)
	Object.Destroy(slot0.lineGo3_)
	Object.Destroy(slot0.pointGo1_)
	Object.Destroy(slot0.pointGo2_)

	slot0.lineTf1_ = nil
	slot0.lineTf2_ = nil
	slot0.lineTf3_ = nil
	slot0.pointTf1_ = nil
	slot0.pointTf2_ = nil
	slot0.lineGo1_ = nil
	slot0.lineGo2_ = nil
	slot0.lineGo3_ = nil
	slot0.pointGo1_ = nil
	slot0.pointGo2_ = nil
end

return slot0
