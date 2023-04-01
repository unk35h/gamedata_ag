slot0 = class("PolyhedronHeroSkillPage", NewHeroSkillPage)

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot2 = slot0:GetRealSkillId(slot1)
		slot0.iconImg_.sprite = getSprite("Atlas/" .. slot1.heroId, slot2)
		slot0.nameText_.text = HeroSkillCfg[slot2].name

		SetActive(slot0.upGo_, false)
		slot0:RefreshLv(slot1)

		slot4 = HeroCfg[slot1.heroId]
		slot0.subnameText_.text = slot4.skill_subhead[table.indexof(slot4.skills, slot1.id)]
	end
end

return slot0
