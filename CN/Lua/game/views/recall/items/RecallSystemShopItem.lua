slot0 = class("RecallSystemShopItem", ReduxView)

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

	slot0.commonItem = CommonItem.New(slot0.itemGo_)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.data)
		end
	end)
	slot0:AddBtnListener(slot0.bgBuyBtn_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.data)
		end
	end)

	slot1 = slot0.commonItem

	slot1:RegistCallBack(function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.data)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.data = slot1
	slot0.exchangeCfg = ExchangeCfg[slot1.id]
	slot0.itemCfg = ItemCfg[slot0.exchangeCfg.give_id]

	slot0:UpdateView()
end

function slot0.GetHave(slot0)
	if getShopCfg(slot0.data.id).cost_id == 0 then
		slot2 = slot1.cheap_cost_id
	end

	if ItemCfg[slot2].type == ItemConst.ITEM_TYPE.CURRENCY then
		return CurrencyData:GetCurrencyNum(slot1.cost_id)
	elseif (slot3.type == ItemConst.ITEM_TYPE.MATERIAL or slot3.type == ItemConst.ITEM_TYPE.PROPS) and MaterialData:GetMaterialList()[slot1.cost_id] then
		return slot4.num
	end

	return 0
end

function slot0.UpdateView(slot0)
	slot0.commonItem:RefreshData({
		id = slot0.itemCfg.id
	})
	slot0.commonItem:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
	slot0.commonItem:HideNum()
	slot0.commonItem:HideServantTxt()

	slot0.itemNameTxt_.text = string.format("%s x%d", GetI18NText(slot0.itemCfg.name), slot0.exchangeCfg.give)

	if slot0:GetHave() < ExchangeTools.GetOriPrice(slot0.exchangeCfg.goods_id) then
		slot0.priceTxt_.text = "<color=#FF0000>" .. slot1 .. "</color>"
	else
		slot0.priceTxt_.text = slot1
	end

	slot0.costImg_.sprite = ItemTools.getItemLittleSprite(slot0.exchangeCfg.cost_id)

	if slot0.exchangeCfg.limit_num == -1 or slot0.exchangeCfg.limit_num == nil then
		SetActive(slot0.buyLimitGo_, false)
		SetActive(slot0.buyLimitTxt_.gameObject, false)
		SetActive(slot0.maskGo_, false)
	elseif slot0.exchangeCfg.limit_num - slot0.data.buyTime > 0 then
		SetActive(slot0.buyLimitTxt_.gameObject, true)
		SetActive(slot0.buyLimitGo_, true)
		SetActive(slot0.maskGo_, false)

		slot0.buyLimitTxt_.text = string.format("<color=#0d89bf>%d</color>/%d", slot2, slot0.exchangeCfg.limit_num)
	else
		SetActive(slot0.buyLimitTxt_.gameObject, false)
		SetActive(slot0.buyLimitGo_, false)
		SetActive(slot0.maskGo_, true)
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.commonItem:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
