slot0 = singletonClass("BattleBossChallengeAdvanceData")

function slot0.Init(slot0)
	slot0.chooseModeID_ = 0
	slot0.bossData_ = {}
	slot0.lockHero_ = {
		{},
		{},
		{}
	}
	slot0.lastHeroTeam_ = {}
	slot0.cacheHeroTeam_ = {}
	slot0.receiveRewardList_ = {}
	slot0.sortRewardList_ = {}

	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_ADVANCE, 0)
end

function slot0.InitData(slot0, slot1)
	slot0.chooseModeID_ = slot1.advance_id

	for slot5, slot6 in ipairs(slot1.boss_list) do
		slot7 = {}

		for slot11, slot12 in ipairs(slot6.time_index_list) do
			table.insert(slot7, slot12)
		end

		slot8 = {}

		for slot12, slot13 in ipairs(slot6.boss_ai_index_list) do
			table.insert(slot8, slot13)
		end

		slot9 = {}

		for slot13, slot14 in ipairs(slot6.affix_index_list) do
			table.insert(slot9, slot14)
		end

		slot14 = BossConst.TYPE_AFFIX
		slot0.bossData_[slot5] = {
			id = slot6.id,
			templateID = BossChallengeAdvancePoolCfg[slot6.id].boss_id,
			timestamp = slot6.unlock_timestamp,
			maxPoint = slot6.max_point,
			multipleIndex = slot6.diffculty_index,
			condition = {
				[BossConst.TYPE_STAGE] = slot7,
				[BossConst.TYPE_BOSS_AI] = slot8,
				[slot14] = slot9
			}
		}
		slot0.lockHero_[slot5] = {}

		for slot14, slot15 in ipairs(slot6.used_heroes) do
			table.insert(slot0.lockHero_[slot5], slot15)
		end

		slot0.lastHeroTeam_[slot5] = {
			0,
			0,
			0
		}

		for slot14, slot15 in ipairs(slot6.last_heroes_cfg) do
			slot0.lastHeroTeam_[slot5][slot14] = slot15 or 0
		end
	end

	for slot5 = #slot0.bossData_, #slot1.boss_list + 1, -1 do
		slot0.bossData_[slot5] = nil
		slot0.lockHero_[slot5] = {}
		slot0.lastHeroTeam_[slot5] = {}
	end

	slot0.receiveRewardList_ = {}

	for slot5, slot6 in ipairs(slot1.receive_point_list) do
		table.insert(slot0.receiveRewardList_, slot6)
	end

	slot0:SortRewardList()
	slot0:CalcRedPoint()
end

function slot0.GetChooseModeID(slot0)
	return slot0.chooseModeID_
end

function slot0.GetBossList(slot0)
	return slot0.bossData_
end

function slot0.ResetBoss(slot0, slot1)
	slot0.bossData_[slot1].maxPoint = 0
	slot0.lockHero_[slot1] = {}

	slot0:SortRewardList()
	slot0:CalcRedPoint()
end

function slot0.GetMaxPoint(slot0, slot1)
	return slot0.bossData_[slot1].maxPoint or 0
end

function slot0.GetTotalPoint(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.bossData_) do
		slot1 = slot1 + slot6.maxPoint
	end

	return slot1
end

function slot0.GetPointValue(slot0, slot1)
	slot2 = slot0.bossData_[slot1]
	slot4 = BossChallengeAdvanceCfg[slot0.chooseModeID_].difficult_point[slot2.multipleIndex]
	slot8 = BossConst.TYPE_STAGE

	for slot8, slot9 in pairs(slot2.condition[slot8]) do
		slot4 = slot4 + StageChallengeConditionPoolCfg[slot9].point
	end

	slot8 = BossConst.TYPE_BOSS_AI

	for slot8, slot9 in pairs(slot2.condition[slot8]) do
		slot4 = slot4 + BossAIPoolCfg[slot9].point
	end

	slot8 = BossConst.TYPE_AFFIX

	for slot8, slot9 in pairs(slot2.condition[slot8]) do
		slot4 = slot4 + ActivityAffixPoolCfg[slot9].point
	end

	return slot4
end

function slot0.SetBossMultipleIndex(slot0, slot1, slot2)
	slot0.bossData_[slot1].multipleIndex = slot2
end

function slot0.GetBossAffixList(slot0, slot1, slot2)
	return slot0.bossData_[slot1].condition[slot2]
end

