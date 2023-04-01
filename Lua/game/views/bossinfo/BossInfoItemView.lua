slot1 = class("BossInfoItemView", import("game.views.IllustratedHandleBook.IlluEnemyFiles.IlluEnemyFileDetailItem"))

function slot1.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot1.RefreshUI(slot0, slot1)
	SetActive(slot0.gameObject_, true)

	slot0.titleText_.text = slot1.name
	slot0.descText_.text = slot1.info

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
end

return slot1
