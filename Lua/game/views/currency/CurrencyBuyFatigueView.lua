slot0 = class("CurrencyBuyFatigueNewView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/VitalityExchangeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.InitSelect(slot0)
	slot0.selectDic_ = {}
end

function slot0.InitData(slot0)
	slot1 = MaterialData
	slot5 = ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID
	slot0.dataList_ = slot1:GetMaterialListBySubTypes({
		ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY,
		slot5
	})
	slot0.itemDrop_ = {}

	function slot4(slot0, slot1)
		if ((ItemTools.GetItemExpiredTimeByInfo(slot0) or 0) > 0 and 1 or 0) ~= ((ItemTools.GetItemExpiredTimeByInfo(slot1) or 0) > 0 and 1 or 0) then
			return slot5 < slot4
		end

		if slot2 ~= slot3 then
			return slot2 < slot3
		end

		return slot0.id < slot1.id
	end

	table.sort(slot0.dataList_, slot4)

	for slot4, slot5 in ipairs(slot0.dataList_) do
		slot0.itemDrop_[slot4] = ItemCfg[slot5.id].param[1][2]
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "selectType")
	slot0.selectIndex_ = {
		"Item",
		"Diamond"
	}
	slot0.itemDrop_ = {}
	slot0.getVitalityText_.text = ""
	slot0.materialList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, CommonItem)
	slot0.toggleGo_ = slot0:FindGo("Canvas/panel/switch")
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = slot0.dataList_[slot1].id
	slot4 = slot0.dataList_[slot1].time_valid

	slot2:RefreshData({
		id = slot3,
		number = slot0.dataList_[slot1].num,
		time_valid = slot4
	})

	if slot0.selectDic_[slot0:GetKey(slot3, slot4)] then
		slot2:ShowSelect(slot0.selectDic_[slot5])
	else
		slot2:ShowSelect(0)
	end

	slot2:RegistCallBack(function (slot0)
		uv0:AddSelect(uv1, uv2)
		uv3:ShowSelect(uv0.selectDic_[uv4])
		uv0:UpdatePreview()
	end)
	slot2:RegistLongCallBack(function (slot0)
		uv0:AddSelect(uv1, uv2)
		uv3:ShowSelect(uv0.selectDic_[uv4])
		uv0:UpdatePreview()

		return true
	end)
	slot2:RegistCutCallBack(function (slot0)
		uv0:DeleteSelect(uv1, uv2)
		uv3:ShowSelect(uv0.selectDic_[uv4])
		uv0:UpdatePreview()

		return true
	end)
	slot2:UpdateTime()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_dundun_diamond_check = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		})

		if uv0.selectType_ == "Diamond" then
			print("购买前 购买次数=======================" .. CurrencyData:GetFatigueBuyTimes())

			if GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].diamond_to_fatigue + CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY) > 999 then
				ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

				return false
			end

			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] then
				if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].cost_diamond_to_fatigue then
					JumpTools.OpenPopUp("rechargeDiamondExchange", {
						getBaseNum = 1,
						useBaseNum = 1,
						useId = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
						getId = CurrencyConst.CURRENCY_TYPE_DIAMOND,
						defaultNum = slot1 - CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)
					}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)

					return
				end

				slot2 = SettingData:GetRemindSettingData()

				if not _G.SkipTip.SkipDiamondBuyFatigueTip and slot2.diamond_buy_fatigue_reminder == 1 then
					ShowMessageBox({
						title = GetTips("PROMPT"),
						content = string.format(GetTips("PAY_FOR_POWER"), slot1, ItemCfg[CurrencyIdMapCfg.CURRENCY_TYPE_FATIGUE.item_id].name, slot0),
						OkCallback = function ()
							_G.SkipTip.SkipDiamondBuyFatigueTip = uv0.SkipDiamondBuyFatigueTip_

							CurrencyAction.BuyFatigue()
						end,
						ToggleCallback = function (slot0)
							uv0.SkipDiamondBuyFatigueTip_ = slot0
						end
					})
				else
					CurrencyAction.BuyFatigue()
				end
			else
				ShowTips("ERROR_ITEM_DIAMOND_COIN_TIMES_OVER_LIMIT")
				uv0:Back()
			end
		elseif uv0.selectType_ == "Item" then
			slot0 = {}
			slot1 = 0

			for slot5, slot6 in pairs(uv0.selectDic_) do
				slot7 = tonumber(string.split(slot5, "_")[1])
				slot8 = tonumber(string.split(slot5, "_")[2] or 0)

				if slot6 > 0 then
					slot1 = slot1 + slot6

					table.insert(slot0, {
						item_id = slot7,
						time_valid = slot8,
						use_list = {},
						num = slot9
					})
				end
			end

			if #slot0 == 0 or slot1 == 0 then
				ShowTips("TIP_CHOOSE_EMPTY")

				return
			end

			if uv0:GetSelectTotalVitality() + CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY) > 999 then
				ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

				return false
			end

			CommonAction.TryToUseItem(slot0)
		end

		uv0:RefreshTexts()
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddToggleListener(slot0.toggle_, function (slot0)
		OperationRecorder.Record("exchange", "dundun_material")

		if slot0 then
			uv0:ChangeShowView("Diamond", true)
		else
			uv0:ChangeShowView("Item", true)

			if not uv0.curMaterialId_ then
				uv0:SelectFirstMaterial()
			end
		end
	end)
