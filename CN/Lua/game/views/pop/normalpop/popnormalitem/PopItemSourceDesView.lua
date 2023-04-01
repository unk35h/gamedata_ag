slot0 = class("PopItemSourceDesView", import("game.views.pop.PopItemView"))
slot1 = import("game.tools.ItemTools")

function slot0.CustomInitUI(slot0)
	SetActive(slot0.mergeBtn_.gameObject, false)
	SetActive(slot0.sourceBtnGo_, false)
	SetActive(slot0.operatePanel_, false)
	SetActive(slot0.sourceDesGo_, true)
end

function slot0.RefreshContent(slot0)
	slot1 = ItemCfg[slot0.itemInfo_[1]]
	slot2 = {
		id = slot0.itemInfo_[1],
		num = slot0.itemInfo_[2],
		time_valid = slot0.itemInfo_[4]
	}
	slot0.nameText_.text = slot1.name
	slot0.countentText_.text = slot1.desc

	if slot1.time == nil or slot1.time == "" then
		slot0.isCountdownController:SetSelectedState("false")
	elseif uv0.GetItemExpiredTimeByInfo(slot2) <= manager.time:GetServerTime() then
		slot0.isCountdownController:SetSelectedState("false")
	else
		slot0.isCountdownController:SetSelectedState("true")

		slot0.timeLabel_.text = string.format(GetTips("TIME_DISPLAY_12"), manager.time:STimeDescS(slot3, "!%Y/%m/%d %H:%M"))
	end

	if slot1.type == ItemConst.ITEM_TYPE.STICKER then
		if slot0.extraInfo_.isForeign then
			SetActive(slot0.isLockGo_, false)
		else
			SetActive(slot0.isLockGo_, PlayerData:GetSticker(slot1.id).unlock == 0)
		end
	else
		SetActive(slot0.isLockGo_, false)
	end

	slot0.sourceDesTxt_.text = slot1.desc_source
end

return slot0
