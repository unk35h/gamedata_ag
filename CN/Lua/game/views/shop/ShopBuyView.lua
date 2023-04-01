slot0 = class("ShopBuyView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Shop/ShopBuyUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
	slot0.useNumTriggerListener_ = slot0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	slot0.typeCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "type")
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.commonItem_

	slot1:RegistCallBack(function (slot0)
		if ItemCfg[slot0.id].type == ItemConst.ITEM_TYPE.EQUIP or slot1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot0.id,
				slot0.number
			}, nil)
			OperationRecorder.Record("ShopItemView", "ExplaintBut")
		end
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddPressingByTimeListener(slot0.addBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ < uv0:GetMaxBuyNum() then
			uv0.selectNum_ = uv0.selectNum_ + 1

			uv0:RefreshNum()
			uv0:UpdateSliderPosition()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.delBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ > 1 then
			uv0.selectNum_ = uv0.selectNum_ - 1

			uv0:RefreshNum()
			uv0:UpdateSliderPosition()

			return true
		end

		return false
	end)

	slot1 = slot0.useNumSlider_.onValueChanged

	slot1:AddListener(function ()
		uv0.selectNum_ = uv0.useNumSlider_.value

		if uv0.selectNum_ < 1 then
			uv0.selectNum_ = 1

			uv0:UpdateSliderPositionBySelectNum()
		elseif uv0:GetMaxBuyNum() < uv0.selectNum_ then
			uv0.selectNum_ = uv0:GetMaxBuyNum()
		end

		uv0:RefreshNum()
	end)

	slot1 = slot0.useNumTriggerListener_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:RefreshNum()
		uv0:UpdateSliderPosition()
		OperationRecorder.Record("shop", "shop_number_slide")
	end))
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		slot0 = uv0.goodInfo_

		if OperationData:IsFunctionStoped(ShopListCfg[getShopCfg(uv0.goodInfo_.id).shop_id].operation_stop_id) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		if ItemCfg[slot1.give_id].type == ItemConst.ITEM_TYPE.HERO_PIECE or slot3.type == ItemConst.ITEM_TYPE.HERO then
			slot5 = HeroData:GetHeroOmegaNeedPiece(slot3.id % 10000)

			if slot1.shop_id == 2 and slot5 <= 0 then
				ShowTips("OMEGA_ENOUGH_TIP")

				return
			end

			if not _G.SkipTip.ShopOmega and slot5 < uv0.selectNum_ then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("SHOP_OMEGA_CONFIRMATION"),
					OkCallback = function ()
						_G.SkipTip.ShopOmega = uv0.ShopOmega_

						ShopAction.BuyItem(uv1.id, uv0.selectNum_)
					end,
					ToggleCallback = function (slot0)
						uv0.ShopOmega_ = slot0
					end
				})

				return
			end
		end

		slot4 = SettingData:GetRemindSettingData()
		slot5 = slot1.cost_id

		if not _G.SkipTip.SkipDiamondBuyItemTip and slot5 == CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id and slot4.diamond_buy_item_reminder == 1 or not _G.SkipTip.SkipCoreEquipBuyItemTip and slot5 == CurrencyIdMapCfg.CURRENCY_TYPE_SIX_STAR_EQUIP_RESOLVE.item_id and slot4.core_equip_buy_item_reminder == 1 or not _G.SkipTip.SkipInfoBadageTopBuyItemTip and slot5 == CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_TOP.item_id and slot4.info_badge_top_buy_item_reminder == 1 or not _G.SkipTip.SkipBossChangeSBuyItemTip and slot5 == CurrencyIdMapCfg.CURRENCY_TYPE_BOSS_CHALLENGE_S.item_id and slot4.boss_challenge_s_buy_item_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("SHOP_SECONDARY_CONFIRMATION"), GetI18NText(ItemCfg[slot5].name), uv0.totalCostText_.text, GetI18NText(slot3.name), uv0.selectNum_),
				OkCallback = function ()
					if uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id then
						_G.SkipTip.SkipDiamondBuyItemTip = uv1.SkipDiamondBuyItemTip_
					elseif uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_SIX_STAR_EQUIP_RESOLVE.item_id then
						_G.SkipTip.SkipCoreEquipBuyItemTip = uv1.SkipCoreEquipBuyItemTip_
					elseif uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_TOP.item_id then
						_G.SkipTip.SkipInfoBadageTopBuyItemTip = uv1.SkipInfoBadageTopBuyItemTip_
					elseif uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_BOSS_CHALLENGE_S.item_id then
						_G.SkipTip.SkipBossChangeSBuyItemTip = uv1.SkipBossChangeSBuyItemTip_
					end

					ShopAction.BuyItem(uv2.id, uv1.selectNum_)
				end,
				ToggleCallback = function (slot0)
					if uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id then
						uv1.SkipDiamondBuyItemTip_ = slot0
					elseif uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_SIX_STAR_EQUIP_RESOLVE.item_id then
						uv1.SkipCoreEquipBuyItemTip_ = slot0
					elseif uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_TOP.item_id then
						uv1.SkipInfoBadageTopBuyItemTip_ = slot0
					elseif uv0 == CurrencyIdMapCfg.CURRENCY_TYPE_BOSS_CHALLENGE_S.item_id then
						uv1.SkipBossChangeSBuyItemTip_ = slot0
					end
				end
			})
		else
			ShopAction.BuyItem(slot0.id, uv0.selectNum_)
		end
	end)
