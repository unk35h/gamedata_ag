slot0 = class("ChessEventQueue")

function slot0.Ctor(slot0)
	slot0.eventQueue_ = {}
	slot0.eventQueueP_ = 0
end

function slot0.Clear(slot0)
	slot0.eventQueue_ = {}
	slot0.eventQueueP_ = 0
end

function slot0.GetCurFunc(slot0)
	slot1 = slot0.eventQueue_[slot0.eventQueueP_]
	slot2 = slot1.list
	slot3 = slot1.eventP

	return slot2[slot3].func, slot2[slot3].params
end

function slot0.PromoteCurEventProgress(slot0)
	slot1 = slot0.eventQueue_[slot0.eventQueueP_]
	slot1.eventP = slot1.eventP + 1
end

function slot0.PromoteToNextEvent(slot0)
	if slot0.eventQueueP_ == #slot0.eventQueue_ then
		return false
	end

	slot0.eventQueueP_ = slot0.eventQueueP_ + 1

	return true
end

function slot0.IsEventEnd(slot0)
	if #slot0.eventQueue_ == 0 then
		return true
	end

	slot1 = slot0.eventQueue_[slot0.eventQueueP_]

	return slot1.eventP > #slot1.list
end

function slot0.GetCurTiming(slot0)
	if not slot0.eventQueue_[slot0.eventQueueP_] then
		return 0
	end

	return slot0.eventQueue_[slot0.eventQueueP_].timing
end

function slot0.GetExecutingChess(slot0)
	for slot4 = slot0.eventQueueP_, 1, -1 do
		if slot0.eventQueue_[slot4].gridData then
			return slot0.eventQueue_[slot4].gridData
		end
	end
end

function slot0.InsertNewEventQueue(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetCurTiming()
	slot5 = {
		eventP = 1,
		gridData = slot3,
		timing = slot2,
		list = {}
	}

	for slot9, slot10 in ipairs(slot1) do
		if not ChessEventConfig[slot10.eventID] then
			-- Nothing
		end

		slot5.list[#slot5.list + 1] = {
			eventID = slot10.eventID,
			func = ChessEventConfig[slot10.eventID][slot2] or ChessEventConfig[slot10.eventID][ChessConst.TIMING_ALL],
			params = slot10.params
		}
	end

	table.insert(slot0.eventQueue_, slot5)

	return #slot1
end

function slot0.InsertCurEventQueue(slot0, slot1)
	slot2 = slot0.eventQueue_[slot0.eventQueueP_]

	for slot8 = #slot2.list, slot2.eventP, -1 do
		slot3[slot8 + #slot1] = slot3[slot8]
	end

	slot5 = slot2.timing
	slot6 = 1

	for slot10 = slot4, slot4 + #slot1 - 1 do
		slot11 = slot1[slot6]
		slot3[slot10] = {
			eventID = slot11.eventID,
			func = ChessEventConfig[slot11.eventID][slot5] or ChessEventConfig[slot11.eventID][ChessConst.TIMING_ALL],
			params = slot11.params
		}
		slot6 = slot6 + 1
	end
end

function slot0.LastEventID(slot0)
	if slot0.eventQueueP_ == 0 then
		return nil
	end

	if slot0.eventQueue_[slot0.eventQueueP_].eventP == 1 then
		return nil
	end

	return slot1.list[slot1.eventP - 1].eventID
end

function slot0.CurEventTiming(slot0)
	if not slot0.eventQueue_[slot0.eventQueueP_] then
		return nil
	end

	return slot0.eventQueue_[slot0.eventQueueP_].timing
end

return slot0
