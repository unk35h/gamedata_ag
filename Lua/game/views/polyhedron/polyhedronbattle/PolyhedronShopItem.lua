slot0 = class("PolyhedronShopItem", PolyhedronRewardItem)

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)
	slot0.shopControlle:SetSelectedIndex(1)
end

function slot0.AddUIListener(slot0)
	uv0.super.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_shopBtn, nil, function ()
		if uv0.polyhedronInfo:GetCoinCount() < uv0.priceNum then
			ShowTips("LACK_CURRENCY")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_SHOP_BUY_CONFIRM"),
			OkCallback = function ()
				PolyhedronAction.QueryBuyShopItem(uv0.shop_index)
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	uv0.super.SetData(slot0, slot1, slot2, slot3)

	slot0.shop_index = slot2.shop_index
	slot0.polyhedronInfo = slot1
	slot0.priceNum = slot2.price
	slot0.m_shopCost.text = slot2.price

	if slot1:GetShopOriginalPrice(slot2.class) ~= slot2.price then
		slot0.m_discountLab.text = slot4

		slot0.shopDiscountControlle:SetSelectedIndex(1)
	else
		slot0.shopDiscountControlle:SetSelectedIndex(0)
	end

	slot0.coinId = slot1:GetPolyhedronCoinId()
	slot0.m_shopIcon.sprite = ItemTools.getItemLittleSprite(slot0.coinId)
end

return slot0
