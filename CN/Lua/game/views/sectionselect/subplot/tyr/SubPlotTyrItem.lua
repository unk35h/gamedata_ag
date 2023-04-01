SubPlotBaseItem = import("game.views.sectionSelect.subPlot.base.SubPlotBaseItem")
slot0 = class("SubPlotHeraItem", SubPlotBaseItem)

function slot0.Ctor(slot0, ...)
	uv0.super.Ctor(slot0, ...)

	slot0.lineController_ = ControllerUtil.GetController(slot0.transform_, "connect")
end

function slot0.RefreshCustomUI(slot0)
	slot0.textIndex_.text = BattleActivityStoryStageCfg[slot0.stageID_].name

	if table.keyof(ChapterCfg[slot0.chapterID_].section_id_list, slot0.stageID_) == 1 then
		slot0.lineController_:SetSelectedState("01")
	elseif slot3 % 2 == 0 then
		slot0.lineController_:SetSelectedState("02")
	else
		slot0.lineController_:SetSelectedState("03")
	end
end

return slot0
