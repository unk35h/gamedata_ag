BattleFailedWithButtonView = import("game.views.battleFailed.BattleFailedWithButtonView")
slot0 = class("BattleFailedSequentialView", BattleFailedWithButtonView)

function slot0.OnClickRestart(slot0)
	slot1 = slot0.params_.stageData:GetActivityID()

	BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, SequentialBattleChapterCfg[slot1].stage_id[SequentialBattleData:GetCurrentFinishStageIndex(slot1) + 1], slot1))
end

function slot0.OnClickBack(slot0)
	slot1 = slot0.params_.stageData
	slot1 = slot1:GetActivityID()

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("SEQUENTIAL_BATTLE_RESET_STAGE"),
		OkCallback = function ()
			SequentialBattleAction.ResetTeam(uv0, function (slot0)
				if isSuccess(slot0.result) then
					SequentialBattleData:ResetChapterTeamData(uv0)
					uv1:Quit()
				else
					ShowTips(slot0.result)
				end
			end)
		end
	})
end

return slot0
