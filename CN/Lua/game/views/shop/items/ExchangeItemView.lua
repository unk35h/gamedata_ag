slot0 = class("ExchangeItemView", ReduxView)

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
	slot0.exchangeCfg_ = ExchangeCfg[slot1.id]
	slot0.itemCfg_ = ItemCfg[slot0.exchangeCfg_.give_id]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.commonItem_:RefreshData({
		id = slot0.itemCfg_.id
	})
	slot0.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
	slot0.commonItem_:HideNum()
	slot0.commonItem_:HideServantTxt()

	slot0.nameText_.text = string.format("%s x%d", GetI18NText(slot0.itemCfg_.name), slot0.exchangeCfg_.give)
	slot1 = ShopListCfg[slot0.exchangeCfg_.shop_id]

	SetActive(slot0.tipsBtn_.gameObject, slot0.itemCfg_.type == ItemConst.ITEM_TYPE.EQUIP or slot0.itemCfg_.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT)
	SetActive(slot0.limitGo_, false)
	SetActive(slot0.null_, false)

	slot0.canvasGroup_.alpha = 1
	slot2 = slot0.exchangeCfg_.cost
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot0.exchangeCfg_.cost_id)

	if ExchangeTools.GetDiscount(slot0.exchangeCfg_.goods_id) ~= 100 then
		slot2 = slot0.exchangeCfg_.cheap_cost

		SetActive(slot0.discountGo_, true)

		slot0.discountText_.text = ExchangeTools.GetDiscountLabel(slot0.exchangeCfg_.goods_id)

		SetActive(slot0.oldPriceGo_, true)

		slot0.oldPriceText_.text = tostring(ExchangeTools.GetOriPrice(slot0.exchangeCfg_.goods_id))
	else
		SetActive(slot0.discountGo_, false)
		SetActive(slot0.oldPriceGo_, false)
	end

	if slot0:GetHave() < slot2 then
		slot0.priceText_.text = "<color=#FF0000>" .. slot2 .. "</color>"
	else
		slot0.priceText_.text = slot2
	end

	if slot0.exchangeCfg_.limit_num == -1 or slot0.exchangeCfg_.limit_num == nil then
		SetActive(slot0.limitGo_, false)
		SetActive(slot0.null_, false)

		slot0.canvasGroup_.alpha = 1
	elseif slot0.exchangeCfg_.limit_num - slot0.data_.buyTime > 0 then
		SetActive(slot0.limitGo_, true)
		SetActive(slot0.null_, false)

		slot0.limitNum_.text = string.format("<color=#0d89bf>%d</color>/%d", slot3, slot0.exchangeCfg_.limit_num)
		slot0.limitText_.text = GetTips("PURCHASE_LIMIT")
		slot0.canvasGroup_.alpha = 1
	else
		SetActive(slot0.limitGo_, false)
		SetActive(slot0.null_, true)

		slot0.nullText_.text = GetTips("SOLD_OUT")
		slot0.canvasGroup_.alpha = 1
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.GetHave(slot0)
	if ItemCfg[ExchangeCfg[slot0.data_.id].cost_id].type == ItemConst.ITEM_TYPE.CURRENCY then
		return CurrencyData:GetCurrencyNum(slot1.cost_id)
	elseif slot2.type == ItemConst.ITEM_TYPE.MATERIAL or slot2.type == ItemConst.ITEM_TYPE.PROPS then
		if MaterialData:GetMaterialList()[slot1.cost_id] then
			return slot3.num
		end
	elseif slot2.type == ItemConst.ITEM_TYPE.HERO_PIECE then
		return HeroData:GetHeroData(ItemCfg[slot1.cost_id].hero_id).piece
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
