ActivityStoryStageBaseView = import("game.views.activity.Submodule.storyStage.base.ActivityStoryStageBaseView")
slot0 = class("ActivityAthenaStoryView", ActivityStoryStageBaseView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIDownUI/SubPlot/VolumeIIIDownSubPlotUI"
end

function slot0.GetItemClass(slot0)
	return ActivityAthenaStoryItem
end

return slot0
