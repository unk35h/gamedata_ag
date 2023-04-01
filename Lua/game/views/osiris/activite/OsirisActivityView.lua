InfinityTaskBaseView = import("game.views.activity.Submodule.infinityTask.base.InfinityTaskBaseView")
slot0 = class("OsirisActivityView", InfinityTaskBaseView)

function slot0.UIName(slot0)
	return "UI/VersionUI/OsirisUI/OsirisUITaskUI"
end

function slot0.GetTaskViewClass(slot0)
	return OsirisTaskView
end

function slot0.GetInfinityPoolViewClass(slot0)
	return OsirisLotteryView
end

return slot0
