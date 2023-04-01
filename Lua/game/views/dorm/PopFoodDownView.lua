slot0 = class("PopFoodDownView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamCancelToDeterminePop"
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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.cancelbtnBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListenerScale(slot0.confirmbtnBtn_, nil, function ()
		CanteenAction:SendSignFoodInfo(uv0.foodID, 0)
	end)
	slot0:AddBtnListenerScale(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RegisterEvent()

	slot0.foodID = slot0.params_.foodID
	slot0.textText_.text = string.format(GetTips("CANTEEN_FOOD_REMOVE"), BackHomeCanteenFoodCfg[slot0.foodID].name)
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(CANTEEN_SET_SIGNFOOD_SUCCESS, function ()
		ShowTips("招牌菜下架成功")
		JumpTools:Back()
	end)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
