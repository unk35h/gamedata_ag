slot0 = class("HeroSurpassStarUpView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroSurpass/SurpassStarUp"
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

	slot0.SkillTypeController = ControllerUtil.GetController(slot0.m_stateController, "state")
	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_skillAttributeList, HeroSurpassAttributeItem)
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
	manager.audio:PlayEffect("ui_system", "starsup_small", "")
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.skillAttributeList[slot1])
end

function slot0.Refresh(slot0)
	slot1 = HeroStarCfg[slot0.star]
	slot2 = HeroCfg[slot0.heroId]
	slot0.m_ratingImg.sprite = getSprite("Atlas/Common", "star_" .. slot1.star)

	if slot1.phase == 0 then
		SetActive(slot0.m_ratingNumImg.gameObject, false)
	else
		SetActive(slot0.m_ratingNumImg.gameObject, true)

		slot0.m_ratingNumImg.sprite = getSprite("Atlas/HeroSurpass", "num" .. slot1.phase)
	end

	slot5 = {}

	for slot9, slot10 in ipairs(HeroStarUpTemplateCfg.get_id_list_by_template[slot2.star_up_skill_template]) do
		if HeroStarUpTemplateCfg[slot10].stage == slot0.star then
			slot5 = HeroStarSkillCfg[slot11.skill_id]

			break
		end
	end

	if HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP == slot5.type then
		slot0.SkillTypeController:SetSelectedIndex(0)

		slot0.titleText_.text = GetTips("BASE_PROPERTY_UP")
		slot0.skillAttributeList = slot5.params

		slot0.scrollHelper:StartScroll(#slot0.skillAttributeList)
	elseif HeroConst.HERO_STAR_SKILL_TYPE.SKILL_UP == slot5.type then
		slot0.SkillTypeController:SetSelectedIndex(1)

		slot0.titleText_.text = GetTips("SKILL_LEVEL_UP")

		if #slot5.params == 1 then
			slot6 = HeroCfg[slot0.heroId]
			slot7 = slot5.params[1]
			slot0.m_skillDesText.text = string.format(GetI18NText(slot5.desc), GetI18NText(slot6.skill_subhead[slot7[1]]), GetI18NText(HeroSkillCfg[slot6.skills[slot7[1]]].name), slot7[2])
		else
			slot0.m_skillDesText.text = slot5.desc
		end
	else
		slot0.SkillTypeController:SetSelectedIndex(2)

		slot0.titleText_.text = GetTips("SPECIAL_SKILL")
		slot0.m_skillDesText.text = slot5 and slot5.desc or ""
	end
end

function slot0.OnExit(slot0)
	slot0.ani_:Play("SurpassStarUp_emerge", -1, 0)
	slot0.ani_:Update(0)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
