slot0 = singletonClass("PassportData")
slot1 = {
	id = 0,
	payLevel = 0,
	isStart = 0,
	nextRefreshTimestamp = 0,
	startTimestamp = 0,
	endTimestamp = 0,
	weeklyGainExp = 0,
	receiveInfo = {}
}

function slot0.Init(slot0)
	uv0.id = 0
	uv0.payLevel = 0
	uv0.nextRefreshTimestamp = 0
	uv0.isStart = 0
	uv0.receiveInfo = {}
	uv0.weeklyGainExp = 0
	uv0.startTimestamp = 0
	uv0.endTimestamp = 0
end

function slot0.InitWithServerData(slot0, slot1)
	uv0.id = slot1.battlepass_list_id
	uv0.payLevel = slot1.pay_level
	uv0.nextRefreshTimestamp = slot1.next_refresh_timestamp
	uv0.isStart = slot1.is_start
	uv0.receiveInfo = {}

	for slot5, slot6 in ipairs(slot1.receive_info) do
		if not uv0.receiveInfo[slot6.id] then
			uv0.receiveInfo[slot6.id] = {}
		end

		table.insert(uv0.receiveInfo[slot6.id], {
			id = slot6.id,
			isPay = slot6.is_pay
		})
	end

	uv0.weeklyGainExp = slot1.weekly_gain_exp
	uv0.startTimestamp = slot1.start_timestamp
	uv0.endTimestamp = slot1.end_timestamp

	manager.notify:Invoke(PASSPORT_INIT, 0)
end

function slot0.GetBonusSuccess(slot0, slot1, slot2)
	if not uv0.receiveInfo[slot1] then
		uv0.receiveInfo[slot1] = {}
	end

	if slot2 == 0 then
		uv0.receiveInfo[slot1] = {
			{
				id = slot1,
				isPay = slot2
			}
		}
	else
		uv0.receiveInfo[slot1] = {
			{
				isPay = 0,
				id = slot1
			},
			{
				isPay = 1,
				id = slot1
			}
		}
	end

	manager.notify:Invoke(GET_BONUS_SUCCESS, slot1)
end

function slot0.HaveGetBonus(slot0, slot1)
	if uv0.receiveInfo[slot1] then
		if uv0.payLevel == 0 then
			for slot5, slot6 in ipairs(uv0.receiveInfo[slot1]) do
				if slot6.isPay == 0 then
					return true
				end
			end

			return false
		else
			slot2 = uv0.receiveInfo[slot1] ~= nil and #uv0.receiveInfo[slot1] == 2

			return slot2
		end
	end

	return false
end

function slot0.HaveReceiveInfo(slot0, slot1)
	if uv0.receiveInfo[slot1] and #uv0.receiveInfo[slot1] > 0 then
		return true
	end

	return false
end

function slot0.MarkAllBonusGet(slot0)
	if uv0.id == 0 then
		return
	end

	for slot5, slot6 in ipairs(BattlePassCfg.get_id_list_by_type[BattlePassListCfg[uv0.id].battlepass_type]) do
		if slot5 <= slot0:GetLevel() then
			if uv0.payLevel == 0 then
				uv0.receiveInfo[slot6] = {
					{
						isPay = 0,
						id = slot6
					}
				}
			else
				uv0.receiveInfo[slot6] = {
					{
						isPay = 0,
						id = slot6
					},
					{
						isPay = 1,
						id = slot6
					}
				}
			end
		end
	end

	manager.notify:Invoke(GET_BONUS_SUCCESS, 0)
end

function slot0.GetLevel(slot0)
	slot1 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP)

	for slot5 = slot0:GetMaxLevel(), 1, -1 do
		if GameLevelSetting[slot5].battlepass_lv_exp_sum <= slot1 then
			return slot5
		end
	end

	return 0
end

function slot0.GetCurrentExp(slot0)
	slot1 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP)

	if slot0:GetLevel() == 0 then
		return slot1
	end

	return slot1 - GameLevelSetting[slot2].battlepass_lv_exp_sum
end

function slot0.GetUpgradeNeedExp(slot0)
	if slot0:GetMaxLevel() <= slot0:GetLevel() then
		return GameLevelSetting[slot0:GetMaxLevel()].battlepass_level_exp
	end

	return GameLevelSetting[slot1 + 1].battlepass_level_exp
end

