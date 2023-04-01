SummerStageBaseView = import("game.views.activity.Submodule.storyStage.summer.stage.SummerStageBaseView")
slot0 = class("SummerStageMainView", SummerStageBaseView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerMainStoryUI"
end

function slot0.GetStageItemClass(slot0)
	return SummerStageMainItem
end

function slot0.GetActivityID(slot0)
	return ActivityConst.SUMMER_STORY_ISLAND
end

return slot0
