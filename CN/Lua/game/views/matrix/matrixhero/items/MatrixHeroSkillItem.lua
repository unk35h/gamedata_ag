slot1 = class("MatrixHeroSkillItem", import("game.views.newHero.items.HeroSkillItem"))

function slot1.RefreshLv(slot0, slot1)
	slot0.lvText_.text = string.format("%d", slot1.lv + slot1.addSkillLv)
end

function slot1.GetRealSkillId(slot0, slot1)
	return SkillTools.GetRealSkillIdByWeaponServantId(slot1.heroId, slot1.servantId, slot1.id)
end

return slot1
