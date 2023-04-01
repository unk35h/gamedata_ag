ActivityTaskBaseView = import("game.views.activity.Submodule.infinityTask.base.task.ActivityTaskBaseView")
slot0 = class("ActivityTaskFactoryView", ActivityTaskBaseView)

function slot0.GetAssetName(slot0)
	return "UI/MardukUI/catMatch/MardukTaskContent"
end

function slot0.GetTaskClass(slot0)
	return ActivityTaskFactoryItem
end

return slot0
