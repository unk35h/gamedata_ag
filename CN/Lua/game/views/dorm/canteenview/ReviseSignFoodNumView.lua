slot0 = class("ReviseSignFoodNumView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dining/ShelfPresetUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.sceneID = DormConst.CANTEEN_ID
	slot0.foodMaterialScroll = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, FoodMaterialItem)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0.foodID = slot0.params_.foodID

	slot0:SetfurNum(0)

	slot0.progressSlr_.maxValue = CanteenData:CalculateFoodCanCookNum(slot0.foodID)
	slot0.furNumMax = CanteenData:CalculateFoodCanCookNum(slot0.foodID)
	slot0.sellNum = 0

	slot0:RegisterEvent()
	slot0:RefreshView()
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(CANTEEN_SET_SIGNFOOD_SUCCESS, function ()
		ShowTips(GetTips("DORM_FOOD_SET_SUCCESS"))
		JumpTools:Back()
	end)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.signBtn_, nil, function ()
		if uv0.sellNum <= 0 then
			ShowTips(GetTips("DORM_FOOD_SET_NULL"))

			return
		end

		CanteenAction:SendSignFoodInfo(uv0.foodID, uv0.sellNum)
	end)
	slot0:AddToggleListener(slot0.progressSlr_, function ()
		if uv0.foodID then
			uv0:SetfurNum(uv0.progressSlr_.value)
		end
	end)
	slot0:AddPressingByTimeListener(slot0.reduceNumBtn_.gameObject, 3, 0.5, 0.5, function ()
		if uv0.foodID and uv0.sellNum > 0 then
			uv0:SetfurNum(uv0.progressSlr_.value - 1)

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.addNumBtn_.gameObject, 3, 0.5, 0.5, function ()
		if uv0.foodID and uv0.sellNum < uv0.furNumMax then
			uv0:SetfurNum(uv0.progressSlr_.value + 1)

			return true
		end

		return false
	end)
	slot0:AddBtnListenerScale(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListenerScale(slot0.takeOffBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.SetfurNum(slot0, slot1)
	slot0.sellNum = slot1
	slot0.numText_.text = slot1
	slot0.progressSlr_.value = slot1

	slot0:RefreshSellNumAndIncome()
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshItem(slot0.foodMaterialList[slot1], slot0.foodID, slot0.sellNum)
end

function slot0.RefreshView(slot0)
	slot0:RefreshFoodInfo()
	slot0:RefreshFoodMaterialList()
	slot0:RefreshSellNumAndIncome()
end

function slot0.RefreshFoodMaterialList(slot0)
	slot0.foodMaterialList = BackHomeCanteenFoodCfg[slot0.foodID].ingredient_list

	if slot0.foodMaterialList then
		slot0.foodMaterialScroll:StartScroll(#slot0.foodMaterialList)
	end
end

function slot0.RefreshSellNumAndIncome(slot0)
	slot0.sellNumTex_.text = slot0.sellNum
	slot0.incomeNumTex_.text = math.floor(CanteenData:GetFoodUnitCost(slot0.foodID) * slot0.sellNum)
	slot0.costTimeTex.text = DormTools:SecondSwitchTime(math.ceil(BackHomeCanteenFoodCfg[slot0.foodID].cost_time * slot0.sellNum * (100 - DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FoodCostQucik, nil, , BackHomeCanteenFoodCfg[slot0.foodID].cook_type)) / 100))

	slot0.foodMaterialScroll:Refresh()
end

function slot0.RefreshFoodInfo(slot0)
	slot0.iconImg_.sprite = CanteenTools.GetFoodSprite(slot0.foodID)
	slot0.foodName.text = BackHomeCanteenFoodCfg[slot0.foodID].name
	slot0.descText_.text = BackHomeCanteenFoodCfg[slot0.foodID].desc
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
