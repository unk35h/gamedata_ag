ActivityInfinityPoolRewardPreviewBaseItem = import("game.views.activity.Submodule.infinityTask.base.rewardPreview.ActivityInfinityPoolRewardPreviewBaseItem")
slot0 = class("ActivityInfinityPoolRewardPreviewItem", ActivityInfinityPoolRewardPreviewBaseItem)

function slot0.GetRewardItem(slot0, slot1)
	return RewardPoolFactoryItem.New(slot0.commonParent_, slot1, true)
end

return slot0
