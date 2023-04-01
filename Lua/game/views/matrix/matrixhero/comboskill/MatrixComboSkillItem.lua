slot0 = class("MatrixComboSkillItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1)
	slot2 = ComboSkillCfg[slot1]
	slot3 = HeroSkillCfg[slot2.skill_id]
	slot0.textLv_.text = string.format("")
	slot0.textTitle_.text = slot3.name
	slot0.textSkillType_.text = ""
	slot0.textDesc_.text = GetCfgDescription(slot3.desc[1], 1)
	slot8 = slot2.skill_id
	slot7 = SpritePathCfg.ComboSkill.path .. slot8
	slot0.m_icon.sprite = getSpriteWithoutAtlas(slot7)

	for slot7, slot8 in ipairs(slot2.cooperate_role_ids) do
		SetActive(slot0[string.format("goHeroItem%s_", slot7)], true)

		slot0[string.format("imageHeroIcon%s_", slot7)].sprite = getSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. slot8)
	end

	for slot7 = #slot2.cooperate_role_ids + 1, 3 do
		SetActive(slot0[string.format("goHeroItem%s_", slot7)], false)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
