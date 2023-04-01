slot0 = class("SummerHeroTrialActiviteView", HeroTrialActiviteView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerHeroTrialUI"
end

function slot0.RefreshTextName(slot0, slot1)
	slot2 = string.split(slot1, "·")
	slot0.textName_.text = string.format("<size=46>%s</size><size=32>·%s</size>", slot2[1], slot2[2])
end

return slot0
