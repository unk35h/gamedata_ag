slot0 = require("cjson")
slot1 = {
	{
		1,
		1
	},
	{
		0,
		1
	},
	{
		-1,
		0
	},
	{
		-1,
		-1
	},
	{
		0,
		-1
	},
	{
		1,
		0
	}
}

return {
	IsInteract = function (slot0, slot1)
		if WarchessHexCfg[slot1 == 0 and slot0 or slot0 * 10 + slot1] then
			return WarchessHexCfg[slot2].interact == 1
		end

		return WarchessHexCfg[slot0].interact == 1
	end,
	IsMove = function (slot0, slot1)
		if WarchessHexCfg[slot1 == 0 and slot0 or slot0 * 10 + slot1] then
			return WarchessHexCfg[slot2].move ~= 0
		end

		return WarchessHexCfg[slot0].move ~= 0
	end,
	WayFindingWeight = function (slot0, slot1)
		if WarchessHexCfg[slot1 == 0 and slot0 or slot0 * 10 + slot1] then
			return WarchessHexCfg[slot2].move
		end

		return WarchessHexCfg[slot0].move
	end,
	IsWalkEvent = function (slot0, slot1)
		if WarchessHexCfg[slot1 == 0 and slot0 or slot0 * 10 + slot1] then
			return WarchessHexCfg[slot2].interact == 2
		end

		return WarchessHexCfg[slot0].interact == 2
	end,
	IsStoneInteract = function (slot0, slot1, slot2)
		if (slot1 == 0 and slot0 or slot0 * 10 + slot1) == ChessConst.HOLE_GRID_ID and slot2 == 2 then
			return false
		end

		if WarchessHexCfg[slot3] then
			return WarchessHexCfg[slot3].stonecaninteract == 1
		end

		return WarchessHexCfg[slot0].stonecaninteract == 1
	end,
	IsExplode = function (slot0)
		slot1 = slot0.typeID

		if WarchessHexCfg[slot0.status == 0 and slot1 or slot1 * 10 + slot2].explode == 1 then
			return true
		end

		return false
	end,
	IsBreakAuto = function (slot0)
		slot1 = uv0.ParseParameter(slot0)
		slot2 = slot0.typeID

		if WarchessHexCfg[slot0.status == 0 and slot2 or slot2 * 10 + slot3].interact ~= 2 then
			return false
		end

		for slot8, slot9 in pairs(slot1) do
			if slot9.eventID == 10402 then
				return true
			end
		end

		return false
	end,
	LoadMap = function (slot0)
		slot1 = nil

		return uv0.decode(AssetEx.LoadText("Map/Chess/JsonMap/" .. slot0 .. ".json"))
	end,
	GetPosViaDir = function (slot0, slot1, slot2)
		return slot0 + uv0[slot2 + 1][1], slot1 + uv0[slot2 + 1][2]
	end,
	ParseParameter = function (slot0, slot1, slot2)
		slot3 = nil

		if slot1 then
			if type(slot0.paramList) ~= "table" or #slot0.paramList <= 0 then
				return {}
			end

			slot3 = slot0.paramList[1]
		else
			if slot0.paramList.Length <= 0 then
				return {}
			end

			slot3 = slot0.paramList[0]
		end

		if not WarchessEventPoolCfg[slot3] or not slot3 then
			return {}
		end

		slot4 = nil

		if not slot2 and not WarchessEventPoolCfg[slot3].event_group or not WarchessEventPoolCfg[slot3].event_group_second or slot4 == "" then
			return {}
		end

		return uv0.ParseEventPollCfg(slot4)
	end,
	ParseEventPollCfg = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			slot1[slot5] = {
				params = {}
			}

			for slot10 = 1, #slot6 do
				if slot10 == 1 then
					slot1[slot5].eventID = slot6[slot10]
				else
					slot1[slot5].params[#slot1[slot5].params + 1] = slot6[slot10]
				end
			end
		end

		return slot1
	end,
	ParseToEvents = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in pairs(slot0) do
			if ChessEventConfig[slot7.eventID][slot1] then
				slot2[#slot2 + 1] = slot7.eventID
			elseif slot1 ~= ChessConst.TIMING_CLICK and ChessEventConfig[slot7.eventID][ChessConst.TIMING_ALL] then
				slot2[#slot2 + 1] = slot7.eventID
			end
		end

		return slot2
	end,
	IsSavingEvent = function (slot0)
		for slot4, slot5 in pairs(ChessConst.EVENT) do
			if not ChessEventConfig[slot0] then
				-- Nothing
			end

			if ChessEventConfig[slot0][slot5] then
				return true
			end
		end

		return false
	end,
	GetProgress = function (slot0)
		return WarChessData:GetBoxNum(slot0, ChessConst.BOX.SMALL) * WarchessLevelCfg[slot0].sbox_progress + WarChessData:GetBoxNum(slot0, ChessConst.BOX.BIG) * WarchessLevelCfg[slot0].lbox_progress > 100 and 100 or slot3 + slot4
	end,
	IsFinish = function (slot0)
		return WarchessLevelCfg[slot0].success_progress <= uv0.GetProgress(slot0)
	end,
	TwoDToOneD = function (slot0, slot1)
		return slot1 * 1000 + slot0
	end,
	OneDToTwoD = function (slot0)
		slot1, slot2 = nil

		return math.fmod(slot0, 1000), math.floor(slot0 / 1000)
	end,
	GetExtendID = function (slot0, slot1)
		slot2 = nil
		slot3 = table.keyof(slot0, slot1)

		if #slot0 <= 1 then
			slot2 = slot0[1]
		elseif not slot3 then
			slot2 = slot0[1]
		else
			if math.fmod(slot3 + 1, #slot0 + 1) == 0 then
				slot3 = slot3 + 1
			end

			slot2 = slot0[slot3]
		end

		return slot2
	end,
	GetWarChessItemSprite = function (slot0)
		return getSprite("Atlas/BattleFlag", WarchessItemCfg[slot0].icon)
	end,
	GetChapterProgress = function (slot0)
		if WarchessLevelCfg[slot0] == nil then
			return 0
		end

		return WarChessData:GetBoxNum(slot0, ChessConst.BOX.SMALL) * WarchessLevelCfg[slot0].sbox_progress + WarChessData:GetBoxNum(slot0, ChessConst.BOX.BIG) * WarchessLevelCfg[slot0].lbox_progress > 100 and 100 or slot3 + slot4
	end,
	EnterChessMap = function (slot0, slot1)
		slot2, slot3 = nil

		if not WarchessLevelCfg[(slot1 or ChapterClientCfg[slot0].chapter_list[1]) and slot0] then
			-- Nothing
		end

		if WarChessData:GetCurrentChapter(WarchessLevelCfg[slot2].activity) ~= 0 then
			slot6 = ChapterClientCfg[slot5] or WarchessLevelCfg[slot5]
			slot3 = slot6.name or slot6.name_level
		end

		if slot5 == 0 or slot5 ~= slot2 then
			WarChessData:AboutToStart()
		end

		function slot6()
			WarChessData:SetRedPoint(uv0)

			slot0, slot1 = gameContext:GetLastHistoryAndParams()

			WarChessData:SetTemporaryData("url", slot0)
			WarChessData:SetTemporaryData("urlParams", slot1)

			if getStoryViaStageID(uv0, manager.story.BEFORE) and not manager.story:IsStoryPlayed(slot2) then
				slot3 = manager.story

				slot3:StartStoryOnEnterChessMap(slot2, function ()
					PlayerAction.ChangeStoryList(uv0)
					WarChessAction.RequireWarChessInfo(uv1)
				end)
			else
				WarChessAction.RequireWarChessInfo(uv0)
			end
		end

		if slot5 == 0 then
			slot6()

			return
		end

		if slot5 ~= slot2 then
			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = System.String.Format(GetTips("OPEN_NEW_WARCHESS"), GetI18NText(slot3), GetI18NText(slot3)),
				OkCallback = function ()
					uv0()
				end,
				CancelCallback = function ()
				end
			})
		else
			slot6()
		end
	end,
	IsShowMessage = function (slot0, slot1)
		if WarchessEventPoolCfg[slot0].click_form == "" then
			return slot2
		end

		for slot6, slot7 in ipairs(slot2) do
			if slot7[1] == slot1 then
				return {
					slot7[2],
					slot7[3]
				}
			end
		end

		return ""
	end,
	CantReach = function (slot0, slot1)
		ShowTips("CANNOT_GO")
		TimeTools.StartAfterSeconds(1.2, function (slot0, slot1)
			if manager.ChessManager then
				manager.ChessManager:SetGridSelectOutline(slot0, slot1, false)
			end
		end, {
			slot0,
			slot1
		})
	end,
	IsInRange = function (slot0, slot1, slot2)
		return slot0 >= -slot2 and slot0 <= slot2 and math.max(-slot2, slot0 - slot2) <= slot1 and slot1 <= math.min(slot2, slot0 + slot2)
	end,
	PhraseArea = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			if slot6[1] == 1 then
				slot8 = slot6[2]
				slot9 = slot6[3]
				slot10 = slot6[4]

				for slot14 = -slot10, slot10 do
					slot18 = slot10

					for slot18 = math.max(-slot10, slot14 - slot10), math.min(slot18, slot14 + slot10) do
						slot1[uv0.TwoDToOneD(slot14 + slot8, slot18 + slot9)] = true
					end
				end
			elseif slot7 == 2 then
				slot8 = slot6[2]
				slot9 = slot6[3]
				slot10 = slot6[4]
				slot11 = slot6[5]
				slot1[uv0.TwoDToOneD(slot8, slot9)] = true
				slot1[uv0.TwoDToOneD(slot8, slot11)] = true
				slot1[uv0.TwoDToOneD(slot10, slot9)] = true
				slot1[uv0.TwoDToOneD(slot10, slot11)] = true
			elseif slot7 == 3 then
				for slot11 = 2, #slot6, 2 do
					slot1[uv0.TwoDToOneD(slot6[slot11], slot6[slot11 + 1])] = true
				end
			end
		end

		return slot1
	end,
	DoSpecialEvent = function (slot0, slot1)
		ChessSpecialEventConfig[slot0][slot1] or ChessSpecialEventConfig[slot0][ChessConst.TIMING_ALL](unpack(WarchessSpecialEventCfg[slot0].param))
	end,
	CreateChessData = function (slot0, slot1, slot2, slot3)
		return {
			tag = 0,
			pos = {
				x = slot0,
				z = slot1
			},
			direction = (slot2[slot3].rotationY or 0) / 60,
			status = slot2[slot3].status,
			attribute = {}
		}
	end,
	CheckCanEnterMutiBattle = function (slot0, slot1)
		slot2 = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS

		for slot6 = 1, slot0 do
			if #BattleTeamData:GetSingleTeam(slot2, slot1, nil, slot6) == 0 or slot7[1] == 0 then
				return false
			end
		end

		return true
	end,
	CreateChessDataViaJson = function (slot0)
		slot1 = Chess.GridData.New()
		slot1.paramList = slot0.paramList
		slot1.prefab = slot0.prefab
		slot1.rotationY = slot0.rotationY
		slot1.status = slot0.status
		slot1.typeID = slot0.typeID
		slot1.x = slot0.x
		slot1.z = slot0.z

		return slot1
	end,
	CreateStack = function ()
		slot0 = {}
		slot1 = 1

		setmetatable(slot0, {
			__index = function (slot0, slot1)
				if slot1 == "push" then
					return function (slot0)
						uv0[uv1] = slot0
						uv1 = uv1 + 1
					end
				end

				if slot1 == "pop" then
					return function ()
						uv0 = uv0 - 1
						uv1[uv0] = nil

						return uv1[uv0]
					end
				end

				return rawget(uv0, slot1)
			end,
			__newindex = function (slot0, slot1, slot2)
				rawset(uv0, slot1, slot2)
			end,
			__pairs = function ()
				return function (slot0, slot1)
					slot2, slot3 = next(uv0, slot1)

					return slot2, slot3
				end
			end,
			__len = function ()
				return #uv0
			end
		})

		return slot0
	end,
	GetExtendIDByStoneStatus = function (slot0)
		if slot0 == 1 then
			return WarChessData:GetCacheExtendID("stone_1")
		else
			return WarChessData:GetCacheExtendID("stone_2")
		end
	end,
	GetStoneNextState = function (slot0, slot1)
		if slot0 == slot1[1] then
			return slot1[2]
		else
			return slot1[1]
		end
	end
}
