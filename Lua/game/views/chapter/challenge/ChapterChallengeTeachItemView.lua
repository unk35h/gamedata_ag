slot1 = class("ChapterChallengeTeachItemView", import(".ChapterChallengeItemView"))

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)
	SetActive(slot0.openGo_, false)
end

function slot1.ClickItem(slot0, slot1)
	slot0:Go("/teachStage")
end

function slot1.AddRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.TEACH)
end

function slot1.RemoveRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
end

return slot1