end

function slot0.AddSelect(slot0, slot1, slot2)
	if not slot0.selectDic_[slot0:GetKey(slot1, slot2)] then
		slot0.selectDic_[slot3] = 0
	end

	slot4 = MaterialData:GetMaterial(slot1, slot2).num

	if slot0:GetSelectTotalVitality() + ItemCfg[slot1].param[1][2] + CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY) > 999 then
		ShowTips("ERROR_ITEM_FATIGUE_LIMIT")

		return
	end

	slot0.selectDic_[slot3] = math.min(slot4, slot0.selectDic_[slot3] + 1)
end

function slot0.DeleteSelect(slot0, slot1, slot2)
	if not slot0.selectDic_[slot0:GetKey(slot1, slot2)] then
		slot0.selectDic_[slot3] = 0
	end

	slot0.selectDic_[slot3] = math.max(slot0.selectDic_[slot3] - 1, 0)
end

function slot0.GetKey(slot0, slot1, slot2)
	return string.format("%d_%s", slot1, tostring(slot2))
end

function slot0.SelectFirstMaterial(slot0)
end

function slot0.UpdatePreview(slot0)
	slot0.getVitalityText_.text = string.format(GetTips("GET_FATIGUE"), slot0:GetSelectTotalVitality())
end

function slot0.GetSelectTotalVitality(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.selectDic_) do
		slot8 = string.split(slot5, "_")[2]
		slot1 = slot1 + ItemCfg[tonumber(string.split(slot5, "_")[1])].param[1][2] * slot6
	end

	return slot1
end

function slot0.OnTryToUseItem(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		if #slot2.use_item_list > 0 then
			for slot6, slot7 in pairs(slot2.use_item_list) do
				MaterialAction.MaterialModify(slot2.use_item_list[slot6].item_id, -1 * slot2.use_item_list[slot6].num, slot2.use_item_list[slot6].time_valid)
			end
		end

		if GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max <= CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY) then
			CurrencyData:SetFatigueCallFlag(0)
		end

		ShowTips("EXCHANGE_SUCCESS")
		slot0:Back()
	else
		ShowTips(slot1.result)
	end
end

function slot0.ChangeShowView(slot0, slot1, slot2)
	if slot2 then
		slot0.selectTypeController_:SetSelectedState(slot1)

		slot0.selectType_ = slot1

		slot0:RefreshTexts()
	end
end

function slot0.OnSubscribe(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_dundun_diamond = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	})
	slot0:InitSelect()
	slot0:UpdateMaterials()
	slot0:OnOpenPage()
	slot0:RefreshTexts()
	slot0:RefreshVitality()
	slot0:RefreshCoundown()
	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnCurrencyChange))
	slot0:RegistEventListener(MATERIAL_MODIFY, handler(slot0, slot0.OnMaterialModify))
	slot0:RegistEventListener(MATERIAL_DELETE, handler(slot0, slot0.OnMaterialModify))
end

function slot0.OnBehind(slot0)
	slot3 = slot0.materialList_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:StopLongClickTimer()
	end
end

function slot0.OnMaterialModify(slot0, slot1)
	slot0:UpdateMaterials()
end

