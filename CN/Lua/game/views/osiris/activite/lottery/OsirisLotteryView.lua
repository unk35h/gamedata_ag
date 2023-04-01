ActivityInfinityPoolBaseView = import("game.views.activity.Submodule.infinityTask.base.infinity.ActivityInfinityPoolBaseView")
slot0 = class("OsirisLotteryView", ActivityInfinityPoolBaseView)

function slot0.GetAssetName(slot0)
	return "UI/VersionUI/OsirisUI/OsirisUIInfinitypoolUI"
end

function slot0.GetInfinityPoolItem(slot0)
	return OsirisLotteryItem
end

function slot0.ClickRewardPreview(slot0)
	JumpTools.OpenPageByJump("osirisRewardPreview", {
		poolID = slot0.poolID_
	})
end

return slot0
