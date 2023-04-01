slot0 = class("HeroPreviewPropertyPage", NewHeroPageBase)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.campController_ = ControllerUtil.GetController(slot0.infoViewGo_.transform, "camp")
	slot0.attackTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "attackType")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.campBgBtn_, nil, function ()
		JumpTools.OpenPageByJump("heroRaceDetails")
	end)
end

function slot0.SetHeroInfo(slot0, slot1)
	slot2 = slot0.heroInfo_
	slot0.heroInfo_ = HeroData:GetHeroData(slot1.id)

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.heroCfg_ = HeroCfg[slot0.heroInfo_.id]
	slot0.nameText_.text = slot0.heroCfg_.name
	slot0.subNameText_.text = slot0.heroCfg_.suffix
	slot0.friendlyDescText_.text = slot0.heroCfg_.hero_desc
	slot0.starImg_.sprite = getSprite("Atlas/Common", "star_" .. HeroStarCfg[slot0.heroCfg_.unlock_star].star)
	slot0.rangeTypeText_.text = CharactorParamCfg[slot0.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")

	if slot0.heroCfg_.mechanism_type[1] == HeroConst.HERO_CHARGE_TYPE.RAGE then
		slot0.compatTypeText_.text = GetTips("NOTE_ENERGYTYPE_1")
	elseif slot2 == HeroConst.HERO_CHARGE_TYPE.ENERGY then
		slot0.compatTypeText_.text = GetTips("NOTE_ENERGYTYPE_2")
	elseif slot2 == HeroConst.HERO_CHARGE_TYPE.TRACES then
		slot0.compatTypeText_.text = GetTips("NOTE_ENERGYTYPE_3")
	elseif slot2 == HeroConst.HERO_CHARGE_TYPE.DIVINE_GRACE then
		slot0.compatTypeText_.text = GetTips("NOTE_ENERGYTYPE_4")
	end

	if #slot0.heroCfg_.ATK_attribute > 1 then
		slot0.attackTypeController_:SetSelectedState(-1)
	else
		slot0.attackTypeController_:SetSelectedState(slot0.heroCfg_.ATK_attribute[1])
	end

	slot0.campController_:SetSelectedState(tostring(slot0.heroCfg_.race))
end

function slot0.PlayEnterAni(slot0)
	slot0.playableDirector_ = slot0.playableDirector_ or slot0:FindCom(typeof(PlayableDirector), "panel")

	if slot0.playableDirector_ then
		slot0.playableDirector_.time = 0

		slot0.playableDirector_:Play()
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.OnHeroModify(slot0, slot1)
	if slot1 == slot0.heroInfo_.id then
		slot0:UpdateView()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.heroInfoView_ then
		slot0.heroInfoView_:Dispose()

		slot0.heroInfoView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