function slot0.UpdateMaterials(slot0)
	slot0:InitData()
	slot0.materialList_:StartScroll(#slot0.dataList_)
end

function slot0.OnCurrencyChange(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_VITALITY then
		slot0:RefreshVitality()
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	slot3 = slot0.materialList_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:StopLongClickTimer()
	end

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.itemSelect_ = {
		0,
		0,
		0
	}
	slot0.curMaterialId_ = nil
end

function slot0.OnOpenPage(slot0)
	slot1 = "Item"
	slot2 = #slot0.dataList_ <= 0

	if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] then
		if slot2 then
			slot1 = "Diamond"

			SetActive(slot0.toggleGo_, false)
		else
			slot1 = "Item"

			SetActive(slot0.toggleGo_, true)
		end
	else
		SetActive(slot0.toggleGo_, false)

		slot1 = "Item"
	end

	if slot0.params_.page and slot0.params_.page > 0 then
		slot1 = slot0.selectIndex_[slot0.params_.page]
	end

	if slot1 == "Item" then
		slot0:SelectFirstMaterial()
	end

	slot0.toggle_.isOn = slot1 == "Diamond"

	slot0:ChangeShowView(slot1, true)

	slot0.selectType_ = slot1
end

function slot0.RefreshTexts(slot0)
	if slot0.selectType_ == "Diamond" then
		slot3 = GameSetting.fatigue_max_buy_time.value[1]
		slot0.limitTotal_.text = "/" .. slot3
		slot0.limitNum_.text = slot3 - CurrencyData:GetFatigueBuyTimes()
		slot0.diamondUse_.text = GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].cost_diamond_to_fatigue
		slot0.diamondGet_.text = GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].diamond_to_fatigue
		slot0.getVitalityText_.text = ""
	elseif slot0.selectType_ == "Item" then
		slot0:UpdatePreview()
	end
end

function slot0.RefreshVitality(slot0)
	slot2 = GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max
	slot3 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	slot0.vitalityText_.text = string.format("%s/%s", slot3, slot2)
	slot0.vitalityText1_.text = string.format("%s/%s", slot3, slot2)
	slot0.fullText_.text = string.format("%s/%s", slot3, slot2)
	slot4 = slot3 < slot2

	SetActive(slot0.countdownTextGo_, slot4)
	SetActive(slot0.countdownTextcnGo_, slot4)
	SetActive(slot0.allCountdownTextGo_, slot4)
	SetActive(slot0.allCountdownTextcnGo_, slot4)
	SetActive(slot0.fullPanel_, not slot4)
	SetActive(slot0.vitalityPanelGo_, slot4)
	SetActive(slot0.countdownPanel_, slot3 < 999)
	SetActive(slot0.limitGo_, slot3 >= 999)
end

function slot0.during(slot0)
	slot1 = GameSetting.fatigue_recovery.value[1] * 60

	return CurrencyData:GetLastFatigueRecoverTime() == 0 and slot1 or slot1 - (manager.time:GetServerTime() - CurrencyData:GetLastFatigueRecoverTime()) % slot1
end

function slot0.RefreshCoundown(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	slot1 = slot0:during()
	slot6 = (GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max - CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY) - 1) * GameSetting.fatigue_recovery.value[1] * 60 + slot1
	slot0.countdownText_.text = string.format("%02d:%02d:%02d", math.floor(slot1 / 3600), math.floor(slot1 % 3600 / 60), slot1 % 60)
	slot0.allCountdownText_.text = string.format("%02d:%02d:%02d", math.floor(slot6 / 3600), math.floor(slot6 % 3600 / 60), slot6 % 60)
	slot0.timer_ = Timer.New(function ()
		uv0 = uv1:during()
		uv2 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		uv3 = (uv4 - uv2 - 1) * uv5 + uv0
		uv1.countdownText_.text = string.format("%02d:%02d:%02d", math.floor(uv0 / 3600), math.floor(uv0 % 3600 / 60), uv0 % 60)
		uv1.allCountdownText_.text = string.format("%02d:%02d:%02d", math.floor(uv3 / 3600), math.floor(uv3 % 3600 / 60), uv3 % 60)

		if uv0 <= 0 then
			uv1.timer_:Stop()

			uv1.timer_ = nil
		end
	end, 0.2, -1)

	slot0.timer_:Start()
end

function slot0.OnBuyFatigue(slot0, slot1, slot2)
	if slot1.result == 0 then
		CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_DIAMOND, -GameCurrencyBuySetting[CurrencyData:GetFatigueBuyTimes() + 1].cost_diamond_to_fatigue)
		ShowTips("TRANSACTION_SUCCESS")
		slot0:Back()
	else
		ShowTips(slot1.result)

		return
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.materialList_ then
		slot0.materialList_:Dispose()

		slot0.materialList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
