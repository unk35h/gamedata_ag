slot1 = class("SoloChallengeAffixDescriptionView", import("game.views.setting.AffixDescriptionView"))

function slot1.ItemRenderer(slot0, slot1, slot2)
	slot2:GetComponent("UIList")

	slot5 = slot2.transform:Find("icon"):GetComponent("Image")
	slot5.sprite = getAffixSprite(slot0.data[slot1 + 1])
	slot2.transform:Find("name"):GetComponent("Text").text = getAffixName(slot0.data[slot1 + 1])
	slot2.transform:Find("text"):GetComponent("Text").text = getAffixDesc(slot0.data[slot1 + 1])
	slot5.color = Color.white
end

return slot1
