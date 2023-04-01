slot0 = singletonClass("WarChessData")
slot1 = 0
slot2 = {}
slot3, slot4, slot5 = nil
slot6 = {}
slot7 = false
slot8 = {}
slot9 = nil
slot10 = {}
slot11 = {}
slot12 = nil
slot13 = {}
slot14 = nil
slot15 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = nil
	uv2 = {}
	uv3 = 0
	uv4 = {}
	uv5 = {}
	uv6 = nil
	uv7 = 0
	uv8 = {}
	uv9 = nil
	uv10 = {}
	slot0.teamData_ = {}
	slot0.activiteList_ = {}
end

function slot0.InitData(slot0, slot1)
	uv0[slot1.activity_id] = slot1.chapter

	for slot6, slot7 in ipairs(cleanProtoTable(slot1.chapter_info)) do
		if not uv1[slot7.chapter_id] then
			uv1[slot7.chapter_id] = {
				box = {}
			}
		end

		uv1[slot7.chapter_id].id = slot7.chapter_id

		for slot12, slot13 in ipairs(cleanProtoTable(slot7.box)) do
			uv1[slot7.chapter_id].box[slot13.id] = slot13.num
		end

		if WarchessLevelCfg[slot7.chapter_id].activity ~= 0 then
			slot9 = string.format("%s_%s_%s", RedPointConst.WAR_CHESS, WarchessLevelCfg[slot7.chapter_id].activity, slot7.chapter_id)

			manager.redPoint:setTip(slot9, getData("WarChess", slot9) or 0)
		end
	end
end

function slot0.InitChessTime(slot0, slot1)
	slot0.activiteList_ = clone(slot1)
end

function slot0.GetChessTime(slot0, slot1)
	return slot0.activiteList_[slot1]
end

