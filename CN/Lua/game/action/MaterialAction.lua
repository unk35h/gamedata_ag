slot1 = manager.net

slot1:Bind(17007, function (slot0)
	MaterialData:InitExpiredMaterialList(slot0.invalid_item_list)
end)

slot1 = manager.net

slot1:Bind(17009, function (slot0)
	MaterialData:InitMaterialList(slot0.material_list, slot0.material_list2)
end)

return {
	MaterialModify = function (slot0, slot1, slot2)
		MaterialData:ModifyNum(slot0, slot1, slot2)
	end,
	ApplyEquipStrengthSuccess = function (slot0, slot1, slot2, slot3)
		MaterialData:ApplyEquipStrengthSuccess(slot0, slot1, slot2, slot3)
	end,
	MergeItem = function (slot0, slot1)
		manager.net:SendWithLoadingNew(17016, {
			merge_item_id = slot0,
			merge_item_num = slot1
		}, 17017, uv0.OnMergeResult)
	end,
	OnMergeResult = function (slot0, slot1)
		if isSuccess(slot0.result) then
			MaterialAction.MaterialModify(ItemMergeCfg[slot1.merge_item_id].cost[1][1], -1 * ItemMergeCfg[slot1.merge_item_id].cost[1][2] * slot1.merge_item_num)
			getReward({
				{
					slot1.merge_item_id,
					slot1.merge_item_num
				}
			})
		end
	end,
	ReadExpiredMaterial = function ()
		manager.net:SendWithLoadingNew(17018, {
			nothing = 0
		}, 17019, uv0.OnReadExpiredMaterialCallback)
	end,
	OnReadExpiredMaterialCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {}
			slot3 = {}

			for slot8, slot9 in ipairs(MaterialData:CheckExpiredMaterialList()) do
				slot11 = slot9.num

				if ItemTimeLimitExchangeCfg[slot9.id] then
					if not slot3[slot12.exchange_item[1]] then
						slot3[slot12.exchange_item[1]] = slot12.exchange_item[2] * slot11
					else
						slot3[slot12.exchange_item[1]] = slot3[slot12.exchange_item[1]] + slot12.exchange_item[2] * slot11
					end
				end
			end

			for slot8, slot9 in pairs(slot3) do
				table.insert(slot2, {
					slot8,
					slot9
				})
			end

			getRewardData(slot2)
			MaterialData:ClearExpiredMaterialList()
		else
			ShowTips(GetTips(slot0.result))
		end
	end
}
