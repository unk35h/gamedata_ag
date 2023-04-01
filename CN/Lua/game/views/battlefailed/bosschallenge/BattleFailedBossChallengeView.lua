BattleFailedWithButtonView = import("game.views.battleFailed.BattleFailedWithButtonView")
slot0 = class("BattleFailedBossChallengeView", BattleFailedWithButtonView)

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		uv0:Quit()
	end, 20, 1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
