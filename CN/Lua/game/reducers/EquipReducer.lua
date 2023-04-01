slot0 = import("game.tools.EquipTools")

return function (slot0, slot1)
	if slot0 == nil then
		slot0 = {
			equipBagFull = false,
			equipList = {},
			suitMap = {}
		}
	end

	if ({
		[ACTIONS.EQUIP_INIT] = function (slot0)
			for slot4, slot5 in ipairs(uv0.data) do
				slot0.equipList[slot5.equip_id] = {
					equip_id = slot5.equip_id,
					prefab_id = slot5.prefab_id,
					star = EquipCfg[slot5.prefab_id].starlevel,
					exp = slot5.exp,
					is_lock = slot5.is_lock,
					now_break_level = slot5.now_break_level
				}
				slot0.suitMap[slot6] = slot0.suitMap[EquipCfg[slot5.prefab_id].suit] or {}
				slot0.suitMap[slot6][slot5.equip_id] = true
			end
		end,
		[ACTIONS.APPLY_EQUIP_STRENGTH_SUCCESS] = function (slot0)
			slot3 = uv0.data.usedMaterialList
			slot5 = slot0.equipList[uv0.data.equipID].exp + uv0.data.addExp

			for slot9, slot10 in pairs(uv0.data.usedEquipList) do
				slot0.suitMap[slot12] = slot0.suitMap[EquipCfg[slot0.equipList[slot9].prefab_id].suit] or {}
				slot0.suitMap[slot12][slot9] = nil
				slot0.equipList[slot9] = nil
			end

			slot0.equipList[slot1].exp = slot5
		end,
		[ACTIONS.APPLY_LOCK_EQUIP_SUCCESS] = function (slot0)
			slot1 = uv0.data.equipID
			slot0.equipList[slot1].is_lock = not slot0.equipList[slot1].is_lock
		end,
		[ACTIONS.APPLY_EQUIP_UPGRADE_SUCCESS] = function (slot0)
			slot1 = uv0.data.equipID
			slot3 = EquipCfg[slot0.equipList[slot1].prefab_id]
			slot0.equipList[slot1].now_break_level = slot0.equipList[slot1].now_break_level + 1
			slot0.equipList[slot1].exp = EquipExpCfg[slot3.max_level[slot0.equipList[slot1].now_break_level + 1]]["exp_sum_" .. slot3.starlevel]
		end,
		[ACTIONS.DELETE_EQUIP] = function (slot0)
			slot1 = false

			for slot5, slot6 in pairs(uv0.data.equipList) do
				slot1 = true
				slot0.suitMap[slot8] = slot0.suitMap[EquipCfg[slot0.equipList[slot5].prefab_id].suit] or {}
				slot0.suitMap[slot8][slot5] = nil
				slot0.equipList[slot5] = nil
			end

			if slot1 then
				slot0.equipBagFull = false
			end
		end,
		[ACTIONS.EQUIP_BAG_FULL] = function (slot0)
			slot0.equipBagFull = uv0.data
		end
	})[slot1.type] then
		return immer.produce(slot0, function (slot0)
			uv0[uv1.type](slot0)
		end)
	else
		return slot0
	end
end
