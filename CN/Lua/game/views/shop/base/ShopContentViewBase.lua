slot0 = class("ShopContentViewBase", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.containerGo_ = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.ScrollByPosition(slot0, slot1, slot2)
end

function slot0.ResetFilter(slot0)
end

function slot0.SetShopId(slot0, slot1)
	slot0.shopId_ = slot1
end

function slot0.SetShopHideHome(slot0, slot1)
	slot0.hideHomeBtn_ = slot1
end

function slot0.UpdateBarByShopId(slot0)
	slot1 = slot0.shopId_

	table.insert({}, BACK_BAR)

	if slot0.hideHomeBtn_ == nil or slot0.hideHomeBtn_ == 0 then
		table.insert(slot2, HOME_BAR)
	end

	table.insert(slot2, NAVI_BAR)

	slot3 = {}

	for slot8 = 1, #ShopListCfg[slot1].cost_id do
		slot9 = nil
		slot9 = (not CurrencyIdMapCfg[slot4.cost_id[slot8]] or CurrencyIdMapCfg[slot4.cost_id[slot8]].item_id) and slot4.cost_id[slot8]

		table.insert(slot2, slot9)
		table.insert(slot3, slot9)
	end

	slot8 = slot2

	manager.windowBar:SwitchBar(slot8)

	for slot8 = 1, #slot3 do
		manager.windowBar:SetBarCanAdd(slot3[slot8], true)
	end
end

function slot0.OnShopClick(slot0, slot1)
	if ItemCfg[getShopCfg(slot1.id).give_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		if ShopTools.HaveSkin(slot2.give_id) then
			return
		end
	elseif slot2.limit_num then
		if slot2.limit_num ~= -1 and slot2.limit_num <= slot1.buyTime then
			return
		end

		slot4, slot5 = ShopTools.JudgeIsLvLimit(slot2.level_limit)

		if slot4 then
			return
		end
	end

	JumpTools.OpenPopUp("shopBuy", {
		goodInfo = slot1
	})
end

function slot0.GetShopGoodList(slot0)
	return ShopTools.FilterShopDataList(slot0.shopId_)
end

function slot0.GetLuaList(slot0)
	return slot0.list_
end

function slot0.GetItemList(slot0)
end

function slot0.RefreshShopGoodInfo(slot0, slot1)
	slot6 = slot0

	for slot5, slot6 in pairs(slot0.GetItemList(slot6)) do
		slot9 = ShopData.GetShop(slot0.shopId_)[slot1] ~= nil and slot8.buy_times or 0

		if slot1 == slot6:GetItemInfo().id and slot9 ~= slot7.buyTime then
			slot6:SetData({
				id = slot1,
				shopId = slot0.shopId_,
				buyTime = slot9,
				next_refresh_timestamp = slot8.next_refresh_timestamp
			})
		end
	end
end

function slot0.RefreshList(slot0, slot1)
	slot0:UpdateBarByShopId()
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.GetScrolledPosition(slot0)
	return slot0:GetLuaList():GetScrolledPosition()
end

return slot0
