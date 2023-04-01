slot0 = class("NewShopView", ReduxView)
slot1 = {}

function slot0.UIName(slot0)
	return "UI/Shop/ShopUI_new"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.selectedSuitId = 0
	slot0.selectedPos = 0
	uv0 = {
		[11] = {
			CLASS = ShopEquipContentView
		},
		[12] = {
			CLASS = ShopEquipContentView
		},
		[5] = {
			CLASS = ShopEquipContentView
		},
		[3] = {
			CLASS = ShopEquipContentView
		}
	}
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.GetTreeDataByParams(slot0)
	slot1 = {}

	if slot0.params_.showShops then
		slot1 = slot0.params_.showShops
	else
		for slot6, slot7 in ipairs(ShopListCfg.get_id_list_by_system.shop) do
			if ShopListCfg[slot7].show_in_shop == 1 then
				table.insert(slot1, slot7)
			end
		end

		if #slot1 == 0 then
			slot1 = {
				7
			}
		end
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if ShopTools.IsShopOpen(slot7) then
			slot8 = ShopListCfg[slot7]

			table.insert(slot2, slot7)
		end
	end

	slot0.groups_ = {}
	slot0.groupIndexes_ = {}
	slot3 = UITreeData.New()

	for slot7, slot8 in ipairs(slot2) do
		if not slot0.groups_[ShopListCfg[slot8].display_group] then
			slot0.groups_[slot9.display_group] = {
				itemIndexes_ = {}
			}

			table.insert(slot0.groupIndexes_, slot9.display_group)
		end

		slot0.groups_[slot9.display_group][slot9.display_index] = slot9

		table.insert(slot0.groups_[slot9.display_group].itemIndexes_, slot9.display_index)
	end

	for slot7, slot8 in pairs(slot0.groups_) do
		table.sort(slot8.itemIndexes_, function (slot0, slot1)
			return slot0 < slot1
		end)
	end

	function slot7(slot0, slot1)
		return slot0 < slot1
	end

	table.sort(slot0.groupIndexes_, slot7)

	for slot7, slot8 in pairs(slot0.groupIndexes_) do
		slot10 = UITreeGroupData.New()
		slot10.text = ShopListCfg.get_id_list_by_system_and_group.shop[slot8][1].group_name
		slot10.controllerStateValue = tostring(slot8)

		if #slot0.groups_[slot8].itemIndexes_ == 1 and #ShopListCfg.get_id_list_by_system_and_group.shop[slot8] == 1 then
			slot10.id = slot9[slot9.itemIndexes_[1]].id
		else
			slot10.id = 10000 + slot9[slot9.itemIndexes_[1]].id

			for slot15, slot16 in ipairs(slot9.itemIndexes_) do
				slot17 = slot9[slot16]
				slot18 = UITreeItemData.New()
				slot18.id = slot17.id
				slot18.text = slot17.remark

				slot10.itemDatas:Add(slot18)
			end
		end

		slot3.groupDatas:Add(slot10)
	end

	return slot3
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.contentViewDic_ = {}
	slot0.mainShopTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "mainShopType")
	slot0.statusController_ = ControllerUtil.GetController(slot0.countdownGo_.transform, "status")
	slot0.tree_ = LuaTree.New(slot0.treeGo_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect), handler(slot0, slot0.OnItemSelect))
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	if slot2 < 10000 then
		slot0:UpdateShopList(slot2)
	end
end

function slot0.OnItemSelect(slot0, slot1, slot2, slot3, slot4)
	slot0:UpdateShopList(slot2)
	slot0:ResetFilter()
end

