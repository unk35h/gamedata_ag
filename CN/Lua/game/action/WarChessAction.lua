slot1 = manager.net

slot1:Bind(49001, function (slot0)
	for slot4, slot5 in ipairs(slot0.chess_map_list) do
		WarChessData:InitData(slot5)
	end

	uv0.UpdateWarChessRedPoint()
end)

slot1 = manager.net

slot1:Bind(49011, function (slot0)
	slot1 = cleanProtoTable(slot0.attribute)

	if slot0.event_id == 10202 then
		WarChessData:SetTemporaryData(ChessConst.TEMPORARY_KEY.TREASURE, slot1)
	elseif slot2 == 10205 then
		WarChessData:SetTemporaryData(ChessConst.TEMPORARY_KEY.DEBUFF, slot1)
	end
end)

slot1 = manager.net

slot1:Bind(49023, function (slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.chess_open_info_list) do
		slot1[slot6.chapter_id] = slot6.timestamp
	end

	if uv0.cdTimer_ then
		uv0.cdTimer_:Stop()

		uv0.cdTimer_ = nil
	end

	WarChessData:InitChessTime(slot1)

	uv0.cdTimer_ = Timer.New(function ()
		for slot3, slot4 in pairs(uv0) do
			uv1.ChessOpen(slot3, slot4, uv0)
		end
	end, 1, -1)

	uv0.cdTimer_:Start()
end)

slot1 = manager.notify

slot1:RegistListener(CHESS_BOX_OPEN, function (slot0)
	if WarchessLevelCfg[slot0].activity == ActivityConst.SUMMER_CHESS_ISLAND then
		uv0.UpdateSummerChessPlotRedPoint()
	end
end)

slot1 = manager.notify

slot1:RegistListener(PLAYER_LEVEL_UP, function ()
	uv0.UpdateWarChessRedPoint()
end)

slot1 = nil
slot2 = nil
slot3 = nil
slot4 = nil