end

function slot0.UpdateSliderPositionBySelectNum(slot0)
	slot0.useNumSlider_.value = slot0.selectNum_
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 0 then
		slot5 = getShopCfg(slot2)
		slot7 = slot5.give

		slot0:Back()

		if ItemCfg[slot5.give_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			getReward({
				{
					slot6,
					1
				}
			}, {
				ItemConst.ITEM_TYPE.HERO_SKIN
			})
		elseif slot8 == ItemConst.ITEM_TYPE.EQUIP and EquipData:GetEquipBagFull() then
			showEquipSendMail(nil)
			EquipAction.EquipBagFull(false)
		end
	end
end

function slot0.RefreshUI(slot0)
	slot0.useNumSlider_.minValue = 1
	slot0.useNumSlider_.maxValue = slot0:GetMaxBuyNum()
	slot2 = getShopCfg(slot0.goodInfo_.id)
	slot3 = ShopListCfg[slot2.shop_id]

	if ItemCfg[slot2.give_id].type == ItemConst.ITEM_TYPE.EQUIP then
		SetActive(slot0.tipGo_, true)

		slot0.haveNumText_.text = "x" .. #EquipTools.GetEquipListByEquipid(slot2.give_id)
	elseif slot5 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		SetActive(slot0.tipGo_, true)

		slot0.haveNumText_.text = "x" .. #(WeaponServantData:GetWeaponServantById(slot2.give_id) or {})
	else
		SetActive(slot0.tipGo_, false)

		slot0.haveNumText_.text = "x" .. NumberTools.RetractNumberForWindBar(ItemTools.getItemNum(slot2.give_id))
	end

	slot0.commonItem_:RefreshData({
		id = slot2.give_id,
		number = slot2.give
	})

	if slot5 ~= ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		slot0.commonItem_:SetBottomText("")
		slot0.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
	else
		slot0.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
		slot0.commonItem_:HideServantTxt()
	end

	slot0.nameText_.text = GetI18NText(slot4.name) .. " x" .. slot2.give
	slot0.descText_.text = slot4.desc

	slot0:RefreshNum()
	slot0:UpdateSliderPosition()

	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot2.cost_id)

	if slot0:IsLimit() then
		SetActive(slot0.limitGo_, true)

		if slot3.type == 1 then
			slot0.limitText_.text = GetTips(ShopConst.SHOP_LIMIT_TEXT[slot2.refresh_cycle])
		else
			slot0.limitText_.text = GetTips("PURCHASE_LIMIT")
		end

		slot0.limitNumText_.text = slot0:GetRestNum() .. "/" .. slot0:GetLimitNum()
	else
		SetActive(slot0.limitGo_, false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.limitGo_.transform)

	slot7 = slot5 == ItemConst.ITEM_TYPE.EQUIP
end

function slot0.UpdateSliderPosition(slot0)
	slot0.useNumSlider_.value = slot0.selectNum_
end

