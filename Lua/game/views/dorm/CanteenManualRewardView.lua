slot0 = class("CanteenManualRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamManualModeEndPop"
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

	slot0.materialItemScroll_ = LuaList.New(handler(slot0, slot0.refreshItem), slot0.listUilist_, FoodMaterialItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.okbtnBtn_, nil, function ()
		JumpTools.OpenPageByJump("/restaurantMain")
		CanteenData:ClearManualData()
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.OpenPageByJump("/restaurantMain")
		CanteenData:ClearManualData()
	end)
end

function slot0.refreshItem(slot0, slot1, slot2)
	slot2:RefreshItem(slot0.materialList[slot1], nil, , DormEnum.FoodSellType.SignFood)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = 0
	slot4 = CanteenData
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetManualSettlementList(slot6)) do
		slot1 = slot1 + 1
	end

	slot0.foodnumText_.text = slot1
	slot0.totalcustomernumText_.text = CanteenData:GetGenCusNum() or 0
	slot0.servercustomernumText_.text = CanteenData:GetSerCustomerNum() or 0
	slot0.rewardnumText_.text = CanteenData:GetTotalIncome() or 0
	slot0.maxpopnumText_.text = CanteenData:GetHighPopularityNum() or 0
	slot0.addpopnumText_.text = CanteenData:CalculateRemainPopularity()
	slot2, slot3 = nil
	slot0.foodnameText_.text, slot5 = CanteenData:MostPopFoodIdAndNum()

	if slot5 > 0 then
		slot0.foodpopnumText_.text = string.format(GetTips("CANTEEN_SELL_INFO"), slot2)
	end

	slot0.materialList = CanteenData:ManualConsumeMaterial()

	slot0.materialItemScroll_:StartScroll(#slot0.materialList)
end

function slot0.Dispose(slot0)
	if slot0.materialItemScroll_ then
		slot0.materialItemScroll_:Dispose()

		slot0.materialItemScroll_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
