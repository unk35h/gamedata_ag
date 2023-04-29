slot0 = class("ChooseSignFoodView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamTodayMenuPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.foodScroll_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, ChooseFoodItem)
	slot0.chooseItemScroll_ = LuaList.New(handler(slot0, slot0.refreshItem), slot0.chooseuilistGo_, TodayMenuItem)
	slot0.chooseListController = ControllerUtil.GetController(slot0.transform_, "food")
	slot0.btnController = {
		[3] = ControllerUtil.GetController(slot0.fryingpanBtn_.transform, "name"),
		[4] = ControllerUtil.GetController(slot0.steamerBtn_.transform, "name"),
		[5] = ControllerUtil.GetController(slot0.grillBtn_.transform, "name"),
		[6] = ControllerUtil.GetController(slot0.potBtn_.transform, "name")
	}
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(CANTEEN_SET_SIGNFOOD_SUCCESS, function ()
		ShowTips("招牌菜下架成功")
		uv0:RefreshFoodList()
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.fryingpanBtn_, nil, function ()
		uv0.selectIndex_ = DormEnum.FurnitureTypeNum.Pan

		uv0:UpdateItemData()
		uv0.foodScroll_:StartScroll(#uv0.itemList_)
	end)
	slot0:AddBtnListener(slot0.grillBtn_, nil, function ()
		uv0.selectIndex_ = DormEnum.FurnitureTypeNum.Oven

		uv0:UpdateItemData()
		uv0.foodScroll_:StartScroll(#uv0.itemList_)
	end)
	slot0:AddBtnListener(slot0.steamerBtn_, nil, function ()
		uv0.selectIndex_ = DormEnum.FurnitureTypeNum.Steamer

		uv0:UpdateItemData()
		uv0.foodScroll_:StartScroll(#uv0.itemList_)
	end)
	slot0:AddBtnListener(slot0.potBtn_, nil, function ()
		uv0.selectIndex_ = DormEnum.FurnitureTypeNum.Pot

		uv0:UpdateItemData()
		uv0.foodScroll_:StartScroll(#uv0.itemList_)
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.refreshItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.chooseItemList_[slot1])

	slot0.cursignfoodText_.text = #CanteenData:GetChooseFoodList()
	slot0.totalsignfoodText_.text = "/" .. DormSkillData:GetCanSignFoodNum()
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.itemList_[slot1])
	slot2:RegistCallBack(function (slot0)
		if DormSkillData:GetCanSignFoodNum() <= (#CanteenData:GetChooseFoodList() or 0) then
			ShowTips(GetTips("CANTEEN_FOOD_MAX"))
		else
			JumpTools.OpenPageByJump("/reviseSignFoodNumView", {
				foodID = slot0
			})
		end
	end)
	slot2:RegisterLackCallBack(function (slot0)
		JumpTools.OpenPageByJump("canteenLackFoodIngredientsView", {
			foodID = slot0
		})
	end)
end

function slot0.UpdateItemData(slot0)
	slot0.itemList_ = {}

	for slot4, slot5 in pairs(BackHomeCanteenFoodCfg.all) do
		if slot0.selectIndex_ == BackHomeCanteenFoodCfg[slot5].cook_type and not CanteenData:CheckIsSignFood(slot5) then
			if BackHomeCanteenFoodCfg[slot5].unlock > 0 then
				if CanteenTools:CheckFoodUnLock(slot5) then
					table.insert(slot0.itemList_, slot5)
				end
			else
				table.insert(slot0.itemList_, slot5)
			end
		end
	end

	slot4 = {
		map = slot5
	}

	function slot5(slot0)
		return slot0
	end

	CommonTools.UniversalSortEx(slot0.itemList_, slot4)

	for slot4, slot5 in ipairs(GameDisplayCfg.canteen_cooker_list.value) do
		if slot5[1] == slot0.selectIndex_ then
			slot0.cooktitleText_.text = slot5[2]
		end
	end

	for slot4, slot5 in pairs(slot0.btnController) do
		if slot0.selectIndex_ == slot4 then
			slot5:SetSelectedState("on")
		else
			slot5:SetSelectedState("off")
		end
	end
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})

	slot0.selectIndex_ = slot0.selectIndex_ or DormEnum.FurnitureTypeNum.Pan
	slot0.params_.type = nil

	slot0:RefreshFoodList()
	slot0:RegisterEvent()
end

function slot0.RefreshFoodList(slot0)
	slot0:UpdateItemData()
	slot0.foodScroll_:StartScroll(#slot0.itemList_)

	slot0.chooseItemList_ = CanteenData:GetChooseFoodList()

	if #slot0.chooseItemList_ > 0 then
		slot0.chooseListController:SetSelectedState("on")
	else
		slot0.chooseListController:SetSelectedState("off")
	end

	slot0.chooseItemScroll_:StartScroll(#slot0.chooseItemList_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	if slot0.toggleList_ then
		slot0.toggleList_:Dispose()
	end

	if slot0.chooseItemList_ then
		slot0.chooseItemScroll_:Dispose()
	end

	if slot0.foodScroll_ then
		slot0.foodScroll_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