function slot0.RefreshNum(slot0)
	slot0.useNumText_.text = slot0.selectNum_
	slot2, slot3 = nil

	if ShopCfg[slot0.goodInfo_.id] then
		slot2 = ShopCfg[slot1.id]
		slot3 = ShopTools.GetPrice(slot1.id)
	else
		slot2 = ExchangeCfg[slot1.id]
		slot3 = ExchangeTools.GetPrice(slot1.id)
	end

	if slot0:GetHaveNum() < slot3 * slot0.selectNum_ then
		slot0.totalCostText_.text = "<color=#FF0000>" .. slot4 .. "</color>"
	else
		slot0.totalCostText_.text = slot4
	end

	if slot0:GetMaxBuyNum() <= slot0.selectNum_ then
		slot0:SetBtnEnable(slot0.addBtn_, false)
	else
		slot0:SetBtnEnable(slot0.addBtn_, true)
	end

	if slot0.selectNum_ <= 1 then
		slot0:SetBtnEnable(slot0.delBtn_, false)
	else
		slot0:SetBtnEnable(slot0.delBtn_, true)
	end

	if slot6 == 1 then
		slot0.useNumSlider_.minValue = 0
	else
		slot0.useNumSlider_.minValue = 1
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.totalTransform_)
end

function slot0.SetBtnEnable(slot0, slot1, slot2)
	slot1.interactable = slot2
end

function slot0.GetHaveNum(slot0)
	if ItemCfg[getShopCfg(slot0.goodInfo_.id).cost_id].type == ItemConst.ITEM_TYPE.CURRENCY then
		return CurrencyData:GetCurrencyNum(slot2.cost_id)
	elseif slot3 == ItemConst.ITEM_TYPE.MATERIAL or slot3 == ItemConst.ITEM_TYPE.PROPS then
		if MaterialData:GetMaterialList()[slot2.cost_id] then
			return slot4.num
		end
	elseif slot3 == ItemConst.ITEM_TYPE.HERO_PIECE then
		return HeroData:GetHeroData(ItemCfg[slot2.cost_id].hero_id).piece
	end

	return 0
end

function slot0.GetLimitNum(slot0)
	if getShopCfg(slot0.goodInfo_.id).limit_num and slot1.limit_num ~= -1 then
		return slot1.limit_num
	end

	return -1
end

function slot0.GetRestNum(slot0)
	if slot0:IsLimit() then
		return slot0:GetLimitNum() - slot0.goodInfo_.buyTime
	end

	return -1
end

function slot0.IsLimit(slot0)
	if getShopCfg(slot0.goodInfo_.id).limit_num and slot1.limit_num ~= -1 then
		return true
	end

	return false
end

function slot0.GetMaxBuyNum(slot0)
	slot1, slot2, slot3 = nil

	if ShopCfg[slot0.goodInfo_.id] then
		slot1 = ShopCfg[slot0.goodInfo_.id]
		slot2 = ShopTools.GetPrice(slot0.goodInfo_.id)
	else
		slot1 = ExchangeCfg[slot0.goodInfo_.id]
		slot2 = ExchangeTools.GetPrice(slot0.goodInfo_.id)
	end

	slot4 = -1

	if slot1.limit_num and slot1.limit_num ~= -1 then
		slot4 = slot1.limit_num - slot0.goodInfo_.buyTime
	end

	slot5 = 99999

	if ItemCfg[slot1.give_id].type == ItemConst.ITEM_TYPE.HERO_PIECE and slot1.shop_id == 2 then
		slot4 = math.max(HeroData:GetHeroOmegaNeedPiece(slot3.id - 10000), 1)
	end

	if slot4 < math.floor(slot0:GetHaveNum() / slot2) and slot4 ~= -1 then
		return slot4
	else
		return slot7 < 1 and 1 or slot7
	end
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnTop(slot0)
	slot0:RefreshUI()
	slot0:UpdateBarByGoodId(slot0.goodInfo_.id)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.totalTransform_)
	manager.windowBar:SetAsLastSibling()
end

function slot0.OnEnter(slot0)
	slot0.goodInfo_ = slot0.params_.goodInfo
	slot0.useNumSlider_.value = 1
	slot0.selectNum_ = 1

	slot0.typeCon_:SetSelectedState("shop")
end

function slot0.UpdateBarByGoodId(slot0, slot1)
	slot2 = {}

	if getShopCfg(slot1).cost_id then
		table.insert(slot2, slot3.cost_id)
	end

	slot7 = slot2

	manager.windowBar:SwitchBar(slot7)

	for slot7 = 1, #slot2 do
		manager.windowBar:SetBarCanAdd(slot2[slot7], true)
	end
end

function slot0.Dispose(slot0)
	slot0.useNumSlider_.onValueChanged:RemoveAllListeners()
	slot0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)

	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
