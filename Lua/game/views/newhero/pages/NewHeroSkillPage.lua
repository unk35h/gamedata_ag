slot1 = class("NewHeroSkillPage", import("game.views.newHero.NewHeroPageBase"))

function slot1.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skillItemGo_ = {}
	slot0.skillItem_ = {}

	for slot4 = 1, 6 do
		slot0.skillItemGo_[slot4] = slot0["skillItem" .. slot4 .. "Go_"]
		slot0.skillItem_[slot4] = HeroSkillItem.New(slot0, slot0.skillItemGo_[slot4])
	end

	slot0.isSelfController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isSelf")
end

function slot1.AddUIListener(slot0)
	for slot4 = 1, 6 do
		slot5 = slot0.skillItem_[slot4]

		slot5:RegistCallBack(function (slot0)
			JumpTools.OpenPageByJump("skillUpgrade", {
				skillId = slot0.id,
				heroId = slot0.heroId,
				extra = uv0.extra_
			})
		end)
	end

	slot0:AddBtnListener(slot0.buttonComboSkill_, nil, function ()
		uv0:Go("/comboSkillInfo", {
			heroID = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.teachingBtn_, nil, function ()
		BattleTeachData:SetCacheTeachHeroID(uv0.heroInfo_.id)

		if HeroCfg[uv0.heroInfo_.id] and slot0.study_stage and slot0.study_stage[1] then
			JumpTools.OpenPageByJump("/teachStage", {
				switchType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
				heroID = uv0.heroInfo_.id
			})
			JumpTools.OpenPageByJump("teachSectionInfo", {
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
				section = slot0.study_stage[1]
			})
		end
	end)
end

function slot1.SetHeroInfo(slot0, slot1)
	if slot0.extra_ then
		if slot0.isForeign_ then
			slot0.heroInfo_ = ForeignInfoData:GetHeroInfo(slot1.id)
		elseif slot0.isTemp_ then
			slot0.heroInfo_ = TempHeroData:GetHeroDataByHeroID(slot0.extra_.tempHeroList, slot1.id)
		elseif slot0.isPreview_ then
			slot0.heroInfo_ = HeroData:GetHeroData(slot1.id)
		elseif slot0.isPolyhedron_ then
			slot0.heroInfo_ = PolyhedronData:GetPolyhedronHeroData(slot1.id)
		end
	else
		slot0.heroInfo_ = HeroData:GetHeroData(slot1.id)
	end

	slot0:UpdateView()
end

function slot1.UpdateView(slot0)
	slot0:RefreshSkillItemS()
	slot0:RefreshTeachRedPoint()
	slot0:RefreshComboSkillBtn()
end

function slot1.RefreshSkillItemS(slot0)
	if slot0.extra_ then
		if slot0.isForeign_ then
			slot0.skillList_ = ForeignInfoData:GetHeroSkillInfo(slot0.heroInfo_.id, slot0.extra_)
		elseif slot0.isTemp_ then
			slot0.skillList_ = TempHeroData:GetHeroSkillInfo(slot0.extra_.tempHeroList, slot0.heroInfo_.id, slot0.extra_)
		elseif slot0.isPreview_ then
			slot0.skillList_ = HeroTools.GetHeroSkillInfo(slot0.heroInfo_.id, slot0.isPreview_)
		elseif slot0.isPolyhedron_ then
			slot0.skillList_ = PolyhedronData:GetHeroSkillInfo(slot0.heroInfo_.id)
		end
	else
		slot0.skillList_ = HeroTools.GetHeroSkillInfo(slot0.heroInfo_.id)
	end

	for slot4 = 1, 6 do
		slot0.skillItem_[slot4]:RefreshData(slot0, slot0.skillList_[slot4], slot0.extra_)
	end
end

function slot1.RefreshTeachRedPoint(slot0)
	manager.redPoint:setTip(RedPointConst.HERO_TEACH_ID, BattleTeachData:GetHeroTeachInfo(slot0.heroInfo_.id, HeroCfg[slot0.heroInfo_.id].study_stage[1]) <= 0 and not slot0.extra_ and 1 or 0)
end

function slot1.RefreshComboSkillBtn(slot0)
	if ComboSkillTools.GetHeroComboSkill(slot0.heroInfo_.id) and #slot1 > 0 then
		SetActive(slot0.goComboSkill_, true)
	else
		SetActive(slot0.goComboSkill_, false)
	end
end

function slot1.OnHeroSkillUpgrade(slot0, slot1, slot2)
	slot0:RefreshSkillItemS()
end

function slot1.OnEnter(slot0, slot1)
	slot0.extra_ = slot1
	slot0.isForeign_ = slot1 and slot1.isForeign
	slot0.isTemp_ = slot1 and slot1.isTemp
	slot0.isPreview_ = slot1 and slot1.isPreview
	slot0.isPolyhedron_ = slot1 and slot1.isPolyhedron

	slot0.isSelfController_:SetSelectedState(slot0.extra_ and "true" or "false")
	slot0:BindRedPointUI()
end

function slot1.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.teachingTrs_, RedPointConst.HERO_TEACH_ID)
end

function slot1.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.teachingTrs_, RedPointConst.HERO_TEACH_ID)
end

function slot1.Dispose(slot0)
	for slot4 = 1, 6 do
		slot0.skillItem_[slot4]:Dispose()
	end

	slot0.skillItem_ = nil

	uv0.super.Dispose(slot0)
end

return slot1
