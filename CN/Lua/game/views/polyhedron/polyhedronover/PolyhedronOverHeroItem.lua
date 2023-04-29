slot0 = class("PolyhedronOverHeroItem", ReduxView)

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

	slot0.leaderController = ControllerUtil.GetController(slot0.transform_, "leader")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_servantBtn, nil, function ()
		slot0 = uv0.m_servantGo.transform.position

		if uv0.servant_id == 0 then
			return
		end

		slot1 = ItemCfg[uv0.servant_id].name
		slot5 = WeaponEffectCfg[WeaponServantCfg[uv0.servant_id].effect[1]].simple_description

		if uv0.clickFunc then
			uv0.clickFunc(slot1, slot5, Vector3(0, slot0.y + 0.1, slot0.z))
		end
	end)
	slot0:AddBtnListener(slot0.m_astrolabeBtn1, nil, function ()
		slot0 = uv0.m_astrolabeGo1.transform.position
		slot3 = uv0.using_astrolabe[1]

		uv0.clickFunc(HeroAstrolabeCfg[slot3].name, GetCfgDescription(AstrolabeEffectCfg[slot3].desc[1], 1), Vector3(0, slot0.y, slot0.z))
	end)
	slot0:AddBtnListener(slot0.m_astrolabeBtn2, nil, function ()
		slot0 = uv0.m_astrolabeGo2.transform.position
		slot3 = uv0.using_astrolabe[2]

		uv0.clickFunc(HeroAstrolabeCfg[slot3].name, GetCfgDescription(AstrolabeEffectCfg[slot3].desc[1], 1), Vector3(0, slot0.y, slot0.z))
	end)
	slot0:AddBtnListener(slot0.m_astrolabeBtn3, nil, function ()
		slot0 = uv0.m_astrolabeGo3.transform.position
		slot3 = uv0.using_astrolabe[3]

		uv0.clickFunc(HeroAstrolabeCfg[slot3].name, GetCfgDescription(AstrolabeEffectCfg[slot3].desc[1], 1), Vector3(0, slot0.y, slot0.z))
	end)
	slot0:AddBtnListener(slot0.m_equipBtn1, nil, function ()
		slot0 = uv0.m_equipGo1.transform.position

		if uv0.suitList[1] then
			slot2 = EquipSuitCfg[uv0.suitList[1].id]

			uv0.clickFunc(slot2.name, EquipTools.GetEffectDesc(slot2.suit_effect[1]), Vector3(0, slot0.y, slot0.z))
		end
	end)
	slot0:AddBtnListener(slot0.m_equipBtn2, nil, function ()
		slot0 = uv0.m_equipGo2.transform.position

		if uv0.suitList[2] then
			slot2 = EquipSuitCfg[uv0.suitList[2].id]

			uv0.clickFunc(slot2.name, EquipTools.GetEffectDesc(slot2.suit_effect[1]), Vector3(0, slot0.y, slot0.z))
		end
	end)
	slot0:AddBtnListener(slot0.m_equipBtn3, nil, function ()
		slot0 = uv0.m_equipGo3.transform.position

		if uv0.suitList[3] then
			slot2 = EquipSuitCfg[uv0.suitList[3].id]

			uv0.clickFunc(slot2.name, EquipTools.GetEffectDesc(slot2.suit_effect[1]), Vector3(0, slot0.y, slot0.z))
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.m_heroIcon.sprite = getSpriteViaConfig("HeroLittleIcon", slot2)
	slot4 = PolyhedronHeroCfg[slot2]
	slot5, slot6 = nil

	if slot2 == slot1:GetLeaderHeroId() then
		slot5, slot6 = GetVirtualData(slot4.standard_id)

		slot0.leaderController:SetSelectedIndex(1)
	else
		slot5, slot6 = GetVirtualData(slot4.standard_id)

		slot0.leaderController:SetSelectedIndex(0)
	end

	slot0.using_astrolabe = slot5.using_astrolabe

	for slot10 = 1, 3 do
		slot11 = slot0["m_astrolabeGo" .. slot10]
		slot12 = slot0["m_astrolabeIcon" .. slot10]

		if slot0.using_astrolabe[slot10] and slot13 ~= 0 then
			SetActive(slot11, true)

			if HeroAstrolabeCfg[slot13].hero_astrolabe_suit_id % 10 == 1 then
				slot12.sprite = getSprite("Atlas/Common", "icon_yellow_a")
			elseif slot15 == 2 then
				slot12.sprite = getSprite("Atlas/Common", "icon_red_a")
			else
				slot12.sprite = getSprite("Atlas/Common", "icon_blue_a")
			end
		else
			SetActive(slot11, false)
		end
	end

	slot10 = slot5
	slot0.suitList = slot0:GetEquipSuit(slot10, slot6)

	for slot10 = 1, 3 do
		slot11 = slot0["m_equipGo" .. slot10]
		slot12 = slot0["m_equipIcon" .. slot10]

		if slot0.suitList[slot10] and slot0.suitList[slot10].id and slot13 ~= 0 then
			SetActive(slot11, true)

			slot12.sprite = getSpriteViaConfig("EquipIcon", EquipSuitCfg[slot13].icon)
		else
			SetActive(slot11, false)
		end
	end

	slot0.servant_id = slot5.servant and slot5.servant.id or 0
	slot0.servant_level = slot5.servant and slot5.servant.stage or 1

	if slot0.servant_id == 0 then
		SetActive(slot0.m_servantGo, false)
	else
		SetActive(slot0.m_servantGo, true)

		slot0.m_servantIcon.sprite = ItemTools.getItemSprite(slot0.servant_id)
	end
end

function slot0.GetEquipSuit(slot0, slot1, slot2)
	slot4 = HeroTools.GetIsSuitNumCut(slot1)
	slot5 = {}

	for slot9, slot10 in pairs(slot2) do
		if slot10.equip_id ~= 0 then
			if slot5[EquipCfg[slot10.prefab_id].suit] then
				slot5[slot11.suit].num = slot5[slot11.suit].num + 1
			else
				slot5[slot11.suit] = {
					num = 1,
					id = slot11.suit
				}
			end
		end
	end

	slot6 = {}

	for slot10, slot11 in pairs(slot5) do
		table.insert(slot6, slot11)
	end

	for slot10 = #slot6, 1, -1 do
		if slot6[slot10].num < EquipTools.GetSuitNeedNum(slot6[slot10].id, slot4) then
			table.remove(slot6, slot10)
		end
	end

	return slot6
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

return slot0
