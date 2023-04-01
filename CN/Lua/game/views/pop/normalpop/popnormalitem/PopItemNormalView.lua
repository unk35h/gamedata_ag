slot0 = class("PopItemNormalView", import("game.views.pop.PopItemView"))
slot1 = import("game.tools.ItemTools")

function slot0.CustomInitUI(slot0)
	SetActive(slot0.mergeBtn_.gameObject, false)
	SetActive(slot0.sourceBtnGo_, false)
	SetActive(slot0.operatePanel_, false)
	SetActive(slot0.sourceDesGo_, false)
end

return slot0
