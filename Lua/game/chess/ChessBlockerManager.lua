slot0 = class("ChessBlockerManager")

function slot0.Ctor(slot0, slot1)
	slot0.Blocker_ = nil
	slot0.blockTimes_ = 0

	slot0:CreateBlocker(slot1)
end

function slot0.ShowBlocker(slot0)
	slot0.blockTimes_ = slot0.blockTimes_ + 1

	if slot0.blockTimes_ >= 1 then
		SetActive(slot0.Blocker_, true)
		ChessLuaBridge.SetChessInputEnable(false)
	end
end

function slot0.HideBlocker(slot0)
	slot0.blockTimes_ = slot0.blockTimes_ == 0 and 0 or slot0.blockTimes_ - 1

	if slot0.blockTimes_ <= 0 then
		SetActive(slot0.Blocker_, false)
		ChessLuaBridge.SetChessInputEnable(true)
	end
end

function slot0.CreateBlocker(slot0, slot1)
	slot2 = GameObject("Blocker")
	slot3 = slot2:AddComponent(typeof(RectTransform))

	slot3:SetParent(slot1.transform, false)

	slot3.anchorMin = Vector3.zero
	slot3.anchorMax = Vector3.one
	slot3.sizeDelta = Vector2.zero
	slot2:AddComponent(typeof(Image)).color = Color.clear

	SetActive(slot2, false)

	slot0.Blocker_ = slot2
end

function slot0.DestroyBlocker(slot0)
	Object.Destroy(slot0.Blocker_)
end

function slot0.Dispose(slot0)
	slot0:DestroyBlocker()
end

return slot0
