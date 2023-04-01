SummerStageBaseItem = import("game.views.activity.Submodule.storyStage.summer.stage.SummerStageBaseItem")
slot0 = class("SummerStageSeabedItem", SummerStageBaseItem)

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.lineController_ = ControllerUtil.GetController(slot0.transform_, "Item")
end

function slot0.RefreshText(slot0)
	slot1 = ActivityStoryChapterCfg[slot0.chapterID_]
	slot2 = slot1.activity_id
	slot3 = table.keyof(slot1.stage_list, slot0.stageID_)
	slot0.text_.text = string.format("%d", slot3)

	if slot3 - 1 == 0 then
		slot0.lineController_:SetSelectedState("3-1")
	elseif slot3 == 1 then
		slot0.lineController_:SetSelectedState("0-1")
	else
		slot0.lineController_:SetSelectedState(tostring((slot3 - 1) % 4))
	end
end

return slot0
