slot0 = class("ShopEquipContentView", ShopContentViewBase)

function slot0.InitUI(slot0)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Shop/contentViews/equipView"), slot0.containerGo_.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ShopItemView)
	slot0.positionDropdown_ = slot0.positionDropdownGo_.transform:GetComponent("Dropdown")
	slot0.suitDropdown_ = slot0.suitDropdownGo_.transform:GetComponent("Dropdown")
end

function slot0.AddUIListener(slot0)
	slot0:AddToggleListener(slot0.positionDropdown_, function (slot0)
		if slot0 == 0 then
			uv0.selectedPos = 0
		else
			uv0.selectedPos = slot0
		end

		uv0:UpdateListByFilter()
	end)
	slot0:AddToggleListener(slot0.suitDropdown_, function (slot0)
		if slot0 == 0 then
			uv0.selectedSuitId = 0

			OperationRecorder.Record("shop", "shop_equip_all")
		else
			uv0.selectedSuitId = EquipSuitCfg[uv0:GetShopSuits()[slot0]].id

			OperationRecorder.Record("shop", "shop_equip_one")
		end

		uv0:UpdateListByFilter()
	end)
end

function slot0.ResetFilter(slot0)
	slot0.positionDropdown_.value = 0
	slot0.suitDropdown_.value = 0
end

function slot0.InitEquipDropdownData(slot0)
	slot0.positionDropdown_.options:Clear()

	slot1 = GetTips("ALL_POSITION")

	if ShopListCfg[slot0.shopId_].params ~= nil and #slot2.params > 0 and slot2.params[1].POS_ALL_LABEL ~= nil then
		slot1 = GetTips(slot2.params[1].POS_ALL_LABEL)
	end

	slot6 = UnityEngine.UI.Dropdown.OptionData.New

	slot0.positionDropdown_.options:Add(slot6(string.format(slot1)))

	for slot6 = 1, 6 do
		slot0.positionDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(GetTips("POSITION_TIP"), slot6)))
	end

	slot0.positionDropdown_:RefreshShownValue()
	slot0.suitDropdown_.options:Clear()

	slot3 = getSprite("Atlas/EquipSkillIconAtlas", "sifting_all")
	slot4 = GetTips("ALL_EQUIP")

	if slot2.params ~= nil and #slot2.params > 0 and slot2.params[1].SUIT_ALL_LABEL ~= nil then
		slot4 = GetTips(slot2.params[1].SUIT_ALL_LABEL)
	end

	slot0.suitDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(string.format(slot4), slot3))

	for slot9 = 1, #slot0:GetShopSuits() do
		slot10 = EquipSuitCfg[slot5[slot9]]

		slot0.suitDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(slot10.name, AtlasManager.GetSpriteWithoutAtlas(SpritePathCfg.EquipIcon.path .. slot10.equip_skill_icon)))
	end

	slot0.suitDropdown_:RefreshShownValue()
end

function slot0.GetShopSuits(slot0)
	slot2 = {}
	slot3 = HideInfoData:GetEquipSuitHideList()
	slot8 = slot0.shopId_

	for slot7, slot8 in ipairs(ShopData.GetShop(slot8).shopItemIDs) do
		if getShopCfg(slot8).taken_down == 0 then
			slot11 = nil

			if ItemCfg[slot9.give_id].type == ItemConst.ITEM_TYPE.EQUIP and table.indexof(slot2, EquipCfg[slot9.give_id].suit) == false and not slot3[slot11.suit] then
				table.insert(slot2, slot11.suit)
			end
		end
	end

	return slot2
end

function slot0.UpdateListByFilter(slot0)
	slot0:RefreshList()
end

function slot0.RefreshList(slot0, slot1)
	uv0.super.RefreshList(slot0, slot1)

	slot0.shopDataList_ = slot0:GetShopGoodList(slot0.shopId_)

	if slot1 and slot0.list_:GetNum() == #slot0.shopDataList_ then
		slot0.list_:Refresh()
	else
		slot0.list_:StartScroll(#slot0.shopDataList_)
	end

	slot0:InitEquipDropdownData()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RegistCallBack(handler(slot0, slot0.OnShopClick))
	slot2:SetData(slot0.shopDataList_[slot1])
end

function slot0.GetShopGoodList(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(ExchangeTools.FilterExchangeDataList(slot0.shopId_)) do
		slot11 = false
		slot12 = false
		slot13 = nil

		if ItemCfg[getShopCfg(slot7.id).give_id].type == ItemConst.ITEM_TYPE.EQUIP then
			slot13 = EquipCfg[slot9.give_id]
			slot11 = (slot0.selectedSuitId == 0 or slot0.selectedSuitId == nil or slot0.selectedSuitId == slot13.suit) and true or false
			slot12 = (slot0.selectedPos == 0 or slot0.selectedPos == nil or slot0.selectedPos == slot13.pos) and true or false
		end

		if slot10 then
			if slot11 and slot12 then
				table.insert(slot2, slot7)
			end
		elseif (slot0.selectedPos == 0 or slot0.selectedPos == nil) and (slot0.selectedSuitId == 0 or slot0.selectedSuitId == nil) then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.ScrollByPosition(slot0, slot1, slot2)
	slot3 = nil

	if slot2 then
		for slot7, slot8 in ipairs(slot0.shopDataList_) do
			if slot8.id == slot2 then
				slot3 = slot7

				break
			end
		end
	end

	if slot3 ~= nil then
		slot0.list_:ScrollToIndex(slot3)
	elseif slot1 then
		slot0.list_:SetScrolledPosition(slot1)
	end
end

function slot0.GetLuaList(slot0)
	return slot0.list_
end

function slot0.GetItemList(slot0)
	return slot0.list_:GetItemList()
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
