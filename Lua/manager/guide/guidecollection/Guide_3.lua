slot0 = class("Guide_3", BaseGuide)

function slot0.InitSteps(slot0)
	slot1 = {}

	slot0:OnGuideStart()
	table.insert(slot1, 301)
	table.insert(slot1, 302)
	table.insert(slot1, 303)

	if HeroData:GetHeroList()[1148] and slot2[1148].level == 1 and slot0:HaveAddHeroExpMaterial() then
		table.insert(slot1, 304)
		table.insert(slot1, 305)
		table.insert(slot1, 306)
	end

	table.insert(slot1, 307)
	table.insert(slot1, 308)

	slot3 = EquipData:GetEquipList()[7]

	if not slot0:HeroExchangeEquip() and slot3 then
		table.insert(slot1, 309)
		table.insert(slot1, 310)
		table.insert(slot1, 311)
		table.insert(slot1, 312)

		if slot3.exp == 0 and slot0:HaveAddEquipExpMaterial() then
			table.insert(slot1, 313)
			table.insert(slot1, 314)
			table.insert(slot1, 315)
			table.insert(slot1, 316)
		end
	end

	table.insert(slot1, 317)

	slot0._steps = {}

	for slot8 = 1, #slot1 do
		if slot0:ProduceStep(slot1[slot8]) then
			table.insert(slot0._steps, slot10)
		end
	end
end

function slot0.HaveAddHeroExpMaterial(slot0)
	for slot4, slot5 in ipairs(GameSetting.hero_exp_props_id_list.value) do
		if MaterialData:GetMaterialList()[slot5] and MaterialData:GetMaterialList()[slot5].num > 0 then
			return true
		end
	end

	return false
end

function slot0.HeroExchangeEquip(slot0)
	if HeroData:GetHeroList()[1148] and slot1[1148].equip then
		for slot5, slot6 in pairs(slot1[1148].equip) do
			if slot6.equip_id and slot6.equip_id ~= 0 and EquipCfg[EquipData:GetEquipData(slot6.equip_id).prefab_id].pos == 1 then
				return true
			end
		end
	end

	return false
end

function slot0.HaveAddEquipExpMaterial(slot0)
	slot4 = ItemConst.ITEM_TYPE.MATERIAL

	for slot4, slot5 in ipairs(ItemCfg.get_id_list_by_type[slot4]) do
		slot7 = ItemCfg[slot5]

		if MaterialData:GetMaterialList()[slot5] and slot7.sub_type == MaterialConst.MATERIAL_TYPE.EQUIP_LEVEL_UP and slot6.num > 0 then
			return true
		end
	end

	return false
end

return slot0
