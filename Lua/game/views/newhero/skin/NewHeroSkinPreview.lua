slot0 = class("NewHeroSkinPreview", import("game.views.newHero.skin.NewHeroSkinView"))

function slot0.UIName(slot0)
	return "UI/HeroSkin/SkinPreviewUI"
end

function slot0.SetBtnState(slot0)
	slot0.btnState = {
		"btn_go",
		"sourcetext",
		"btn_now",
		"btn_donthave"
	}
end

function slot0.SkinState(slot0, slot1)
	if slot0:isUnlock(slot1) then
		if HeroTools.GetHeroIsUnlock(slot0.params_.heroID) == false then
			return 4
		end

		return 3
	else
		if HeroTools.CanChangeSkin(slot1) then
			return 3
		end

		if HeroTools.IsSkinOutOfDate(slot1) then
			return 2
		end

		return 1
	end
end

function slot0.SetButtonActive(slot0, slot1)
	if slot0.btnState_ == slot1 then
		return
	end

	slot2 = nil

	if slot0.btnState_ then
		SetActive(slot0[slot0.btnState[slot0.btnState_] .. "Go_"], false)
	end

	SetActive(slot0[slot0.btnState[slot1] .. "Go_"], true)

	slot0.btnState_ = slot1
end

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.costTypeController_ = ControllerUtil.GetController(slot0.btn_goGo_.transform, "costType")
end

function slot0.SetSkinItem(slot0)
	slot0.skinTemplate_ = NewHeroSkinPreviewItem
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.portraitBtn_, nil, function ()
		if Input.touchCount <= 1 then
			uv0:Go("heroPortrait", {
				skinID = uv0.skinID_
			})
		end
	end)
	slot0:AddBtnListener("panel/right/btn_replace", nil, function ()
		if Input.touchCount <= 1 then
			HeroAction.SelectSkin(uv0.heroID_, uv0.skinID_)
		end
	end)
	slot0:AddBtnListener("panel/right/btn_go", nil, function ()
		if Input.touchCount <= 1 then
			uv0.params_.skinID = uv0.skinID_

			if uv0.skinID_ == 104204 then
				uv0:ShowDiscountTip()
			else
				uv0:Go("skinBuyCheck", {
					goodID = uv0.goodID_,
					heroID = uv0.heroID_,
					skinID = uv0.skinID_
				})
			end

			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_skin_buy = uv0.skinID_
			})
		end
	end)
	slot0:AddBtnListener("panel/right/btn_change", nil, function ()
		if Input.touchCount <= 1 then
			uv0:Go("/heroSkin", {
				heroID = uv0.heroID_,
				skinID = uv0.skinID_
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.goodID_ = slot0.params_.goodId

	uv0.super.OnEnter(slot0)
	slot0:RegistEventListener(RECHARGE_SUCCESS, function (slot0)
		uv0:RefreshUI()
	end)
end

function slot0.RefreshInfo(slot0, slot1, slot2)
	slot0.nameText_.text = SkinCfg[slot1].name
	slot0.infoText_.text = SkinCfg[slot1].desc
	slot0.sourcetextText_.text = ItemCfg[slot1].desc_source
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

function slot0.ShowDiscountTip(slot0)
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("BUY_TREASURE_SKIN_TIP"),
		BtnText = {
			GetTips("CONTINUE_BUY"),
			GetTips("CONTINUE_BUY"),
			GetTips("GO_UP_TO")
		},
		OkCallback = function ()
			JumpTools.JumpToPage2({
				527
			})
		end,
		CancelCallback = function ()
			uv0:Go("skinBuyCheck", {
				goodID = uv0.goodID_,
				heroID = uv0.heroID_,
				skinID = uv0.skinID_
			})
		end
	})
end

return slot0
