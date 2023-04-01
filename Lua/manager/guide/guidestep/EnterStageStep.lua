slot0 = class("EnterStageStep", BaseStep)

function slot0.Init(slot0)
	slot0.missionID = GuideStepCfg[slot0._stepId].params[1]
	slot0.reenterStageCnt_ = 0
	slot0.restartBattle_ = 0
end

function slot0.Play(slot0)
	BattleController.GetInstance():LaunchBattle(BattleChapterStageTemplate.New(slot0.missionID), handler(slot0, slot0.OnLaunchBattle))
end

function slot0.OnLaunchBattle(slot0, slot1)
	if isSuccess(slot1.result) then
		if slot0.timer_ then
			slot0.timer_:Stop()
		end

		slot0.timer_ = Timer.New(function ()
			if WaitStartBattle == false then
				uv0.timer_:Stop()

				uv0.timer_ = nil
				uv0.restartBattle_ = uv0.restartBattle_ + 1

				if uv0.restartBattle_ > 3 then
					uv0.restartBattle_ = 0

					GotoLoginView()
				else
					uv0:Play()
				end
			elseif WaitStartBattle == true then
				uv0:OnStepEnd()
			end
		end, 0.033, -1)

		slot0.timer_:Start()
	else
		ShowTips(slot1.result)

		if slot0.reenterStageCnt_ > 3 then
			GotoLoginView()
		else
			slot0:Play()

			slot0.reenterStageCnt_ = slot0.reenterStageCnt_ + 1
		end
	end
end

function slot0.OnStepEnd(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	uv0.super.OnStepEnd(slot0)
end

return slot0
