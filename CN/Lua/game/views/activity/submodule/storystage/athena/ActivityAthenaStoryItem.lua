ActivityStoryStageBaseItem = import("game.views.activity.Submodule.storyStage.base.ActivityStoryStageBaseItem")
slot0 = class("ActivityAthenaStoryItem", ActivityStoryStageBaseItem)

function slot0.Ctor(slot0, ...)
	uv0.super.Ctor(slot0, ...)

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.RefreshUI(slot0)
	slot1 = slot0:GetPosition()
	slot0.transform_.localPosition = Vector3(slot1[1], slot1[2], 0)
	slot2 = ActivityStoryChapterCfg[slot0.chapterID_]
	slot3 = slot2.activity_id
	slot0.textIndex_.text = string.format("%02d", table.keyof(slot2.stage_list, slot0.stageID_))

	slot0:RefreshClear()
end

function slot0.SelectorItem(slot0, slot1)
	if slot0.stageID_ == slot1 and slot0:IsOpenSectionInfo() then
		slot0.selectController_:SetSelectedState("on")
	else
		slot0.selectController_:SetSelectedState("off")
	end
end

return slot0