function slot0.GetContentViewByShopId(slot0, slot1, slot2)
	slot3 = nil
	slot3 = (not uv0[slot1] or slot4.CLASS) and (ShopListCfg[slot1].type ~= 1 or ShopContentView) and ShopExchangeContentView

	if slot0.curClass_ ~= nil and slot0.curClass_ ~= slot3 then
		SetActive(slot0.contentViewDic_[slot0.curClass_.__cname].gameObject_, false)
	end

	slot0.curClass_ = slot3

	if not slot0.contentViewDic_[slot3.__cname] then
		slot0.contentViewDic_[slot5] = slot3.New(slot0.contentContainer_, slot0.params_.hide)
	elseif slot2 ~= true then
		SetActive(slot0.contentViewDic_[slot5].gameObject_, true)
	end

	slot0.contentViewDic_[slot5]:SetShopHideHome(slot0.params_.hideHomeBtn)

	if slot2 ~= true then
		slot0.contentViewDic_[slot5]:SetShopId(slot1)
	end

	return slot0.contentViewDic_[slot5]
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(SHOP_LIST_UPDATE, function (slot0)
		if slot0 == 0 or uv0.curShopId_ == slot0 then
			uv0:UpdateShopList(uv0.curShopId_)
		end
	end)
	slot0:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function (slot0)
		uv0:OnRefreshAllShop(slot0)
	end)
	slot0:RegistEventListener(SHOP_ITEM_UPDATE, function (slot0, slot1)
		uv0:RefreshShopGoodInfo(slot0, slot1)
	end)
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		slot2 = nil

		if ((ShopListCfg[uv0.curShopId_].type ~= 3 or ExchangeCfg.get_id_list_by_cost_id[slot0]) and ShopCfg.get_id_list_by_cost_id[slot0]) ~= nil and #slot2 > 0 then
			uv0:UpdateShopList(uv0.curShopId_, true)
		end
	end)
	slot0:RegistEventListener(MATERIAL_MODIFY, function (slot0)
		slot2 = nil

		if ((ShopListCfg[uv0.curShopId_].type ~= 3 or ExchangeCfg.get_id_list_by_cost_id[slot0]) and ShopCfg.get_id_list_by_cost_id[slot0]) ~= nil and #slot2 > 0 then
			uv0:UpdateShopList(uv0.curShopId_, true)
		end
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.freshBtn_, nil, function ()
		if _G.SkipTip.SkipShopRefreshTip then
			ShopAction.RefreshSingleShop(8, uv0:GetDiamondCount())

			return
		end

		slot5 = uv0

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = {
				GetTips("WHETHER_TO_CONSUME"),
				{
					CurrencyConst.CURRENCY_TYPE_DIAMOND,
					slot5:GetDiamondCount()
				},
				GetTips("MATRIX_SHOP_REFRESH")
			},
			OkCallback = function ()
				OperationRecorder.Record("shop", "okRefresh")
				ShopAction.RefreshSingleShop(8, uv0:GetDiamondCount())

				_G.SkipTip.SkipShopRefreshTip = uv0.skipShopRefreshTip_
			end,
			ToggleCallback = function (slot0)
				uv0.skipShopRefreshTip_ = slot0

				if slot0 then
					OperationRecorder.Record("shop", "toggle")
				end
			end,
			CancelCallback = function ()
				OperationRecorder.Record("shop", "cancelRefresh")
			end
		})
	end)
	slot0:AddBtnListener(slot0.heroPieceExchangeBtn_, nil, function ()
		slot0 = {}

		for slot5 = 1, #HeroTools.GetCanExchangeHero() do
			slot9 = GameSetting.fragment_break_num.value[ItemCfg[slot1[slot5].id].rare - 2]
			slot0[slot9[1]] = (slot0[slot9[1]] or 0) + slot6.number * slot9[2]
		end

		slot2 = {}

		for slot6, slot7 in pairs(slot0) do
			if slot7 > 0 then
				table.insert(slot2, {
					id = slot6,
					num = slot7
				})
			end
		end

		if #slot2 == 0 then
			ShowTips("NO_EXCHANGE_HERO_PIECE")

			return
		end

		JumpTools.OpenPopUp("fragmentExchange", nil, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.modulepieceBtn_, nil, function ()
		if HeroTools.CheckModulePieceCanEnter() then
			JumpTools.OpenPageByJump("moduleItemResolveView")
		else
			ShowTips(GetTips("WEAPON_MODULE_MATERIAL_NOT_ENOUGH"))
		end
	end)
end

function slot0.BindRedPoints(slot0)
	for slot4 = 0, slot0.treeData_.groupDatas.Count - 1 do
		if slot0.treeData_.groupDatas[slot4].id >= 10000 then
			slot6 = slot6 - 10000
		end

		if slot6 == 2 then
			manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(slot5.id), RedPointConst.HERO_PIECE_EXCHANGE, {
				x = 0,
				y = 0
			})
		end
	end

	manager.redPoint:bindUIandKey(slot0.heroPieceExchangeBtn_.transform, RedPointConst.HERO_PIECE_EXCHANGE)
end

function slot0.UnBindRedPoints(slot0)
	for slot4 = 0, slot0.treeData_.groupDatas.Count - 1 do
		if slot0.treeData_.groupDatas[slot4].id >= 10000 then
			slot6 = slot6 - 10000
		end

		if slot6 == 2 then
			manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(slot5.id), RedPointConst.HERO_PIECE_EXCHANGE)
		end
	end

	manager.redPoint:unbindUIandKey(slot0.heroPieceExchangeBtn_.transform, RedPointConst.HERO_PIECE_EXCHANGE)
end

function slot0.OnRefreshOneShop(slot0, slot1)
end

function slot0.RefreshShopGoodInfo(slot0, slot1, slot2)
	if slot0.curShopId_ ~= slot1 then
		return
	end

	slot0:GetContentViewByShopId(slot1):RefreshShopGoodInfo(slot2)
end

