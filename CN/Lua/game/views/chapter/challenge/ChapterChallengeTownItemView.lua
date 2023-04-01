slot1 = class("ChapterChallengeTownItemView", import(".ChapterChallengeItemView"))

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)
	SetActive(slot0.openGo_, false)
end

function slot1.ClickItem(slot0, slot1)
	JumpTools.GoToSystem("/towerStage", nil, ViewConst.SYSTEM_ID.TOWER)
	TowerAction.CancelTowerRedPoint()
end

function slot1.AddRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.TOWER)
end

function slot1.RemoveRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
end

return slot1
