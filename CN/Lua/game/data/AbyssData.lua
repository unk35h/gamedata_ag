slot0 = singletonClass("AbyssData")
slot1, slot2, slot3, slot4, slot5 = nil

function slot0.Init(slot0)
	uv0 = {
		refresh_timestamp = 0,
		layer_reset_time = 0,
		last_version_max_unlock_layer = 1,
		history_max_layer = 1,
		stage_reset_time = 0,
		is_back = false,
		got_layer_reward_list = {},
		layer_info_dic = {}
	}
	uv1 = {}
	uv2 = {
		total = 1,
		version = 0,
		rankList = {},
		myRank = {}
	}
	uv3 = {
		total = 1,
		version = 0,
		rankList = {},
		myRank = {}
	}
	uv4 = 1
end

function slot0.InitFromServer(slot0, slot1)
	uv0 = {
		is_back = slot1.is_back,
		history_max_layer = slot1.history_max_layer,
		layer_reset_time = slot1.layer_reset_time,
		stage_reset_time = slot1.stage_reset_time,
		refresh_timestamp = slot1.refresh_timestamp,
		last_version_max_unlock_layer = slot1.last_version_max_unlock_layer,
		got_layer_reward_list = {},
		layer_info_dic = {}
	}

	for slot5, slot6 in ipairs(slot1.got_layer_reward_list) do
		table.insert(uv0.got_layer_reward_list, slot6)
	end

	for slot5, slot6 in ipairs(slot1.layer_info_list) do
		uv0.layer_info_dic[slot6.layer_id] = slot0:DecodeServerLayerInfo(slot6)
	end
end

function slot0.GetRefreshTimestamp(slot0)
	return uv0.refresh_timestamp
end

function slot0.DecodeServerLayerInfo(slot0, slot1)
	slot2 = {
		layer_id = slot1.layer_id,
		stage_info_list = {},
		stage_info_dic = {},
		boss_stage_info_list = {},
		boss_stage_info_dic = {}
	}

	for slot6, slot7 in ipairs(slot1.stage_info_list) do
		slot8 = {
			stage_id = slot7.stage_id,
			is_completed = slot7.is_completed,
			lock_hero_id_list = {}
		}

		for slot12, slot13 in ipairs(slot7.lock_hero_id_list) do
			table.insert(slot8.lock_hero_id_list, slot13)
		end

		table.insert(slot2.stage_info_list, slot8)

		slot2.stage_info_dic[slot7.stage_id] = slot8
	end

	for slot6, slot7 in ipairs(slot1.boss_stage_info_list) do
		slot8 = {
			stage_id = slot7.stage_id,
			is_completed = slot7.is_completed,
			score = slot7.score,
			phase = slot7.phase,
			boss_hp_rate = slot7.boss_hp_rate,
			team_info_list = {},
			lock_hero_id_list = {}
		}

		function slot12(slot0, slot1)
			return slot1.index < slot0.index
		end

		table.sort(slot7.team_info_list, slot12)

		for slot12, slot13 in ipairs(slot7.team_info_list) do
			slot14 = {
				index = slot13.index,
				block_hero_id_list = {}
			}

			for slot18, slot19 in ipairs(slot13.block_hero_id_list) do
				table.insert(slot14.block_hero_id_list, slot19)
			end

			table.insert(slot8.team_info_list, slot14)
		end

		for slot12, slot13 in ipairs(slot7.lock_hero_id_list) do
			table.insert(slot8.lock_hero_id_list, slot13)
		end

		table.insert(slot2.boss_stage_info_list, slot8)

		slot2.boss_stage_info_dic[slot7.stage_id] = slot8
	end

	return slot2
end

function slot0.UpdateResetTime(slot0, slot1)
	uv0.layer_reset_time = slot1.layer_reset_time
	uv0.stage_reset_time = slot1.stage_reset_time
end

