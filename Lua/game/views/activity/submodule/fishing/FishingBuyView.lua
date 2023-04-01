slot0 = class("FishingBuyView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Fishing/FishingBuyUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.slider_ = LuaSlider.New(slot0.sliderGo_)
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.slider_

	slot1:SetNumChangeHandler(function (slot0)
		uv0:UpdateView()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN) < uv0.cfg_.price * uv0.slider_:GetSelectedNum() then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

			return
		end

		FishingAction.FishingBuyFish(ActivityConst.SUMMER_FISHING, uv0.params_.fishId, slot1)
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(FISHING_BUY_SUCCESS, function ()
		uv0:Back()
	end)
end

function slot0.UpdateView(slot0)
	slot0.buyNumLabel_.text = slot0.slider_:GetSelectedNum()
	slot0.useText_.text = slot0.cfg_.price * slot0.slider_:GetSelectedNum()
	slot0.getText_.text = slot0.slider_:GetSelectedNum()
	slot2 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
	slot0.maxNum_ = 10000

	if slot0.cfg_.price ~= nil and slot0.cfg_.price ~= 0 then
		slot0.maxNum_ = math.floor(slot2 / slot0.cfg_.price)
	end
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
	slot0:ShowDefaultBar()
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.cfg_ = RareFishCfg[slot0.params_.fishId]
	slot0.icon1_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
	slot0.icon2_.sprite = getSpriteWithoutAtlas(string.format("Textures/Fishing/RareFishIcon/%d", slot0.params_.fishId))
	slot0.useNameText_.text = ItemCfg[CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN].name
	slot0.getNameText_.text = RareFishCfg[slot0.params_.fishId].name

	slot0:UpdateView()
	slot0.slider_:SetData(1, slot0.maxNum_)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	if slot0.slider_ then
		slot0.slider_:Reset()
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.slider_ then
		slot0.slider_:Dispose()

		slot0.slider_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
