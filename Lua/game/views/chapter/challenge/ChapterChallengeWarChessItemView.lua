slot0 = class("ChapterChallengeWarChessItemView", import(".ChapterChallengeItemView"))

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)
	SetActive(slot0.openGo_, false)
end

function slot0.ClickItem(slot0, slot1)
	JumpTools.GoToSystem("/warChessStage", {
		chapterClientID = slot1
	}, ViewConst.SYSTEM_ID.WARCHESS)
	WarChessAction.CancelWarChessRedPoint()
end

function slot0.AddRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.WARCHESS)
end

function slot0.RemoveRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
end

return slot0