function slot0.UpdateBossInfo(slot0, slot1)
	slot3 = uv0.layer_info_dic[slot1.layer].boss_stage_info_dic[slot1.stage_id]
	slot3.score = slot1.score
	slot3.phase = slot1.phase
	slot3.boss_hp_rate = slot1.boss_hp_rate
	slot3.lock_hero_id_list = {}

	table.insertto(slot3.lock_hero_id_list, slot1.lock_hero_id_list, 1)

	if #slot3.lock_hero_id_list > 0 then
		slot3.is_completed = true
	end

	function slot7(slot0, slot1)
		return slot1.index < slot0.index
	end

	table.sort(slot1.team_info_list, slot7)

	for slot7, slot8 in ipairs(slot1.team_info_list) do
		slot3.team_info_list[slot7] = {
			index = slot8.index,
			block_hero_id_list = {}
		}

		table.insertto(slot3.team_info_list[slot7].block_hero_id_list, slot8.block_hero_id_list)
	end
end

function slot0.UpdateNormalLayerHeroLock(slot0, slot1)
	slot3 = uv0.layer_info_dic[slot1.layer].stage_info_dic[slot1.stage_id]
	slot3.is_completed = true

	table.insertto(slot3.lock_hero_id_list, slot1.lock_hero_id_list, 1)
end

function slot0.UpdateLayerUnlock(slot0, slot1)
	uv0.history_max_layer = slot1.history_max_layer
	slot2 = slot0:DecodeServerLayerInfo(slot1.layer_info)
	uv0.layer_info_dic[slot2.layer_id] = slot2
end

function slot0.GetStageData(slot0, slot1, slot2)
	if not uv0.layer_info_dic[slot1] then
		return nil
	end

	if AbyssCfg[slot1].stage_list[slot2][1] == 3 then
		if slot3.boss_stage_info_dic[slot5[2]] ~= nil then
			return slot3.boss_stage_info_dic[slot5[2]]
		end
	elseif slot3.stage_info_dic[slot5[2]] ~= nil then
		return slot3.stage_info_dic[slot5[2]]
	end

	return nil
end

function slot0.IsLayerBonusGet(slot0, slot1)
	if table.indexof(uv0.got_layer_reward_list, slot1) then
		return true
	end

	return false
end

function slot0.IsLayerComplete(slot0, slot1)
	if not uv0.layer_info_dic[slot1] then
		return false
	end

	slot3 = AbyssCfg[slot1].stage_list
	slot4 = 0
	slot5 = slot2.stage_info_list or {}

	for slot9, slot10 in pairs(slot5) do
		if slot10.is_completed then
			slot4 = slot4 + 1
		end
	end

	slot6 = slot2.boss_stage_info_list or {}

	for slot10, slot11 in pairs(slot6) do
		if slot11.is_completed then
			slot4 = slot4 + 1
		end
	end

	return slot4 >= #slot3
end

function slot0.GetFirstLockLayer(slot0)
	for slot4, slot5 in ipairs(AbyssCfg.all) do
		if not slot0:IsLayerUnlock(slot5) then
			return slot5
		end
	end

	return 1
end

function slot0.IsLayerChallenging(slot0, slot1)
	if not uv0.layer_info_dic[slot1] then
		return false
	end

	slot3 = slot2.stage_info_list or {}

	for slot7, slot8 in ipairs(slot3) do
		if #slot8.lock_hero_id_list > 0 then
			return true
		end
	end

	slot4 = slot2.boss_stage_info_list or {}

	for slot8, slot9 in ipairs(slot4) do
		if #slot9.team_info_list > 0 then
			return true
		end
	end

	slot5 = slot2.boss_stage_info_list or {}

	for slot9, slot10 in ipairs(slot5) do
		if #slot10.lock_hero_id_list > 0 then
			return true
		end
	end

	return false
end

function slot0.IsLayerUnlock(slot0, slot1)
	if slot1 == 1 then
		return true
	end

	if uv0.last_version_max_unlock_layer > 1 and slot1 <= uv0.last_version_max_unlock_layer then
		return true
	end

	if uv0.layer_info_dic[slot1] ~= nil then
		return true
	end

	return false
end

function slot0.GetLayerStatus(slot0, slot1)
	if slot0:IsLayerComplete(slot1) then
		return 3
	end

	if slot0:IsLayerChallenging(slot1) then
		return 2
	end

	if slot0:IsLayerUnlock(slot1) then
		return 1
	end

	return 0
end

