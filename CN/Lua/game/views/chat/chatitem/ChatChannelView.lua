slot0 = class("ChatChannelView", ChatBaseItemView)

function slot0.SetData(slot0, slot1, slot2)
	slot0.textTitle_.text = string.format(GetTips("ENTER_CHAT_CHANNEL"), slot1.content)
	slot0.index_ = slot2

	slot0:Show(true)
end

return slot0
