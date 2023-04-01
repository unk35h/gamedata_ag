SummerStageBaseView = import("game.views.activity.Submodule.storyStage.summer.stage.SummerStageBaseView")
slot0 = class("SummerStageSeabedView", SummerStageBaseView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerSeafloorStoryUI"
end

function slot0.GetStageItemClass(slot0)
	return SummerStageSeabedItem
end

function slot0.GetActivityID(slot0)
	return ActivityConst.SUMMER_STORY_SEABED
end

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Go("/summerStageMain", {
			theme = ActivityConst.THEME.SUMMER,
			chapterID = ActivityStoryChapterCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_STORY_ISLAND][1]
		})
	end)
end

return slot0
