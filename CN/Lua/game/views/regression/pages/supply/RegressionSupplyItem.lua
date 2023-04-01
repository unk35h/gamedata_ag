slot0 = class("RegressionSupplyItem", ReduxView)

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

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.costTypeController_ = ControllerUtil.GetController(slot0.transform_, "costType")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if not RegressionData:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			return
		end

		SendMessageManagerToSDK("purchase_click_gp_once")

		if uv0.statusController_:GetSelectedState() == "normal" then
			JumpTools.OpenPageByJump("rechargeGiftPop", {
				goodId = uv0.goodId_,
				buyTime = uv0.buyTime_,
				itemCfg = uv0.itemCfg_,
				shopId = uv0.shopId_,
				shopCfg = uv0.goodCfg_
			})
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_giftbox = uv0.goodId_
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.shopId_ = slot2
	slot0.goodId_ = slot3
	slot0.goodCfg_ = getShopCfg(slot3)
	slot0.shopCfg_ = ShopListCfg[slot0.goodCfg_.shop_id]
	slot0.itemCfg_ = ItemCfg[slot0.goodCfg_.give_id]
	slot0.buyTime_ = ShopData.GetShop(slot2)[slot3] ~= nil and ShopData.GetShop(slot2)[slot3].buy_times or 0

	slot0:UpdateView()
	slot0:UpdatePrice()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.costPanelTrans_)
end

function slot0.SetOutOfDateHandler(slot0, slot1)
	slot0.outOfDateHandler_ = slot1
end

function slot0.UpdateView(slot0)
	slot0.nameLabel_.text = string.format("%s", slot0.itemCfg_.name)
	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/PrizeItem/" .. slot0.itemCfg_.icon)
	slot1 = false

	if slot0.goodCfg_.limit_num ~= nil and slot0.goodCfg_.limit_num ~= -1 then
		slot2 = slot0.goodCfg_.limit_num - slot0.buyTime_
		slot0.limitLabel_.text = string.format("%d/%d", slot2, slot0.goodCfg_.limit_num)

		if slot2 <= 0 then
			slot1 = true
		end
	end

	if #slot0.goodCfg_.level_limit > 0 then
		if slot0.goodCfg_.level_limit[1][1] ~= nil then
			if slot0.goodCfg_.level_limit[1][1] == 1 and PlayerData:GetPlayerInfo().userLevel < slot0.goodCfg_.level_limit[1][2] then
				levelEnough = false
			end
		elseif slot0.goodCfg_.level_limit[1].type and slot0.goodCfg_.level_limit[1].type == 1 and PlayerData:GetPlayerInfo().userLevel < slot0.goodCfg_.level_limit[1].num then
			levelEnough = false
		end
	end

	if slot1 then
		slot0.statusController_:SetSelectedState("soldout")
	else
		slot0.statusController_:SetSelectedState("normal")
	end

	slot2 = false
	slot3, slot4, slot5 = ShopTools.GetPrice(slot0.goodCfg_.goods_id)

	if slot3 <= 0 and not slot1 then
		slot2 = true
	end

	SetActive(slot0.redPointGo_, slot2 and not OperationData:IsFunctionStoped(slot0.shopCfg_.operation_stop_id))
end

function slot0.UpdatePrice(slot0)
	slot1, slot2, slot3 = ShopTools.GetPrice(slot0.goodCfg_.goods_id)

	if slot1 <= 0 then
		slot0.costTypeController_:SetSelectedState("free")

		slot0.isFree_ = true
	else
		slot0.costTypeController_:SetSelectedState("currency")

		slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot0.goodCfg_.cost_id)

		if slot0:GetHave() < slot1 then
			slot0.costLabel_.text = "<color=#cf5050>" .. slot1 .. "</color>"
		else
			slot0.costLabel_.text = slot1
		end

		slot0.isFree_ = false
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.GetHave(slot0)
	if ItemCfg[slot0.goodCfg_.cost_id].type == ItemConst.ITEM_TYPE.CURRENCY then
		if slot1.cost_id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE then
			return CurrencyData:GetRechargeDiamond()
		end

		return CurrencyData:GetCurrencyNum(slot1.cost_id)
	elseif (slot2.type == ItemConst.ITEM_TYPE.MATERIAL or slot2.type == ItemConst.ITEM_TYPE.PROPS) and MaterialData:GetMaterialList()[slot1.cost_id] then
		return slot3.num
	end

	return 0
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
