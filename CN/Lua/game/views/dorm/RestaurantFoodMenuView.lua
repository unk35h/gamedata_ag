slot0 = class("RestaurantFoodMenuView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamRecipePop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0.itemScroll_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.itemuilistGo_, FoodMenuItem)
	slot0.bagScroll_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.baguilistUilist_, FoodMenuItem)
	slot0.tastScroll_ = LuaList.New(handler(slot0, slot0.indexTastItem), slot0.tasteuilistUilist_, CanteenFoodTasteitem)
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.infoController = ControllerUtil.GetController(slot0.transform_, "info")
	slot0.materialItemScroll_ = LuaList.New(handler(slot0, slot0.indexMaterialItem), slot0.materiallistUilist_, FoodMaterialItem)
	slot0.btnController = {
		[3] = ControllerUtil.GetController(slot0.fryingpanBtn_.transform, "name"),
		[4] = ControllerUtil.GetController(slot0.steamerBtn_.transform, "name"),
		[5] = ControllerUtil.GetController(slot0.grillBtn_.transform, "name"),
		[6] = ControllerUtil.GetController(slot0.potBtn_.transform, "name")
	}
	slot0.menuController = ControllerUtil.GetController(slot0.recipeGo_.transform, "toggle")
	slot0.bagController = ControllerUtil.GetController(slot0.bagGo_.transform, "toggle")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.recipeBtn_, nil, function ()
		uv0.curChooseIndex = DormEnum.FurnitureTypeNum.Pan

		uv0:UpdataFoodMenuView()
	end)
	slot0:AddBtnListenerScale(slot0.fryingpanBtn_, nil, function ()
		uv0.curChooseIndex = DormEnum.FurnitureTypeNum.Pan

		uv0:UpdataFoodMenuView()
	end)
	slot0:AddBtnListenerScale(slot0.grillBtn_, nil, function ()
		uv0.curChooseIndex = DormEnum.FurnitureTypeNum.Oven

		uv0:UpdataFoodMenuView()
	end)
	slot0:AddBtnListenerScale(slot0.steamerBtn_, nil, function ()
		uv0.curChooseIndex = DormEnum.FurnitureTypeNum.Steamer

		uv0:UpdataFoodMenuView()
	end)
	slot0:AddBtnListenerScale(slot0.potBtn_, nil, function ()
		uv0.curChooseIndex = DormEnum.FurnitureTypeNum.Pot

		uv0:UpdataFoodMenuView()
	end)
	slot0:AddBtnListenerScale(slot0.bagBtn_, nil, function ()
		uv0:UpdataBagView()
	end)
	slot0:AddBtnListenerScale(slot0.proiconBtn_, nil, function ()
		JumpTools.OpenPageByJump("canteenProDesView")
	end)
	slot0:AddBtnListenerScale(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})

	slot0.menuType = slot0.params_.state

	if slot0.menuType == DormEnum.MenuType.foodMenu then
		slot0.curChooseIndex = DormEnum.FurnitureTypeNum.Pan

		slot0:UpdataFoodMenuView()
	elseif slot0.menuType == DormEnum.MenuType.bag then
		slot0:UpdataBagView()
	end

	slot0:RegisterEvent()
end

function slot0.OnTop(slot0)
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(CANTEEN_CLICK_MENU_ITEM, function (slot0, slot1)
		if slot1 == DormEnum.MenuType.bag then
			uv0.bagScroll_:Refresh()
		else
			uv0.itemScroll_:Refresh()
		end

		uv0:RefreshInfoPage(slot0)
	end)
end

function slot0.UpdataBagView(slot0)
	slot0.menuType = DormEnum.MenuType.bag

	slot0.stateController:SetSelectedState("bag")
	slot0.menuController:SetSelectedState("off")
	slot0.bagController:SetSelectedState("on")

	slot4 = "off"

	slot0.infoController:SetSelectedState(slot4)

	for slot4, slot5 in pairs(slot0.btnController) do
		slot5:SetSelectedState("off")
	end

	slot0:RefreshBag()
	slot0.bagScroll_:StartScroll(#slot0.itemList_)
	slot0:RefreshItemInfo(slot0.itemList_[1], DormEnum.MenuType.bag)
end

function slot0.UpdataFoodMenuView(slot0)
	slot0.menuType = DormEnum.MenuType.foodMenu

	slot0:UpdateItemData(slot0.curChooseIndex)
	slot0.stateController:SetSelectedState("food")
	slot0.bagController:SetSelectedState("off")
	slot0.menuController:SetSelectedState("on")
	slot0.infoController:SetSelectedState("off")

	slot4 = #slot0.itemList_

	slot0.itemScroll_:StartScroll(slot4)

	for slot4, slot5 in pairs(slot0.btnController) do
		if slot4 == slot0.curChooseIndex then
			slot5:SetSelectedState("on")
		else
			slot5:SetSelectedState("off")
		end
	end

	slot0:RefreshItemInfo(slot0.itemList_[1], DormEnum.MenuType.foodMenu)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshItem(slot0.itemList_[slot1], slot0.menuType, slot0.selItem)
	slot2:RegisterClickCallBack(function (slot0, slot1)
		uv0.selItem = slot0

		uv0:RefreshItemInfo(slot0, slot1)
	end)
end

function slot0.RefreshItemInfo(slot0, slot1, slot2)
	slot0.selItem = slot1

	if slot2 == DormEnum.MenuType.bag then
		slot0.bagScroll_:Refresh()
	else
		slot0.itemScroll_:Refresh()
	end

	slot0:RefreshInfoPage(slot1)
end

function slot0.indexMaterialItem(slot0, slot1, slot2)
	slot2:RefreshItem(slot0.materialItemList_[slot1])
end

function slot0.indexTastItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.tasteItemList_[slot1])
end

