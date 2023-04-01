ActivityInfinityPoolBaseItem = import("game.views.activity.Submodule.infinityTask.base.infinity.ActivityInfinityPoolBaseItem")
slot0 = class("ActivityInfinityPoolFactoryItem", ActivityInfinityPoolBaseItem)

function slot0.Ctor(slot0, ...)
	uv0.super.Ctor(slot0, ...)

	slot0.unLockController_ = ControllerUtil.GetController(slot0.transform_, "unlock")
end

function slot0.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)
	slot0:RefreshRewardPanel()
end

function slot0.RefreshRewardPanel(slot0)
	if OsirisInfinityPoolData:GetPoolData(slot0.poolID_).openBoxList[slot0.index_] then
		slot0.unLockController_:SetSelectedState("on")
	else
		slot0.unLockController_:SetSelectedState("off")
	end
end

function slot0.GetRewardItem(slot0, slot1)
	return RewardPoolFactoryItem.New(slot0.goItemParent_, slot1, true)
end

return slot0
