slot1 = class("ChatGuildRecruitItemView", import("game.views.chat.loopScrollView.LoopScrollViewBaseItem"))

function slot1.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.guildItemView_ = ChatGuildInfoView.New(slot0.guildRecruitGo_)

	slot0:Show(true)
end

function slot1.Dispose(slot0)
	slot0.guildItemView_:Dispose()

	slot0.guildItemView_ = nil

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot1.GetUserID(slot0)
	return slot0.itemData_.id
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonHead_, nil, function ()
		if CooperationData:CheckInRoom() then
			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0:GetUserID())
	end)
end

function slot1.GetNick(slot0)
	return slot0.itemData_.nick
end

function slot1.SetText(slot0, slot1)
	if slot1.id == USER_ID then
		slot2 = PlayerData:GetPlayerInfo()
		slot0.textName_.text = slot2.nick
		slot0.imageIcon_.sprite = ItemTools.getItemSprite(slot2.portrait)
		slot0.imageFrame_.sprite = ItemTools.getItemSprite(slot2.icon_frame)
	else
		slot0.textName_.text = slot1.nick
		slot0.imageIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[slot1.icon].icon)
		slot0.imageFrame_.sprite = ItemTools.getItemSprite(slot1.iconFrame)
	end

	if slot1.content == "" then
		SetActive(slot0.contentGo_, false)
	else
		SetActive(slot0.contentGo_, true)

		slot0.contentText_.text = slot1.content
	end
end

function slot1.SetData(slot0, slot1, slot2)
	slot0.itemData_ = slot1
	slot0.index_ = slot2

	slot0:SetText(slot1)
	slot0.guildItemView_:SetGuildID(tonumber(slot1.guildID))
	slot0:Show(true)
end

function slot1.SetAsLastSibling(slot0)
	slot0.transform_:SetAsLastSibling()
end

function slot1.SetAsFirstSibling(slot0)
	slot0.transform_:SetAsFirstSibling()
end

function slot1.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot1