function slot0.SetBossCondition(slot0, slot1, slot2, slot3)
	if slot0:IsActiveBossCondition(slot1, slot2, slot3) then
		table.removebyvalue(slot0.bossData_[slot1].condition[slot2], slot3)

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
	return table.keyof(slot0.bossData_[slot1].condition[slot2], slot3) ~= nil
end

function slot0.SetBossConditionStage(slot0, slot1, slot2)
	slot5 = StageChallengeConditionPoolCfg[slot2].condition[1]

	for slot9, slot10 in pairs(slot0.bossData_[slot1].condition[BossConst.TYPE_STAGE]) do
		if slot5 == StageChallengeConditionPoolCfg[slot10].condition[1] then
			table.remove(slot0.bossData_[slot1].condition[slot3], slot9)

			break
		end
	end

	table.insert(slot0.bossData_[slot1].condition[slot3], slot2)
end

function slot0.SetBossConditionAI(slot0, slot1, slot2)
	slot4 = BossAIPoolCfg[slot2]

	for slot8, slot9 in pairs(slot0.bossData_[slot1].condition[BossConst.TYPE_BOSS_AI]) do
		if slot4.group == BossAIPoolCfg[slot9].group then
			table.remove(slot0.bossData_[slot1].condition[slot3], slot8)

			break
		end
	end

	table.insert(slot0.bossData_[slot1].condition[slot3], slot2)
end

function slot0.SetBossAffix(slot0, slot1, slot2)
	slot4 = ActivityAffixPoolCfg[slot2]

	for slot8, slot9 in pairs(slot0.bossData_[slot1].condition[BossConst.TYPE_AFFIX]) do
		if slot4.affix[1] == ActivityAffixPoolCfg[slot9].affix[1] then
			table.remove(slot0.bossData_[slot1].condition[slot3], slot8)

			break
		end
	end

	table.insert(slot0.bossData_[slot1].condition[slot3], slot2)
end

function slot0.SetBossTarget(slot0, slot1, slot2, slot3)
	slot0.bossData_[slot1].multipleIndex = slot2
	slot0.bossData_[slot1].condition = slot3
end

function slot0.GetLockHero(slot0)
	return slot0.lockHero_
end

function slot0.SetCacheHeroTeam(slot0, slot1, slot2)
	slot0.lastHeroTeam_[slot1] = slot2
end

function slot0.GetCacheHeroTeam(slot0, slot1)
	return slot0.lastHeroTeam_[slot1] or {
		0,
		0,
		0
	}
end

function slot0.ModifyReceiveReward(slot0, slot1)
	table.insert(slot0.receiveRewardList_, slot1)
	slot0:SortRewardList()
	slot0:CalcRedPoint()
end

function slot0.ModifyAllReceiveReward(slot0)
	slot2 = slot0:GetTotalPoint()

	for slot6, slot7 in ipairs(BossChallengeAdvanceCfg[slot0.chooseModeID_].reward) do
		if slot7[1] <= slot2 and not table.keyof(slot0.receiveRewardList_, slot7[1]) then
			table.insert(slot0.receiveRewardList_, slot7[1])
		end
	end

	slot0:SortRewardList()
	slot0:CalcRedPoint()
end

function slot0.GetReceiveRewardList(slot0)
	return slot0.receiveRewardList_
end

function slot0.GetSortRewardList(slot0)
	return slot0.sortRewardList_
end

function slot0.SortRewardList(slot0)
	slot1 = slot0:GetTotalPoint()
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot8 = slot0.chooseModeID_

	for slot8, slot9 in ipairs(BossChallengeAdvanceCfg[slot8].reward) do
		if table.keyof(slot0.receiveRewardList_, slot9[1]) then
			table.insert(slot3, slot8)
		elseif slot9[1] < slot1 then
			table.insert(slot2, slot8)
		else
			table.insert(slot4, slot8)
		end
	end

	table.insertto(slot2, slot4)
	table.insertto(slot2, slot3)

	slot0.sortRewardList_ = slot2
end

function slot0.CalcRedPoint(slot0)
	slot2 = slot0:GetTotalPoint()

	for slot6, slot7 in ipairs(BossChallengeAdvanceCfg[slot0.chooseModeID_].reward) do
		if slot7[1] <= slot2 and not table.keyof(slot0.receiveRewardList_, slot7[1]) then
			manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_ADVANCE, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_ADVANCE, 0)
end

return slot0