function slot0.RefreshBag(slot0)
	slot0.itemList_ = {}
	slot3 = CanteenData
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetCateenIngredient(slot5)) do
		table.insert(slot0.itemList_, slot4)
	end
end

function slot0.RefreshInfoPage(slot0, slot1)
	if slot0.menuType == DormEnum.MenuType.foodMenu then
		slot0.infoController:SetSelectedState("food")

		slot2 = BackHomeCanteenFoodCfg[slot1]
		slot0.tasteItemList_ = slot2.tag
		slot0.foodnameText_.text = slot2.name
		slot0.earningnumText_.text = CanteenData:GetFoodUnitCost(slot1)
		slot0.fooddescribeText_.text = slot2.desc

		slot0:UpdataMaterialItemData(slot1)
		slot0.materialItemScroll_:StartScroll(#slot0.materialItemList_)

		slot0.foodiconImg_.sprite = getSpriteWithoutAtlas(DormConst.CANTEEN_FOOD_PATH .. BackHomeCanteenFoodCfg[slot1].icon)
		slot0.progressnumText_.text = CanteenData:GetFoodProficiency(slot1)

		slot0:UpdataTasteData(slot1)
	elseif slot0.menuType == DormEnum.MenuType.bag then
		slot0.infoController:SetSelectedState("ingredient")

		slot2 = ItemCfg[slot1]
		slot0.ingnameText_.text = slot2.name
		slot0.ingdestextText_.text = slot2.desc
		slot0.ingnumText_.text = string.format("X%d", CanteenData:GetCateenIngredient()[slot1])
		slot0.foodicon2Img_.sprite = ItemTools.getItemSprite(slot1)
	end
end

function slot0.UpdataTasteData(slot0, slot1)
	slot0.tasteList = BackHomeCanteenFoodCfg[slot1].tag

	slot0.tastScroll_:StartScroll(#slot0.tasteList)
end

function slot0.UpdateItemData(slot0, slot1)
	slot0.itemList_ = {}
	slot2 = 0

	for slot6, slot7 in ipairs(BackHomeCanteenFoodCfg.all) do
		if BackHomeCanteenFoodCfg[slot7].cook_type == slot1 then
			if CanteenTools:CheckFoodUnLock(slot7) then
				slot2 = slot2 + 1
			end

			table.insert(slot0.itemList_, slot7)
		end
	end

	slot6 = {
		ascend = true,
		map = function (slot0)
			if CanteenTools:CheckFoodUnLock(slot0) then
				return 1
			else
				return 2
			end
		end
	}
	slot7 = {
		ascend = true,
		map = function (slot0)
			return CanteenTools:GetFoodUnLockLevel(slot0)
		end
	}

	CommonTools.UniversalSortEx(slot0.itemList_, slot6, slot7, {
		ascend = true,
		map = function (slot0)
			return slot0
		end
	})

	slot0.curnumText_.text = slot2
	slot0.totlanumText_.text = "/" .. #slot0.itemList_

	for slot6, slot7 in ipairs(GameDisplayCfg.canteen_cooker_list.value) do
		if slot7[1] == slot1 then
			slot0.cooktitleText_.text = slot7[2]
		end
	end

	for slot6, slot7 in pairs(slot0.btnController) do
		if slot6 == slot1 then
			slot7:SetSelectedState("on")
		else
			slot7:SetSelectedState("off")
		end
	end
end

function slot0.UpdataMaterialItemData(slot0, slot1)
	slot0.materialItemList_ = {}

	for slot5, slot6 in ipairs(BackHomeCanteenFoodCfg[slot1].ingredient_list) do
		table.insert(slot0.materialItemList_, slot6)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	slot0.menuType = nil

	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	if slot0.itemScroll_ then
		slot0.itemScroll_:Dispose()
	end

	if slot0.bagScroll_ then
		slot0.bagScroll_:Dispose()
	end

	if slot0.tastScroll_ then
		slot0.tastScroll_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
