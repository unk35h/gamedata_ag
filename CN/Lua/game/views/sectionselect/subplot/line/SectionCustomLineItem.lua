slot0 = class("SectionCustomLineItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.lineAB_ = slot1
	slot0.pointAB_ = slot3
	slot0.lineParent_ = slot2
	slot0.lineList_ = {}
	slot0.pointList_ = {}
end

function slot0.RefreshUI(slot0, slot1)
	for slot5, slot6 in pairs(slot0.lineList_) do
		SetActive(slot0.lineList_[i], false)
	end

	for slot5, slot6 in pairs(slot0.pointList_) do
		SetActive(slot0.pointList_[i], false)
	end

	slot2 = 1
	slot3 = 1

	for slot7, slot8 in pairs(slot1) do
		if slot8[1] == 1 then
			slot0.lineList_[slot2] = slot0.lineList_[slot2] or Object.Instantiate(slot0.lineAB_, slot0.lineParent_.transform)

			slot0:RefreshLine(slot0.lineList_[slot2]:GetComponent("RectTransform"), slot8)
			SetActive(slot0.lineList_[slot2], true)

			slot2 = slot2 + 1
		elseif slot8[1] == 2 then
			slot0.pointList_[slot3] = slot0.pointList_[slot3] or Object.Instantiate(slot0.pointAB_, slot0.lineParent_.transform)

			slot0:RefreshPoint(slot0.pointList_[slot3]:GetComponent("RectTransform"), slot8)
			SetActive(slot0.pointList_[slot2], true)

			slot3 = slot3 + 1
		end
	end
end

function slot0.RefreshPoint(slot0, slot1, slot2)
	slot1.localPosition = Vector3(slot2[2][1], slot2[2][2], 0)

	slot1:SetAsFirstSibling()
end

function slot0.RefreshLine(slot0, slot1, slot2)
	slot1.localPosition = Vector3(slot2[2][1], slot2[2][2], 0)
	slot1.sizeDelta = Vector2(slot2[3][1], slot2[3][2])
	slot1.localEulerAngles = Vector3(slot2[4][1], slot2[4][2], slot2[4][3])

	slot1:SetAsFirstSibling()
end

function slot0.Show(slot0, slot1)
	for slot5, slot6 in pairs(slot0.lineList_) do
		SetActive(slot6, slot1)
	end

	for slot5, slot6 in pairs(slot0.pointList_) do
		SetActive(slot6, slot1)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.lineList_) do
		Object.Destroy(slot5)
	end

	slot0.lineList_ = nil

	for slot4, slot5 in pairs(slot0.pointList_) do
		Object.Destroy(slot5)
	end

	slot0.pointList_ = nil
	slot0.pointTf1_ = nil
	slot0.pointTf2_ = nil
	slot0.pointGo1_ = nil
	slot0.pointGo2_ = nil
end

return slot0
