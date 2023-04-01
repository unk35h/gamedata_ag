slot0 = class("ThirdVolumeHeroTrialView", HeroTrialActiviteView)

function slot0.UIName(slot0)
	if ActivityTools.GetActivityTheme(slot0.params_.activiteID) == ActivityConst.THEME.VOLUME_DOWN then
		return "UI/VolumeIIIDownUI/HeroTrial/VolumeIIIDownHeroTrialUI"
	else
		return "UI/VolumeIIIUI/VolumeHeroTrialUI"
	end
end

function slot0.RefreshTextName(slot0, slot1)
	slot2 = string.split(slot1, "·")
	slot0.textName_.text = string.format("<size=46>%s</size><size=32>·%s</size>", slot2[1], slot2[2])
end

return slot0
