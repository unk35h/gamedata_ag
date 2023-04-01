slot1 = class("ChapterChallengeAbyssItemView", import(".ChapterChallengeItemView"))

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)
end

function slot1.ClickItem(slot0, slot1)
	slot0:Go("/abyssMain")
end

function slot1.GetLostTime(slot0)
	return AbyssData:GetRefreshTimestamp()
end

function slot1.AddRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.ABYSS)
end

function slot1.RemoveRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
end

return slot1
