slot0 = class("ShopSkinItemView", ReduxView)

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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, , "OnClick")
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
	slot0.data_ = slot1
	slot0.shopCfg_ = getShopCfg(slot1.id)
	slot0.itemCfg_ = ItemCfg[slot0.shopCfg_.give_id]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = SkinCfg[slot0.shopCfg_.give_id]
	slot0.nameText_.text = slot0.itemCfg_.name
	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/Character/Icon/" .. slot1.picture_id)
	slot0.ownerText_.text = string.format("%s专属", HeroCfg[slot1.hero].name)

	if ShopTools.HaveSkin(slot0.shopCfg_.give_id) then
		SetActive(slot0.null_, true)

		slot0.nullText_.text = GetTips("TPURCHASED")
	else
		SetActive(slot0.null_, false)
	end

	slot0.priceIcon_.sprite = ItemTools.getItemLittleSprite(slot0.shopCfg_.cost_id)

	if slot0:GetHave() < ShopTools.GetPrice(slot0.shopCfg_.goods_id) then
		slot0.priceText_.text = "<color=#FF0000>" .. slot3 .. "</color>"
	else
		slot0.priceText_.text = slot3
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.GetHave(slot0)
	if ItemCfg[getShopCfg(slot0.data_.id).cost_id].type == ItemConst.ITEM_TYPE.CURRENCY then
		return CurrencyData:GetCurrencyNum(slot1.cost_id)
	elseif (slot2.type == ItemConst.ITEM_TYPE.MATERIAL or slot2.type == ItemConst.ITEM_TYPE.PROPS) and MaterialData:GetMaterialList()[slot1.cost_id] then
		return slot3.num
	end

	return 0
end

function slot0.GetItemInfo(slot0)
	return slot0.data_
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
