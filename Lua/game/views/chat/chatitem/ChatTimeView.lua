slot0 = class("ChatTimeView", ChatBaseItemView)

function slot0.IsTimeBar(slot0)
	return true
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.textTimeStamp_.text = manager.time:FormatTime(slot1.timestamp)
	slot0.index_ = slot2

	slot0:Show(true)
end

return slot0
