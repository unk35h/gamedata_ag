slot0 = class("FoodMenuItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.statusController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.selectedController = ControllerUtil.GetController(slot0.transform_, "select")

	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.ID, uv0.type)
		end
	end)
end

function slot0.RefreshItem(slot0, slot1, slot2, slot3)
	slot0.ID = slot1
	slot0.type = slot2

	if slot0.selectedController then
		if slot0.ID == slot3 then
			slot0.selectedController:SetSelectedState("on")
		else
			slot0.selectedController:SetSelectedState("off")
		end
	end

	if slot2 == DormEnum.MenuType.foodMenu then
		slot4 = BackHomeCanteenFoodCfg[slot1].unlock

		if not CanteenTools:CheckFoodUnLock(slot1) then
			slot0.statusController:SetSelectedState("on")

			slot0.locktextText_.text = CanteenTools:GetConditionDes(slot4)
		else
			slot0.statusController:SetSelectedState("off")

			slot0.nameText_.text = BackHomeCanteenFoodCfg[slot1].name
			slot0.iconimageImg_.sprite = getSpriteWithoutAtlas(DormConst.CANTEEN_FOOD_PATH .. BackHomeCanteenFoodCfg[slot1].icon)
		end
	elseif slot2 == DormEnum.MenuType.bag then
		slot0.nameText_.text = ItemCfg[slot1].name
		slot0.numText_.text = CanteenData:GetCateenIngredient()[slot1]
		slot0.foodiconImg_.sprite = ItemTools.getItemSprite(slot1)
	end
end

function slot0.RegisterClickCallBack(slot0, slot1)
	if slot1 ~= nil then
		slot0.clickFunc = slot1
	end
end

return slot0
