slot0 = class("ShopItemView", ReduxView)

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

	slot0.limitController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "limit")
	slot0.extendController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "extend")
	slot0.commonItem_ = CommonItem.New(slot0.commonGo_)
	slot0.canvasGroup_ = slot0.nonullGo_:GetComponent(typeof(CanvasGroup))
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, , "OnClick")
	slot0:AddBtnListener(slot0.tipsBtn_, nil, function ()
		ShowPopItem(POP_SOURCE_ITEM, {
			uv0.itemCfg_.id
		})
	end)
end

function slot0.UpdateTimerView(slot0)
	if slot0.isExchange_ then
		return
	end

	if slot0.shopCfg_.refresh_cycle == 1 then
		return
	end

	slot2 = nil

	if not slot0.isExchange_ then
		if slot1 == 2 then
			slot2 = _G.gameTimer:GetNextMonthFreshTime()
		elseif slot1 == 3 then
			slot2 = _G.gameTimer:GetNextWeekFreshTime()
		elseif slot1 == 4 then
			slot2 = _G.gameTimer:GetNextDayFreshTime()
		elseif slot1 == 5 then
			slot2 = slot0.data_.next_refresh_timestamp
		end

		slot0.countdownText_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:DescCdTime3(slot2 - manager.time:GetServerTime()))
	end
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0.clickFunc(slot0.data_)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.SetData(slot0, slot1)
	if slot1 == nil then
		print("data is null")
	end

	slot0.data_ = slot1

	if slot1 == nil then
		print("data is nil")
	end

	if ShopCfg[slot1.id] then
		slot0.shopCfg_ = ShopCfg[slot1.id]
		slot0.isExchange_ = false
	else
		slot0.shopCfg_ = ExchangeCfg[slot1.id]
		slot0.isExchange_ = true
	end

	slot0.itemCfg_ = ItemCfg[slot0.shopCfg_.give_id]

	slot0:UpdateView()
	slot0:UpdateTimerView()
end

function slot0.UpdateView(slot0)
	slot0.commonItem_:RefreshData({
		id = slot0.itemCfg_.id
	})
	slot0.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
	slot0.commonItem_:HideNum()
	slot0.commonItem_:HideServantTxt()

	slot0.nameText_.text = string.format("%s x%d", GetI18NText(slot0.itemCfg_.name), slot0.shopCfg_.give)
	slot1 = ShopListCfg[slot0.shopCfg_.shop_id]

	SetActive(slot0.tipsBtn_.gameObject, slot0.itemCfg_.type == ItemConst.ITEM_TYPE.EQUIP or slot0.itemCfg_.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT)

	if slot0.shopCfg_.limit_num == -1 or slot0.shopCfg_.limit_num == nil then
		slot0.limitController_:SetSelectedState("no")
		SetActive(slot0.limitGo_, false)
		SetActive(slot0.null_, false)

		slot0.canvasGroup_.alpha = 1
	elseif slot0.shopCfg_.limit_num - slot0.data_.buyTime > 0 then
		SetActive(slot0.limitGo_, true)
		SetActive(slot0.null_, false)

		slot0.limitNum_.text = string.format("<color=#0d89bf>%d</color>/%d", slot2, slot0.shopCfg_.limit_num)
		slot0.limitText_.text = GetTips(ShopConst.SHOP_LIMIT_TEXT[slot0.shopCfg_.refresh_cycle])
		slot0.canvasGroup_.alpha = 1
	else
		if slot0.isExchange_ then
			slot0.limitController_:SetSelectedState("no")

			slot0.nullText_.text = GetTips("SOLD_OUT")
		elseif slot0.shopCfg_.refresh_cycle == 1 then
			slot0.limitController_:SetSelectedState("no")

			slot0.nullText_.text = GetTips("SOLD_OUT")
		elseif slot3 == 2 then
			slot0.limitController_:SetSelectedState("monthly")

			slot0.nullText_.text = GetTips("MONTHLY_SOLD_OUT")
		elseif slot3 == 3 then
			slot0.limitController_:SetSelectedState("weekly")

			slot0.nullText_.text = GetTips("WEEKLY_SOLD_OUT")
		elseif slot3 == 4 then
			slot0.limitController_:SetSelectedState("daily")

			slot0.nullText_.text = GetTips("DAILY_SOLD_OUT")
		elseif slot3 == 5 then
			slot0.limitController_:SetSelectedState("activity")

			slot0.nullText_.text = GetTips("ACTIVITY_SOLD_OUT")
		end

		SetActive(slot0.limitGo_, false)
		SetActive(slot0.null_, true)

		slot0.canvasGroup_.alpha = 1
	end

	if slot0.shopCfg_.backhome_tag and #slot0.shopCfg_.backhome_tag > 0 then
		slot0.extendController_:SetSelectedState("true")

		slot0.extendText_.text = slot0.shopCfg_.backhome_tag
	else
		slot0.extendController_:SetSelectedState("false")
	end

	if slot0.shopCfg_.limit_num == 0 then
		SetActive(slot0.limitGo_, false)
	end

	slot2 = slot0.shopCfg_.cost

	if slot0.shopCfg_.cost_id == 0 then
		slot3 = slot0.shopCfg_.cheap_cost_id
	end

	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot3)
	slot4, slot5, slot6 = nil

	if ShopCfg[slot0.shopCfg_.goods_id] then
		slot4 = ShopTools.GetDiscount(slot0.shopCfg_.goods_id)
		slot5 = ShopTools.GetDiscountLabel(slot0.shopCfg_.goods_id)
		slot6 = ShopTools.GetOriPrice(slot0.shopCfg_.goods_id)
	else
		slot4 = ExchangeTools.GetDiscount(slot0.shopCfg_.goods_id)
		slot5 = ExchangeTools.GetDiscountLabel(slot0.shopCfg_.goods_id)
		slot6 = ExchangeTools.GetOriPrice(slot0.shopCfg_.goods_id)
	end

	if slot4 ~= 100 then
		slot2 = slot0.shopCfg_.cheap_cost

		SetActive(slot0.discountGo_, true)

		slot0.discountText_.text = slot5

		SetActive(slot0.oldPriceGo_, true)

		slot0.oldPriceText_.text = tostring(slot6)
	else
		SetActive(slot0.oldPriceGo_, false)

		if slot0.shopCfg_.tag == 2 then
			SetActive(slot0.discountGo_, true)

			slot0.discountText_.text = GetTips("NEW_ADD")
		else
			SetActive(slot0.discountGo_, false)
		end
	end

	if slot0:GetHave() < slot2 then
		slot0.priceText_.text = "<color=#FF0000>" .. slot2 .. "</color>"
	else
		slot0.priceText_.text = slot2
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.GetHave(slot0)
	if getShopCfg(slot0.data_.id).cost_id == 0 then
		slot2 = slot1.cheap_cost_id
	end

	if ItemCfg[slot2].type == ItemConst.ITEM_TYPE.CURRENCY then
		return CurrencyData:GetCurrencyNum(slot1.cost_id)
	elseif (slot3.type == ItemConst.ITEM_TYPE.MATERIAL or slot3.type == ItemConst.ITEM_TYPE.PROPS) and MaterialData:GetMaterialList()[slot1.cost_id] then
		return slot4.num
	end

	return 0
end

function slot0.GetItemInfo(slot0)
	return slot0.data_
end

function slot0.Dispose(slot0)
	slot0.clickFunc = nil

	slot0.commonItem_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
