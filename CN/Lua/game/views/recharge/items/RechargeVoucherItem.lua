slot0 = class("RechargeVoucherItem", ReduxView)

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
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_ticket = uv0.goodId_
		})
		JumpTools.OpenPopUp("rechargeDiamondExchange", {
			defaultNum = 0,
			getBaseNum = 1,
			useBaseNum = uv0.cost_,
			useId = uv0.shopCfg_.cost_id,
			getId = uv0.itemId_,
			exchangeId = uv0.goodId_
		}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.goodId_ = slot2
	slot0.shopCfg_ = getShopCfg(slot2)
	slot0.itemId_ = slot0.shopCfg_.give_id
	slot0.itemCfg_ = ItemCfg[slot0.itemId_]
	slot0.cost_ = slot0.shopCfg_.cost

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.nameLabel_.text = slot0.itemCfg_.name
	slot0.image_.sprite = ItemTools.getItemSprite(slot0.itemId_)
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot0.shopCfg_.cost_id)
	slot0.costLabel_.text = slot0.cost_
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
