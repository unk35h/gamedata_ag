slot0 = class("SkinTrialSelect108", SkinTrialActivitySelectView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIDownUI/SkinTrial/VolumeSkinTrialUI_" .. slot0.params_.skinTrialID
end

function slot0.RefreshUI(slot0)
	slot3 = ActivitySkinTrialCfg[slot0.skinTrialID_].trial_id
	slot5 = HeroStandardSystemCfg[slot3].hero_id
	slot0.heroNameText_.text = string.format("%s·%s", HeroCfg[slot5].name, HeroCfg[slot5].suffix)
	slot0.skinDescText_.text = SkinCfg[HeroStandardSystemCfg[slot3].skin_id].desc

	slot0:RefreshReward()
end

return slot0