function slot0.GetStageScore(slot0, slot1, slot2)
	if not uv0.layer_info_dic[slot1] then
		return 0
	end

	slot5 = AbyssCfg[slot1].stage_list[slot2]
	slot6 = slot5[2]

	if slot5[1] == 3 then
		if not slot3.boss_stage_info_dic[slot6] then
			return 0
		end

		return slot7.score or 0
	else
		if not slot3.stage_info_dic[slot6] then
			return 0
		end

		slot8 = nil

		return (not slot7.is_completed or slot5[3]) and 0
	end
end

function slot0.GetLayerScore(slot0, slot1)
	slot3 = 0

	for slot7, slot8 in ipairs(AbyssCfg[slot1].stage_list) do
		slot3 = slot3 + slot0:GetStageScore(slot1, slot7)
	end

	return slot3
end

function slot0.GetCurrentLayer(slot0)
	for slot4 = #AbyssCfg.all, 1, -1 do
		if slot0:IsLayerUnlock(AbyssCfg.all[slot4]) then
			return slot5
		end
	end

	return 1
end

function slot0.GetAbandonHeroList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0.layer_info_dic) do
		for slot10, slot11 in pairs(slot6.boss_stage_info_dic) do
			for slot15, slot16 in pairs(slot11.team_info_list) do
				for slot20, slot21 in ipairs(slot16.block_hero_id_list) do
					table.insert(slot1, slot21)
				end
			end
		end
	end

	return slot1
end

function slot0.GetLockedHeroList(slot0, slot1)
	slot2 = {}

	if not uv0.layer_info_dic[slot1] then
		return {}
	end

	for slot7, slot8 in pairs(uv0.layer_info_dic[slot1].stage_info_dic) do
		for slot12, slot13 in ipairs(slot8.lock_hero_id_list) do
			table.insert(slot2, slot13)
		end
	end

	for slot7, slot8 in pairs(slot3.boss_stage_info_dic) do
		for slot12, slot13 in ipairs(slot8.lock_hero_id_list) do
			table.insert(slot2, slot13)
		end
	end

	return slot2
end

function slot0.GetLayerResetTime(slot0)
	return uv0.layer_reset_time
end

function slot0.GetLayerResetLimit(slot0)
	return GameSetting.abyss_layer_reset_time.value[1]
end

function slot0.GetStageResetTime(slot0)
	return uv0.stage_reset_time
end

function slot0.GetStageResetLimit(slot0)
	return GameSetting.abyss_stage_reset_time.value[1]
end

function slot0.GetAbyssUnlockLevel(slot0)
	return GameSetting.abyss_unlock_level.value[1]
end

function slot0.IsHeroInAbandonList(slot0, slot1, slot2)
	if table.indexof(slot2, slot1) then
		return slot2[slot3]
	end

	return 0
end

function slot0.IsHeroInLockList(slot0, slot1, slot2)
	if table.indexof(slot2, slot1) then
		return slot2[slot3]
	end

	return 0
end

function slot0.GetCanFightHeroList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(HeroData:GetHeroList()) do
		if slot8.unlock == 1 then
			table.insert(slot2, slot8.id)
		end
	end

	return slot2
end