function slot0.GetCurrentStatus(slot0)
	slot2 = slot0:GetLevel() == slot0:GetMaxLevel() and 0 or slot1 + 1
	slot3 = 0

	if not slot0:IsOpen() then
		return slot3, slot2
	end

	for slot8, slot9 in ipairs(BattlePassCfg.get_id_list_by_type[BattlePassListCfg[uv0.id].battlepass_type]) do
		slot10 = BattlePassCfg[slot9]

		if slot8 <= slot1 then
			if uv0.receiveInfo[slot9] == nil or #uv0.receiveInfo[slot9] == 0 then
				for slot14, slot15 in ipairs(slot10.reward_free) do
					return slot8, slot2
				end

				if slot0:GetPayLevel() > 0 then
					for slot14, slot15 in ipairs(slot10.reward_pay) do
						return slot8, slot2
					end
				end
			elseif slot0:GetPayLevel() > 0 and #uv0.receiveInfo[slot9] == 1 and uv0.receiveInfo[slot9][1].isPay == 0 then
				for slot14, slot15 in ipairs(slot10.reward_pay) do
					return slot8, slot2
				end
			end
		end
	end

	return slot3, slot2
end

function slot0.GetCanGetBonusList(slot0)
	slot1 = slot0:GetLevel()
	slot2 = {}

	if not slot0:IsOpen() then
		return slot2
	end

	for slot7, slot8 in ipairs(BattlePassCfg.get_id_list_by_type[BattlePassListCfg[uv0.id].battlepass_type]) do
		slot9 = BattlePassCfg[slot8]

		if slot7 <= slot1 then
			if uv0.receiveInfo[slot8] == nil then
				for slot13, slot14 in ipairs(slot9.reward_free) do
					table.insert(slot2, slot14)
				end

				if slot0:GetPayLevel() > 0 then
					for slot13, slot14 in ipairs(slot9.reward_pay) do
						table.insert(slot2, slot14)
					end
				end
			elseif slot0:GetPayLevel() > 0 and #uv0.receiveInfo[slot8] == 1 and uv0.receiveInfo[slot8][1].isPay == 0 then
				for slot13, slot14 in ipairs(slot9.reward_pay) do
					table.insert(slot2, slot14)
				end
			end
		end
	end

	return slot2
end

function slot0.BuyedCard(slot0, slot1)
	if slot1 == 201 then
		uv0.payLevel = 201
	elseif slot1 == 202 then
		uv0.payLevel = 202
	elseif slot1 == 203 then
		uv0.payLevel = 202
	end

	manager.notify:Invoke(PASSPORT_BUYED)
end

function slot0.GetRewardStatus(slot0, slot1, slot2)
	slot3 = GameLevelSetting[slot1]
	slot4 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP)
	slot7 = slot0:GetPayLevel() > 0 and "pay" or "free"

	if slot0:HaveGetBonus(slot2) then
		return slot7 .. "HaveGet"
	elseif slot3.battlepass_lv_exp_sum <= slot4 then
		if slot7 == "free" then
			return slot7 .. "CanGet"
		elseif slot0:HaveReceiveInfo(slot2) then
			return slot7 .. "HalfCanGet"
		else
			return slot7 .. "CanGet"
		end
	else
		return slot7 .. "CannotGet"
	end
end

function slot0.GetReceiveInfo(slot0, slot1)
	return uv0.receiveInfo[slot1]
end

function slot0.GetPayLevel(slot0)
	return uv0.payLevel
end

function slot0.GetExpWeekly(slot0)
	return uv0.weeklyGainExp
end

function slot0.GetStartTimestamp(slot0)
	return uv0.startTimestamp
end

function slot0.GetEndTimestamp(slot0)
	return uv0.endTimestamp
end

function slot0.GetId(slot0)
	return uv0.id
end

function slot0.GetCurrentActivityId(slot0)
	return BattlePassListCfg[uv0.id].activity_id
end

function slot0.GetUIRoot(slot0)
	return ActivityTools.GetVersionUIRoot(slot0:GetCurrentActivityId())
end

function slot0.GetMaxLevel(slot0)
	if uv0.id == 0 then
		return 10
	end

	return #BattlePassCfg.get_id_list_by_type[BattlePassListCfg[uv0.id].battlepass_type]
end

function slot0.AddWeeklyExp(slot0, slot1)
	uv0.weeklyGainExp = uv0.weeklyGainExp + slot1
end

function slot0.IsOpen(slot0)
	if uv0.id == 0 then
		return false
	end

	return uv0.isStart == 1
end

function slot0.IsUnlock(slot0)
	return not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.PASSPORT_MAIN)
end

function slot0.GetNextRefreshTimestamp(slot0)
	return uv0.nextRefreshTimestamp
end

return slot0
