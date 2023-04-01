slot1 = class("FactoryHeroTrialView", import("game.views.heroTrialActivite.HeroTrialActiviteView"))

function slot1.UIName(slot0)
	return "UI/MardukUI/HeroTrial/MardukHeroTrialUI"
end

function slot1.RefreshTextName(slot0, slot1)
	slot2 = string.split(slot1, "·")
	slot0.textName_.text = string.format("<size=46>%s</size><size=32>·%s</size>", slot2[1], slot2[2])
end

function slot1.GetRewardItem(slot0, slot1)
	return RewardPoolFactoryItem.New(slot0.goRewardPanel_, slot1, true)
end

return slot1
