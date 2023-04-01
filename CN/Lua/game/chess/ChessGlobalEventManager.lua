slot0 = class("ChessGlobalEventManager")

function slot0.Ctor(slot0, slot1)
	slot0.globalEventList_ = {}
	slot0.eventGlobalQueue_ = {}
	slot0.eventGlobalP_ = 1
	slot0.globalEventModels = {
		[ChessConst.GLOBAL.AREA] = ChessGlobalAreaModel.New(slot0),
		[ChessConst.GLOBAL.COUNT_STEP] = ChessGlobalCountDownModel.New(slot0),
		[ChessConst.GLOBAL.ORDER_EVENT] = ChessGlobalOrderEventModel.New(slot0),
		[ChessConst.GLOBAL.SEAL] = ChessGlobalSealModel.New(slot0),
		[ChessConst.GLOBAL.CHECK] = ChessGlobalCheckModel.New(slot0)
	}
	slot0.handler_ = slot1

	slot0:CreateGlobalEventList()
end

function slot0.CreateGlobalEventList(slot0)
	slot0.globalEventList_ = {}

	for slot5, slot6 in pairs(WarChessData:GetGlobalEventList()) do
		for slot10, slot11 in pairs(slot6) do
			if slot0.globalEventList_[slot10] then
				return
			end

			slot0.globalEventList_[slot10] = {}

			table.insert(slot0.globalEventList_[slot10], {
				params = WarchessGlobalCfg[slot10].params,
				eventList = ChessTools.ParseEventPollCfg(WarchessGlobalCfg[slot10].event_list)
			})

			if slot0.globalEventModels[slot5] then
				slot0.globalEventModels[slot5]:SetUp(slot10)
			end
		end
	end
end

function slot0.InsertGlobalEventList(slot0, slot1)
	slot2 = WarchessGlobalCfg[slot1].type

	if slot0.globalEventList_[slot1] then
		return
	end

	slot0.globalEventList_[slot1] = {}

	table.insert(slot0.globalEventList_[slot1], {
		params = WarchessGlobalCfg[slot1].params,
		eventList = ChessTools.ParseEventPollCfg(WarchessGlobalCfg[slot1].event_list)
	})

	if slot0.globalEventModels[slot2] then
		slot0.globalEventModels[slot2]:SetUp(slot1)
	end
end

function slot0.ClearGlobalEventByType(slot0, slot1)
	for slot5, slot6 in pairs(slot0.globalEventList_) do
		if WarchessGlobalCfg[slot5].type == slot1 then
			slot0.globalEventList_[slot5] = nil

			WarChessData:ClearGlobalEvent(slot1, slot5)
		end
	end
end

function slot0.ClearGlobalEventByID(slot0, slot1)
	slot0.globalEventList_[slot1] = nil

	WarChessData:ClearGlobalEvent(WarchessGlobalCfg[slot1].type, slot1)
end

function slot0.ExecuteGlobalEvent(slot0, slot1)
	slot5 = slot1

	slot0:UpdateEventProgress(slot5)

	for slot5, slot6 in pairs(slot0.globalEventList_) do
		for slot10, slot11 in pairs(slot6) do
			slot12 = WarchessGlobalCfg[slot5].type

			if slot0:IsConditionCheck(slot5, slot11.params, slot1) then
				if slot0.globalEventModels[slot12] and slot0.globalEventModels[slot12].ExternExecutePhase and slot0.globalEventModels[slot12]:ExternExecutePhase(slot5, slot1) then
					slot0:CreateGlobalEventQueue(slot13, "GLOBAL")
				end

				slot0:CreateGlobalEventQueue(slot11.eventList, "GLOBAL")

				if slot0.globalEventModels[slot12] then
					slot0.globalEventModels[slot12]:ExecutePhase(slot5)
				end

				slot0.globalEventList_[slot5] = nil

				WarChessData:ClearGlobalEvent(slot12, slot5)

				return
			end

			if slot0.globalEventModels[slot12] and slot0.globalEventModels[slot12].ExternExecutePhase and slot0.globalEventModels[slot12]:ExternExecutePhase(slot5, slot1) then
				slot0:CreateGlobalEventQueue(slot13, "GLOBAL")

				return
			end
		end
	end
end

function slot0.IsConditionCheck(slot0, slot1, slot2, slot3)
	if WarchessGlobalCfg[slot1].type == ChessConst.GLOBAL.START then
		return true
	elseif slot0.globalEventModels[slot4] then
		return slot0.globalEventModels[slot4]:IsConditionCheck(slot1, slot3)
	else
		slot5 = WarChessData:GetGlobalEventList()[slot4][slot1]
		slot6 = nil

		if type((slot4 ~= ChessConst.GLOBAL.PROGRESS and slot4 ~= ChessConst.GLOBAL.TALLY or slot2[1]) and slot2[2]) ~= "number" then
			-- Nothing
		end

		return slot6 <= slot5
	end
end

function slot0.UpdateEventProgress(slot0, slot1)
	for slot5, slot6 in pairs(slot0.globalEventList_) do
		slot8 = nil
		slot9 = WarchessGlobalCfg[slot5].params

		if WarchessGlobalCfg[slot5].type == ChessConst.GLOBAL.PROGRESS then
			WarChessData:SetGlobalEventProgress(slot7, slot5, ChessTools.GetProgress(WarChessData:GetCurrentChapter()))
		elseif slot7 == ChessConst.GLOBAL.EVENT then
			WarChessData:SetGlobalEventProgress(slot7, slot5, WarChessData:GetEventExecuteTime(slot9[1]) or 0)
		elseif slot0.globalEventModels[slot7] then
			slot0.globalEventModels[slot7]:UpdateProgress(slot5, slot1)
		end
	end
end

function slot0.CreateGlobalEventQueue(slot0, slot1, slot2)
	slot0.handler_:InsertEventQueue(slot1, slot2)
end

function slot0.Dispose(slot0)
	slot0.globalEventList_ = {}
	slot0.eventGlobalQueue_ = {}
	slot0.eventGlobalP_ = 1

	for slot4, slot5 in pairs(slot0.globalEventModels) do
		slot5:Dispose()
	end
end

return slot0
