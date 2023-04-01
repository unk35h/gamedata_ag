ActivityInfinityPoolRewardPreviewBaseView = import("game.views.activity.Submodule.infinityTask.base.rewardPreview.ActivityInfinityPoolRewardPreviewBaseView")
slot0 = class("ActivityInfinityPoolRewardPreviewFactoryView", ActivityInfinityPoolRewardPreviewBaseView)

function slot0.UIName(slot0)
	return "UI/MardukUI/catMatch/MardukCatmatchPopUI"
end

function slot0.GetRewardPreviewItem(slot0)
	return ActivityInfinityPoolRewardPreviewFactoryItem
end

return slot0
