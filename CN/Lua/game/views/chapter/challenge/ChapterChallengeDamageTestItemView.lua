slot1 = class("ChapterChallengeDamageTestItemView", import(".ChapterChallengeItemView"))

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)
	SetActive(slot0.openGo_, false)
end

function slot1.ClickItem(slot0, slot1)
	slot0:Go("/damageTestMode")
end

return slot1
