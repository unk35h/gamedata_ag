slot0 = class("RegressionBPTaskPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot3 = Object.Instantiate(Asset.Load("UI/ReturnTwoUI/RT2stSuppliesPackUI"), slot1)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.giftList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, RechargeGiftItem)
end

function slot0.AddUIListener(slot0)
	slot0:RegistEventListener(SHOP_LIST_UPDATE, function (slot0)
		if slot0 > 0 and slot0 == uv0.curShopId_ then
			uv0:RefreshList()
		end
	end)
	slot0:RegistEventListener(SHOP_ITEM_UPDATE, function (slot0, slot1)
		uv0:RefreshShopGoodInfo(slot0, slot1)
	end)
	slot0:RegistEventListener(RECHARGE_SUCCESS, function (slot0)
		uv0:RefreshList()
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.giftList_ then
		slot0.giftList_:Dispose()

		slot0.giftList_ = nil
	end

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.SetData(slot0)
	slot0.curShopId_ = 25
	slot0.shopDataList_ = slot0:InitShopList(slot0.curShopId_)

	slot0.giftList_:StartScroll(#slot0.shopDataList_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.curShopId_, slot0.shopDataList_[slot1].id)
	slot2:SetOutOfDateHandler(handler(slot0, slot0.OnItemOutOfDate))
end

function slot0.OnItemOutOfDate(slot0, slot1)
	slot0:RefreshList()

	if #slot0.shopDataList_ == 0 and slot0.treeRefreshHandler_ ~= nil then
		slot0.treeRefreshHandler_()
	end
end

function slot0.RefreshList(slot0)
	slot0.shopDataList_ = slot0:InitShopList(slot0.curShopId_)

	slot0.giftList_:StartScroll(#slot0.shopDataList_)
end

function slot0.InitShopList(slot0, slot1)
	slot2 = ShopTools.FilterShopDataList(slot1)

	table.sort(slot2, function (slot0, slot1)
		slot2 = getShopCfg(slot0.id)
		slot3 = getShopCfg(slot1.id)

		if uv0:GetGoodStatus(slot0.id) ~= uv0:GetGoodStatus(slot1.id) then
			return slot4 < slot5
		end

		slot7 = slot3.cost

		if slot2.cost == 0 and slot7 ~= 0 or slot7 == 0 and slot6 ~= 0 then
			return slot6 < slot7
		end

		slot9 = slot3.tag

		if slot2.tag == 1 and slot9 == 0 or slot8 == 0 and slot9 == 1 then
			return slot9 < slot8
		end

		if slot2.shop_sort ~= slot3.shop_sort then
			return slot3.shop_sort < slot2.shop_sort
		end

		return slot3.goods_id < slot2.goods_id
	end)

	return slot2
end

function slot0.GetGoodStatus(slot0, slot1)
	slot2 = false
	slot5 = ShopData.GetShop(getShopCfg(slot1).shop_id)[slot1]

	if ShopData.IsGoodOutOfDate(slot1) then
		return 2
	end

	if slot5 ~= nil and slot3.limit_num ~= nil and slot3.limit_num ~= -1 and slot3.limit_num - slot5.buy_times <= 0 then
		slot2 = true
	end

	if slot2 then
		return 2
	end

	if ShopData.IsGoodUnlock(slot1) == 0 then
		return 1
	end

	return 0
end

function slot0.RefreshShopGoodInfo(slot0, slot1, slot2)
	if slot0.curShopId_ ~= slot1 then
		return
	end

	slot5 = slot0.giftList_
	slot7 = slot5

	for slot6, slot7 in pairs(slot5.GetItemList(slot7)) do
		if slot2 == slot7.goodId_ then
			slot7:SetData(slot7.index_, slot7.shopId_, slot7.goodId_)
		end
	end
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 0 then
		slot0:RefreshList()
	end
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

return slot0
