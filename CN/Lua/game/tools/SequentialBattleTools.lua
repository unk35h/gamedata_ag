return {
	GetConditionStatus = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			if slot7[1] == 1 then
				table.insert(slot2, uv0.GetRaceConditionStatus(slot0, slot7[2]))
			elseif slot7[1] == 2 then
				table.insert(slot2, uv0.GetMechanismConditionStatus(slot0, slot7[2]))
			elseif slot7[1] == 3 then
				table.insert(slot2, uv0.GetAttackAttributeConditionStatus(slot0, slot7[2]))
			end
		end

		return slot2
	end,
	GetRaceConditionStatus = function (slot0, slot1)
		slot2 = 0

		for slot6, slot7 in pairs(slot0) do
			if HeroCfg[slot7].race == slot1 then
				slot2 = slot2 + 1
			end
		end

		return slot2
	end,
	GetMechanismConditionStatus = function (slot0, slot1)
		slot2 = 0

		for slot6, slot7 in pairs(slot0) do
			if table.keyof(HeroCfg[slot7].mechanism_type, slot1) then
				slot2 = slot2 + 1
			end
		end

		return slot2
	end,
	GetAttackAttributeConditionStatus = function (slot0, slot1)
		slot2 = 0

		for slot6, slot7 in pairs(slot0) do
			if table.keyof(HeroCfg[slot7].ATK_attribute, slot1) then
				slot2 = slot2 + 1
			end
		end

		return slot2
	end,
	CheckHeroTeam = function (slot0, slot1)
		slot7 = slot0
		slot3 = GetTrialHeroList(_, _, slot7)

		for slot7, slot8 in pairs(SequentialBattleData:GetHeroTeam(slot0, slot1)) do
			if slot8.trialID ~= 0 and not table.keyof(slot3, slot8.trialID) then
				slot2[slot7] = {
					trialID = 0,
					heroID = 0
				}
			end
		end

		SequentialBattleAction.SaveEnabledBuff(slot0, slot1)
	end
}
