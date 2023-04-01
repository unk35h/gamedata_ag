slot1 = class("ChatFriendHistoryTipsItem", import("game.views.chat.chatItem.ChatBaseItemView"))

function slot1.SetData(slot0, slot1, slot2)
	slot0.index_ = slot2
	slot0.itemData_ = slot1

	slot0:Show(true)
end

return slot1
