slot0 = singletonClass("BattleBossChallengeNormalData")

function slot0.Init(slot0)
	slot0.areaID_ = 1
	slot0.bossList_ = {}
	slot0.bossUnlockTimeList_ = {
		0,
		0,
		0
	}
	slot0.finishIndex_ = {
		0,
		0,
		0
	}
	slot0.lockHero_ = {
		{},
		{},
		{}
	}
	slot0.lastHeroTeam_ = {}
	slot0.cacheHeroTeam_ = {}
	slot0.usedCnt_ = 0
	slot0.threeStarList_ = {}
	slot0.receiveStarList_ = {}
	slot0.selectDifficult_ = {}
end

slot1 = -1
slot2 = 0

function slot0.InitData(slot0, slot1)
	slot0.threeStarList_ = {}

	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_NORMAL, 0)

	slot0.receiveStarList_ = {}
	slot0.areaID_ = slot1.area_id == 0 and 1 or slot1.area_id

	slot0:SetUsedCnt(slot1.use_times)

	slot0.bossList_ = {}

	for slot5, slot6 in ipairs(slot1.receive_star_list) do
		slot0.receiveStarList_[slot5] = slot6
	end

	for slot5, slot6 in ipairs(slot1.boss_challenge_list) do
		slot0.bossList_[slot5] = slot6.group_id
		slot0.bossUnlockTimeList_[slot5] = slot6.unlock_timestamp or 0
		slot0.finishIndex_[slot5] = (table.keyof(StageGroupCfg[slot6.group_id].stage_list, slot6.finish_stage) or 0) + 1

		if BossChallengeCfg[slot0.areaID_].level_amount < slot0.finishIndex_[slot5] then
			slot0.finishIndex_[slot5] = BossChallengeCfg[slot0.areaID_].level_amount
		end

		slot0.lockHero_[slot5] = {}

		for slot10, slot11 in ipairs(slot6.used_heroes) do
			table.insert(slot0.lockHero_[slot5], slot11)
		end

		slot0.lastHeroTeam_[slot5] = {
			0,
			0,
			0
		}

		for slot10, slot11 in ipairs(slot6.last_heroes_cfg) do
			slot0.lastHeroTeam_[slot5][slot10] = slot11 or 0
		end

		for slot10, slot11 in ipairs(slot6.star_info) do
			slot0.threeStarList_[slot11.stage_id] = {}

			slot0:ClientModifyThreeStar(slot11.stage_id, slot11.star_list)
		end
	end

	slot0.selectDifficult_ = {}
	slot2 = StageTools.CalcBossChallengeStar()

	if uv0 > 0 then
		print(slot2)

		if math.floor(slot2 % 3) == 0 and uv1 < slot2 then
			SendMessageManagerToSDK("bossrush_star", {
				curStarCnt = slot2
			})
		end
	end

	uv0 = 1
	uv1 = slot2
end

function slot0.GetBossChallengeCfg(slot0)
	return BossChallengeCfg[slot0.areaID_]
end

function slot0.GetStageList(slot0, slot1, slot2)
	return StageGroupCfg[slot0.bossList_[slot1]].stage_list[slot2]
end

function slot0.GetBossList(slot0)
	return slot0.bossList_
end

function slot0.GetBossUnlockTime(slot0, slot1)
	return slot0.bossUnlockTimeList_[slot1] or 0
end

function slot0.ResetBoss(slot0, slot1)
	for slot6, slot7 in ipairs(StageGroupCfg[slot0.bossList_[slot1]].stage_list) do
		slot0.threeStarList_[slot7] = {
			0,
			0,
			0
		}
	end

	slot0.finishIndex_[slot1] = 1
	slot0.lockHero_[slot1] = {}
	slot0.lastHeroTeam_[slot1] = {
		0,
		0,
		0
	}
	slot0.selectDifficult_[slot1] = 1

	slot0:CalcRedPoint()
end

function slot0.GetFinishIndex(slot0, slot1)
	return slot0.finishIndex_[slot1]
end

function slot0.SetUsedCnt(slot0, slot1)
	slot0.usedCnt_ = slot1
end

function slot0.GetUsedCnt(slot0)
	return slot0.usedCnt_
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

function slot0.SetSelectDifficult(slot0, slot1, slot2)
	slot0.selectDifficult_[slot1] = slot2
end

function slot0.GetSelectDifficult(slot0, slot1)
	return slot0.selectDifficult_[slot1] or slot0.finishIndex_[slot1]
end

function slot0.GetThreeStarList(slot0)
	return slot0.threeStarList_
end

function slot0.GetStarList(slot0, slot1)
	return slot0.threeStarList_[slot1] or {
		0,
		0,
		0
	}
end

function slot0.ClientModifyThreeStar(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		slot0.threeStarList_[slot1][slot6] = slot0.threeStarList_[slot1][slot6] == 1 and 1 or slot7
	end

	slot0:CalcRedPoint()
end

function slot0.GetReceiveStarList(slot0)
	return slot0.receiveStarList_
end

function slot0.SetReceiveStarList(slot0, slot1)
	table.insert(slot0.receiveStarList_, slot1)
	slot0:CalcRedPoint()
end

function slot0.CalcRedPoint(slot0)
	slot1 = StageTools.CalcBossChallengeStar()

	for slot6, slot7 in ipairs(slot0:GetBossChallengeCfg().reward) do
		if slot7[1] <= slot1 and not table.keyof(slot0.receiveStarList_, slot7[1]) then
			manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_NORMAL, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_NORMAL, 0)
end

return slot0
