slot0 = class("CanteenFoodTasteitem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1)
	slot0.nameText_.text = string.format("<color=#%s>%s</color>", BackHomeCateenFlavor[slot1].color, BackHomeCateenFlavor[slot1].flavor)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