function slot0.GetChapterInfo(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = {
			box = {},
			id = slot1
		}
	end

	return uv0[slot1]
end

function slot0.ModifyData(slot0, slot1)
end

function slot0.SetWarChessData(slot0, slot1, slot2)
	uv0 = WarchessLevelCfg[slot1].activity
	uv1[uv0] = slot1
	uv2 = {
		mapId = slot1,
		bronPos = {
			x = slot2.pos.x,
			z = slot2.pos.z
		},
		bag = {
			item = {},
			artifact = {}
		},
		hp_list = {},
		event_list = {},
		global_event = {},
		direction = slot2.direction,
		eventInfo = {},
		log = {}
	}
	slot3 = cleanProtoTable(slot2.bag.artifact)
	slot5 = cleanProtoTable(slot2.log)
	slot6 = cleanProtoTable(slot2.hp_list)

	for slot10, slot11 in ipairs(cleanProtoTable(slot2.bag.item)) do
		uv2.bag.item[slot11.type] = slot11.num
	end

	for slot10, slot11 in ipairs(slot3) do
		uv2.bag.artifact[slot11] = 1
	end

	for slot10, slot11 in ipairs(slot5) do
		uv2.log[slot10] = {
			index = slot11.index,
			tag = slot11.tag,
			log = slot11.log
		}
	end

	for slot10, slot11 in ipairs(slot2.event_list) do
		if not WarchessGlobalCfg[slot11.id] then
			error("服务端下发了客户端不存在的全局事件 id:" .. slot11.id)
		end

		if slot12.type == ChessConst.GLOBAL.EVENT then
			uv2.event_list[slot12.params[1]] = slot11.progress
		end

		slot0:SetGlobalEventProgress(slot12.type, slot11.id, slot11.progress or 0)
	end

	for slot10, slot11 in ipairs(slot6) do
		uv2.hp_list[slot11.id] = slot11.hp
	end

	slot7 = {}

	for slot11, slot12 in ipairs(slot2.map) do
		slot7[ChessTools.TwoDToOneD(slot12.pos.x, slot12.pos.z)] = {
			tag = slot12.tag,
			pos = {
				x = slot12.pos.x,
				z = slot12.pos.z
			},
			status = slot12.state or 0,
			attribute = cleanProtoTable(slot12.attribute),
			direction = (slot12.rotation or 0) / 60
		}
	end

	uv2.mapChangeInfo = slot7
	uv2.is_fog = slot2.is_fog

	if uv2.is_fog then
		uv2.fogInfo = WarChessTools.DecodeFogInfo(slot2.fog)
	else
		uv2.fogInfo = {}

		for slot11 = 1, slot2.fog[1] do
			for slot15 = 1, slot2.fog[2] do
				table.insert(uv2.fogInfo, true)
			end
		end
	end

	if slot2.guide_pos and slot2.guide_pos[1] then
		uv2.guidePos = {
			slot2.guide_pos[1],
			slot2.guide_pos[2]
		}
	else
		uv2.guidePos = nil
	end

	uv2.direction = slot2.direction
	slot8 = {}

	for slot12, slot13 in ipairs(slot2.event_info) do
		if not slot8[slot13.event_id] then
			slot8[slot14] = {}
		end

		for slot18, slot19 in ipairs(slot13.pos_list) do
			if not slot8[slot14][ChessTools.TwoDToOneD(slot19.pos.x, slot19.pos.z)] then
				slot8[slot14][slot20] = {}
			end

			table.insert(slot8[slot14][slot20], slot19.tag)
		end
	end

	uv2.eventInfo = slot8

	if slot2.extra_gameplay and slot2.extra_gameplay.ocean_gameplay then
		slot9 = slot2.extra_gameplay.ocean_gameplay

		if not uv2.extra_gameplay then
			uv2.extra_gameplay = {}
		end

		uv2.extra_gameplay.research_vessel_hp = slot9.research_vessel_hp
		uv2.extra_gameplay.detector_pos = cleanProtoTable(slot9.detector_pos)
		uv2.extra_gameplay.boss_pos = cleanProtoTable(slot9.boss_pos)
	end
end

function slot0.ChangeFogInfo(slot0, slot1)
	for slot5 = 0, slot1.Count - 1 do
		uv0.fogInfo[slot1[slot5]] = true
	end
end

function slot0.GetCurrentWarChessMapData(slot0)
	return uv0
end

function slot0.SetCurrentIndex(slot0, slot1, slot2)
	if uv0.bronPos.x == slot1 and uv0.bronPos.z == slot2 then
		return false
	end

	uv0.bronPos = {
		x = slot1,
		z = slot2
	}

	return true
end

function slot0.GetCurrentIndex(slot0)
	return uv0.bronPos
end

function slot0.SetBattleIndex(slot0, slot1)
	uv0 = slot1
end

function slot0.GetBattleIndex(slot0)
	return uv0
end

function slot0.GetItemData(slot0)
	return uv0.bag.item
end

function slot0.GetArtifactData(slot0)
	return uv0.bag.artifact
end

function slot0.ModifyItemData(slot0, slot1, slot2)
	if uv0.bag.item[slot1] == nil then
		uv0.bag.item[slot1] = 0
	end

	if slot2 > 0 and WarchessObjectCfg[slot1].max ~= 0 then
		uv0.bag.item[slot1] = math.min(WarchessObjectCfg[slot1].max, uv0.bag.item[slot1] + slot2)
	else
		uv0.bag.item[slot1] = uv0.bag.item[slot1] + slot2
	end

	if slot2 > 0 then
		slot3 = slot0:GetGlobalEventList()[ChessConst.GLOBAL.KEY] or {}

		for slot7, slot8 in pairs(slot3) do
			if slot1 == WarchessGlobalCfg[slot7].params[1] then
				slot0:SetGlobalEventProgress(ChessConst.GLOBAL.KEY, slot7, slot8 + slot2)
			end
		end
	end

	if uv0.bag.item[slot1] == 0 then
		uv0.bag.item[slot1] = nil
	end

	if slot1 == ChessConst.BULLET then
		manager.notify:CallUpdateFunc(GET_BULLET, true)
	end
end

function slot0.ModifyArtifactData(slot0, slot1, slot2)
	if uv0.bag.artifact[slot1] == nil then
		uv0.bag.artifact[slot1] = 0
	end

	uv0.bag.artifact[slot1] = uv0.bag.artifact[slot1] + slot2

	if uv0.bag.artifact[slot1] == 0 then
		uv0.bag.artifact[slot1] = nil
	end
end

function slot0.AddAllHp(slot0, slot1)
	for slot5, slot6 in pairs(uv0.hp_list) do
		slot7 = nil

		if (slot6 == 0 and 0 or slot6 + slot1) > 10000 then
			slot7 = 10000
		end

		if slot7 < 0 then
			slot7 = 0
		end

		uv0.hp_list[slot5] = slot7
	end
end

function slot0.ModifyHp(slot0, slot1, slot2)
	uv0.hp_list[slot1] = slot2
end

function slot0.GetHeroHp(slot0, slot1)
	return uv0.hp_list[slot1]
end

function slot0.GetHeroList(slot0)
	return uv0.hp_list
end

function slot0.SetChapterClientID(slot0, slot1)
	uv0 = slot1
end

function slot0.GetChapterClientID(slot0)
	return uv0
end

function slot0.GetBoxNum(slot0, slot1, slot2)
	return uv0:GetChapterInfo(slot1).box[slot2] or 0
end

function slot0.AddBoxNum(slot0, slot1, slot2)
	slot3.box[slot2] = (uv0:GetChapterInfo(slot1).box[slot2] or 0) + 1

	manager.notify:Invoke(CHESS_BOX_OPEN, slot1)
end

function slot0.GetLogs(slot0)
	return uv0.log
end

function slot0.AddLog(slot0, slot1, slot2, slot3, slot4)
	slot6 = {
		index = slot2 * manager.ChessManager.map_.width + slot1 + 1,
		tag = slot3,
		log = slot4
	}

	for slot10, slot11 in ipairs(uv0.log) do
		if table.equal(slot11, slot6, "all") then
			return
		end
	end

	uv0.log[#uv0.log + 1] = slot6
end

function slot0.SetExtendMap(slot0, slot1)
	uv0 = slot1
end

function slot0.SetJsonMap(slot0, slot1)
	uv0 = slot1
end

function slot0.GetJsonData(slot0, slot1, slot2)
	return uv0[ChessTools.TwoDToOneD(slot1, slot2)]
end

function slot0.GetTypeIDViaExtendID(slot0, slot1)
	return uv0[slot1].typeID
end

function slot0.ChangeGridLua(slot0, slot1, slot2, slot3)
	slot4 = uv0.mapChangeInfo[ChessTools.TwoDToOneD(slot1, slot2)]
	slot4 = (slot3 == 0 or ChessTools.CreateChessData(slot1, slot2, uv1, slot3)) and ChessTools.CreateChessData(slot1, slot2, uv2, ChessTools.TwoDToOneD(slot1, slot2))
	slot4.tag = slot3
	uv0.mapChangeInfo[ChessTools.TwoDToOneD(slot1, slot2)] = slot4
end

function slot0.ChangeGridStatusLua(slot0, slot1, slot2, slot3)
	slot4 = uv0.mapChangeInfo[ChessTools.TwoDToOneD(slot1, slot2)] or ChessTools.CreateChessData(slot1, slot2, uv1, ChessTools.TwoDToOneD(slot1, slot2))
	slot4.status = slot3
	uv0.mapChangeInfo[ChessTools.TwoDToOneD(slot1, slot2)] = slot4
end

function slot0.ChangeGridDirection(slot0, slot1, slot2, slot3)
	slot4 = uv0.mapChangeInfo[ChessTools.TwoDToOneD(slot1, slot2)] or ChessTools.CreateChessData(slot1, slot2, uv1, ChessTools.TwoDToOneD(slot1, slot2))
	slot4.direction = math.fmod(slot4.direction + slot3, 6)
	uv0.mapChangeInfo[ChessTools.TwoDToOneD(slot1, slot2)] = slot4
end

function slot0.GetGridDirection(slot0, slot1, slot2)
	slot3 = uv0.mapChangeInfo[ChessTools.TwoDToOneD(slot1, slot2)] or ChessTools.CreateChessData(slot1, slot2, uv1, ChessTools.TwoDToOneD(slot1, slot2))
	uv0.mapChangeInfo[ChessTools.TwoDToOneD(slot1, slot2)] = slot3

	return slot3.direction
end

function slot0.GetGridAttribute(slot0, slot1, slot2)
	uv0.mapChangeInfo[slot3] = uv0.mapChangeInfo[ChessTools.TwoDToOneD(slot1, slot2)] or ChessTools.CreateChessData(slot1, slot2, uv1, slot3)

	return uv0.mapChangeInfo[slot3].attribute
end

function slot0.SetGridAttribute(slot0, slot1, slot2, slot3)
	uv0.mapChangeInfo[slot4] = uv0.mapChangeInfo[ChessTools.TwoDToOneD(slot1, slot2)] or ChessTools.CreateChessData(slot1, slot2, uv1, slot4)
	uv0.mapChangeInfo[slot4].attribute = slot3
end

function slot0.GetGridLua(slot0, slot1, slot2)
	if not uv0.mapChangeInfo[ChessTools.TwoDToOneD(slot1, slot2)] then
		return ChessTools.CreateChessData(slot1, slot2, uv1, ChessTools.TwoDToOneD(slot1, slot2))
	end

	return slot3
end

function slot0.GetCurrentChapter(slot0, slot1)
	return uv1[slot1 or uv0] or 0
end

function slot0.SetCurrentChapter(slot0, slot1, slot2)
	uv1[slot2 or uv0] = slot1
end

function slot0.RemoveCurrentActivity(slot0)
	uv0 = 0
end

function slot0.GetCurrentActivity(slot0)
	return uv0
end

function slot0.SetTemporaryData(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.GetTemporaryData(slot0, slot1, slot2)
	uv0[slot1] = nil

	return uv0[slot1]
end

function slot0.AboutToStart(slot0)
	uv0 = true
end

function slot0.IsAboutToStart(slot0)
	uv0 = false

	return uv0
end

function slot0.ExecuteEventOneTime(slot0, slot1)
	uv0.event_list[slot1] = (uv0.event_list[slot1] or 0) + 1
end

function slot0.GetEventExecuteTime(slot0, slot1)
	return uv0.event_list[slot1] or 0
end

function slot0.GetGlobalEventList(slot0)
	return uv0.global_event
end

function slot0.SetGlobalEventProgress(slot0, slot1, slot2, slot3)
	if not uv0.global_event[slot1] then
		uv0.global_event[slot1] = {}
	end

	uv0.global_event[slot1][slot2] = slot3

	if slot1 == ChessConst.GLOBAL.COUNT_STEP and manager.ChessManager then
		manager.ChessManager:SetCountDown(slot3)
	end
end

function slot0.GetGlobalEventProgress(slot0, slot1)
	if not uv0.global_event[WarchessGlobalCfg[slot1].type] then
		return nil
	end

	return uv0.global_event[slot2][slot1]
end

function slot0.GetGlobalEventByType(slot0, slot1)
	return uv0.global_event[slot1]
end

function slot0.ClearGlobalEvent(slot0, slot1, slot2)
	if not uv0.global_event[slot1] then
		return
	end

	uv0.global_event[slot1][slot2] = nil

	if table.length(uv0.global_event[slot1]) == 0 then
		uv0.global_event[slot1] = nil
	end

	if slot1 == ChessConst.GLOBAL.COUNT_STEP and manager.ChessManager then
		manager.ChessManager:SetCountDown(false)
	end
end

function slot0.SetStartTime(slot0, slot1)
	uv0 = slot1
end

function slot0.GetStartTime(slot0)
	return uv0
end

function slot0.GetBulletNum(slot0)
	return uv0.bag.item[ChessConst.BULLET] or 0
end

function slot0.SetButterFlyPos(slot0, slot1)
	uv0.guidePos = slot1
end

function slot0.GetButterFlyPos(slot0)
	return uv0.guidePos
end

function slot0.GetCharacterDirection(slot0)
	return uv0.direction
end

function slot0.SetCharacterDirection(slot0, slot1)
	uv0.direction = slot1
end

function slot0.GetBattleIsFinish(slot0, slot1, slot2, slot3)
	return slot0:IsEventExecute(10201, slot1, slot2, slot3)
end

function slot0.GetMutiBattleIsFinish(slot0, slot1, slot2, slot3)
	return slot0:IsEventExecute(10207, slot1, slot2, slot3)
end

function slot0.IsEventExecute(slot0, slot1, slot2, slot3, slot4)
	if not uv0.eventInfo[slot1] then
		return false
	end

	if not slot5[ChessTools.TwoDToOneD(slot2, slot3)] then
		return false
	end

	if not table.indexof(slot6, slot4) then
		return false
	end

	return true
end

function slot0.SetEventExecute(slot0, slot1, slot2, slot3, slot4)
	if not uv0.eventInfo[slot1] then
		uv0.eventInfo[slot1] = {}
	end

	if not uv0.eventInfo[slot1][ChessTools.TwoDToOneD(slot2, slot3)] then
		uv0.eventInfo[slot1][slot6] = {}
		slot7 = uv0.eventInfo[slot1][slot6]
	end

	if table.indexof(slot7, slot4) then
		error("不应该存在两个相同的一次性事件")
	end

	table.insert(slot7, slot4)
end

function slot0.SetRedPoint(slot0, slot1)
	slot3 = string.format("%s_%s_%s", RedPointConst.WAR_CHESS, WarchessLevelCfg[slot1].activity, slot1)

	manager.redPoint:setTip(slot3, 0)
	saveData("WarChess", slot3, 0)
end

function slot0.GetStepCountDownNum(slot0)
	if not uv0.global_event[ChessConst.GLOBAL.COUNT_STEP] then
		return 0
	end

	for slot5, slot6 in pairs(slot1) do
		return slot6
	end
end

function slot0.GetShipHp(slot0)
	return uv0.extra_gameplay.research_vessel_hp
end

function slot0.CostShipHp(slot0, slot1)
	uv0.extra_gameplay.research_vessel_hp = uv0.extra_gameplay.research_vessel_hp + slot1

	manager.notify:CallUpdateFunc(SHIP_HP_CHANGE, slot1)
end

function slot0.GetBossPos(slot0)
	return uv0.extra_gameplay.boss_pos
end

function slot0.ModifyBossPos(slot0, slot1, slot2)
	uv0.extra_gameplay.boss_pos = {
		slot1,
		slot2
	}
end

function slot0.GetDetectorPos(slot0)
	return uv0.extra_gameplay.detector_pos
end

function slot0.SetDetectorPos(slot0, slot1, slot2)
	uv0.extra_gameplay.detector_pos = {
		slot1,
		slot2
	}
end

function slot0.SetMutiBattleData(slot0, slot1, slot2, slot3)
	(slot0:GetMutiBattleDataWithoutType(slot1) or {
		{},
		[2.0] = 0,
		[3.0] = 0
	})[slot2] = slot3

	if slot2 == 1 then
		for slot8 = 1, 3 do
			if slot0:GetMutiBattleDataWithoutType(slot8) ~= slot4 and slot9 and slot9[1] then
				slot10 = {
					{},
					slot9[2],
					slot9[3]
				}

				for slot14, slot15 in pairs(slot9[1]) do
					slot16 = false

					for slot20, slot21 in pairs(slot4[1]) do
						if slot21 == slot15 then
							slot16 = true

							if ComboSkillCfg[slot10[3]] then
								slot25 = slot10[3]

								for slot25, slot26 in pairs(ComboSkillCfg[slot25].cooperate_role_ids) do
									if slot21 == slot26 then
										slot10[3] = 0
									end
								end
							end

							break
						end
					end

					if slot16 == false then
						table.insert(slot10[1], slot15)
					end
				end

				for slot14 = 1, 3 do
					if slot10[1][slot14] == nil then
						slot10[1][slot14] = 0
					end
				end

				slot0.teamData_[slot8] = slot10

				saveData("chessMutiBattleData", "team_" .. slot8, slot10)
			end
		end
	end

	saveData("chessMutiBattleData", "team_" .. slot1, slot4)
end

function slot0.GetMutiBattleData(slot0, slot1, slot2)
	if slot0.teamData_[slot1] == nil then
		slot0.teamData_[slot1] = getData("chessMutiBattleData", "team_" .. slot1) or {
			{},
			[2.0] = 0,
			[3.0] = 0
		}
	end

	return slot0.teamData_[slot1][slot2]
end

function slot0.GetMutiBattleDataWithoutType(slot0, slot1)
	if slot0.teamData_[slot1] == nil then
		slot0.teamData_[slot1] = getData("chessMutiBattleData", "team_" .. slot1) or {
			{},
			[2.0] = 0,
			[3.0] = 0
		}
	end

	return slot0.teamData_[slot1]
end

function slot0.SwapTeam(slot0, slot1, slot2)
	slot3 = nil
	slot0.teamData_[slot1] = slot0.teamData_[slot2]
	slot0.teamData_[slot2] = deepClone(slot0.teamData_[slot1])
	slot3 = nil

	saveData("chessMutiBattleData", "team_" .. slot1, slot0.teamData_[slot1])
	saveData("chessMutiBattleData", "team_" .. slot2, slot0.teamData_[slot2])
end

function slot0.SetCacheExtendID(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.GetCacheExtendID(slot0, slot1)
	if uv0[slot1] == nil then
		-- Nothing
	end

	return uv0[slot1]
end

function slot0.CacheGridData(slot0, slot1)
	uv0 = true
	uv1 = slot1
end

function slot0.GetCacheGridData(slot0)
	if uv0 == nil then
		-- Nothing
	end

	return uv0
end

function slot0.ClearCacheGridData(slot0)
	uv0 = false
	uv1 = nil
end

function slot0.GetMapChangeInfo(slot0)
	return uv0.mapChangeInfo
end

function slot0.GetGridIsChanged(slot0, slot1, slot2)
	if uv0.mapChangeInfo[ChessTools.TwoDToOneD(slot1, slot2)] then
		if slot4.tag == 0 then
			return false
		else
			return true
		end
	else
		return false
	end
end

function slot0.GetStoneIsMoving(slot0)
	return uv0
end

slot16 = 0

function slot0.CacheViewPos(slot0, slot1)
	uv0 = slot1
end

function slot0.GetViewPos(slot0)
	return uv0
end

return slot0
