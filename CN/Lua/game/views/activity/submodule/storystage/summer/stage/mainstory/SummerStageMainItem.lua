SummerStageBaseItem = import("game.views.activity.Submodule.storyStage.summer.stage.SummerStageBaseItem")
slot0 = class("SummerStageMainItem", SummerStageBaseItem)

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.lineController_ = ControllerUtil.GetController(slot0.transform_, "Item")
end

function slot0.RefreshText(slot0)
	slot2 = table.keyof(ActivityStoryChapterCfg[slot0.chapterID_].stage_list, slot0.stageID_)
	slot0.text_.text = string.format("%d", slot2)

	if slot2 - 1 == 0 then
		slot0.lineController_:SetSelectedState("-1")
	elseif slot2 % 2 == 0 then
		slot0.lineController_:SetSelectedState(tostring(slot3))
	else
		slot0.lineController_:SetSelectedState(tostring(slot2 % 4))
	end
end

return slot0
