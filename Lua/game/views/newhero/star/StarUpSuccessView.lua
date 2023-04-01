slot0 = class("StarUpSuccessView", ReduxView)
slot1 = {
	HeroConst.HERO_ATTRIBUTE.ATK,
	HeroConst.HERO_ATTRIBUTE.ARM,
	HeroConst.HERO_ATTRIBUTE.STA,
	HeroConst.HERO_ATTRIBUTE.CRITICAL
}

function slot0.UIName(slot0)
	return "UI/HeroPromotion/HeroStarUpSuccessUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot3 = HeroCfg[slot1.heroId]
	slot4 = HeroData:GetHeroData(slot1.heroId)
	slot0.iconImg_.sprite = getSprite("Atlas/Common", "star_" .. HeroStarCfg[slot1.newStar].star)
	slot5 = HeroTools.CaculateHeroAttribute(slot4, {}, nil, slot1.oldStar, true, true)
	slot10 = nil
	slot6 = HeroTools.CaculateHeroAttribute(slot4, {}, slot10, slot1.newStar, true, true)

	for slot10 = 1, 3 do
		slot0["textText_" .. slot10].text, slot12, slot0["propIconImg_" .. slot10].sprite = SkillTools.GetAttr({
			uv0[slot10],
			0
		})
		slot0["oldnum" .. slot10 .. "Text_"].text = math.floor(slot5[uv0[slot10]])
		slot0["newnum" .. slot10 .. "Text_"].text = math.floor(slot6[uv0[slot10]])
	end

	slot7 = HeroStarCfg[slot1.oldStar]
	slot10 = 0

	for slot14, slot15 in ipairs(HeroStarUpTemplateCfg.get_id_list_by_template[slot3.star_up_skill_template]) do
		if HeroStarUpTemplateCfg[slot15].stage == slot1.newStar then
			slot10 = slot16.skill_id

			break
		end
	end

	if slot7.star < slot2.star and slot10 ~= 0 then
		SetActive(slot0.upskillGo_, true)

		slot0.upskillText_.text = HeroStarSkillCfg[slot10].desc
	else
		SetActive(slot0.upskillGo_, false)
	end

	if slot7.star < slot2.star then
		if slot2.star == HeroConst.MAX_STAR then
			HeroTools.PlayTalk(slot1.heroId, "pro3")
		elseif slot2.star == HeroConst.MAX_STAR - 1 then
			HeroTools.PlayTalk(slot1.heroId, "pro2")
		else
			HeroTools.PlayTalk(slot1.heroId, "pro1")
		end
	end
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI(slot0.params_)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
