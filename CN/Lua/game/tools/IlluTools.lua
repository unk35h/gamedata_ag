return {
	GetEquipHaveNum = function (slot0)
		if IllustratedData:GetEquipInfo()[slot0] then
			slot2 = 0

			for slot6, slot7 in pairs(slot1.pos_list) do
				if slot7 == 1 then
					slot2 = slot2 + 1
				end
			end

			return slot2
		end

		return 0
	end,
	GetEquipAll = function ()
		slot1 = 0

		for slot5, slot6 in pairs(IllustratedData:GetEquipInfo()) do
			for slot10, slot11 in pairs(slot6.pos_list) do
				if slot11 == 1 then
					slot1 = slot1 + 1
				end
			end
		end

		return slot1
	end,
	GetIllustrationNotRewardList = function ()
		slot1 = {}

		for slot5, slot6 in pairs(IllustratedData:GetIllustrationInfo()) do
			if slot6.is_receive == 0 then
				table.insert(slot1, slot5)
			end
		end

		return slot1
	end
}