return {
	ChessOpen = function (slot0, slot1, slot2)
		if WarchessLevelCfg[slot0].unlock_level ~= 0 and ChessTools.GetChapterProgress(slot4) < slot3.success_progress then
			return
		end

		if slot1 < manager.time:GetServerTime() then
			slot5 = true

			if slot3.activity ~= 0 and slot3.unlock_condition ~= "" then
				if not StoryStageActivityData:GetStageData(slot6[1])[slot6[2]] or slot7.clear_times < 1 then
					slot5 = false
				end
			end

			if slot5 then
				slot6 = string.format("%s_%s_%s", RedPointConst.WAR_CHESS, slot3.activity, slot0)

				manager.redPoint:setTip(slot6, getData("WarChess", slot6) or 1)

				slot2[slot0] = nil
			end
		end
	end,
	RequireWarChessInfo = function (slot0)
		manager.net:SendWithLoadingNew(49002, {
			chapter_id = slot0
		}, 49003, uv0.OnRequireWarChessInfo)
	end,
	OnRequireWarChessInfo = function (slot0, slot1)
		if isSuccess(slot0.result) then
			WarChessData:SetWarChessData(slot1.chapter_id, slot0.map_info)
			uv0.EnterChessMap()
		else
			ShowTips(slot0.result)
		end
	end,
	FireByPlayer = function (slot0)
		slot1 = manager.net

		slot1:SendWithLoadingNew(49016, {}, 49017, function (slot0, slot1)
			uv0.OnFireByPlayer(slot0, slot1, uv1)
		end)
	end,
	OnFireByPlayer = function (slot0, slot1, slot2)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)

			return
		end

		WarChessData:ModifyItemData(ChessConst.BULLET, -1)

		if slot2 then
			slot2()
		end
	end,
	EnterChessMap = function ()
		slot0 = GetChessDataForExcehange()
		slot1 = WarChessData:GetCurrentWarChessMapData()
		slot0.mapId = slot1.mapId
		slot0.bronPos = Vector2(slot1.bronPos.x, slot1.bronPos.z)
		slot0.direction = slot1.direction
		slot0.GridConfig = WarchessHexCfg.AllGridConfig
		slot2 = WarchessLevelCfg[slot0.mapId]
		slot3 = MapConfig.New()
		slot3.mapId = slot0.mapId
		slot3.sceneId = slot2.scene_id
		slot3.minFreeLookX = slot2.freelook_range[1][1]
		slot3.maxFreeLookX = slot2.freelook_range[1][2]
		slot3.minFreeLookZ = slot2.freelook_range[2][1]
		slot3.maxFreeLookZ = slot2.freelook_range[2][2]
		slot3.modelName = slot2.model
		slot3.modelScale = tonumber(slot2.model_scale)
		slot0.MapConfig = slot3
		slot4 = {}

		for slot8, slot9 in pairs(slot1.mapChangeInfo) do
			slot10 = GridChangeData.New()
			slot10.tag = slot9.tag
			slot10.x = slot9.pos.x
			slot10.z = slot9.pos.z
			slot10.status = slot9.status
			slot10.rotationY = slot9.direction * 60

			table.insert(slot4, slot10)
		end

		slot0.mapInfoS = slot4
		slot0.fogInfo = slot1.fogInfo
		slot5 = {}

		if slot2.cache_asset and type(slot2.cache_asset) == "table" then
			for slot9, slot10 in ipairs(slot2.cache_asset) do
				slot11 = CacheAssetInfo.New()
				slot11.assetPath = slot10
				slot11.num = 1

				table.insert(slot5, slot11)
			end
		end

		slot0.cacheAssetS = slot5

		StartChessBattleMode()
	end,
	RoleMoveByPath = function (slot0, slot1)
		uv0 = slot1

		manager.net:SendWithLoadingNew(49004, {
			path = slot0
		}, 49005, uv1.OnRoleMoveByPath)
	end,
	OnRoleMoveByPath = function (slot0, slot1)
		if uv0 then
			uv0(slot0.result)
		end
	end,
	TouchGrid = function (slot0, slot1, slot2, slot3)
		uv0 = slot3

		manager.net:SendWithLoadingNew(49006, {
			pos = slot0,
			param = slot1,
			type = slot2
		}, 49007, uv1.OnTouchGrid)
	end,
	OnTouchGrid = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:CallUpdateFunc(TOUCH_GRID, slot0, slot1)
		end

		if uv0 then
			uv0()
		end
	end,
	SkipBattle = function (slot0)
		manager.net:SendWithLoadingNew(49006, {
			param = 0,
			type = 1,
			pos = slot0
		}, 49007, uv0.OnSkipBattle)
	end,
	OnSkipBattle = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	GetTreasure = function (slot0, slot1)
		manager.net:SendWithLoadingNew(49006, {
			type = 1,
			pos = slot0,
			param = slot1
		}, 49007, uv0.OnGetTreasure)
	end,
	OnGetTreasure = function (slot0, slot1)
		manager.notify:CallUpdateFunc(GET_TREASURE, slot0, slot1)
	end,
	ForceBattle = function (slot0, slot1)
		uv0 = slot1

		manager.net:SendWithLoadingNew(49006, {
			type = 1,
			pos = slot0
		}, 49007, uv1.OnForceBattle)
	end,
	OnForceBattle = function (slot0, slot1)
		if uv0 then
			uv0()

			uv0 = nil
		end
	end,
	PurifyDeBuff = function (slot0, slot1)
		manager.net:SendWithLoadingNew(49006, {
			type = 1,
			pos = slot0,
			param = slot1
		}, 49007, uv0.OnPurifyDeBuff)
	end,
	OnPurifyDeBuff = function (slot0, slot1)
		manager.notify:CallUpdateFunc(PURIFY_DEBUFF, slot0, slot1)
	end,
	ReviveHero = function (slot0, slot1)
		manager.net:SendWithLoadingNew(49006, {
			type = 1,
			pos = slot0,
			param = slot1
		}, 49007, uv0.OnReviveHero)
	end,
	OnReviveHero = function (slot0, slot1)
		manager.notify:CallUpdateFunc(REVIVE_HERO, slot0, slot1)
	end,
	AddLog = function (slot0, slot1, slot2, slot3)
		WarChessData:AddLog(slot0, slot1, slot2, slot3)
	end,
	AddAllHp = function (slot0)
		WarChessData:AddAllHp(slot0)
	end,
	FinishExplore = function ()
		manager.net:SendWithLoadingNew(49008, {}, 49009, uv0.OnFinishExplore)
	end,
	OnFinishExplore = function (slot0, slot1)
		if isSuccess(slot0.result) then
			WarChessData:SetCurrentChapter(0)
			WarChessData:RemoveCurrentActivity()
		else
			ShowTips(slot0.result)
		end
	end,
	UpdateSummerChessPlotRedPoint = function ()
		if not ActivityData:GetActivityIsOpen(ActivityConst.SUMMER_CHESS_ISLAND) then
			return
		end

		slot1, slot2 = ActivityTools.GetActivityChessProgress(slot0)
		slot3 = slot1 / slot2

		for slot9, slot10 in pairs(ActivityStoryCollect[ActivityCfg[slot0].activity_theme].story_id) do
			slot11 = string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, slot4, slot10)

			if slot5.unlock_value[slot9] <= slot3 then
				manager.redPoint:setTip(slot11, getData("WarChessPlot", slot11) or 1)
			else
				manager.redPoint:setTip(slot11, 0)
			end
		end
	end,
	SetActivityChessPlotRedPoint = function (slot0, slot1)
		slot2 = string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, slot0, slot1)

		manager.redPoint:setTip(slot2, 0)
		saveData("WarChessPlot", slot2, 0)
	end,
	CostShipHp = function (slot0)
		WarChessData:CostShipHp(slot0)
	end,
	SwitchShipControl = function (slot0)
		manager.net:SendWithLoadingNew(49024, {
			type = slot0
		}, 49025, uv0.OnSwitchShipControl)
	end,
	OnSwitchShipControl = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	SetMutiTeam = function (slot0, slot1, slot2, slot3, slot4)
		slot6 = GetHeroTeamActivityID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS, slot3)
		slot7 = {}

		for slot11 = 1, slot2 do
			slot7[slot11] = {
				id = slot11,
				hero_list = {},
				mimir_info = {},
				cooperate_unique_skill_id = BattleTeamData:GetComboInfo(slot5, slot6, nil, slot11)
			}
			slot17 = slot6
			slot13 = BattleTeamData:GetSingleTeam(slot5, slot17, nil, slot11)

			for slot17 = 1, 3 do
				if slot13[slot17] ~= 0 then
					if HeroData:GetHeroData(slot13[slot17]).unlock ~= 1 then
						ShowTips("ERROR_HERO_NOT_UNLOCK")

						return
					end

					table.insert(slot7[slot11].hero_list, {
						owner_id = 0,
						hero_type = 1,
						hero_id = slot13[slot17]
					})
				end
			end

			slot14, slot15 = BattleTeamData:GetMimirInfo(slot5, slot6, nil, slot11)
			slot7[slot11].mimir_info = {
				mimir_id = slot14,
				chip_list = slot15
			}
		end

		uv0 = slot4

		manager.net:SendWithLoadingNew(63000, {
			stage_type = slot5,
			activity_id = slot6,
			cont_teams = {
				teams = slot7
			},
			data = {
				chess_data_info_1 = {
					{
						x = slot0,
						z = slot1
					}
				},
				chess_data_info_2 = {}
			}
		}, 63001, uv1.OnSetMutiTeam)
	end,
	OnSetMutiTeam = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		elseif uv0 then
			uv0()
		end
	end,
	UpdateWarChessRedPoint = function ()
		if PlayerData:GetPlayerInfo().userLevel < ChapterClientCfg[404].level then
			return
		end

		slot3 = false

		for slot7, slot8 in ipairs(uv0.GetChapterList()) do
			if slot0 >= (ChapterClientCfg[slot8].level or 0) and ChessTools.GetChapterProgress(slot8) < 100 and RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot8) == nil then
				slot3 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.WARCHESS, slot3 and 1 or 0)
	end,
	CancelWarChessRedPoint = function ()
		slot1 = PlayerData:GetPlayerInfo().userLevel

		for slot5, slot6 in ipairs(uv0.GetChapterList()) do
			if slot1 >= (ChapterClientCfg[slot6].level or 0) and RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot6) == nil then
				RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot6)
			end
		end

		manager.redPoint:setTip(RedPointConst.WARCHESS, 0)
	end,
	GetChapterList = function ()
		slot0 = {}
		slot4 = 404

		for slot4, slot5 in pairs(ChapterClientCfg[slot4].chapter_list) do
			if WarchessLevelCfg[slot5].switch_id == 0 then
				table.insert(slot0, slot5)
			elseif not SystemSwitchData:GetSwitchIDIsOpen(slot6) then
				table.insert(slot0, slot5)
			end
		end

		return slot0
	end
}
