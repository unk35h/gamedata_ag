slot0 = class("BattleFailedView", ReduxView)
slot1 = import("game.tools.BattleInstance")

function slot0.UIName(slot0)
	return "UI/BattleResult/BattleFailed"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stayTime = 6
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.mask_, nil, function ()
		if uv0.isEnd then
			return
		end

		if Time.realtimeSinceStartup - uv0.startTime < 2 then
			return
		end

		uv0:Quit()
	end)
	slot0:AddBtnListener(slot0.btnBattleCount_, nil, function ()
		if uv0.isEnd then
			return
		end

		uv0:RemoveTimer()
		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = uv0.stageData,
			battleTime = uv0:GetBattleTime()
		})
	end)
end

function slot0.GetBattleTime(slot0)
	return manager.time:DescCdTime2((LuaExchangeHelper.GetBattleStatisticsData() or LuaExchangeHelper.GetBattleStatisticsDataBeforeBattleEnd()).dataForLua.battleTime)
end

function slot0.Quit(slot0)
	slot0.isEnd = true

	slot0:RemoveTimer()

	slot0.timer_ = Timer.New(function ()
		uv0.QuitBattle(uv1.params_.stageData, true, true)
	end, 1, 1)

	slot0.timer_:Start()
	slot0.animator_:Play("battleFailed_out")
end

function slot0.OnEnter(slot0)
	uv0.hideBattlePanel()
	slot0:RecordThreeStar()

	slot0.startTime = Time.realtimeSinceStartup
	slot0.isEnd = false

	slot0:RemoveTimer()

	slot0.timer_ = Timer.New(function ()
		uv0:Quit()
	end, slot0.stayTime, 1)

	slot0.timer_:Start()

	slot0.battleTimeText_.text = slot0:GetBattleTime()

	slot0.animator_:Play("battleFailed")
end

function slot0.OnExit(slot0)
	slot0:RemoveTimer()
end

function slot0.RemoveTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RecordThreeStar(slot0)
	slot0.stageData_ = slot0.params_.stageData
	slot0.stageID_ = slot0.stageData_:GetStageId()
	slot0.stageType_ = slot0.stageData_:GetType()
	slot1 = slot0.params_.starMissionData
	slot2 = {}

	for slot6 = 1, 3 do
		if slot1 ~= nil and slot1[slot6] ~= nil then
			slot7 = ThreeStarConditionCfg[slot1[slot6].id]
			slot8 = nil

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot0.stageType_ then
				slot8 = BattleStageData:GetStageData()[slot0.stageID_]
			elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == slot0.stageType_ then
				slot8 = BattleBossChallengeNormalData:GetStarList(slot0.stageID_)
			end

			slot9 = false

			if slot8 and slot8.stars and slot8.stars[slot6] == 1 then
				slot9 = true
			end

			slot10 = false

			if slot7.id == 15 or slot7.id == 16 then
				slot10 = slot1[slot6].isComplete
			end

			slot2[slot6] = (slot10 or slot9) and 1 or 0
		end
	end

	uv0.RecordThreeStar(slot0.stageType_, slot0.stageID_, slot2)
end

return slot0
