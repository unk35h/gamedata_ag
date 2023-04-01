slot0 = class("SequentialBattleFactoryTeamView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/continuousBattle/MardukContinuousBattleTeamUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.teamUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, SequentialBattleFactoryTeamItem)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.activityID_ = slot0.params_.activityID

	slot0.teamUIList_:StartScroll(#SequentialBattleChapterCfg[slot0.activityID_].stage_id)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.teamUIList_:Dispose()

	slot0.teamUIList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buffBtn_, nil, function ()
		JumpTools.OpenPageByJump("sequentialBattleBuffInfo", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("SEQUENTIAL_BATTLE_RESET_TEAM"),
			OkCallback = function ()
				SequentialBattleAction.ResetTeam(uv0.activityID_, function (slot0)
					if isSuccess(slot0.result) then
						SequentialBattleData:ResetChapterTeamData(uv0.activityID_)
						SequentialBattleData:ResetChapterCacheTeamData(uv0.activityID_)
						uv0.teamUIList_:StartScroll(#SequentialBattleChapterCfg[uv0.activityID_].stage_id)
					else
						ShowTips(slot0.result)
					end
				end)
			end
		})
	end)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		for slot3 = 1, #SequentialBattleChapterCfg[uv0.activityID_].stage_id do
			if SequentialBattleData:GetHeroTeam(uv0.activityID_, slot3)[1] == nil or slot4[1].heroID == nil or slot4[1].heroID == 0 then
				ShowTips("SEQUENTIAL_BATTLE_TEAM_IS_NULL")

				return
			end
		end

		SequentialBattleAction.SaveAllTeam(uv0.activityID_, function (slot0)
			if isSuccess(slot0.result) then
				BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, SequentialBattleChapterCfg[uv0.activityID_].stage_id[1], uv0.activityID_))
			else
				ShowTips(slot0.result)
			end
		end)
	end)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot0.activityID_, slot1)
end

return slot0
