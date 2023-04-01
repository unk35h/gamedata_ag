slot0 = class("PopSetFoodView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamShelvesToDeterminePop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.cookMaterialItemScroll_ = LuaList.New(handler(slot0, slot0.indexFoodMaterialItem), slot0.uilistUilist_, FoodMaterialItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.confirmbtnBtn_, nil, function ()
		DormData:ReviseSignFood(uv0.foodID, true)
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.canclebtnBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.foodID = slot0.params_.foodID
	slot1 = slot0.foodID
	slot0.titletextText_.text = string.format(GetTips("CANTEEN_FOOD_ADD"), BackHomeCanteenFoodCfg[slot1].name)

	slot0:UpdateFoodMaterialData(slot1)
	slot0.cookMaterialItemScroll_:StartScroll(#slot0.itemList_)
end

function slot0.indexFoodMaterialItem(slot0, slot1, slot2)
	slot2:RefreshItem(slot0.itemList_[slot1])
end

function slot0.UpdateFoodMaterialData(slot0, slot1)
	slot0.itemList_ = {}

	for slot5, slot6 in pairs(BackHomeCanteenFoodCfg[slot1].ingredient_list) do
		table.insert(slot0.itemList_, slot6)
	end
end

function slot0.Dispose(slot0)
	if slot0.cookMaterialItemScroll_ then
		slot0.cookMaterialItemScroll_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
