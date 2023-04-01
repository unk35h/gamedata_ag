slot0 = class("ActivityMatrixSelectHeroItem", ReduxView)

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

	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.weaponController = ControllerUtil.GetController(slot0.transform_, "weapon")
	slot0.astrolabeController = ControllerUtil.GetController(slot0.transform_, "astrolabe")
	slot0.equipController = ControllerUtil.GetController(slot0.transform_, "equip")
	slot0.trialController = ControllerUtil.GetController(slot0.transform_, "trial")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_clickBtn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.index)
		end
	end)
end

function slot0.SetStandardData(slot0, slot1)
	slot0.trialController:SetSelectedIndex(1)

	slot3 = HeroTools.GetVirtualHeroByCfg(slot1)
	slot5 = HeroCfg[HeroStandardSystemCfg[slot1].hero_id]
	slot0.m_name.text = slot5.name
	slot0.m_img.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[slot3.skin_id].picture_id)
	slot0.m_raceImg.sprite = getSprite("Atlas/CampItem", RaceEffectCfg[slot5.race].icon)

	if not slot3.servant or slot8.id == 0 then
		slot0.weaponController:SetSelectedIndex(0)
	else
		slot0.weaponController:SetSelectedIndex(1)

		slot0.m_weaponImg.sprite = ItemTools.getItemSprite(slot8.id)
	end

	slot9 = clone(slot3.using_astrolabe)

	table.sort(slot9, function (slot0, slot1)
		return slot0 < slot1
	end)

	slot10 = math.min(3, #slot9)
	slot14 = slot10

	slot0.astrolabeController:SetSelectedIndex(slot14)

	for slot14 = 1, slot10 do
		slot15 = slot0["m_astrolabe" .. slot14]

		if (table.indexof(slot5.astrolabe, HeroAstrolabeCfg[slot9[slot14]].hero_astrolabe_suit_id) or 1) == 1 then
			slot15.sprite = getSprite("Atlas/Common", "icon_yellow_a")
		elseif slot18 == 2 then
			slot15.sprite = getSprite("Atlas/Common", "icon_red_a")
		elseif slot18 == 3 then
			slot15.sprite = getSprite("Atlas/Common", "icon_blue_a")
		end
	end

	slot12 = HeroTools.GetIsSuitNumCut(slot3)
	slot13 = {}

	for slot17, slot18 in pairs(EquipTools.GetConstructVirtualEquips(slot1)) do
		if slot18.equip_id ~= 0 then
			if slot13[EquipCfg[slot18.prefab_id].suit] then
				slot13[slot19.suit].num = slot13[slot19.suit].num + 1
			else
				slot13[slot19.suit] = {
					num = 1,
					id = slot19.suit
				}
			end
		end
	end

	slot14 = {}

	for slot18, slot19 in pairs(slot13) do
		table.insert(slot14, slot19)
	end

	for slot18 = #slot14, 1, -1 do
		if slot14[slot18].num < EquipTools.GetSuitNeedNum(slot14[slot18].id, slot12) then
			table.remove(slot14, slot18)
		end
	end

	slot15 = math.min(3, #slot14)
	slot19 = slot15

	slot0.equipController:SetSelectedIndex(slot19)

	for slot19 = 1, slot15 do
		slot0["m_equip" .. slot19].sprite = getSpriteViaConfig("EquipIcon", EquipSuitCfg[slot14[slot19].id].icon)
	end
end

function slot0.SetData(slot0, slot1)
	slot0.trialController:SetSelectedIndex(0)

	slot0.heroId = slot1
	slot3 = HeroCfg[slot1]
	slot0.m_name.text = slot3.name
	slot0.m_img.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[HeroTools.HeroUsingSkinInfo(slot1).id].picture_id)
	slot0.m_raceImg.sprite = getSprite("Atlas/CampItem", RaceEffectCfg[slot3.race].icon)

	if not WeaponServantData:GetServantDataByUID(HeroData:GetHeroData(slot1).servant_uid) then
		slot0.weaponController:SetSelectedIndex(0)
	else
		slot0.weaponController:SetSelectedIndex(1)

		slot0.m_weaponImg.sprite = ItemTools.getItemSprite(slot6.id)
	end

	slot7 = clone(slot2.using_astrolabe)

	table.sort(slot7, function (slot0, slot1)
		return slot0 < slot1
	end)

	slot8 = math.min(3, #slot7)
	slot12 = slot8

	slot0.astrolabeController:SetSelectedIndex(slot12)

	for slot12 = 1, slot8 do
		slot13 = slot0["m_astrolabe" .. slot12]

		if (table.indexof(slot3.astrolabe, HeroAstrolabeCfg[slot7[slot12]].hero_astrolabe_suit_id) or 1) == 1 then
			slot13.sprite = getSprite("Atlas/Common", "icon_yellow_a")
		elseif slot16 == 2 then
			slot13.sprite = getSprite("Atlas/Common", "icon_red_a")
		elseif slot16 == 3 then
			slot13.sprite = getSprite("Atlas/Common", "icon_blue_a")
		end
	end

	slot10 = HeroTools.GetIsSuitNumCut(slot2)

	for slot15 = #EquipTools.CountActiveSuit(slot2.equip), 1, -1 do
		if slot11[slot15].num < EquipTools.GetSuitNeedNum(slot11[slot15].id, slot10) then
			table.remove(slot11, slot15)
		end
	end

	slot12 = math.min(3, #slot11)
	slot16 = slot12

	slot0.equipController:SetSelectedIndex(slot16)

	for slot16 = 1, slot12 do
		slot0["m_equip" .. slot16].sprite = getSpriteViaConfig("EquipIcon", EquipSuitCfg[slot11[slot16].id].icon)
	end
end

function slot0.SetIndex(slot0, slot1)
	slot0.index = slot1
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectController:SetSelectedIndex(slot0.index == slot1 and 1 or 0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
