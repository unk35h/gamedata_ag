ActivityTaskBaseView = import("game.views.activity.Submodule.infinityTask.base.task.ActivityTaskBaseView")
slot0 = class("OsirisTaskView", ActivityTaskBaseView)

function slot0.GetAssetName(slot0)
	return "UI/VersionUI/OsirisUI/OsirisTaskContent"
end

function slot0.GetTaskClass(slot0)
	return OsirisTaskItem
end

return slot0
