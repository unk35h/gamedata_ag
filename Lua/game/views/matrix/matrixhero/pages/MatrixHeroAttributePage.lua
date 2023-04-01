slot0 = class("MatrixHeroAttributePage", ReduxView)

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

	slot0.attackTypeController_ = ControllerUtil.GetController(slot0.transform_, "attackType")
	slot0.campController_ = ControllerUtil.GetController(slot0.transform_, "camp")
	slot1 = {
		HeroConst.HERO_ATTRIBUTE.ATK,
		HeroConst.HERO_ATTRIBUTE.ARM,
		HeroConst.HERO_ATTRIBUTE.STA,
		HeroConst.HERO_ATTRIBUTE.CRITICAL
	}
	slot0.propItemList = {}

	for slot5 = 1, 4 do
		slot6 = {}

		ComponentBinder.GetInstance():BindCfgUI(slot6, slot0["m_propItem" .. slot5])

		slot6.m_name.text, slot10, slot6.m_icon.sprite = SkillTools.GetAttr({
			slot1[slot5],
			0
		})
		slot6.attribute = slot1[slot5]

		table.insert(slot0.propItemList, slot6)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.racebtn_, nil, function ()
		JumpTools.OpenPageByJump("heroRaceDetails")
	end)
	slot0:AddBtnListener(slot0.m_moreAttributeBtn, nil, function ()
		JumpTools.OpenPageByJump("heroCommonAttribute", {
			attribute = uv0.att_
		})
	end)
end

function slot0.SetMatirxHeroInfo(slot0, slot1)
	slot0.heroId_ = slot1
	slot0.matrixHeroData = slot0:GetHeroData(slot1)
	slot2 = slot0.matrixHeroData:GetStandardId()
	slot3, slot4 = nil

	if slot0.matrixHeroData:GetIsOwnerHero() then
		slot3, slot4 = GetPracticalData(slot0.matrixHeroData:GetEntrySnapShot())
	else
		slot3, slot4 = GetVirtualData(slot2)
	end

	slot0.heroInfo_ = slot3
	slot0.heroCfg_ = HeroCfg[slot1]
	slot5 = GetMatrixtHeroPracticalAttr(slot3, slot4, slot2, slot0.matrix_activity_id, slot0.matrixHeroData)
	slot8 = slot5[HeroConst.HERO_ATTRIBUTE.STA]
	slot5[HeroConst.HERO_ATTRIBUTE.ATK] = slot5[HeroConst.HERO_ATTRIBUTE.ATK] * (1 + slot5[11] / 1000 + slot5[13] / 1000) + slot5[12]
	slot5[HeroConst.HERO_ATTRIBUTE.ARM] = slot5[HeroConst.HERO_ATTRIBUTE.ARM] * (1 + slot5[21] / 1000) + slot5[22]
	slot0.att_ = slot5

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.m_nameLab.text = slot0.heroCfg_.name
	slot0.m_suffixLab.text = slot0.heroCfg_.suffix

	slot0.campController_:SetSelectedState(tostring(slot0.heroCfg_.race))

	slot0.m_starImg.sprite = getSprite("Atlas/Common", "star_" .. HeroStarCfg[slot0.heroInfo_.star].star)
	slot0.m_rangeTypeLab.text = CharactorParamCfg[slot0.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
	slot0.m_desLab.text = slot0.heroCfg_.hero_desc
	slot3 = slot0.matrixHeroData:GetHeroMaxHP()
	slot0.m_hpLab.text = slot0.matrixHeroData:GetHeroHP() .. "/" .. slot3
	slot0.m_hpProgress.value = slot3 == 0 and 0 or slot2 / slot3

	for slot7, slot8 in ipairs(slot0.propItemList) do
		slot11 = slot0.att_[slot9]

		if PublicAttrCfg[slot8.attribute].percent == 1 then
			slot8.m_number.text = string.format("%.2f", slot11 / 10) .. "%"
		else
			slot8.m_number.text = math.floor(slot11)
		end
	end

	slot0:RefreshChargeType()
	slot0:RefreshAttackType()
end

function slot0.RefreshChargeType(slot0)
	if slot0.heroCfg_.mechanism_type[1] == HeroConst.HERO_CHARGE_TYPE.RAGE then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_1")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.ENERGY then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_2")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.TRACES then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_3")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.DIVINE_GRACE then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_4")
	end
end

function slot0.RefreshAttackType(slot0)
	if #slot0.heroCfg_.ATK_attribute > 1 then
		slot0.attackTypeController_:SetSelectedState(-1)
	else
		slot0.attackTypeController_:SetSelectedState(slot0.heroCfg_.ATK_attribute[1])
	end
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Show(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.handler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

return slot0
