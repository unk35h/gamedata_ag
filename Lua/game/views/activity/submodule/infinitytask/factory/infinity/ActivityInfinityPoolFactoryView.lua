ActivityInfinityPoolBaseView = import("game.views.activity.Submodule.infinityTask.base.infinity.ActivityInfinityPoolBaseView")
slot0 = class("ActivityInfinityPoolFactoryView", ActivityInfinityPoolBaseView)

function slot0.GetAssetName(slot0)
	return "UI/MardukUI/catMatch/MardukInfinitypoolUI"
end

function slot0.GetInfinityPoolItem(slot0)
	return ActivityInfinityPoolFactoryItem
end

function slot0.ClickRewardPreview(slot0)
	JumpTools.OpenPageByJump("infinityRewardPreviewFactory", {
		poolID = slot0.poolID_
	})
end

function slot0.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)

	slot0.phaseText_.text = GetTips(string.format("PHASE_%s", slot0.phase_))
end

function slot0.GetRewardItem(slot0, slot1)
	return RewardPoolFactoryItem.New(slot0.goMainReward_, slot1, true)
end

return slot0
