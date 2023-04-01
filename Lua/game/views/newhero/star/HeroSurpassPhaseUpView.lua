slot0 = class("HeroSurpassPhaseUpView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroSurpass/SurpassPhaseUp"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.attributeUI = {}

	ComponentBinder.GetInstance():BindCfgUI(slot0.attributeUI, slot0.m_attribute)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_maskButton, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.star = slot0.params_.star
	slot0.heroId = slot0.params_.heroId

	slot0:Refresh()

	if slot0.star == 600 then
		HeroTools.PlayTalk(slot0.heroId, "pro3", 1)
	elseif slot0.star == 500 then
		HeroTools.PlayTalk(slot0.heroId, "pro2", 1)
	else
		HeroTools.PlayTalk(slot0.heroId, "pro1", 1)
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.skillAttributeList[slot1])
end

function slot0.Refresh(slot0)
	slot1 = HeroStarCfg[slot0.star]
	slot2 = HeroCfg[slot0.heroId]
	slot0.m_ratingImg.sprite = getSprite("Atlas/Common", "star_" .. slot1.star)
	slot3 = slot1.star
	slot0.attributeUI.m_atkText.text = slot2.atk_ratio[slot3]
	slot0.attributeUI.m_armText.text = slot2.arm_ratio[slot3]
	slot0.attributeUI.m_staText.text = slot2.sta_ratio[slot3]
	slot0.attributeUI.m_lastAtkText.text = math.max(slot3 - 1, 0) > 0 and slot2.atk_ratio[slot4] or 0
	slot0.attributeUI.m_lastArmText.text = slot4 > 0 and slot2.arm_ratio[slot4] or 0
	slot0.attributeUI.m_lastStaText.text = slot4 > 0 and slot2.sta_ratio[slot4] or 0
	slot7 = {}

	for slot11, slot12 in ipairs(HeroStarUpTemplateCfg.get_id_list_by_template[slot2.star_up_skill_template]) do
		if HeroStarUpTemplateCfg[slot12].stage == slot0.star then
			slot7 = HeroStarSkillCfg[slot13.skill_id]

			break
		end
	end

	if HeroConst.HERO_STAR_SKILL_TYPE.SKILL_UP == slot7.type then
		if #slot7.params == 1 then
			slot8 = HeroCfg[slot0.heroId]
			slot9 = slot7.params[1]
			slot0.m_skillDesText.text = string.format(GetI18NText(slot7.desc), GetI18NText(slot8.skill_subhead[slot9[1]]), GetI18NText(HeroSkillCfg[slot8.skills[slot9[1]]].name), slot9[2])
		else
			slot0.m_skillDesText.text = slot7.desc
		end
	else
		slot0.m_skillDesText.text = slot7 and slot7.desc or ""
	end
end

return slot0
