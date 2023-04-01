slot0 = class("SkinBuyCheckView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroSkin/SkinBuyCheckUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.costTypeController_ = ControllerUtil.GetController(slot0.transform_, "price")
	slot0.commonItem_ = CommonItem.New(slot0.commonitemGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.checkBtn_, nil, function ()
		function slot0(slot0)
			if ShopTools.IsRMB(slot0) then
				slot1, slot2, slot3 = ShopTools.IsOnDiscountArea(slot0)
				slot4 = nil

				PayAction.RequestGSPay((not slot1 or not slot3 or ShopCfg[slot0].cheap_cost_id) and ShopCfg[slot0].cost_id, 1, ShopCfg[slot0].shop_id, slot0)
			else
				ShopTools.ConfirmBuyItem(slot0, 1)
			end
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_skin_buy_check = uv0.params_.skinID
		})

		if ShopData.IsGoodOutOfDate(uv0.goodID_) then
			ShowTips("SKIN_SALE_FINISH")
			uv0:Back()

			return
		end

		if HeroData:GetHeroData(uv0.params_.heroID).unlock == 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("NOT_HAVE_HERO_SKIN_CONFIRM"), HeroCfg[uv0.params_.heroID].name),
				OkCallback = function ()
					uv0(uv1)
					SDKTools.SendPaymentMessageToSDK("payment_touch", {
						payment_skin_buy_unlock = 0
					})
				end,
				CancelCallback = function ()
					SDKTools.SendPaymentMessageToSDK("payment_touch", {
						payment_skin_buy_unlock = 1
					})
				end
			})
		else
			slot0(slot1)
		end
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = HeroTools.GetSkinChangeItem(slot0.skinID_)
	slot0.textnameText_.text = ItemCfg[slot1].name
	slot0.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), GetI18NText(ItemCfg[slot1].name)) .. GetI18NText(ItemCfg[slot1].desc)

	slot0.commonItem_:RefreshData({
		number = 1,
		id = slot1
	})
	slot0:UpdatePrice()
end

function slot0.UpdatePrice(slot0)
	slot1 = ShopCfg[slot0.goodID_]
	slot2 = slot0.goodID_
	slot3, slot4, slot5 = ShopTools.GetPrice(slot2)

	if ShopTools.IsRMB(slot2) then
		slot0.costTypeController_:SetSelectedState("money")

		slot0.rmbpriceText_.text = slot3
	else
		slot0.costTypeController_:SetSelectedState("currency")

		slot0.costiconImg_.sprite = ItemTools.getItemLittleSprite(slot1.cost_id)

		if slot0:GetHave() < slot3 then
			slot0.priceText_.text = "<color=#FF0000>" .. slot3 .. "</color>"
		else
			slot0.priceText_.text = slot3
		end
	end
end

function slot0.GetHave(slot0)
	if ItemCfg[ShopCfg[slot0.goodID_].cost_id].type == ItemConst.ITEM_TYPE.CURRENCY then
		if slot1.cost_id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE then
			return CurrencyData:GetRechargeDiamond()
		end

		return CurrencyData:GetCurrencyNum(slot1.cost_id)
	elseif (slot2.type == ItemConst.ITEM_TYPE.MATERIAL or slot2.type == ItemConst.ITEM_TYPE.PROPS) and MaterialData:GetMaterialList()[slot1.cost_id] then
		return slot3.num
	end

	return 0
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 0 then
		slot5 = getShopCfg(slot2)
		slot6 = slot5.give_id
		slot8 = ItemCfg[slot6].param[1]

		getReward({
			{
				slot6,
				slot5.give
			}
		}, nil, function ()
			slot0 = uv0

			slot0:Back()
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("USE_SKIN_CHANGE"), ItemCfg[uv1].name),
				OkCallback = function ()
					CommonAction.TryToUseItem({
						{
							num = 1,
							item_id = HeroTools.GetSkinChangeItem(uv0.skinID_),
							use_list = {}
						}
					})
				end
			})
		end, nil, true)

		return
	end

	slot0:Back()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function slot0.OnEnter(slot0)
	slot0.goodID_ = slot0.params_.goodID
	slot0.heroID_ = slot0.params_.heroID
	slot0.skinID_ = slot0.params_.skinID

	slot0:RefreshUI()
	slot0:RegistEventListener(RECHARGE_SUCCESS, function (slot0)
		slot2 = uv0

		slot2:Back()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("USE_SKIN_CHANGE"), ItemCfg[HeroTools.GetSkinChangeItem(uv0.skinID_)].name),
			OkCallback = function ()
				CommonAction.TryToUseItem({
					{
						num = 1,
						item_id = uv0,
						use_list = {}
					}
				})
			end
		})
	end)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
