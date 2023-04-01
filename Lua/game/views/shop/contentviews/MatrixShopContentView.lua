slot1 = class("MatrixShopContentView", import("game.views.shop.contentViews.ShopExchangeContentView"))

function slot1.GetExchangeGoodList(slot0)
	return ExchangeTools.FilterExchangeDataList(slot0.shopId_, true)
end

return slot1
