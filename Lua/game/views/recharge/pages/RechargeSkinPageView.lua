slot1 = class("RechargeSkinPageView", import("game.views.recharge.pages.RechargePageBase"))

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, RechargeSkinItem)
end

function slot1.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.skinDataList_[slot1].id, slot0.skinDataList_)
	slot2:SetOutOfDateHandler(handler(slot0, slot0.OnItemOutOfDate))
end

function slot1.OnItemOutOfDate(slot0, slot1)
	slot0:RefreshList()
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

function slot1.OnTop(slot0)
	slot0:RefreshList()
end

function slot1.InitDataList(slot0)
	slot1 = ShopTools.FilterShopDataList(14)

	table.sort(slot1, function (slot0, slot1)
		slot2 = ShopCfg[slot0.id]
		slot3 = ShopCfg[slot1.id]

		if uv0:GetGoodStatus(slot0.id) ~= uv0:GetGoodStatus(slot1.id) then
			return slot4 < slot5
		end

		if slot2.shop_sort ~= slot3.shop_sort then
			return slot3.shop_sort < slot2.shop_sort
		end

		return slot3.goods_id < slot2.goods_id
	end)

	return slot1
end

function slot1.RefreshList(slot0)
	slot0.skinDataList_ = slot0:InitDataList()

	slot0.list_:StartScroll(#slot0.skinDataList_)
end

function slot1.OnEnter(slot0)
	slot0:RefreshList()
	SetActive(slot0.refundGo_, not SDKTools.GetIsInputServer("kr"))

	if slot0.timer_ == nil then
		slot0.timer_ = FrameTimer.New(function ()
			slot2 = uv0.list_
			slot4 = slot2

			for slot3, slot4 in ipairs(slot2.GetItemList(slot4)) do
				slot4:UpdateTimer()
			end
		end, 1, -1)

		slot0.timer_:Start()
	end

	SetActive(slot0.refundGo_, not SDKTools.GetIsKorea())
	SetActive(slot0.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(slot0.refundbtn_.gameObject, slot0.curPageIndex_ ~= 4 and slot0.curPageIndex_ ~= 6)
	end
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

function slot1.GetGoodStatus(slot0, slot1)
	if ShopTools.HaveSkin(ItemCfg[getShopCfg(slot1).give_id].param[1]) or HeroTools.CanChangeSkin(slot5) then
		return 2
	end

	if ShopData.IsGoodUnlock(slot1) == 0 then
		return 1
	end

	return 0
end

function slot1.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
