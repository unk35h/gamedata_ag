slot1 = manager.net

slot1:Bind(24019, function (slot0)
	SkuldTravelData:SetData(slot0)
	manager.notify:CallUpdateFunc(SKULD_STATE_CHANGE)
end)

return {
	GotoTravel = function (slot0, slot1)
		manager.net:SendWithLoadingNew(24020, {
			plot_id = slot1
		}, 24021, handler(slot0, slot0.OnGotoTravel))
	end,
	OnGotoTravel = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			SkuldTravelData:SetTravelStatu(1)
			JumpTools.OpenPageByJump("skuldTravelTipsView")
			manager.notify:CallUpdateFunc(SKULD_STATE_CHANGE)
		else
			ShowTips(slot1.result)
		end
	end,
	OpenEnding = function (slot0, slot1)
		manager.net:SendWithLoadingNew(24022, {
			ending_id = slot1
		}, 24023, handler(slot0, slot0.OnOpenEnding))
	end,
	OnOpenEnding = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			SkuldTravelData:OpenEnding(slot2.ending_id)

			if table.indexof(TravelSkuldEndingCfg.all, slot2.ending_id) > 3 then
				BattleController.GetInstance():LaunchStoryBattle(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, GameSetting.travel_skuld_new_ending_stage_id.value[1], 0)
			else
				JumpTools.OpenPageByJump("skuldTravelFinalPlotView", {
					endingid = slot2.ending_id
				})
			end

			manager.notify:CallUpdateFunc(SKULD_OPENENDING)
		else
			ShowTips(slot1.result)
		end
	end,
	GetTravelReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(24024, {
			task_id = slot1
		}, 24025, handler(slot0, slot0.OnGetTravelReward))
	end,
	OnGetTravelReward = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			SkuldTravelData:GetedTaskReward(slot2.task_id)
			manager.notify:CallUpdateFunc(SKULD_GETREWARD)
		else
			ShowTips(slot1.result)
		end
	end,
	ReadTravelResult = function (slot0)
		manager.net:SendWithLoadingNew(24026, {}, 24027, handler(slot0, slot0.OnReadTravelResult))
	end,
	OnReadTravelResult = function (slot0, slot1)
		if isSuccess(slot1.result) then
			SkuldTravelData:SetTravelStatu(0)
			manager.notify:CallUpdateFunc(SKULD_STATE_CHANGE)
		else
			ShowTips(slot1.result)
		end
	end,
	CheckUnBindActivitySkuld = function (slot0)
		slot1 = RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
		slot2 = RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
		slot3 = RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
		slot4 = RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
		slot5 = RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_1_6) then
			manager.redPoint:addGroup(slot1, {
				slot4,
				slot2,
				slot3
			})
			manager.redPoint:addGroup(slot5, {
				slot4,
				slot2,
				slot3
			})
		else
			manager.redPoint:delGroup(slot1, {
				slot4,
				slot2
			})
		end
	end,
	CheckUnBindChapterKey = function (slot0)
		slot1 = RedPointConst.TRAVEL_SKULD_CHAPTER .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
		slot2 = RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL

		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_1_6) then
			manager.redPoint:addGroup(slot1, {
				slot2
			})
		elseif ChapterTools.IsFinishPreChapter(SkuldTravelData:GetChapterID()) then
			manager.redPoint:addGroup(slot1, {
				slot2
			})
		else
			manager.redPoint:delGroup(slot1, {
				slot2
			})
		end
	end
}
