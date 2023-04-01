slot1 = class("RechargeGiftPageView", import("game.views.recharge.pages.RechargePageBase"))

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.shopIds_ = {
		15,
		16
	}

	slot0:Init()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.giftList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, RechargeGiftItem)
end

function slot1.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.curShopId_, slot0.shopDataList_[slot1].id)
	slot2:SetOutOfDateHandler(handler(slot0, slot0.OnItemOutOfDate))
end

function slot1.OnItemOutOfDate(slot0, slot1)
	slot0:RefreshList()

	if #slot0.shopDataList_ == 0 and slot0.treeRefreshHandler_ ~= nil then
		slot0.treeRefreshHandler_()
	end
end

function slot1.AddUIListener(slot0)
	if SDKTools.GetIsInputServer("kr") then
		slot0:AddBtnListener(slot0.refundbtn_, nil, function ()
			JumpTools.OpenPageByJump("gameHelpPro", {
				pages = {
					"Textures/RechargeUI/Refund Policy@kr"
				}
			})
		end)
	end
end

function slot1.SwitchPage(slot0, slot1)
	slot0.curShopId_ = slot1
	slot0.shopDataList_ = slot0:InitShopList(slot1)

	slot0.giftList_:StartScroll(#slot0.shopDataList_)
end

function slot1.RefreshList(slot0, slot1)
	slot0.shopDataList_ = slot0:InitShopList(slot0.curShopId_)

	if slot1 or false then
		slot0.giftList_:StartScrollByPosition(#slot0.shopDataList_, slot0.giftList_:GetScrolledPosition())
	else
		slot0.giftList_:StartScroll(#slot0.shopDataList_)
	end
end

function slot1.InitShopList(slot0, slot1)
	slot2 = ShopTools.FilterShopDataList(slot1)

	table.sort(slot2, function (slot0, slot1)
		slot2 = getShopCfg(slot0.id)
		slot3 = getShopCfg(slot1.id)

		if uv0:GetGoodStatus(slot0.id) ~= uv0:GetGoodStatus(slot1.id) then
			return slot4 < slot5
		end

		if slot2.shop_sort ~= slot3.shop_sort then
			return slot3.shop_sort < slot2.shop_sort
		end

		return slot3.goods_id < slot2.goods_id
	end)

	return slot2
end

function slot1.GetGoodStatus(slot0, slot1)
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

function slot1.IsInChain(slot0, slot1)
	for slot7, slot8 in ipairs(ShopCfg.get_id_list_by_shop_id[getShopCfg(slot1).shop_id]) do
		if #ShopCfg[slot8].pre_goods_id > 0 and slot9.pre_goods_id[1] == slot1 then
			return true
		end
	end

	if #slot2.pre_goods_id > 0 then
		return true
	end

	return false
end

function slot1.AddEventListeners(slot0)
	slot0:RegistEventListener(SHOP_LIST_UPDATE, function (slot0)
		if slot0 > 0 and slot0 == uv0.curShopId_ then
			uv0:RefreshList()
		end
	end)
	slot0:RegistEventListener(SHOP_ITEM_UPDATE, function (slot0, slot1)
		uv0:RefreshShopGoodInfo(slot0, slot1)
	end)
end

function slot1.UpdateShopList(slot0, slot1)
	if slot1 == slot0.curShopId_ then
		slot0.giftList_:Refresh()
	end
end

function slot1.RefreshShopGoodInfo(slot0, slot1, slot2)
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

function slot1.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 0 then
		slot0:RefreshList(true)
	end
end

function slot1.OnTop(slot0)
end

function slot1.OnEnter(slot0)
	slot0:AddEventListeners()

	if slot0.timer_ == nil then
		slot0.timer_ = FrameTimer.New(function ()
			if uv0.giftList_ ~= nil then
				slot2 = uv0.giftList_
				slot4 = slot2

				for slot3, slot4 in ipairs(slot2.GetItemList(slot4)) do
					slot4:UpdateTimer()
				end
			end

			uv0:UpdateTimer()
		end, 1, -1)

		slot0.timer_:Start()
	end

	SetActive(slot0.refundGo_, not SDKTools.GetIsInputServer("kr"))
	SetActive(slot0.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(slot0.refundbtn_.gameObject, slot0.curPageIndex_ ~= 4 and slot0.curPageIndex_ ~= 6)
	end
end

function slot1.UpdateTimer(slot0)
end

function slot1.OnExit(slot0)
	if slot0.timer_ ~= nil then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot1.Hide(slot0)
	uv0.super.Hide(slot0)
end

function slot1.SetTreeRefreshHandler(slot0, slot1)
	slot0.treeRefreshHandler_ = slot1
end

function slot1.HaveActivityGift(slot0)
	for slot5, slot6 in ipairs(ShopCfg.get_id_list_by_shop_id[15]) do
		if not ShopData.IsGoodOutOfDate(slot6) then
			return true
		end
	end

	return false
end

function slot1.Dispose(slot0)
	if slot0.giftList_ then
		slot0.giftList_:Dispose()

		slot0.giftList_ = nil
	end

	slot0.treeRefreshHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot1
