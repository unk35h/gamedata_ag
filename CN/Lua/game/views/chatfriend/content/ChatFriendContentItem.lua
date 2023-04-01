slot1 = class("ChatFirendContentItem", import("game.views.chat.chatItem.ChatItemView"))

function slot1.GetUserID(slot0)
	return slot0.itemData_.senderID
end

function slot1.GetNick(slot0)
	return FriendsData:GetInfoByID(slot0.itemData_.senderID).nick
end

function slot1.SetText(slot0, slot1)
	slot0.textName_.text = manager.time:FormatTime(slot1.timestamp)

	if slot1.senderID == tostring(PlayerData:GetPlayerInfo().userID) then
		slot0.imageIcon_.sprite = ItemTools.getItemSprite(slot2.portrait)
		slot0.imageFrame_.sprite = ItemTools.getItemSprite(slot2.icon_frame)
	else
		if FriendsData:GetInfoByID(slot4) == false then
			print("unfind friend data", slot4)
			slot0:Show(false)

			return
		end

		slot0.imageIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[slot5.icon].icon)
		slot0.imageFrame_.sprite = ItemTools.getItemSprite(slot5.icon_frame)
	end
end

function slot1.CalcOffsetY(slot0)
	slot2 = slot0.rectReportParent_.rect.height / 2

	if slot0.rectReportParent_:InverseTransformPoint(slot0.rectScrollView_:TransformPoint(Vector3.zero)).y < -20 then
		return slot1.y + slot2
	else
		return 0
	end
end

return slot1
