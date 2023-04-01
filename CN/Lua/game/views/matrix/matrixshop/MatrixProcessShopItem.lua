slot0 = class("MatrixProcessShopItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_priceBtn, nil, function ()
		if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN) < uv0.priceNum then
			ShowTips("LACK_CURRENCY")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_SHOP_BUY_CONFIRM"),
			OkCallback = function ()
				uv0:OnRewardAction()
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItem = MatrixProcessRewardItem.New(slot0.m_reward)
	slot0.discountController = ControllerUtil.GetController(slot0.transform_, "discount")
end

function slot0.Refresh(slot0, slot1)
	slot0.id = slot1.id
	slot0.shopIndex = slot1.index
	slot0.discount = slot1.discount
	slot0.priceId = slot1.priceId
	slot0.priceNum = slot1.priceNum
	slot0.m_priceIcon.sprite = ItemTools.getItemLittleSprite(slot0:GetSwitchItemIcon(slot0.priceId))
	slot0.m_priceText.text = slot1.priceNum

	if slot1.discount ~= 1 then
		slot0.m_originalText.text = slot1.priceOriginal

		slot0.discountController:SetSelectedIndex(1)
	else
		slot0.discountController:SetSelectedIndex(0)
	end

	slot0.rewardItem:Refresh(slot0.id)

	slot0.rewardItem.selected_ = true

	slot0.rewardItem:UpdateAstrolabePreview()
end

function slot0.OnRewardAction(slot0)
	if not MatrixItemCfg[slot0.id] then
		print("MatrixItemCfg cant find item by id :" .. slot1)

		return
	end

	if MatrixConst.ITEM_TYPE.ASTROLABE == slot2.matrix_item_type then
		slot5 = slot0:GetHeroData(math.floor(slot2.params[1] / 1000))
		slot6 = slot5:GetAstrolabeList()

		if slot5:GetAstrolabeNum(slot2.params[1]) >= 3 then
			ShowTips(GetTips("MATRIX_NOT_GET_ASTROLABEL"))

			return
		end

		if slot0:GetAstrolabeMaxCount() <= #slot6 then
			JumpTools.OpenPageByJump("matrixProcessAstrolabeReplace", {
				heroId = slot4,
				astrolabeId = slot1,
				callback = function (slot0)
					MatrixAction.BuyShopItem(uv0.shopIndex, uv1:GetStandardId(), slot0)
				end
			})
		else
			MatrixAction.BuyShopItem(slot0.shopIndex, slot5:GetStandardId(), 0)
		end

		return
	end

	if MatrixConst.ITEM_TYPE.EQUIP == slot3 then
		JumpTools.OpenPageByJump("matrixProcessShopSelectHero", {
			index = slot0.shopIndex,
			id = slot1
		})
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == slot3 then
		if MatrixTools.GetWeaponSpecHero(slot2.params[1]) == 0 then
			JumpTools.OpenPageByJump("matrixProcessShopSelectHero", {
				index = slot0.shopIndex,
				id = slot1
			})
		elseif slot0:GetHeroData(slot4):GetWeaponServant() ~= 0 then
			JumpTools.OpenPageByJump("matrixProcessWeaponReplace", {
				heroId = slot4,
				weaponId = slot1,
				callback = function ()
					MatrixAction.BuyShopItem(uv0.shopIndex, uv1:GetStandardId(), uv2)
				end
			})
		else
			MatrixAction.BuyShopItem(slot0.shopIndex, slot5:GetStandardId(), 0)
		end
	else
		MatrixAction.BuyShopItem(slot0.shopIndex, 0, 0)
	end
end

function slot0.Dispose(slot0)
	slot0.rewardItem:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

function slot0.GetAstrolabeMaxCount(slot0)
	return MatrixData:GetAstrolabeMaxCount()
end

function slot0.GetSwitchItemIcon(slot0, slot1)
	return slot1
end

return slot0