function slot0.UpdateShopList(slot0, slot1, slot2)
	slot0.curShopId_ = slot1

	if slot0.mainShopTypeController_.stateValues.Count <= ShopListCfg[slot1].display_group then
		slot0.mainShopTypeController_:SetSelectedState("default")
	else
		slot0.mainShopTypeController_:SetSelectedIndex(slot3.display_group)
	end

	if slot3.display_group == ShopConst.ModuleItemShop then
		SetActive(slot0.modulepieceBtn_.gameObject, true)
	else
		SetActive(slot0.modulepieceBtn_.gameObject, false)
	end

	slot0:RefreshList(slot2)
	slot0:UpdateRefreshCount()
	slot0:UpdateTimer()
end

function slot0.RefreshList(slot0, slot1)
	slot0:GetContentViewByShopId(slot0.curShopId_):RefreshList(slot1)
end

function slot0.UpdateBarByShopId(slot0, slot1)
	if slot0:GetContentViewByShopId(slot1) then
		slot2:UpdateBarByShopId()
	end

	slot3 = manager.windowBar

	slot3:RegistHomeCallBack(function ()
		gameContext:Go("/home", nil, , true)
	end)

	slot3 = manager.windowBar

	slot3:RegistBackCallBack(function ()
		uv0:ResetPosition()
		JumpTools.Back()
	end)
end

function slot0.SelectTreeByShopId(slot0, slot1)
	slot2 = -1
	slot3 = -1

	for slot7 = 0, slot0.treeData_.groupDatas.Count - 1 do
		if tostring(slot0.treeData_.groupDatas[slot7].id) == tostring(slot1) then
			slot2 = slot7 + 1

			break
		end

		for slot12 = 0, slot8.itemDatas.Count - 1 do
			if slot8.itemDatas[slot12].id == slot1 then
				slot2 = slot7 + 1
				slot3 = slot12 + 1

				break
			end
		end
	end

	if slot3 > 0 then
		slot0.tree_:SelectItem(slot2, slot3)
	else
		slot0.tree_:SelectGroup(slot2)
	end

	slot0:UpdateShopList(slot0.curShopId_)
end

function slot0.OnEnter(slot0)
	slot0:UpdateViewByParams()

	slot0.params_.isBack = false

	slot0:AddEventListeners()
	slot0:BindRedPoints()
	slot0:SetTimer()
end

function slot0.UpdateViewByParams(slot0)
	slot0.params_.goodId = nil
	slot2 = slot0.params_.shopId
	slot0.treeData_ = slot0:GetTreeDataByParams()

	slot0.tree_:SetData(slot0.treeData_)

	if slot0.params_.goodId then
		slot0.curShopId_ = ShopListCfg[getShopCfg(slot1).shop_id].id
	elseif slot2 then
		slot0.curShopId_ = tonumber(slot2)
	else
		slot0.curShopId_ = 1
	end

	slot0:SelectTreeByShopId(slot0.curShopId_)

	slot3 = slot0:GetContentViewByShopId(slot0.curShopId_)

	if not slot0.params_.tmpBack then
		slot3:ScrollByPosition(nil, slot1)
	else
		slot3:ScrollByPosition(slot0.params_.scrollPosition, slot1)
	end

	if slot1 then
		slot0.timer_ = FrameTimer.New(function ()
			slot0 = getShopCfg(uv0)

			JumpTools.OpenPopUp("shopBuy", {
				mainShopID = uv1.curShopId_,
				goodInfo = {
					id = uv0,
					shopId = slot0.shop_id,
					buyTime = ShopData.GetShop(slot0.shop_id)[uv0] ~= nil and ShopData.GetShop(slot0.shop_id)[uv0].buy_times or 0
				}
			})

			uv1.timer_ = nil
		end, 1, 1)

		slot0.timer_:Start()
	end
end

function slot0.OnTop(slot0)
	if slot0.params_.shopId ~= nil then
		slot0:UnBindRedPoints()
		slot0:UpdateViewByParams()

		slot0.params_.shopId = nil

		slot0:BindRedPoints()
	end

	if slot0.curShopId_ ~= nil then
		slot0:UpdateShopList(slot0.curShopId_, true)
		slot0:UpdateBarByShopId(slot0.curShopId_)
	end
end

function slot0.OnExit(slot0)
	slot0.params_.shopId = slot0.curShopId_
	slot0.params_.tmpBack = true
	slot0.params_.scrollPosition = slot0:GetContentViewByShopId(slot0.curShopId_):GetScrolledPosition()

	manager.windowBar:HideBar()
	slot0:StopTimer()

	if slot0.resumeTimer_ then
		slot0.resumeTimer_:Stop()

		slot0.resumeTimer_ = nil
	end

	slot0:RemoveAllEventListener()
	slot0:UnBindRedPoints()
end

