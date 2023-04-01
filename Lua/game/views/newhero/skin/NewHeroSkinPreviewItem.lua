slot0 = class("NewHeroSkinPreviewItem", NewHeroSkinItem)

function slot0.SkinState(slot0)
	if slot0:isUnlock(slot0.skinID_) then
		if HeroTools.GetHeroIsUnlock(SkinCfg[slot0.skinID_].hero) == false then
			return 4
		end

		return 3
	else
		if HeroTools.CanChangeSkin(slot0.skinID_) then
			return 3
		end

		if HeroTools.IsSkinOutOfDate(slot0.skinID_) then
			return 2
		end

		return 1
	end
end

return slot0
