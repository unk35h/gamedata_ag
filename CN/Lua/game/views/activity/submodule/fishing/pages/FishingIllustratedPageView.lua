slot0 = class("FishingGroupPageView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, FishingIllustratedItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.fishIdList_[slot1])
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		if slot0 == 0 or slot0 == CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN then
			uv0.coinValueLabel_.text = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
		end
	end)
	slot0:RegistEventListener(FISHING_GROUP_REWARD_CHANGE, function ()
		uv0.uiList_:Refresh()
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
	slot0:SortData()
	slot0:UpdateView()
end

function slot0.SortData(slot0)
	slot0.fishIdList_ = RareFishCfg.all

	table.sort(slot0.fishIdList_, function (slot0, slot1)
		slot3 = FishingData:GetFish(slot1)
		slot4 = RareFishCfg[slot0]
		slot5 = RareFishCfg[slot1]

		if FishingData:GetFish(slot0) == nil and slot3 ~= nil or slot2 ~= nil and slot3 == nil then
			return slot2 ~= nil
		end

		if slot4.rare ~= slot5.rare then
			return slot5.rare < slot4.rare
		end

		return slot4.id < slot5.id
	end)
end

function slot0.UpdateView(slot0)
	slot0:SortData()
	slot0.uiList_:StartScroll(#slot0.fishIdList_)

	slot0.coinValueLabel_.text = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
