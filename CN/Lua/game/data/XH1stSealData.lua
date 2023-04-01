slot0 = singletonClass("XH1stSealData")
slot1 = nil
slot2 = {
	[0] = {
		11,
		22,
		33
	},
	{
		11,
		21,
		31
	},
	{
		12,
		22,
		32
	},
	{
		13,
		23,
		33
	},
	{
		13,
		22,
		31
	},
	[10] = {
		11,
		12,
		13
	},
	[20] = {
		21,
		22,
		23
	},
	[30] = {
		31,
		32,
		33
	}
}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.OnServerData(slot0, slot1)
	for slot6, slot7 in ipairs(slot1.ticket_list) do
		slot11 = {}
		uv0[slot7.ticket_id] = {
			stamp_list = {},
			stamp_number_dic = {},
			reward_list = {},
			reward_number_dic = slot11
		}

		for slot11, slot12 in ipairs(slot7.stamp_list) do
			table.insert(uv0[slot7.ticket_id].stamp_list, slot0:ParseCoordinateInfo(slot12))

			uv0[slot7.ticket_id].stamp_number_dic[slot0:GetCoordinateNumber(slot12.row, slot12.column)] = 1
		end

		for slot11, slot12 in ipairs(slot7.reward_list) do
			table.insert(uv0[slot7.ticket_id].reward_list, slot0:ParseCoordinateInfo(slot12))

			uv0[slot7.ticket_id].reward_number_dic[slot0:GetCoordinateNumber(slot12.row, slot12.column)] = 1
		end
	end

	manager.notify:Invoke(XH1ST_SEAL_UPDATE, {})
end

function slot0.GetCurrentTicket(slot0)
	for slot5 = #ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list, 1, -1 do
		if uv0[slot1[slot5]] then
			return slot6
		end
	end

	return ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list[1]
end

function slot0.IsTicketFinish(slot0, slot1)
	if not uv0[slot1] then
		return false
	end

	return #uv0[slot1].stamp_list + #uv0[slot1].reward_list >= #ActivitySealTicketCfg.get_id_list_by_ticket_id[slot1]
end

function slot0.GetCanGetRewardList(slot0, slot1)
	if not uv0[slot1] then
		return {}
	end

	slot2 = uv0[slot1]
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in pairs(uv1) do
		if not slot2.reward_number_dic[slot8] then
			slot10 = true

			for slot14, slot15 in ipairs(slot9) do
				if not slot2.stamp_number_dic[slot15] then
					slot10 = false

					break
				end
			end

			if slot10 then
				slot11 = {}

				table.insertto(slot11, slot9)
				table.insert(slot3, slot8)
				table.insert(slot4, slot11)
			end
		end
	end

	return slot3, slot4
end

function slot0.ParseCoordinateInfo(slot0, slot1)
	return {
		row = slot1.row,
		column = slot1.column
	}
end

function slot0.GetCoordinateNumber(slot0, slot1, slot2)
	return 10 * slot1 + slot2
end

function slot0.HaveGotSeal(slot0, slot1, slot2, slot3)
	if not uv0[slot1] then
		return false
	end

	return uv0[slot1].stamp_number_dic[slot0:GetCoordinateNumber(slot2, slot3)] == 1
end

function slot0.HaveGotReward(slot0, slot1, slot2, slot3)
	if not uv0[slot1] then
		return false
	end

	return uv0[slot1].reward_number_dic[slot0:GetCoordinateNumber(slot2, slot3)] == 1
end

function slot0.IsUnLock(slot0, slot1)
	if slot1 == 1 then
		return true
	end

	if not ActivitySealTicketCfg.get_id_list_by_ticket_id[slot1 - 1] then
		return false
	end

	for slot6, slot7 in ipairs(slot2) do
		if ActivitySealTicketCfg[slot7].is_main_reward == 1 and slot0:HaveGotReward(slot1 - 1, slot8.row, slot8.column) then
			return true
		end
	end

	return false
end

function slot0.DecodeCoordinateNumber(slot0, slot1)
	return {
		math.floor(slot1 / 10),
		slot1 % 10
	}
end

function slot0.OnSealSuccess(slot0, slot1, slot2, slot3)
	if not uv0[slot1] then
		slot0:InitTicket(slot1)
	end

	slot4 = false
	uv0[slot1].stamp_number_dic[slot0:GetCoordinateNumber(slot2, slot3)] = 1

	table.insert(uv0[slot1].stamp_list, {
		row = slot2,
		column = slot3
	})

	slot5, slot6 = slot0:GetCanGetRewardList(slot1)
	slot7 = {}
	slot8 = {}

	for slot12, slot13 in ipairs(slot5) do
		slot14 = slot0:DecodeCoordinateNumber(slot13)

		for slot19, slot20 in ipairs(ActivitySealTicketCfg.get_id_list_by_ticket_id[slot1]) do
			if ActivitySealTicketCfg[slot20].row == slot14[1] and slot21.column == slot14[2] then
				slot4 = slot21.is_main_reward == 1

				if slot21.is_main_reward == 1 and slot1 < #ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list then
					ShowTips(string.format(GetTips("XH1ST_SEAL_UNLOCK_NEXT_TICKET_TIP"), slot1 + 1))
				end

				slot26 = slot14[1]
				uv0[slot1].reward_number_dic[slot0:GetCoordinateNumber(slot26, slot14[2])] = 1
				slot25 = {
					row = slot2,
					column = slot3
				}

				table.insert(uv0[slot1].reward_list, slot25)

				for slot25, slot26 in ipairs(slot21.reward_item_list) do
					table.insert(slot7, slot26)
				end
			end
		end
	end

	manager.notify:Invoke(XH1ST_SEAL_UPDATE, {})

	return mergeReward(slot7), slot4, slot6
end

function slot0.ResetTicket(slot0)
	slot1 = ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list

	slot0:InitTicket(slot1[#slot1])
	manager.notify:Invoke(XH1ST_SEAL_UPDATE, {})
end

function slot0.InitTicket(slot0, slot1)
	uv0[slot1] = {
		stamp_list = {},
		stamp_number_dic = {},
		reward_list = {},
		reward_number_dic = {}
	}
end

return slot0
