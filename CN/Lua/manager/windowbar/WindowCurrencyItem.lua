slot0 = class("WindowCurrencyItem", import("game.extend.ReduxView"))

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.currencyType_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
	slot0:RefreshUI()

	slot0.isCanAdd_ = true
	slot0.isCanClick_ = false
	slot0.type_ = "black"
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeSet_ = {
		"black",
		"hyaline"
	}
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(nil, , "OnClick")
	slot0:AddBtnListener(slot0.buttonIcon_, nil, function ()
		manager.notify:Invoke(WINDOW_BAR_INFO, uv0.currencyType_, uv0.gameObject_)

		if uv0.currencyType_ == CurrencyConst.GetPlatformDiamondId() then
			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].flower_tips == 1 then
				JumpTools.OpenPageByJump("totalRecharge")
			end
		elseif slot0 == CurrencyConst.CURRENCY_TYPE_VITALITY and uv0.OnClickCurrencyFunc_ then
			uv0.OnClickCurrencyFunc_()
		end
	end)
end

function slot0.OnClick(slot0)
	if slot0.isCanAdd_ or slot0.isCanClick_ then
		if slot0.currencyType_ == CurrencyConst.CURRENCY_TYPE_GOLD then
			slot2 = false
			slot4 = ipairs
			slot6 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND] or {}

			for slot7, slot8 in slot4(slot6) do
				if ItemTools.getItemNum(slot8) > 0 then
					slot2 = true

					break
				end
			end

			if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or slot2 then
				JumpTools.OpenPopUp("currencyBuyGold", slot0.params_, ViewConst.SYSTEM_ID.BUY_GOLD)
			else
				ShowTips("ERROR_SHOP_BUY_TIMES_LIMIT")
			end
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
				OperationRecorder.Record(gameContext:GetLastOpenPage() .. "_" .. slot0.class.__cname, "hongjing")
				JumpTools.OpenPopUp("rechargeDiamondExchange", {
					defaultNum = 0,
					getBaseNum = 1,
					useBaseNum = 1,
					useId = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
					getId = CurrencyConst.CURRENCY_TYPE_DIAMOND
				}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
			end
		elseif slot1 == CurrencyConst.GetPlatformDiamondId() then
			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 0 then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
			else
				JumpTools.GoToSystem("/rechargeMain", {
					page = 5
				}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
			end
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_VITALITY then
			OperationRecorder.Record(gameContext:GetLastOpenPage() .. "_" .. slot0.class.__cname, "dundunzhi")

			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or slot0:HaveMaterial() then
				JumpTools.OpenPopUp("currencyBuyFatigue", slot0.params_ or {
					page = 0
				}, ViewConst.SYSTEM_ID.BUY_FATIGUE)
			else
				ShowTips("ERROR_SHOP_BUY_TIMES_LIMIT")
			end
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_R_FRAGMENT or slot1 == CurrencyConst.CURRENCY_TYPE_SR_FRAGMENT or slot1 == CurrencyConst.CURRENCY_TYPE_SSR_FRAGMENT then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1,
				0
			})
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_EQUIP_PIECE or slot1 == CurrencyConst.CURRENCY_TYPE_EQUIP_CHIP_FIVESTAR or slot1 == CurrencyConst.CURRENCY_TYPE_EQUIP_CHIP_SIXSTAR then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1,
				0
			})
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_SKIN or slot1 == CurrencyConst.CURRENCY_TYPE_MYTHIC then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1,
				0
			})
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_MATRIX_COIN or slot1 == CurrencyConst.CURRENCY_TYPE_MATRIX_RING or slot1 == CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION or slot1 == CurrencyConst.CURRENCY_TYPE_MATRIX_PT or slot1 == CurrencyConst.CURRENCY_TYPE_BOSS_CHALLENGE then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1,
				0
			})
		elseif slot1 == CurrencyConst.CURRENCY_TYPE_CLUB_A or slot1 == CurrencyConst.CURRENCY_TYPE_CLUB_B then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1,
				0
			})
		else
			ShowPopItem(POP_SOURCE_ITEM, {
				slot1,
				0
			})
		end
	end
end

function slot0.SetCanAdd(slot0, slot1)
	if slot0.isCanAdd_ == slot1 then
		return
	end

	slot0.isCanAdd_ = slot1

	SetActive(slot0.add_, slot1)
end

function slot0.SetCanClick(slot0, slot1)
	slot0.isCanClick_ = slot1
end

function slot0.SetType(slot0, slot1)
	if table.indexof(slot0.typeSet_, slot1) then
		slot0.type_ = slot1

		slot0.typeCon_:SetSelectedState(slot0.type_)
	end
end

function slot0.RefreshUI(slot0)
	if slot0.currencyType_ == CurrencyConst.CURRENCY_TYPE_VITALITY then
		slot0.text_.text = NumberTools.RetractNumberForWindBar(slot0:GetCnt(slot0.currencyType_)) .. "/" .. GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max
	elseif slot1 == CurrencyConst.GetPlatformDiamondId() then
		slot0.text_.text = CurrencyData:GetRechargeDiamond()
	else
		slot0.text_.text = NumberTools.RetractNumberForWindBar(slot0:GetCnt(slot0.currencyType_))
	end

	slot0.icon_.sprite = ItemTools.getItemLittleSprite(slot1)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.UpdateCurrencyNum))
		slot0:RefreshUI()
		slot0.transform_:SetAsLastSibling()
	else
		slot0:RemoveAllEventListener()
	end
end

function slot0.UpdateCurrencyNum(slot0, slot1)
	if slot1 == 0 or slot1 == slot0.currencyType_ or CurrencyData:IsRechargeDiamond(slot1) and CurrencyData:IsRechargeDiamond(slot0.currencyType_) then
		slot0:RefreshUI()

		if slot1 == CurrencyConst.CURRENCY_TYPE_VITALITY and GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max <= slot0:GetCnt(slot0.currencyType_) and slot0.OnStopTimerFunc_ then
			slot0.OnStopTimerFunc_()
		end
	end
end

function slot0.GetCnt(slot0, slot1)
	if CurrencyData:GetCurrencyMap() == nil then
		return 0
	elseif slot1 == CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A then
		return CommunityData:GetCurrenyA()
	else
		return CurrencyData:GetCurrencyNum(slot1)
	end
end

function slot0.HaveMaterial(slot0)
	slot1 = false

	for slot6 = 1, #GameSetting.vitality_exchange_id_list.value do
		if MaterialData:GetMaterialList()[slot2[slot6]] and MaterialData:GetMaterialList()[slot2[slot6]].num > 0 then
			slot1 = true

			break
		end
	end

	return slot1
end

function slot0.UnBindListener(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.RegistClickFunc(slot0, slot1)
	slot0.OnClickCurrencyFunc_ = slot1
end

function slot0.RegistTimeFunc(slot0, slot1)
	slot0.OnStopTimerFunc_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
