SubPlotBaseView = import("game.views.sectionSelect.subPlot.base.SubPlotBaseView")
slot0 = class("SubPlotHeraView", SubPlotBaseView)

function slot0.UIName(slot0)
	return "UI/MardukUI/hera/HeraStoryUI"
end

function slot0.GetItemClass(slot0)
	return SubPlotHeraItem
end

return slot0
