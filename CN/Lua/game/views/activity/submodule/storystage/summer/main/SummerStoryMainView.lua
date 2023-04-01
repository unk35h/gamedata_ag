slot0 = class("SummerStoryMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerIslandMapUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.itemList_ = {}
	slot4 = ActivityConst.SUMMER_CHESS_ISLAND

	for slot4, slot5 in ipairs(WarchessLevelCfg.get_id_list_by_activity[slot4]) do
		slot0.itemList_[slot4] = SummerStoryMainWarchessItem.New(slot0[string.format("sideStoryGo%s_", slot4)], slot5)
	end

	slot0.mainItem_ = SummerStoryMainItem.New(slot0.mainStoryGo_, ActivityStoryChapterCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_STORY_ISLAND][1])
	slot0.seabedItem_ = SummerStorySeabedItem.New(slot0.seabedGo_, ActivityStoryChapterCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_STORY_SEABED][1], ActivityConst.SUMMER_STORY_SEABED)
	slot0.plotController_ = ControllerUtil.GetController(slot0.sideStoryBtn_.transform, "name")
	slot0.chessController_ = ControllerUtil.GetController(slot0.shipLogBtn_.transform, "name")
end

function slot0.OnEnter(slot0)
	slot4 = {
		BACK_BAR,
		slot5
	}
	slot5 = HOME_BAR

	manager.windowBar:SwitchBar(slot4)
	slot0.mainItem_:OnEnter()
	slot0.seabedItem_:OnEnter()

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:OnEnter()
	end

	slot0.unLockSideStoryState_ = ActivityTools.IsUnlockActivity(ActivityConst.SUMMER_CHESS_SHIP_LOG)
	slot0.unLockChipLogState_ = ActivityTools.IsUnlockActivity(ActivityConst.SUMMER_CHESS_SHIP_LOG)

	slot0:RefreshUI()
	manager.redPoint:bindUIandKey(slot0.sideStoryBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER))
	manager.redPoint:bindUIandKey(slot0.shipLogBtn_.transform, string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.SUMMER_CHESS_SHIP_LOG))

	if not getData("ActivityFirstEnter", ActivityConst.THEME.SUMMER, false) then
		slot1 = ActivityStoryChapterCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_STORY_ISLAND][1]

		if StoryStageActivityData:GetStageData(slot1)[ActivityStoryChapterCfg[slot1].stage_list[1]] and slot3.clear_times > 0 then
			return
		end

		saveData("ActivityFirstEnter", ActivityConst.THEME.SUMMER, true)
		slot0:Go("/summerStageMain", {
			theme = ActivityConst.THEME.SUMMER,
			chapterID = slot1
		})
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.sideStoryBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER))

	slot4 = slot0.shipLogBtn_.transform
	slot5 = string.format

	manager.redPoint:unbindUIandKey(slot4, slot5("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.SUMMER_CHESS_SHIP_LOG))
	slot0.mainItem_:OnExit()
	slot0.seabedItem_:OnExit()

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.mainItem_:Dispose()

	slot0.mainItem_ = nil

	slot0.seabedItem_:Dispose()

	slot0.seabedItem_ = nil

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.timeList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.sideStoryBtn_, nil, function ()
		if not uv0.unLockSideStoryState_ then
			slot0 = ActivityCfg[ActivityConst.SUMMER_CHESS_SHIP_LOG].unlock_condition

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityStoryChapterCfg[slot0[2][1]].name, BattleActivityStoryStageCfg[slot0[2][2]].name))

			return
		end

		uv0:Go("/summerPlot", {
			theme = ActivityConst.THEME.SUMMER
		})
	end)
	slot0:AddBtnListener(slot0.shipLogBtn_, nil, function ()
		if not uv0.unLockChipLogState_ then
			slot0 = ActivityCfg[ActivityConst.SUMMER_CHESS_SHIP_LOG].unlock_condition

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityStoryChapterCfg[slot0[2][1]].name, BattleActivityStoryStageCfg[slot0[2][2]].name))

			return
		end

		uv0:Go("/summerChess", {
			activityId = ActivityConst.SUMMER_CHESS_SHIP_LOG
		})
	end)
end

function slot0.RefreshUI(slot0)
	slot1, slot2 = ActivityTools.GetActivityChessProgress(ActivityConst.SUMMER_CHESS_ISLAND)
	slot0.exploreText_.text = string.format("%d%%", math.floor(slot1 / slot2))

	if slot0.unLockSideStoryState_ then
		slot0.plotController_:SetSelectedState("on")
	else
		slot0.plotController_:SetSelectedState("off")
	end

	if slot0.unLockChipLogState_ then
		slot0.chessController_:SetSelectedState("on")
	else
		slot0.chessController_:SetSelectedState("off")
	end
end

return slot0
