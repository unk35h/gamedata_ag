slot0 = class("CanteenLackFoodIngredientsView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamLackMaterialPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0.foodID = slot0.params_.foodID
	slot0.ingredientsList = BackHomeCanteenFoodCfg[slot0.foodID].ingredient_list

	slot0.ingredientsListScroll_:StartScroll(#slot0.ingredientsList)

	slot0.titletextText_.text = BackHomeCanteenFoodCfg[slot0.foodID].name .. GetTips("ERROR_ITEM_NO_ENOUGH_MATERIAL")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.ingredientsListScroll_ = LuaList.New(handler(slot0, slot0.indexIngredientsItem), slot0.ingredientslistUilist_, FoodMaterialItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.indexIngredientsItem(slot0, slot1, slot2)
	slot2:RefreshItem(slot0.ingredientsList[slot1])
end

function slot0.Dispose(slot0)
	if slot0.ingredientsListScroll_ then
		slot0.ingredientsListScroll_:Dispose()

		slot0.ingredientsListScroll_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
