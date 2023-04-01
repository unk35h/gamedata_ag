slot0 = class("ComboSkillItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1)
	slot2 = ComboSkillCfg[slot1]
	slot3 = HeroSkillCfg[slot2.skill_id]
	slot4 = ComboSkillTools.GetComboSkillLevel(slot1)
	slot0.textLv_.text = GetTips("LEVEL") .. string.format("%s", slot4)
	slot0.textTitle_.text = slot3.name
	slot0.textSkillType_.text = SkillElementCfg[slot3.element_type].name
	slot0.textDesc_.text = GetCfgDescription(slot3.desc[1], slot4)
	slot8 = "ComboSkill"
	slot9 = slot2.skill_id
	slot0.imageIcon_.sprite = getSpriteViaConfig(slot8, slot9)

	for slot8, slot9 in ipairs(slot2.cooperate_role_ids) do
		SetActive(slot0[string.format("goHeroItem%s_", slot8)], true)

		slot0[string.format("imageHeroIcon%s_", slot8)].sprite = getSpriteViaConfig("HeroLittleIcon", slot9)
	end

	for slot8 = #slot2.cooperate_role_ids + 1, 3 do
		SetActive(slot0[string.format("goHeroItem%s_", slot8)], false)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
