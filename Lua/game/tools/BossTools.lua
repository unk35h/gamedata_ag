return {
	GetLockHero = function ()
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
			return {}
		end

		if slot0 == BossConst.MODE_NORMAL then
			return BattleBossChallengeNormalData:GetLockHero()
		else
			return BattleBossChallengeAdvanceData:GetLockHero()
		end
	end,
	GetCacheHeroTeam = function (slot0)
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NORMAL then
			return BattleBossChallengeNormalData:GetCacheHeroTeam(slot0)
		else
			return BattleBossChallengeAdvanceData:GetCacheHeroTeam(slot0)
		end
	end,
	CheckTimeout = function ()
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
			BattleBossChallengeAction.BossChallengeBackEntrace()
		end
	end,
	GetBossID = function (slot0, slot1)
		if slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
			return StageGroupCfg[BattleBossChallengeNormalData:GetBossList()[slot1]].boss_id
		elseif slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE then
			return BattleBossChallengeAdvanceData:GetBossList()[slot1].templateID
		end
	end,
	GetContID = function (slot0, slot1)
		if slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
			return BattleBossChallengeNormalData:GetBossList()[slot1]
		elseif slot0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE then
			return BattleBossChallengeAdvanceData:GetBossList()[slot1].id
		end
	end
}
