slot0 = singletonClass("BattleBossChallengeData")

function slot0.Ctor(slot0)
end

function slot0.Init(slot0)
	slot0.nextRefreshTime_ = 0
	slot0.oldTime_ = 0
	slot0.cacheSelectBossIndex_ = getData("BossChallenge", "bossIndex") or 1
	slot0.openModeList_ = {}
	slot0.selectMode_ = 0
end

function slot0.InitData(slot0, slot1)
	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_NORMAL, 0)
	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_ADVANCE, 0)

	slot0.selectMode_ = slot1.mode

	if slot0.nextRefreshTime_ ~= slot1.next_refresh_time then
		slot0.oldTime_ = slot0.nextRefreshTime_ ~= 0 and slot0.nextRefreshTime_ or slot1.next_refresh_time
	end

	slot0.nextRefreshTime_ = slot1.next_refresh_time
	slot0.openModeList_ = {}

	for slot5, slot6 in ipairs(slot1.difficulty_list) do
		table.insert(slot0.openModeList_, slot6)
	end

	if slot0.cooldownTimer_ then
		slot0.cooldownTimer_:Stop()

		slot0.cooldownTimer_ = nil
	end

	slot0.cooldownTimer_ = Timer.New(function ()
		if uv0.oldTime_ < manager.time:GetServerTime() or uv0.oldTime_ ~= uv1.next_refresh_time then
			uv0.oldTime_ = uv1.next_refresh_time

			manager.notify:Invoke(BOSS_CHALLENGE_BACK_ENTRACE)
			uv0.cooldownTimer_:Stop()

			uv0.cooldownTimer_ = nil
		end
	end, 1, -1)

	slot0.cooldownTimer_:Start()
end

function slot0.GetNextRefreshTime(slot0)
	return slot0.oldTime_
end

function slot0.Reset(slot0)
	slot0.selectMode_ = 0
end

function slot0.GetOpenModeList(slot0)
	return slot0.openModeList_
end

function slot0.SetSelectMode(slot0, slot1)
	slot0.selectMode_ = slot1
end

function slot0.GetSelectMode(slot0)
	return slot0.selectMode_
end

function slot0.GetCacheSelectBossIndex(slot0)
	return slot0.cacheSelectBossIndex_ or 1
end

function slot0.SaveCacheSelectBossIndex(slot0, slot1)
	saveData("BossChallenge", "bossIndex", slot1)

	slot0.cacheSelectBossIndex_ = slot1
end

return slot0
