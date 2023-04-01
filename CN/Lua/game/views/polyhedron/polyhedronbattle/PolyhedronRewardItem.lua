slot0 = class("PolyhedronRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeController = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.artifactFrameController = ControllerUtil.GetController(slot0.transform_, "artifactFrame")
	slot0.shopControlle = ControllerUtil.GetController(slot0.transform_, "shop")
	slot0.shopDiscountControlle = ControllerUtil.GetController(slot0.transform_, "shopDiscount")
	slot0.attackTypeController = ControllerUtil.GetController(slot0.transform_, "attackType")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.index)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index = slot3
	slot0.data = slot2
	slot0.polyhedronInfo = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot2 = slot0.data.params

	if slot0.data.class == PolyhedronConst.ITEM_TYPE.ARTIFACT then
		slot0.typeController:SetSelectedState("Artifact")

		slot4 = PolyhedronArtifactCfg[slot2[1]]
		slot5 = slot4.affix_id
		slot0.m_name.text = getAffixName({
			slot5,
			1
		})
		slot0.m_desLab.text = getAffixDesc({
			slot5,
			1
		})
		slot0.m_ArtifactIcon.sprite = getSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. slot4.icon)

		if slot4.exclusive_hero_id ~= 0 then
			slot0.artifactFrameController:SetSelectedIndex(1)
		else
			slot0.artifactFrameController:SetSelectedIndex(0)
		end
	elseif slot1 == PolyhedronConst.ITEM_TYPE.ARTIFACT_UP_LEVEL then
		slot0.typeController:SetSelectedState("ArtifactLv")

		slot3 = slot2[1]
		slot4 = PolyhedronArtifactCfg[slot3]
		slot6 = slot0.polyhedronInfo:GetArtifact(slot3) and slot5.level or 1
		slot7 = slot6 + 1
		slot0.m_curLv.text = "LV." .. slot6
		slot0.m_nextLv.text = "LV." .. slot7
		slot8 = slot4.affix_id
		slot0.m_name.text = getAffixName({
			slot8,
			1
		})
		slot0.m_desLab.text = PolyhedronTools.getAffixUpLvDes(slot8, slot6, slot7)
		slot0.m_ArtifactIcon.sprite = getSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. slot4.icon)

		if slot4.exclusive_hero_id ~= 0 then
			slot0.artifactFrameController:SetSelectedIndex(1)
		else
			slot0.artifactFrameController:SetSelectedIndex(0)
		end
	elseif slot1 == PolyhedronConst.ITEM_TYPE.BUFF then
		slot0.typeController:SetSelectedState("buff")

		slot4 = PolyhedronEffectCfg[slot2[1]]
		slot0.m_name.text = slot4.name
		slot0.m_desLab.text = slot4.desc

		slot0.artifactFrameController:SetSelectedIndex(0)

		slot0.m_effectIcon.sprite = getSpriteWithoutAtlas(PolyhedronConst.EFFECT_ATTRIBUTE_ICON_PATH .. slot4.icon)
	elseif slot1 == PolyhedronConst.ITEM_TYPE.COIN then
		slot0.typeController:SetSelectedState("coin")

		slot3 = slot2[1]
		slot6 = ItemCfg[slot0.polyhedronInfo:GetPolyhedronCoinId()]
		slot0.m_name.text = slot6.name
		slot0.m_desLab.text = string.format(GetTips("MATRIX_GET"), slot2[2], slot6.name)

		slot0.artifactFrameController:SetSelectedIndex(0)
	elseif slot1 == PolyhedronConst.ITEM_TYPE.HERO then
		slot0.typeController:SetSelectedState("hero")

		slot3 = slot2[1]
		slot4 = HeroCfg[slot3]
		slot0.m_heroName.text = slot4.name
		slot0.m_heroIcon.sprite = getSpriteWithoutAtlas("Textures/Character/Icon/" .. slot3)

		if slot4.mechanism_type[1] == HeroConst.HERO_CHARGE_TYPE.RAGE then
			slot0.m_heroDes2.text = GetTips("NOTE_ENERGYTYPE_1")
		elseif slot5 == HeroConst.HERO_CHARGE_TYPE.ENERGY then
			slot0.m_heroDes2.text = GetTips("NOTE_ENERGYTYPE_2")
		elseif slot5 == HeroConst.HERO_CHARGE_TYPE.TRACES then
			slot0.m_heroDes2.text = GetTips("NOTE_ENERGYTYPE_3")
		elseif slot5 == HeroConst.HERO_CHARGE_TYPE.DIVINE_GRACE then
			slot0.m_heroDes2.text = GetTips("NOTE_ENERGYTYPE_4")
		end

		if #slot4.ATK_attribute > 1 then
			slot0.attackTypeController:SetSelectedState(-1)
		else
			slot0.attackTypeController:SetSelectedState(slot4.ATK_attribute[1])
		end

		slot0.m_heroDes1.text = HeroStandardSystemCfg[PolyhedronHeroCfg[slot3].standard_id].hero_desc
		slot0.m_campIcon.sprite = getSprite("Atlas/CampItem", RaceEffectCfg[slot4.race].icon)

		slot0.artifactFrameController:SetSelectedIndex(0)
	elseif slot1 == PolyhedronConst.ITEM_TYPE.BLOOD then
		slot0.typeController:SetSelectedState("blood")

		if slot2[1] > 1000 then
			slot3 = 1000
		end

		slot0.m_name.text = ""
		slot0.m_desLab.text = string.format(GetTips("POLYHEDRON_HP_REWARD_TIP"), math.floor(slot3 / 10) .. "%")

		slot0.artifactFrameController:SetSelectedIndex(0)
	end
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectController:SetSelectedIndex(slot1 == slot0.index and 1 or 0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
