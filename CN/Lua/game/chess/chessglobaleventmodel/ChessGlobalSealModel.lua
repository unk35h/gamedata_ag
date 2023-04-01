slot0 = class("ChessGlobalSealModel")

function slot1(slot0)
	if not slot0 or slot0.paramList.Length == 0 then
		return false
	end

	if WarchessEventPoolCfg[slot0.paramList[0]].event_group_second == "" then
		return false
	end

	for slot5, slot6 in ipairs(slot1) do
		if slot6[1] == 15001 then
			return true
		end
	end

	return false
end

function slot0.Ctor(slot0)
	slot0.areaMemory_ = {}
	slot0.isRight_ = false
	slot0.areaCount_ = 0
	slot0.defaultState_ = 0
	slot0.sealState_ = 0
	slot0.successState_ = 0
end

function slot0.SetUp(slot0, slot1)
	slot0.curEventID_ = slot1
	slot0.areaMemory_ = {}
	slot2 = WarchessGlobalCfg[slot1].params
	slot3 = slot2[1]
	slot4 = slot2[2]
	slot5 = slot2[3]
	slot0.areaCount_ = 0
	slot0.sealState_ = slot2[4][1]
	slot0.successState_ = slot2[4][2]

	for slot9 = -slot5, slot5 do
		slot13 = slot5

		for slot13 = math.max(-slot5, slot9 - slot5), math.min(slot13, slot9 + slot5) do
			if uv0(ChessLuaBridge.GetGridData(slot9 + slot3, slot13 + slot4)) then
				if slot14.status == slot0.defaultState_ then
					slot0.areaMemory_[ChessTools.TwoDToOneD(slot9 + slot3, slot13 + slot4)] = 1
					slot0.areaCount_ = slot0.areaCount_ + 1
				else
					slot0.areaMemory_[ChessTools.TwoDToOneD(slot9 + slot3, slot13 + slot4)] = 0
				end
			end
		end
	end

	WarChessData:SetGlobalEventProgress(WarchessGlobalCfg[slot0.curEventID_].type, slot0.curEventID_, slot0.areaCount_)
end

function slot0.IsConditionCheck(slot0)
	if slot0.areaCount_ == 0 then
		return true
	end

	return false
end

function slot0.ExecutePhase(slot0, slot1)
	slot0.areaMemory_ = {}

	manager.ChessManager:StopMove()
end

function slot0.UpdateProgress(slot0, slot1, slot2)
	if slot2 == ChessConst.TIMING_WALK then
		slot3 = manager.ChessManager:GetExecutingChess()

		if slot0.areaMemory_[ChessTools.TwoDToOneD(slot3.x, slot3.z)] and slot3.status == 0 then
			slot0.isRight_ = true
			slot0.areaMemory_[slot4] = 0
			slot0.areaCount_ = slot0.areaCount_ - 1
		else
			slot0.isRight_ = false
		end
	end
end

function slot0.ExternExecutePhase(slot0, slot1, slot2)
	if slot2 == ChessConst.TIMING_WALK then
		if slot0.isRight_ then
			slot3 = manager.ChessManager:GetExecutingChess()
			slot4 = {
				{
					10309,
					slot3.x,
					slot3.z,
					{
						slot0.sealState_
					}
				}
			}

			if slot0.areaCount_ == 0 then
				for slot8, slot9 in pairs(slot0.areaMemory_) do
					slot10, slot11 = ChessTools.OneDToTwoD(slot8)

					table.insert(slot4, {
						10309,
						slot10,
						slot11,
						{
							slot0.successState_
						}
					})
				end
			end

			return ChessTools.ParseEventPollCfg(slot4)
		else
			slot3 = {}

			for slot7, slot8 in pairs(slot0.areaMemory_) do
				if slot8 == 0 then
					slot9, slot10 = ChessTools.OneDToTwoD(slot7)

					table.insert(slot3, {
						10309,
						slot9,
						slot10,
						{
							slot0.defaultState_
						}
					})
				end
			end

			slot7 = slot0.curEventID_

			for slot7, slot8 in pairs(WarchessGlobalCfg[slot7].event_list2) do
				table.insert(slot3, slot8)
			end

			table.insert(slot3, {
				15002,
				9
			})

			return ChessTools.ParseEventPollCfg(slot3)
		end
	end
end

function slot0.Dispose(slot0)
	slot0.areaMemory_ = {}
	slot0.isRight_ = false
	slot0.areaCount_ = 0
	slot0.defaultState_ = 0
	slot0.sealState_ = 0
	slot0.successState_ = 0
end

return slot0
