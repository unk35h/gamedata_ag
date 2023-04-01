slot0 = singletonClass("DamageTestData")
slot1 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.SetSelectAffix(slot0, slot1, slot2, slot3)
	if not uv0[slot1] then
		uv0[slot1] = {
			[BossConst.TYPE_STAGE] = {},
			[BossConst.TYPE_BOSS_AI] = {},
			[BossConst.TYPE_AFFIX] = {}
		}
	end

	if slot0:IsActiveBossCondition(slot1, slot2, slot3) then
		table.removebyvalue(uv0[slot1][slot2], slot3)

		return
	end

	if slot2 == BossConst.TYPE_STAGE then
		slot0:SetBossConditionStage(slot1, slot3)
	elseif slot2 == BossConst.TYPE_BOSS_AI then
		slot0:SetBossConditionAI(slot1, slot3)
	else
		slot0:SetBossAffix(slot1, slot3)
	end
end

function slot0.IsActiveBossCondition(slot0, slot1, slot2, slot3)
	return table.keyof(uv0[slot1][slot2], slot3) ~= nil
end

function slot0.SetBossConditionStage(slot0, slot1, slot2)
	slot5 = StageChallengeConditionPoolCfg[slot2].condition[1]

	for slot9, slot10 in pairs(uv0[slot1][BossConst.TYPE_STAGE]) do
		if slot5 == StageChallengeConditionPoolCfg[slot10].condition[1] then
			table.remove(uv0[slot1][slot3], slot9)

			break
		end
	end

	table.insert(uv0[slot1][slot3], slot2)
end

function slot0.SetBossConditionAI(slot0, slot1, slot2)
	slot4 = BossAIPoolCfg[slot2]

	for slot8, slot9 in pairs(uv0[slot1][BossConst.TYPE_BOSS_AI]) do
		if slot4.group == BossAIPoolCfg[slot9].group then
			table.remove(uv0[slot1][slot3], slot8)

			break
		end
	end

	table.insert(uv0[slot1][slot3], slot2)
end

function slot0.SetBossAffix(slot0, slot1, slot2)
	slot4 = ActivityAffixPoolCfg[slot2]

	for slot8, slot9 in pairs(uv0[slot1][BossConst.TYPE_AFFIX]) do
		if slot4.affix[1] == ActivityAffixPoolCfg[slot9].affix[1] then
			table.remove(uv0[slot1][slot3], slot8)

			break
		end
	end

	table.insert(uv0[slot1][slot3], slot2)
end

function slot0.GetAffixList(slot0, slot1, slot2)
	if uv0[slot1] and uv0[slot1][slot2] then
		return uv0[slot1][slot2]
	end

	return {}
end

return slot0
