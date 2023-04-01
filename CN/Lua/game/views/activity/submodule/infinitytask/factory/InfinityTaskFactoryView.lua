InfinityTaskBaseView = import("game.views.activity.Submodule.infinityTask.base.InfinityTaskBaseView")
slot0 = class("InfinityTaskFactoryView", InfinityTaskBaseView)

function slot0.UIName(slot0)
	return "UI/MardukUI/catMatch/MardukTaskUI"
end

function slot0.GetTaskViewClass(slot0)
	return ActivityTaskFactoryView
end

function slot0.GetInfinityPoolViewClass(slot0)
	return ActivityInfinityPoolFactoryView
end

function slot0.GetInfinityPoolItemID(slot0)
	return CurrencyConst.CURRENCY_TYPE_FACTORY_INFINITY_COIN
end

function slot0.GetHelpTips(slot0)
	return "ACTIVITY_FACTORY_INFINITY_POOL_DESCRIPE"
end

return slot0
