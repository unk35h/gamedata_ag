slot0 = singletonClass("HideInfoData")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = {}
slot5 = {}
slot6 = {
	EQUIP = 3,
	HERO = 1,
	WEAPON_SERVANT = 2,
	SKIN = 4
}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = {}
	uv4 = {}
end

function slot0.InitHideData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.hide_list) do
		if slot6.type == uv0.HERO then
			for slot10, slot11 in ipairs(slot6.id_list) do
				uv1[slot11] = true

				if HeroCfg[slot11] then
					if HeroTools.GetHeroSpecServant(slot11) then
						uv2[slot13] = true
					end

					for slot18, slot19 in ipairs(SkinCfg.get_id_list_by_hero[slot11]) do
						uv3[slot19] = true
						uv4[SkinCfg[slot19].portrait] = true
					end
				end
			end
		elseif slot6.type == uv0.WEAPON_SERVANT then
			for slot10, slot11 in ipairs(slot6.id_list) do
				uv2[slot11] = true
			end
		elseif slot6.type == uv0.EQUIP then
			for slot10, slot11 in ipairs(slot6.id_list) do
				uv5[slot11] = true
			end
		elseif slot6.type == uv0.SKIN then
			for slot10, slot11 in ipairs(slot6.id_list) do
				uv3[slot11] = true
				uv4[SkinCfg[slot11].portrait] = true
			end
		end
	end
end

function slot0.GetHeroHideList(slot0)
	return uv0
end

function slot0.GetWeaponServantHideList(slot0)
	return uv0
end

function slot0.GetEquipSuitHideList(slot0)
	return uv0
end

function slot0.GetSkinHideList(slot0)
	return uv0
end

function slot0.GetHeadIconHideList(slot0)
	return uv0
end

return slot0
