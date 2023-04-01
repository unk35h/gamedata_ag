slot1 = class("ChapterChallengeBossItemView", import(".ChapterChallengeItemView"))

function slot1.GetLostTime(slot0)
	if BattleBossChallengeData:GetNextRefreshTime() < manager.time:GetServerTime() then
		return manager.time:GetServerTime() + 604800
	end

	return slot1
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.BOSS_CHALLENGE)
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, RedPointConst.BOSS_CHALLENGE)
end

function slot1.ClickItem(slot0)
	BattleBossChallengeAction.EnterBossChallenge()
end

return slot1