function slot0.UpdateRefreshCount(slot0)
	if slot0.curShopId_ == 7 or slot0.curShopId_ == 8 then
		SetActive(slot0.exchangeShopFresh_, slot0:GetRefreshCount() < ShopListCfg[slot0.curShopId_].refresh_num_limit)
		SetActive(slot0.exchangeShopNoFresh_, slot1 <= slot2)

		if slot2 < slot1 then
			slot0.exchangeShopFreshNum_.text = string.format("(%d/%d)", slot2, ShopListCfg[slot0.curShopId_].refresh_num_limit)
			slot0.exchangeShopFreshCost_.text = slot0:GetDiamondCount()
		end
	end
end

function slot0.StopTimer(slot0)
	if slot0.refreshTimer_ then
		slot0.refreshTimer_:Stop()

		slot0.refreshTimer_ = nil
	end
end

function slot0.SetTimer(slot0)
	slot0:StopTimer()

	slot1 = _G.gameTimer:GetNextDayFreshTime()

	if _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime() < 0 then
		slot2 = 0
	end

	slot0.exchangeShopTime_.text = string.format(GetTips("TIME_DISPLAY_8"), TimeMgr.GetInstance():DescCDTime(slot2))
	slot0.refreshTimer_ = Timer.New(function ()
		uv0:UpdateTimer()
	end, 1, slot2, 1)

	slot0.refreshTimer_:Start()
end

function slot0.UpdateTimer(slot0)
	slot1, slot2 = ShopTools.IsShopOpen(slot0.curShopId_)

	if slot2 == 0 then
		slot0.statusController_:SetSelectedState("endless")
	elseif slot2 == 1 then
		slot0.statusController_:SetSelectedState("counting")

		slot0.countdownLabel_.text = manager.time:GetLostTimeStr(ActivityData:GetActivityData(ShopListCfg[slot0.curShopId_].activity_id).stopTime)
	else
		slot0.statusController_:SetSelectedState("timeout")
	end

	if not slot0.waitingRefresh_ and (slot0.curShopId_ == 7 or slot0.curShopId_ == 8) then
		if _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime() <= 0 then
			slot0:Complete()
			slot0:StopTimer()

			slot0.exchangeShopTime_.text = string.format(GetTips("TIME_DISPLAY_8"), "00:00:00")

			return
		end

		slot0.exchangeShopTime_.text = string.format(GetTips("TIME_DISPLAY_8"), TimeMgr.GetInstance():DescCDTime(slot3))
	end

	for slot8, slot9 in ipairs(slot0:GetContentViewByShopId(slot0.curShopId_, true):GetItemList()) do
		if slot9.UpdateTimerView then
			slot9:UpdateTimerView()
		end
	end
end

function slot0.Complete(slot0)
	slot0.waitingRefresh_ = true

	ShopAction.RefreshAllShop()
end

function slot0.OnRefreshAllShop(slot0, slot1)
	if slot1.result == 0 then
		if slot0.resumeTimer_ == nil then
			slot0.resumeTimer_ = Timer.New(function ()
				uv0.waitingRefresh_ = false
				uv0.resumeTimer_ = nil

				uv0:SetTimer()
			end, 1, 1)
		end

		slot0.resumeTimer_:Start()
	else
		return
	end
end

function slot0.ResetFilter(slot0)
	slot0:GetContentViewByShopId(slot0.curShopId_):ResetFilter()
end

function slot0.GetRefreshCount(slot0)
	if ShopData.GetShop(slot0.curShopId_) then
		return ShopData.GetShop(slot1).refreshCount
	end

	return 0
end

function slot0.GetDiamondCount(slot0)
	slot3 = GameCurrencyBuySetting[#GameCurrencyBuySetting.all].shop_money_refresh

	if ShopData.GetShop(slot0.curShopId_).refreshCount < #GameCurrencyBuySetting.all then
		return GameCurrencyBuySetting[slot2.refreshCount + 1].shop_money_refresh
	else
		return slot3
	end
end

function slot0.OnMainHomeViewTop(slot0)
	slot0:ResetFilter()
	slot0:ResetPosition()
end

function slot0.ResetPosition(slot0)
	print("self.scrollPosition_ = " .. tostring(slot0.params_.scrollPosition))

	slot0.params_.scrollPosition = nil

	print("self.params_.shopId = " .. tostring(slot0.params_.shopId))

	slot0.params_.shopId = nil
	slot0.params_.tmpBack = nil
end

function slot0.Dispose(slot0)
	if slot0.tree_ then
		slot0.tree_:Dispose()

		slot0.tree_ = nil
	end

	slot0.mainShopTypeController_:RemoveAllListeners()
	slot0:RemoveAllListeners()

	if slot0.contentViewDic_ then
		for slot4, slot5 in pairs(slot0.contentViewDic_) do
			slot5:Dispose()
		end

		slot0.contentViewDic_ = nil
	end

	slot0.curShopId_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
