SubPlotBaseView = import("game.views.sectionSelect.subPlot.base.SubPlotBaseView")
slot0 = class("SubPlotTyrView", SubPlotBaseView)

function slot0.UIName(slot0)
	return "UI/BranchlineUI/DFPlotTyreUI"
end

function slot0.GetItemClass(slot0)
	return SubPlotTyrItem
end

return slot0
