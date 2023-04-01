GuildActivityRankStruct = class("GuildActivityRankStruct")

function GuildActivityRankStruct.Ctor(slot0, slot1)
	slot0.score = slot1.damage
	slot0.user_id = slot1.uid
	slot0.nick = slot1.name
	slot0.icon = slot1.icon
	slot0.icon_frame = slot1.icon_frame
	slot0.time_stamp = slot1.timestamp
	slot0.select_hero_id_list = {}
	slot2 = ipairs
	slot4 = slot1.hero_list or {}

	for slot5, slot6 in slot2(slot4) do
		table.insert(slot0.select_hero_id_list, slot6)
	end
end

slot0 = singletonClass("GuildActivityData")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = {}
slot5 = 0

function slot0.Init(slot0)
	uv0 = 0
	uv1 = {}
	uv2 = {
		benchmark_time = 0,
		current_grid = 1,
		is_init_hero_list = 0,
		spawn_id_list = {},
		grid_list = {},
		talent_list = {},
		receive_list = {},
		grid_dic = {},
		hero_list = {},
		max_node_id = ActivityClubCfg.all[#ActivityClubCfg.all]
	}
end

function slot0.InitMainDataFromServer(slot0, slot1)
	uv0 = {
		current_grid = slot1.stay_id,
		last_receive_time = slot1.last_receive_time,
		is_init_hero_list = slot1.is_init_hero_list,
		benchmark_time = slot1.benchmark_time,
		hero_list = {},
		hero_dic = {}
	}

	for slot5, slot6 in ipairs(slot1.hero_list) do
		slot7 = {
			id = slot6.id,
			fatigue = slot6.fatigue,
			last_update_time = slot6.last_update_time
		}
		uv0.hero_dic[slot6.id] = slot7

		table.insert(uv0.hero_list, slot7)
	end

	uv0.spawn_id_list = {}

	for slot5, slot6 in ipairs(slot1.spawn_id_list) do
		if not table.indexof(uv0.spawn_id_list, slot6) then
			table.insert(uv0.spawn_id_list, slot6)
		end
	end

	function slot5(slot0, slot1)
		return slot0 < slot1
	end

	table.sort(uv0.spawn_id_list, slot5)

	uv0.grid_dic = {}

	for slot5, slot6 in ipairs(slot1.grid_list) do
		slot7 = {
			id = slot6.id,
			occupied_timestamp = slot6.occupied_timestamp,
			processing_type = slot6.processing_type,
			processing_timestamp = slot6.processing_timestamp,
			elite_health_rate = slot6.elite_health_rate
		}
		uv0.grid_dic[slot7.id] = slot7
	end

	uv0.talent_list = {}

	for slot5, slot6 in ipairs(slot1.talent_list) do
		uv0.talent_list[slot6.id] = {}
		uv0.talent_list[slot6.id] = {
			id = slot6.id,
			level = slot6.level
		}
	end

	slot5 = ActivityConst.GUILD_ACTIVITY_START

	slot0:RefreshAffixRedPoint(slot5)

	uv0.receive_list = {}

	for slot5, slot6 in ipairs(slot1.receive_list) do
		table.insert(uv0.receive_list, slot6)
	end
end

function slot0.InitGridsDataFromServer(slot0, slot1)
	uv0 = {}
	slot2 = slot0:CreateDefaultDataList()
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		slot3[slot8.id] = slot8
	end

	for slot7, slot8 in ipairs(ActivityClubCfg.all) do
		if ActivityClubCfg[slot8].type ~= 0 then
			slot10 = slot3[slot8]

			if slot8 == 11999 then
				CustomLog.Log(debug.traceback(string.format("11999")))
			end

			slot11 = nil
			slot11 = (not slot10 or {
				id = slot8,
				occupied_num = slot10.occupied_num,
				processing_num = slot10.processing_num,
				health = slot10.health,
				history_occupied_num = slot10.history_occupied_num
			}) and {
				history_occupied_num = 0,
				processing_num = 0,
				occupied_num = 0,
				id = slot8,
				health = slot9.boss_score
			}
			uv0[slot11.id] = slot11
			slot12 = slot0:CreateNodeData(slot11.id)
			slot12.occupied_num = slot11.occupied_num
			slot12.processing_num = slot11.processing_num
			slot12.health = math.floor(slot11.health / 100)

			if slot12.health == 0 and slot11.health > 0 then
				slot12.health = 1
			end

			if uv1.grid_dic[slot11.id] then
				if uv1.grid_dic[slot11.id].occupied_timestamp > 0 then
					slot12.myOccupiedTimestamp = uv1.grid_dic[slot11.id].occupied_timestamp
				end

				if uv1.grid_dic[slot11.id].processing_type > 0 then
					slot12.processingType = uv1.grid_dic[slot11.id].processing_type
				end

				if uv1.grid_dic[slot11.id].processing_timestamp > 0 then
					slot12.myProcessingTimestamp = uv1.grid_dic[slot11.id].processing_timestamp
				end
			end

			slot2.dataList:Add(slot12)
		end
	end

	manager.notify:Invoke(INIT_GUILD_ACTIVITY_MAIN_DATA, {})

	if GuildActivityLuaBridge.GetManager() then
		GuildActivityLuaBridge.GetManager():UpdateNodeData(slot2, true)
	end
end

function slot0.InitFightRecordFromServer(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(uv0, {
			uid = slot6.uid,
			icon = slot6.icon,
			icon_frame = slot6.icon_frame,
			name = slot6.name,
			damage = slot6.damage,
			hero_list = slot6.hero_list,
			timestamp = slot6.timestamp
		})
	end

	table.sort(uv0, function (slot0, slot1)
		return slot1.damage < slot0.damage
	end)
	manager.notify:Invoke(FIGHT_RECORD_GET, {})
end

function slot0.UpdateSelfGridDataFromServer(slot0, slot1)
	if slot1.spawn_id_list ~= nil and #slot1.spawn_id_list > 0 then
		for slot5, slot6 in ipairs(slot1.spawn_id_list) do
			if not table.indexof(uv0.spawn_id_list, slot6) then
				table.insert(uv0.spawn_id_list, slot6)
			end
		end

		table.sort(uv0.spawn_id_list, function (slot0, slot1)
			return slot0 < slot1
		end)
		manager.notify:Invoke(SPAWN_ID_UPDATE, {})
	end

	slot2 = slot0:CreateDefaultDataList()
	slot3 = slot1.type
	slot4 = {}

	for slot8, slot9 in ipairs(slot1.grid_list) do
		table.insert(slot4, slot9.id)

		if slot3 == 1 then
			uv0.grid_dic[slot9.id] = {
				id = slot9.id,
				occupied_timestamp = slot9.occupied_timestamp,
				processing_type = slot9.processing_type,
				processing_timestamp = slot9.processing_timestamp,
				elite_health_rate = slot9.elite_health_rate
			}

			if uv1[slot9.id] then
				slot12 = slot0:CreateNodeData(slot9.id)
				slot12.occupied_num = slot11.occupied_num
				slot12.processing_num = slot11.processing_num
				slot12.health = math.floor(slot11.health / 100)

				if slot12.health == 0 and slot11.health > 0 then
					slot12.health = 1
				end

				if slot10 and slot10.occupied_timestamp > 0 then
					if slot10.occupied_timestamp > 0 then
						slot12.myOccupiedTimestamp = slot10.occupied_timestamp
					end

					if slot10.processing_type > 0 then
						slot12.processingType = slot10.processing_type
					end

					if slot10.processing_timestamp > 0 then
						slot12.myProcessingTimestamp = slot10.processing_timestamp
					end
				end

				slot2.dataList:Add(slot12)
			end
		else
			uv0.grid_dic[slot9.id] = nil

			if uv1[slot9.id] then
				slot11 = slot0:CreateNodeData(slot9.id)
				slot11.occupied_num = slot10.occupied_num
				slot11.processing_num = slot10.processing_num
				slot11.health = slot10.health
				slot11.myOccupiedTimestamp = 0
				slot11.processingType = 0
				slot11.myProcessingTimestamp = 0

				slot2.dataList:Add(slot11)
			end
		end
	end

	manager.notify:Invoke(UPDATE_GRIDS_DATA, slot4)

	if GuildActivityLuaBridge.GetManager() then
		GuildActivityLuaBridge.GetManager():UpdateNodeData(slot2)
	end
end

function slot0.UpdateGridsDataFromServer(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = {
			id = slot7.id,
			occupied_num = slot7.occupied_num,
			processing_num = slot7.processing_num,
			health = slot7.health,
			history_occupied_num = slot7.history_occupied_num
		}

		table.insert(slot2, slot8.id)

		uv0[slot8.id] = slot8
	end

	manager.notify:Invoke(UPDATE_GRIDS_DATA, slot2)

	if GuildActivityLuaBridge.GetManager() then
		slot3 = slot0:CreateDefaultDataList()

		for slot7, slot8 in ipairs(slot1) do
			slot9 = slot0:CreateNodeData(slot8.id)
			slot9.occupied_num = slot8.occupied_num
			slot9.processing_num = slot8.processing_num
			slot9.health = math.floor(slot8.health / 100)

			if slot9.health == 0 and slot8.health > 0 then
				slot9.health = 1
			end

			if uv1.grid_dic[slot8.id] then
				if uv1.grid_dic[slot8.id].occupied_timestamp > 0 then
					slot9.myOccupiedTimestamp = uv1.grid_dic[slot8.id].occupied_timestamp
				end

				if uv1.grid_dic[slot8.id].processing_type > 0 then
					slot9.processingType = uv1.grid_dic[slot8.id].processing_type
				end

				if uv1.grid_dic[slot8.id].processing_timestamp > 0 then
					slot9.myProcessingTimestamp = uv1.grid_dic[slot8.id].processing_timestamp
				end
			end

			slot3.dataList:Add(slot9)
		end

		GuildActivityLuaBridge.GetManager():UpdateNodeData(slot3)
	end
end

function slot0.GetSpawnIdList(slot0)
	return uv0.spawn_id_list
end

function slot0.GetFightRecords(slot0)
	return uv0
end

function slot0.CreateNodeData(slot0, slot1)
	slot2 = GuildActivityNodeData.New()
	slot3 = ActivityClubCfg[slot1]
	slot2.id = slot1
	slot2.map_id = slot3.map_id
	slot2.type = slot3.type
	slot2.level = slot3.level
	slot2.stage_id = slot3.stage_id
	slot2.vitality_cost = slot3.vitality_cost
	slot2.token_get = slot3.token_get
	slot2.boss_score = math.floor(slot3.boss_score / 100)
	slot2.boss_stage_hp = slot3.boss_stage_hp
	slot2.boss_name = slot3.boss_name

	return slot2
end

function slot0.CreateDefaultDataList(slot0)
	slot1 = GuildActivityNodeDataList.New()
	slot1.selfData.benchmark_time = uv0.benchmark_time
	slot1.selfData.coinRefreshMinutes = GameSetting.activity_club_coin_calculate_time.value[1]
	slot1.selfData.curNode = uv0.current_grid
	slot1.selfData.mapCount = #ActivityClubMapCfg.all
	slot1.selfData.myLastReceiveTimestamp = uv0.last_receive_time
	slot1.selfData.maxNodeId = ActivityClubCfg.all[#ActivityClubCfg.all]

	for slot5, slot6 in ipairs(uv0.spawn_id_list) do
		slot1.selfData.spawnNodeIdList:Add(slot6)
	end

	slot2 = {}

	for slot6, slot7 in pairs(ActivityClubCfg.get_id_list_by_map_id) do
		slot9 = ActivityClubCfg.get_id_list_by_map_id[slot6]
		slot2[table.indexof(ActivityClubMapCfg.all, slot6)] = slot9[#slot9]
	end

	for slot6, slot7 in ipairs(slot2) do
		slot1.selfData.bossIdList:Add(slot7)
	end

	return slot1
end

function slot0.OnGetCoin(slot0, slot1)
	uv0.last_receive_time = slot1
	slot2 = slot0:CreateDefaultDataList()

	if GuildActivityLuaBridge.GetManager() then
		GuildActivityLuaBridge.GetManager():UpdateNodeData(slot2)
	end
end

function slot0.OnSetFightMember(slot0)
	uv0.is_init_hero_list = 1
end

function slot0.GetCurrentGrid(slot0)
	return uv0.current_grid
end

function slot0.SetIsSignFromServer(slot0, slot1)
	uv0 = slot1
end

function slot0.SignUpSuccess(slot0)
	uv0 = 1
end

function slot0.UpdateGuildActivityHeroes(slot0, slot1)
	uv0.hero_dic = {}
	uv0.hero_list = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = {
			id = slot6.id,
			fatigue = slot6.fatigue,
			last_update_time = slot6.last_update_time
		}
		uv0.hero_dic[slot6.id] = slot7

		table.insert(uv0.hero_list, slot7)
	end

	manager.notify:Invoke(GUILD_ACTIVITY_HERO_LIST_UPDATE, {})
end

function slot0.IsFirstConfigFightRole(slot0)
	return uv0.is_init_hero_list == 0
end

function slot0.GetMyOccupiedNum(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(uv0.grid_dic) do
		if slot6.occupied_timestamp > 0 then
			slot1 = slot1 + 1
		end
	end

	return slot1
end

function slot0.GetMaxFightHeroCount(slot0)
	return ActivityClubLevelSettingCfg[slot0:GetCurRateID(ActivityConst.GUILD_ACTIVITY_START)].max_hero
end

function slot0.GetMaxOccupyCount(slot0)
	return ActivityClubLevelSettingCfg[slot0:GetCurRateID(ActivityConst.GUILD_ACTIVITY_START)].max_domain
end

function slot0.GetFightHeroById(slot0, slot1)
	return uv0.hero_dic[slot1]
end

function slot0.GetHeroFatigue(slot0, slot1)
	if slot0:IsFirstConfigFightRole() then
		return GameSetting.activity_club_hero_fatigue_max.value[1]
	end

	slot2 = manager.time:GetServerTime()
	slot3 = uv0.benchmark_time

	if uv0.hero_dic[slot1] then
		slot6 = GameSetting.activity_club_hero_fatigue_recovery.value[1] * 60

		return math.min(uv0.hero_dic[slot1].fatigue + math.floor((slot2 - slot3) / slot6) - math.floor((uv0.hero_dic[slot1].last_update_time - slot3) / slot6), GameSetting.activity_club_hero_fatigue_max.value[1])
	else
		return 0
	end
end

function slot0.GetFightHeroList(slot0)
	return uv0.hero_list
end

function slot0.GetMaxNodeId(slot0)
	return ActivityClubCfg.all[#ActivityClubCfg.all]
end

function slot0.GetTotalCoinToGet(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in pairs(uv0.grid_dic) do
		slot8 = ActivityClubCfg[slot7.id]
		slot9 = manager.time:GetServerTime()
		slot10 = uv0.last_receive_time

		if slot7.occupied_timestamp > 0 then
			slot12 = uv0.benchmark_time
			slot14 = GameSetting.activity_club_coin_calculate_time.value[1] * 60
			slot2 = slot2 + (math.floor((slot9 - slot12) / slot14) - math.floor((math.max(slot10, slot7.occupied_timestamp) - slot12) / slot14)) * slot8.token_get / (3600 / slot14)
		end
	end

	return slot2
end

function slot0.GetCoinGain(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(uv0.grid_dic) do
		slot7 = ActivityClubCfg[slot6.id]

		if slot6.occupied_timestamp > 0 and (slot7.type == 1 or slot7.type == 2) then
			slot1 = slot1 + slot7.token_get
		end
	end

	return slot1
end

function slot0.GetLastReceiveTimestamp(slot0)
	return uv0.last_receive_time
end

function slot0.GetSelfNodeData(slot0, slot1)
	return uv0.grid_dic[slot1]
end

function slot0.GetNodeData(slot0, slot1)
	return uv0[slot1]
end

function slot0.CanTakeOnFightNum(slot0)
	return ActivityClubLevelSettingCfg[slot0:GetCurRateID(ActivityConst.GUILD_ACTIVITY_START)].max_hero
end

function slot0.HaveTakeOnFightNum(slot0)
	return #uv0.hero_list
end

function slot0.IsMyOccupiedNode(slot0, slot1)
	return uv0.grid_dic[slot1] ~= nil and uv0.grid_dic[slot1].occupied_timestamp > 0
end

function slot0.IsNodeCanReach(slot0, slot1)
	return slot0:HandleNode1(slot1, slot1, {}, {})
end

function slot0.ConstructPath(slot0, slot1, slot2)
	slot5 = {}

	slot0:HandleNode(slot2, slot1, {}, {}, slot5)

	return slot5
end

function slot0.HandleNode(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = ActivityClubCfg[slot2]

	if slot2 == slot1 then
		for slot10 = #slot3, 1, -1 do
			table.insert(slot5, slot3[slot10])
		end

		table.insert(slot5, slot2)

		return true
	end

	if table.indexof(slot3, slot2) then
		return false
	end

	if table.indexof(slot4, slot2) then
		return false
	end

	slot7 = false

	if slot6.type == 0 and table.indexof(uv0.spawn_id_list, slot2) then
		slot7 = true
	elseif slot6.type == 3 then
		if table.indexof(ActivityClubMapCfg.all, slot6.map_id) < #uv0.spawn_id_list then
			slot7 = true
		end
	elseif uv1[slot2] and uv1[slot2].occupied_num > 0 then
		slot7 = true
	end

	if not slot7 then
		return false
	end

	table.insert(slot3, slot2)

	slot8 = false

	for slot12, slot13 in ipairs(slot6.neighbours) do
		if slot0:HandleNode(slot1, slot13, slot3, slot4, slot5) then
			slot8 = true

			break
		end
	end

	return slot8
end

function slot0.HandleNode1(slot0, slot1, slot2, slot3, slot4)
	slot6 = uv0.grid_dic[slot2] and uv0.grid_dic[slot2].occupied_timestamp > 0

	if ActivityClubCfg[slot2].type == 3 then
		if table.indexof(ActivityClubMapCfg.all, slot5.map_id) < #uv0.spawn_id_list then
			slot6 = true
		end
	elseif slot5.type == 0 and table.indexof(uv0.spawn_id_list, slot2) then
		slot6 = true
	end

	if slot6 then
		return true
	end

	if table.indexof(slot3, slot2) then
		return false
	end

	if table.indexof(slot4, slot2) then
		return false
	end

	slot7 = false

	if slot1 == slot2 and slot5.type ~= 0 then
		slot7 = true
	elseif slot5.type == 0 and table.indexof(uv0.spawn_id_list, slot2) then
		slot7 = true
	elseif slot5.type == 3 then
		if table.indexof(ActivityClubMapCfg.all, slot5.map_id) < #uv0.spawn_id_list then
			slot7 = true
		end
	elseif uv1[slot2] and uv1[slot2].occupied_num > 0 then
		slot7 = true
	end

	if not slot7 then
		return false
	end

	table.insert(slot3, slot2)

	slot8 = false

	for slot12, slot13 in ipairs(slot5.neighbours) do
		if slot0:HandleNode1(slot1, slot13, slot3, slot4) then
			slot8 = true

			break
		end
	end

	return slot8
end

function slot0.GetMySpawnNodeId(slot0, slot1)
	return uv0.spawn_id_list[slot1]
end

function slot0.IsMySpawnPoint(slot0, slot1)
	if ActivityClubCfg[slot1].type ~= 0 then
		return false
	end

	if slot2.map_id > 101 then
		return true
	end

	if table.indexof(uv0.spawn_id_list, slot1) then
		return true
	else
		return false
	end
end

function slot0.HaveRegister(slot0)
	return uv0 > 0
end

function slot0.OnGridGiveUp(slot0, slot1)
	manager.notify:Invoke(ON_GRID_CANCEL_OCCUPYING, slot1)
end

function slot0.OnGridOccupying(slot0, slot1)
	manager.notify:Invoke(ON_GRID_OCCUPYING, slot1)
end

function slot0.OnGridCancelOccupy(slot0, slot1)
	manager.notify:Invoke(ON_GRID_CANCEL_OCCUPYING, slot1)
end

function slot0.HaveBossBeKilled(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityClubCfg.get_id_list_by_map_id[slot1]) do
		if ActivityClubCfg[slot7].type == 3 and uv0[slot7] and uv0[slot7].occupied_num > 0 then
			return true
		end
	end

	return false
end

function slot0.GetCurRateID(slot0, slot1, slot2)
	slot3 = ActivityClubLevelSettingCfg.get_id_list_by_activity[slot1]
	slot4 = slot3[1]

	for slot8 = 2, #slot3 do
		slot10 = true

		for slot14, slot15 in ipairs(ActivityClubLevelSettingCfg[slot3[slot8]].condition) do
			if not GuildActivityTools.IsConditionAchieved(slot15) then
				break
			end
		end

		if not slot10 then
			break
		end

		slot4 = slot3[slot8]
	end

	slot0.curRateID_ = slot4

	if slot2 == true and slot0.preRateID_ == nil then
		slot0.preRateID_ = slot4
	end

	return slot0.curRateID_, slot0.preRateID_
end

function slot0.CheckRateUpgrade(slot0, slot1)
	slot2, slot3 = slot0:GetCurRateID(slot1, true)

	if slot2 ~= ActivityClubLevelSettingCfg.get_id_list_by_activity[slot1][1] and slot2 ~= slot3 then
		slot0.preRateID_ = slot2

		return true, slot2
	end

	return false
end

function slot0.GetSortedRateIDList(slot0, slot1)
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot6 = {}

	for slot10 = 2, #ActivityClubLevelSettingCfg.get_id_list_by_activity[slot1] do
		slot6[#slot6 + 1] = slot5[slot10]
	end

	slot7 = uv0.receive_list
	slot9 = ActivityClubLevelSettingCfg[slot0:GetCurRateID(slot1)].user_level

	for slot13, slot14 in ipairs(slot6) do
		if ActivityClubLevelSettingCfg[slot14].user_level <= slot9 and table.keyof(slot7, ActivityClubLevelSettingCfg[slot14].user_level) == nil then
			table.insert(slot2, slot14)
		elseif slot9 < ActivityClubLevelSettingCfg[slot14].user_level then
			table.insert(slot3, slot14)
		elseif table.keyof(slot7, ActivityClubLevelSettingCfg[slot14].user_level) ~= nil then
			table.insert(slot4, slot14)
		end
	end

	table.insertto(slot2, slot3)
	table.insertto(slot2, slot4)

	return slot2
end

function slot0.SetReceivedList(slot0, slot1, slot2)
	table.insert(uv0.receive_list, ActivityClubLevelSettingCfg[slot2].user_level)
	slot0:RefreshRateRedPoint(slot1)
end

function slot0.GetReceivedList(slot0)
	return uv0.receive_list
end

function slot0.RefreshRateRedPoint(slot0, slot1)
	slot3 = uv0.receive_list
	slot5 = ActivityClubLevelSettingCfg[slot0:GetCurRateID(slot1)].user_level
	slot6 = string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_RATE, slot1)
	slot7 = nil

	for slot11 = 2, #ActivityClubLevelSettingCfg.get_id_list_by_activity[slot1] do
		if ActivityClubLevelSettingCfg[slot2[slot11]].user_level <= slot5 and table.keyof(slot3, slot7) == nil then
			manager.redPoint:setTip(slot6, 1)

			return
		end
	end

	manager.redPoint:setTip(slot6, 0)
end

function slot0.GetSelectRaceID(slot0, slot1)
	return getData("Guild_Activity_SelectRaceID", tostring(slot1))
end

function slot0.SetSelectRaceID(slot0, slot1, slot2)
	saveData("Guild_Activity_SelectRaceID", tostring(slot1), slot2)
end

function slot0.GetSelectAffixID(slot0, slot1, slot2)
	return getData(string.format("Guild_Activity_%d_SelectAffixID", slot1), tostring(slot2))
end

function slot0.SetSelectAffixID(slot0, slot1, slot2, slot3)
	saveData(string.format("Guild_Activity_%d_SelectAffixID", slot1), tostring(slot2), slot3)
end

function slot0.GetUnLockAffixList(slot0)
	return uv0.talent_list
end

function slot0.UpgradeAffix(slot0, slot1, slot2)
	if uv0.talent_list[slot2] == nil then
		uv0.talent_list[slot2] = {
			level = 1,
			id = slot2
		}
	else
		uv0.talent_list[slot2].level = uv0.talent_list[slot2].level + 1 <= TalentTreeCfg[slot2].max_level and slot3 or slot4
	end

	slot0:RefreshAffixRedPoint(slot1)
end

function slot0.RefreshAffixRedPoint(slot0, slot1)
	slot5 = ItemTools.getItemNum(TalentTreeCfg[TalentTreeCfg.get_id_list_by_activity_id[slot1][1]].cost[1][1]) or 0
	slot6, slot7, slot8 = nil

	for slot12, slot13 in ipairs(slot2) do
		slot8 = string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, slot1, TalentTreeCfg[slot13].race, slot13)
		slot6 = uv0.talent_list[slot13] and uv0.talent_list[slot13].level + 1 or 1

		if ((TalentTreeCfg[slot13].cost[slot6] == nil or TalentTreeCfg[slot13].cost[slot6][2]) and -1) ~= -1 and slot7 <= slot5 then
			manager.redPoint:setTip(slot8, 1)
		else
			manager.redPoint:setTip(slot8, 0)
		end
	end
end

function slot0.SetTempEffectiveAffixList(slot0, slot1)
	slot0.effectiveAffixIDList_ = slot1
end

function slot0.GetTempEffectiveAffixList(slot0, slot1)
	return slot0.effectiveAffixIDList_ or {}
end

function slot0.IsAllAffixMax(slot0, slot1)
	for slot6, slot7 in ipairs(TalentTreeCfg.get_id_list_by_activity_id[slot1]) do
		if uv0.talent_list[slot7] then
			if uv0.talent_list[slot7].level < TalentTreeCfg[slot7].max_level then
				return false
			end
		else
			return false
		end
	end

	return true
end

function slot0.SetRankData(slot0, slot1)
	slot2 = {}
	slot3 = ipairs
	slot5 = slot1.records or {}

	for slot6, slot7 in slot3(slot5) do
		table.insert(slot2, GuildActivityRankStruct.New(slot7))
	end

	uv0 = {
		rankList = slot2
	}

	function slot6(slot0, slot1)
		if slot0.score == slot1.score then
			if slot0.time_stamp == slot1.time_stamp then
				return slot1.user_id < slot0.user_id
			else
				return slot0.time_stamp < slot1.time_stamp
			end
		else
			return slot1.score < slot0.score
		end
	end

	table.sort(uv0.rankList, slot6)

	for slot6, slot7 in ipairs(uv0.rankList) do
		slot7.rank = slot6
	end
end

function slot0.GetRankList(slot0)
	return uv0.rankList or {}
end

return slot0
