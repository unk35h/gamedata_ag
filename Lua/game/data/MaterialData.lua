slot0 = singletonClass("MaterialData")
slot1 = {}
slot2 = {}
slot3 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.InitExpiredMaterialList(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1) do
		if slot6.num > 0 then
			table.insert(uv0, {
				id = slot6.id,
				num = slot6.num,
				time_valid = slot6.time_valid
			})
		end
	end
end

function slot0.InitMaterialList(slot0, slot1, slot2)
	uv0 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = slot7.id
		uv0[slot8] = {
			id = slot8,
			num = slot7.num
		}
	end

	uv1 = {}

	for slot6, slot7 in ipairs(slot2) do
		table.insert(uv1, {
			id = slot7.id,
			num = slot7.num,
			time_valid = slot7.time_valid
		})
	end

	manager.notify:Invoke(MATERIAL_INIT)
end

function slot0.ModifyNum(slot0, slot1, slot2, slot3)
	slot4 = nil
	slot5 = slot1
	slot6 = nil

	if (slot3 or 0) == 0 then
		if uv0[slot5] == nil then
			slot4[slot5] = {
				num = 0,
				id = slot5
			}
		end
	else
		slot4 = uv1

		for slot10, slot11 in pairs(uv1) do
			if slot11.id == slot1 and slot11.time_valid == slot3 then
				slot6 = slot11

				break
			end
		end

		if slot6 == nil then
			table.insert(uv1, {
				num = 0,
				id = slot1,
				time_valid = slot3
			})
		end
	end

	slot7 = slot6.num
	slot8 = slot7 + slot2
	slot6.num = slot8

	manager.notify:Invoke(MATERIAL_MODIFY, slot5, slot3, slot8, slot7)

	if slot8 <= 0 then
		if slot3 == nil or slot3 == 0 then
			uv0[slot5] = nil
		else
			for slot12, slot13 in ipairs(uv1) do
				if slot13.time_valid == slot3 and slot13.id == slot1 then
					table.remove(slot13, slot12)

					break
				end
			end
		end

		manager.notify:Invoke(MATERIAL_DELETE, slot5)
		manager.notify:Invoke(MATERIAL_LIST_UPDATE, slot5)
	elseif (slot7 == nil or slot7 == 0) and slot8 > 0 then
		manager.notify:Invoke(MATERIAL_LIST_UPDATE, slot5)
	end
end

function slot0.ApplyEquipStrengthSuccess(slot0, slot1, slot2, slot3, slot4)
	for slot9, slot10 in pairs(slot3) do
		uv0[slot9].num = uv0[slot9].num - slot10

		manager.notify:Invoke(MATERIAL_MODIFY, slot9, 0, uv0[slot9].num, uv0[slot9].num)
	end
end

function slot0.GetMaterialList(slot0)
	return uv0
end

function slot0.GetMaterial(slot0, slot1, slot2)
	slot3 = nil

	if (slot2 or 0) > 0 then
		for slot7, slot8 in pairs(uv0) do
			slot9 = ItemCfg[slot1]

			if slot8.time_valid == slot2 and slot8.id == slot1 then
				return slot8
			elseif slot8.time_valid == slot2 and ItemConst.ITEM_SUB_TYPE.TIME_LIMIT_ITEM == slot9.sub_type and slot9.param ~= "" and slot9.param[1] == slot8.id then
				return slot8
			end
		end

		for slot7, slot8 in pairs(uv1) do
			slot9 = ItemTools.GetItemExpiredTimeByInfo(slot8)

			if slot8.id == slot1 and slot9 == slot2 then
				return slot8
			end
		end

		return nil
	else
		if not uv1[slot1] then
			return {
				num = 0,
				id = slot1
			}
		end

		return slot3[slot1]
	end
end

function slot0.GetMaterialListById(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0) do
		if slot7.id == slot1 then
			table.insert(slot2, slot7)
		end
	end

	for slot6, slot7 in pairs(uv1) do
		if slot7.id == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.GetMaterialListByTypes(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0) do
		if table.indexof(slot1, ItemCfg[slot7.id].type) then
			table.insert(slot2, slot7)
		end
	end

	for slot6, slot7 in pairs(uv1) do
		if table.indexof(slot1, ItemCfg[slot7.id].type) then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.GetMaterialListBySubTypes(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0) do
		if table.indexof(slot1, ItemCfg[slot7.id].sub_type) and slot7.num > 0 then
			table.insert(slot2, slot7)
		end
	end

	for slot6, slot7 in pairs(uv1) do
		if table.indexof(slot1, ItemCfg[slot7.id].sub_type) and slot7.num > 0 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.GetMaterialListExceptTypes(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0) do
		if not ItemCfg[slot7.id] then
			CustomLog.Log(debug.traceback(string.format("matcfg is null, id = %d", slot7.id)))
		end

		if table.indexof(slot1, slot8.type) == nil or slot9 == false then
			table.insert(slot2, slot7)
		end
	end

	for slot6, slot7 in pairs(uv1) do
		if table.indexof(slot1, ItemCfg[slot7.id].type) == nil or slot9 == false then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.CheckExpiredMaterialList(slot0)
	return uv0
end

function slot0.ClearExpiredMaterialList(slot0)
	uv0 = {}
end

function slot0.IsItemInExpiredMaterialList(slot0, slot1)
	for slot5, slot6 in ipairs(uv0) do
		if slot6.id == slot1.id then
			return true
		end
	end

	return false
end

return slot0
