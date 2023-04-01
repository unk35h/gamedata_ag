slot1 = class("NewHeroAstrolabePage", import("game.views.newHero.NewHeroPageBase"))

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

	slot0.infoSGo_ = {}
	slot0.isSelfController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isSelf")
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.adjustBtn_, nil, function ()
		JumpTools.OpenPageByJump("/astrolabeAdjust", {
			heroId = uv0.heroInfo_.id,
			selectPos = {
				0
			}
		})
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
	slot0:RefreshAstrolabeInfo()
	slot0:RefreshAstrolabeEffect()
end

function slot1.SelectItem(slot0, slot1)
	if slot0.extra_ and not slot0.isPreview_ then
		return
	end

	slot2 = slot1:GetItemInfo()

	JumpTools.OpenPageByJump("/astrolabeAdjust", {
		heroId = slot0.heroInfo_.id,
		selectPos = {
			slot2.posX,
			slot2.posY
		},
		extra = slot0.extra_
	})
end

function slot1.RefreshAstrolabeInfo(slot0)
	if slot0.heroInfo_ then
		slot0.currentRace_ = slot0.heroInfo_.id

		if slot0.astrolabeInfoView_ and slot0.lastRace_ and slot0.lastRace_ ~= slot0.currentRace_ then
			SetActive(slot0.infoSGo_[slot0.lastRace_], false)
			slot0.astrolabeInfoView_:Dispose()

			slot0.astrolabeInfoView_ = nil
		end

		if slot0.astrolabeInfoView_ == nil then
			if slot0.infoSGo_[slot0.currentRace_] == nil then
				slot0.infoSGo_[slot0.currentRace_] = Object.Instantiate(Asset.Load("UI/Astrolabe/Race_" .. slot0.currentRace_), slot0.infoTrs_)
			end

			SetActive(slot0.infoSGo_[slot0.currentRace_], true)

			slot0.astrolabeInfoView_ = slot0:GetHeroAstrolabeInfoView().New(slot0, slot0.infoSGo_[slot0.currentRace_])

			slot0.astrolabeInfoView_:RegistCallBack(handler(slot0, slot0.SelectItem))
			slot0.astrolabeInfoView_:ChangeStyle("NoName")

			slot0.lastRace_ = slot0.currentRace_
		end

		slot0.astrolabeInfoView_:RefreshUI(slot0.heroInfo_, slot0.extra_)
		slot0:UpdateNotice()
	end
end

function slot1.GetHeroAstrolabeInfoView(slot0)
	return HeroAstrolabeInfoView
end

function slot1.RefreshAstrolabeEffect(slot0)
	slot3 = #AstrolabeTools.GetAcitveEffect(slot0.heroInfo_.using_astrolabe, slot0.extra_) > 0
	slot4 = ""

	for slot8 = 1, slot2 do
		slot15 = GetI18NText
		slot4 = slot4 .. string.format("<size=32><color=#FFFFFF>%s\n\n</color></size>", slot15(HeroAstrolabeCfg[HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot1[slot8].id][1]].suit_name))

		for slot15 = 1, slot1[slot8].num do
			slot4 = slot4 .. GetI18NText(SkillTools.GetAstrolabeDesc(slot9[slot15], slot0.heroInfo_.id, slot0.extra_)) .. (slot15 == slot11 and "" or "\n\n")
		end

		slot4 = slot4 .. (slot8 == slot2 and "" or "\n\n")
	end

	SetActive(slot0.nullGo_, not slot3)
	SetActive(slot0.desGo_, slot3)

	slot0.desText_.text = slot4
end

function slot1.OnTop(slot0)
	slot0:UpdateNotice()
end

function slot1.UpdateNotice(slot0)
	if not slot0.isPreview_ then
		SetActive(slot0.noticeGo_, AstrolabeTools.GetIsHaveCanUnlock(slot0.heroInfo_.id))
	end
end

function slot1.OnEnter(slot0, slot1)
	slot0.extra_ = slot1
	slot0.isForeign_ = slot1 and slot1.isForeign
	slot0.isTemp_ = slot1 and slot1.isTemp
	slot0.isPreview_ = slot1 and slot1.isPreview

	if slot0.astrolabeInfoView_ then
		slot0.astrolabeInfoView_:OnEnter(slot0.extra_)
	end

	slot0.isSelfController_:SetSelectedState(slot0.extra_ and "true" or "false")
end

function slot1.OnExit(slot0)
	if slot0.astrolabeInfoView_ then
		slot0.astrolabeInfoView_:OnExit()
	end
end

function slot1.Hide(slot0)
	uv0.super.Hide(slot0)
	HeroTools.StopTalk()
end

function slot1.Dispose(slot0)
	if slot0.astrolabeInfoView_ then
		slot0.astrolabeInfoView_:Dispose()

		slot0.astrolabeInfoView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