function slot0.SetHeroTeam(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.GetCachedHero(slot0, slot1)
	slot2 = uv0[slot1] or {}

	return {
		slot2[1] or 0,
		slot2[2] or 0,
		slot2[3] or 0
	}
end

function slot0.GetCanUseCachedHero(slot0, slot1, slot2)
	slot3 = uv0[slot1] or {}
	slot4 = {
		slot3[1] or 0,
		slot3[2] or 0,
		slot3[3] or 0
	}

	if slot2 ~= nil then
		for slot9, slot10 in pairs(slot0:GetLockedHeroList(slot2)) do
			for slot14, slot15 in pairs(slot4) do
				if slot15 == slot10 then
					slot4[slot14] = 0
				end
			end
		end
	end

	for slot9, slot10 in pairs(slot0:GetAbandonHeroList()) do
		for slot14, slot15 in pairs(slot4) do
			if slot15 == slot10 then
				slot4[slot14] = 0
			end
		end
	end

	slot6 = {}

	for slot10, slot11 in pairs(slot4) do
		if slot11 ~= 0 then
			table.insert(slot6, slot11)
		end
	end

	for slot10 = 1, 3 do
		if slot6[slot10] == nil then
			slot6[slot10] = 0
		end
	end

	return slot6
end

function slot0.GetMaxLayer(slot0)
	return uv0.history_max_layer
end

function slot0.GetCanGetLayers(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(AbyssCfg.all) do
		if slot0:GetBonusStatus(slot6) == 1 then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.GetBonusStatus(slot0, slot1)
	if slot0:IsLayerBonusGet(slot1) then
		return 3
	elseif slot1 <= slot0:GetMaxLayer() then
		return 1
	else
		return 2
	end
end

function slot0.OnLayerBonusGet(slot0, slot1)
	table.insertto(uv0.got_layer_reward_list, slot1)
	manager.notify:Invoke(ABYSS_LAYER_BONUS_GET, slot1)
end

function slot0.HaveGetBonusNum(slot0)
	return #uv0.got_layer_reward_list
end

function slot0.OnResetStage(slot0, slot1, slot2, slot3)
	uv0.stage_reset_time = uv0.stage_reset_time - 1

	slot0:ResetStageInfo(slot1, slot2)
	slot0:RemoveLayerAbove(slot1)
	manager.notify:Invoke(ABYSS_STAGE_RESET_TIME_UPDATE, slot1, slot3)
end

function slot0.OnResetLayer(slot0, slot1)
	uv0.layer_reset_time = uv0.layer_reset_time - 1

	for slot6, slot7 in ipairs(AbyssCfg[slot1].stage_list) do
		slot0:ResetStageInfo(slot1, slot6)
		slot0:ClearTeamCache(slot7[2])
	end

	slot0:RemoveLayerAbove(slot1)
	manager.notify:Invoke(ABYSS_LAYER_RESET_TIME_UPDATE, slot1)
end

function slot0.RemoveLayerAbove(slot0, slot1)
	for slot5 = #AbyssCfg.all, 1, -1 do
		if slot1 < AbyssCfg.all[slot5] and uv0.last_version_max_unlock_layer < slot6 then
			uv0.layer_info_dic[slot6] = nil
		end
	end
end

function slot0.ResetStageInfo(slot0, slot1, slot2)
	slot3 = uv0.layer_info_dic[slot1]
	slot5 = AbyssCfg[slot1].stage_list[slot2]
	slot6 = slot5[2]

	if slot5[1] == 3 then
		slot7 = slot3.boss_stage_info_dic[slot6]
		slot7.score = 0
		slot7.is_completed = false
		slot7.phase = 1
		slot7.boss_hp_rate = 1000
		slot7.team_info_list = {}
		slot7.lock_hero_id_list = {}
	else
		slot7 = slot3.stage_info_dic[slot6]
		slot7.is_completed = false
		slot7.lock_hero_id_list = {}
	end
end

function slot0.OnGetRankList(slot0, slot1)
	uv0.rankList = {}

	for slot5, slot6 in ipairs(slot1.rank_list) do
		table.insert(uv0.rankList, slot0:ParseRankData(slot6))
	end

	table.sort(uv0.rankList, function (slot0, slot1)
		return slot0.rank < slot1.rank
	end)

	uv0.myRank = slot0:ParseRankData(slot1.my_rank)
	uv0.total = slot1.total
	uv0.version = slot1.version
end

function slot0.ParseRankData(slot0, slot1)
	slot2 = {
		user_id = slot1.user_id,
		layer = slot1.layer or 0,
		score = slot1.score or 0,
		rank = slot1.rank or 1,
		nick = slot1.nick or "",
		portrait = slot1.portrait or 0,
		frame = slot1.frame or 0,
		timestamp = slot1.timestamp or 0,
		stage_team_info_list = {}
	}

	for slot6, slot7 in ipairs(slot1.stage_team_info_list) do
		slot8 = {
			stage_id = slot7.stage_id,
			lock_hero_list = {},
			team_info_list = {}
		}

		for slot12, slot13 in ipairs(slot7.lock_hero_list) do
			table.insert(slot8.lock_hero_list, {
				hero_id = slot13.hero_id,
				skin_id = slot13.skin_id
			})
		end

		for slot12, slot13 in ipairs(slot7.team_info_list) do
			slot14 = {
				index = slot13.index,
				block_hero_list = {}
			}

			for slot18, slot19 in ipairs(slot13.block_hero_list) do
				table.insert(slot14.block_hero_list, {
					hero_id = slot19.hero_id,
					skin_id = slot19.skin_id
				})
			end

			table.insert(slot8.team_info_list, slot14)
		end

		table.insert(slot2.stage_team_info_list, slot8)
	end

	return slot2
end

function slot0.GetMyRank(slot0)
	return uv0.myRank
end

function slot0.OnGetGuildRankList(slot0, slot1)
	uv0.rankList = {}
	uv0.myRank = nil

	for slot5, slot6 in ipairs(slot1.rank_list) do
		slot7 = slot0:ParseRankData(slot6)

		table.insert(uv0.rankList, slot7)

		if slot7.user_id == tostring(PlayerData:GetPlayerInfo().userID) then
			uv0.myRank = slot7
		end
	end

	table.sort(uv0.rankList, function (slot0, slot1)
		return slot0.rank < slot1.rank
	end)
end

function slot0.GetRankList(slot0)
	return uv0.rankList
end

function slot0.GetGuildRankList(slot0)
	return uv0.rankList
end

function slot0.GetCurRankVersion(slot0)
	return uv0.version
end

function slot0.GetRankLayerHeroList(slot0, slot1, slot2)
	slot3 = slot2 and slot0:GetGuildRankList()[slot1] or slot0:GetRankList()[slot1]
	slot4 = {
		userId = slot3.user_id,
		layer = slot3.layer,
		stageInfos = {}
	}

	for slot8, slot9 in ipairs(slot3.stage_team_info_list) do
		slot14 = slot9.lock_hero_list

		table.insertto(({
			stage_id = slot9.stage_id,
			heroList = {}
		}).heroList, slot14)

		for slot14 = 1, #slot9.team_info_list do
			table.insertto(slot10.heroList, slot9.team_info_list[slot14].block_hero_list)
		end

		table.insert(slot4.stageInfos, slot10)
	end

	return slot4
end

function slot0.GetMyRankData(slot0, slot1)
	if slot1 then
		return uv0.myRank
	else
		return uv1.myRank
	end
end

function slot0.GetRankTotal(slot0)
	return uv0.total
end

function slot0.GetStageAbandonList(slot0, slot1, slot2)
	if not uv0.layer_info_dic[slot1] then
		return {}
	end

	slot4 = slot0:GetStageData(slot1, slot2)
	slot6 = AbyssCfg[slot1].stage_list[slot2]
	slot7 = slot6[2]
	slot8 = {}

	if slot6[1] == 3 then
		for slot12, slot13 in ipairs(slot4.team_info_list) do
			table.insertto(slot8, slot13.block_hero_id_list)
		end
	end

	return slot8
end

function slot0.ClearTeamCache(slot0, slot1)
	uv0[slot1] = nil
end

function slot0.SetCurrentBossPhase(slot0, slot1)
	uv0 = slot1
end

function slot0.GetCurrentBossPhase(slot0)
	return uv0 or 1
end

function slot0.GetBossTotalHp(slot0, slot1)
	if not AbyssBossHpCfg[slot1] then
		return 1
	end

	slot3 = 0

	for slot7, slot8 in ipairs(slot2.boss_hp) do
		slot3 = slot3 + slot8
	end

	return slot3
end

function slot0.GetPhaseBossHp(slot0, slot1, slot2)
	if not AbyssBossHpCfg[slot1] then
		return 1
	end

	return slot3.boss_hp[slot2] or 1
end

function slot0.ConvertPhaseBossHpToTotal(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetPhaseBossHp(slot1, slot2) * slot3 / 1000

	if slot2 ~= #AbyssBossHpCfg[slot1].boss_hp then
		for slot8 = slot2 + 1, #AbyssBossHpCfg[slot1].boss_hp do
			slot4 = slot4 + AbyssBossHpCfg[slot1].boss_hp[slot8]
		end
	end

	return slot4
end

function slot0.OnReadBackFlag(slot0)
	uv0.is_back = false
end

function slot0.NeedTipBack(slot0)
	return uv0.is_back
end

return slot0
