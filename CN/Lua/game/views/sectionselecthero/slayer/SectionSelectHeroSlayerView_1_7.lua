slot1 = class("SectionSelectHeroSlayerView_1_7", import("game.views.sectionSelectHero.SectionSelectHeroSlayerView"))

function slot1.RefreshAddBtn(slot0)
	uv0.super.RefreshAddBtn(slot0)
	SetActive(slot0.addBtnGo_[2], false)
	SetActive(slot0.addBtnGo_[3], false)
	SetActive(slot0.drag_[2].gameObject, false)
	SetActive(slot0.drag_[3].gameObject, false)
end

function slot1.RefreshRace(slot0)
	uv0.super.RefreshRace(slot0)
	SetActive(slot0.effectPanel_, false)
end

return slot1
