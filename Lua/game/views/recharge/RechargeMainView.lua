slot0 = class("RechargeMainView", ReduxView)
slot1 = 2
slot2 = 6

function slot0.UIName(slot0)
	return "UI/Recharge/RechargeSystemUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.curPageIndex_ = -1
	slot0.prefabList_ = {
		"UI/Recharge/pages/RechargeMonthCardPageUI",
		"UI/Recharge/pages/RechargeGiftPageUI",
		"UI/Recharge/pages/RechargeSkinPageUI",
		"UI/Recharge/pages/RechargeVoucherPageUI",
		"UI/Recharge/pages/RechargeRechargePageUI",
		"UI/Recharge/pages/RechargeFirstRechargePageUI",
		"UI/Activity/NewbieMonthlyCardUI_old",
		"UI/Activity/NewbieBpRechargeUI_old"
	}
	slot0.ClassList_ = {
		RechargeMonthCardPageView,
		RechargeGiftPageView,
		RechargeSkinPageView,
		RechargeVoucherPageView,
		RechargeRechargePageView,
		RechargeFirstRechargePageView,
		RechargeFirstMonthlyCardPageView,
		RechargeFirstBpPageView
	}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.pages_ = {}
	slot0.tree_ = LuaTree.New(slot0.treeGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cumulativeBtn_, nil, function ()
		JumpTools.OpenPageByJump("/rechargeTotalRecharge")
	end)
end

function slot0.OnItemSelect(slot0, slot1, slot2, slot3, slot4)
	slot0.currentItemIndex_ = slot1

	if slot0.currentGroupIndex_ == uv0 and slot0.pages_[uv0] then
		slot0.params_.childShopIndex = slot1

		slot0.pages_[uv0]:SwitchPage(tonumber(slot4))
	elseif slot0.currentGroupIndex_ == uv1 and slot0.pages_[uv1] then
		slot0.pages_[uv1]:SetData(slot1)
	end
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	slot0.currentGroupIndex_ = slot1
	slot0.params_.page = slot1

	if slot1 == 5 then
		RedPointAction.HandleRedPoint(RED_POINT_ID.RECHARGE)
		manager.redPoint:setTip(RED_POINT_ID.RECHARGE, 0)
	end

	slot0:SwitchPage(slot1)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function slot0.RefreshTree(slot0, slot1)
	if not slot1 then
		slot0:UnbindRedPoint()
	end

	slot0.tree_:SetSelectedHandler(nil, slot8)

	slot4 = UITreeData.New()

	for slot8 = 1, #{
		GetTips("MONTHLYCARD"),
		GetTips("GIFTBOX"),
		GetTips("SKIN"),
		GetTips("DRAW_CARD"),
		GetTips("RECHARG"),
		GetTips("ACTIVITY_FIRST_CHARGE"),
		GetTips("ACTIVITY_FIRST_MONTHLY_CARD"),
		GetTips("ACTIVITY_FIRST_CONTRACT")
	} do
		if not false then
			slot10 = UITreeGroupData.New()
			slot10.id = slot8
			slot10.text = slot2[slot8]

			if slot8 == 2 then
				slot11 = nil
				slot12 = true

				if slot0:HaveNewbieGift() and slot12 then
					slot11 = UITreeItemData.New()
					slot11.id = 1
					slot11.text = GetTips("NEWBIE_GIFTBOX")
					slot11.extraData = "22"

					slot10.itemDatas:Add(slot11)
				end

				if slot0:HaveActivityGift() and slot12 then
					slot11 = UITreeItemData.New()
					slot11.id = 3
					slot11.text = GetTips("LIMIT_TIME_GIFTBOX")
					slot11.extraData = "15"

					slot10.itemDatas:Add(slot11)
				end

				if slot12 then
					slot11 = UITreeItemData.New()
					slot11.id = 4
					slot11.text = GetTips("NORMAL_GIFTBOX")
					slot11.extraData = "23"

					slot10.itemDatas:Add(slot11)
				end
			elseif slot8 == 6 then
				for slot14 = 1, 2 do
					UITreeItemData.New().id = slot14

					if slot14 == 1 then
						slot15.text = string.format(GetTips("ACTIVITY_FIRST_PRICE"), GameSetting.newbie_first_charge_reward_6.value[1])
					else
						slot15.text = string.format(GetTips("ACTIVITY_FIRST_PRICE"), GameSetting.newbie_first_charge_reward_18.value[1])
					end

					slot10.itemDatas:Add(slot15)
				end
			end

			slot4.groupDatas:Add(slot10)
		end
	end

	slot3:SetData(slot4)
	slot3:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect), handler(slot0, slot0.OnItemSelect))

	slot0.treeData_ = slot4

	if not slot1 then
		slot3:SelectItem(slot0.currentGroupIndex_, slot0.currentItemIndex_)
	end

	slot0:BindRedPoint()
end

function slot0.SwitchPage(slot0, slot1)
	if slot0.pages_[slot0.curPageIndex_] then
		slot2:Hide()
	end

	slot3 = slot0.curPageIndex_
	slot0.curPageIndex_ = slot1
	slot0.params_.page = slot1

	if not slot0.pages_[slot1] then
		if slot0.prefabList_[slot1] and slot0.ClassList_[slot1] then
			slot0.pages_[slot1] = slot0.ClassList_[slot1].New(Object.Instantiate(Asset.Load(slot0.prefabList_[slot1]), slot0.container_))

			slot0:CheckPageEnter(slot1)

			if slot1 == 2 then
				slot0.pages_[slot1]:SetTreeRefreshHandler(handler(slot0, slot0.RefreshTree))
			end
		end
	else
		slot0.pages_[slot0.curPageIndex_]:Show()
	end
end

function slot0.SwitchPageByParams(slot0)
	slot0.currentGroupIndex_, slot0.currentItemIndex_ = slot0:GetGroupItemIndexByParams()

	slot0.tree_:SelectItem(slot0.currentGroupIndex_, slot0.currentItemIndex_)

	if slot0.currentGroupIndex_ == uv0 and slot0.currentItemIndex_ == 2 and slot0.pages_[uv0] then
		slot0.pages_[uv0]:SwitchPage(tonumber(slot0.treeData_.groupDatas[slot0.currentGroupIndex_ - 1].itemDatas[slot0.currentItemIndex_ - 1].extraData))
	end
end

function slot0.GetGroupItemIndexByParams(slot0)
	slot1 = 1
	slot2 = 1

	if slot0.params_.page then
		if slot0.params_.page == 2 then
			if slot0.params_.shopId then
				for slot7 = 0, slot0.treeData_.groupDatas[slot1 - 1].itemDatas.Count - 1 do
					if tonumber(slot3.itemDatas[slot7].extraData) == slot0.params_.shopId then
						slot0.params_.childShopIndex = slot7 + 1

						break
					end
				end
			else
				slot2 = slot0.params_.childShopIndex
			end
		elseif slot1 == 6 then
			slot2 = slot0.currentItemIndex_
		end
	end

	return slot1, slot2
end

function slot0.CheckPageEnter(slot0, slot1)
	if not slot0.enteredPage_[slot1] then
		slot0.pages_[slot1]:OnEnter()

		slot0.enteredPage_[slot1] = true
	end
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()

	slot1, slot2 = slot0:GetGroupItemIndexByParams()

	if slot1 ~= slot0.currentGroupIndex_ or slot2 ~= slot0.currentItemIndex_ then
		slot0.tree_:SelectItem(slot1, slot2)
	end

	if slot0.pages_[slot0.curPageIndex_].OnTop then
		slot0.pages_[slot0.curPageIndex_]:OnTop()
	end
end

function slot0.OnEnter(slot0)
	slot0.enteredPage_ = {}

	for slot4, slot5 in pairs(slot0.pages_) do
		slot0:CheckPageEnter(slot4)
	end

	slot0:RefreshTree(true)
	slot0:SwitchPageByParams()
	slot0:RegistEventListener(SHOP_LIST_UPDATE, function (slot0)
		if uv0.pages_[uv1] then
			uv0.pages_[uv1]:RefreshList()
		end
	end)
	slot0:RegistEventListener(RECHARGE_SUCCESS, function (slot0)
		uv0:CheckNewbieTree()
	end)
	slot0:RefreshFirstRechargeGroup()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	for slot4, slot5 in pairs(slot0.pages_) do
		if slot5 ~= nil then
			slot5:OnExit()
		end
	end

	slot0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.totalRechargeNoticeContainer_, RedPointConst.TOTAL_CHARGE_BONUS, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(1), RedPointConst.NOOB_MONTHLY_RECHARGE_SIGN, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(2), RedPointConst.RECHARGE_BONUS, {
		x = 0,
		y = 0
	})

	if slot0:HaveNewbieGift() then
		slot0.haveNewbieGiftRedPoint_ = true

		manager.redPoint:bindUIandKey(slot0.tree_:GetItemRedPointContainerById(2, 1), RedPointConst.NEWBIE_BONUS, {
			x = 0,
			y = 0
		})
	else
		slot0.haveNewbieGiftRedPoint_ = false
	end

	if slot0:HaveActivityGift() then
		slot0.haveActivityGiftRedPoint_ = true

		manager.redPoint:bindUIandKey(slot0.tree_:GetItemRedPointContainerById(2, 3), RedPointConst.ACTIVITY_BONUS, {
			x = 0,
			y = 0
		})
	else
		slot0.haveActivityGiftRedPoint_ = false
	end

	manager.redPoint:bindUIandKey(slot0.tree_:GetItemRedPointContainerById(2, 4), RedPointConst.NORMAL_BONUS, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(5), RED_POINT_ID.RECHARGE, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(6), RedPointConst.NOOB_FIRST_RECHARGE, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.tree_:GetItemRedPointContainerById(6, 1), RedPointConst.NOOB_FIRST_RECHARGE_1, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.tree_:GetItemRedPointContainerById(6, 2), RedPointConst.NOOB_FIRST_RECHARGE_2, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(7), RedPointConst.NOOB_MONTHLY_RECHARGE, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(8), RedPointConst.NOOB_BP_RECHARGE, {
		x = 0,
		y = 0
	})
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.totalRechargeNoticeContainer_, RedPointConst.TOTAL_CHARGE_BONUS)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(1), RedPointConst.NOOB_MONTHLY_RECHARGE_SIGN, {
		x = 0,
		y = 0
	})
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(2), RedPointConst.RECHARGE_BONUS)

	if slot0.tree_:GetItemRedPointContainerById(2, 1) ~= nil then
		manager.redPoint:unbindUIandKey(slot0.tree_:GetItemRedPointContainerById(2, 1), RedPointConst.NEWBIE_BONUS)
	end

	if slot0.tree_:GetItemRedPointContainerById(2, 3) ~= nil then
		manager.redPoint:unbindUIandKey(slot0.tree_:GetItemRedPointContainerById(2, 3), RedPointConst.ACTIVITY_BONUS)
	end

	if slot0.tree_:GetItemRedPointContainerById(2, 4) ~= nil then
		manager.redPoint:unbindUIandKey(slot0.tree_:GetItemRedPointContainerById(2, 4), RedPointConst.NORMAL_BONUS)
	end

	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(5), RED_POINT_ID.RECHARGE, {
		x = 0,
		y = 0
	})
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(6), RedPointConst.NOOB_FIRST_RECHARGE, {
		x = 0,
		y = 0
	})
	manager.redPoint:unbindUIandKey(slot0.tree_:GetItemRedPointContainerById(6, 1), RedPointConst.NOOB_FIRST_RECHARGE_1, {
		x = 0,
		y = 0
	})
	manager.redPoint:unbindUIandKey(slot0.tree_:GetItemRedPointContainerById(6, 2), RedPointConst.NOOB_FIRST_RECHARGE_2, {
		x = 0,
		y = 0
	})
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(7), RedPointConst.NOOB_MONTHLY_RECHARGE, {
		x = 0,
		y = 0
	})
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(8), RedPointConst.NOOB_BP_RECHARGE, {
		x = 0,
		y = 0
	})
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot0.pages_[uv0] then
		slot0.pages_[uv0]:OnShopBuyResult(slot1, slot2, slot3, slot4)
	end

	slot0:CheckNewbieTree()
end

function slot0.CheckNewbieTree(slot0)
	if not slot0:HaveNewbieGift() and slot0.tree_:GetItemRedPointContainerById(2, 1) ~= nil then
		slot0:RefreshTree(false)
	end
end

function slot0.OnTryToUseItem(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		slot4 = ItemCfg[slot2.use_item_list[1].item_id].param[1]

		getReward({
			{
				slot4,
				1
			}
		}, {
			ItemConst.ITEM_TYPE.HERO_SKIN
		})
		MaterialAction.MaterialModify(slot2.use_item_list[1].item_id, -1, slot2.use_item_list[1].time_valid)
		HeroAction.UpdateSkinCouponRedPoint(SkinCfg[slot4].hero)
		HeroAction.SkinAdd(slot4)
	else
		ShowTips(slot1.result)
	end
end

function slot0.HaveActivityGift(slot0)
	for slot5, slot6 in ipairs(ShopCfg.get_id_list_by_shop_id[15]) do
		if not ShopData.IsGoodOutOfDate(slot6) then
			return true
		end
	end

	return false
end

function slot0.HaveNewbieGift(slot0)
	slot3 = true

	for slot7, slot8 in pairs(ShopData.GetShop(22).shopItemIDs) do
		slot9 = slot2[slot8]

		if ShopTools.IsGoodCanDisplay(slot1, slot8) and not ShopData.IsSoldout(slot1, slot8) then
			slot3 = false

			break
		end
	end

	if slot3 then
		return false
	end

	return true
end

function slot0.OnMainHomeViewTop(slot0)
	slot0.params_.childShopIndex = 1
	slot0.params_.page = 1
end

function slot0.Dispose(slot0)
	slot0.firstRechargeGroupGoList_ = nil

	if slot0.tree_ then
		slot0.tree_:Dispose()

		slot0.tree_ = nil
	end

	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:Dispose()
		end

		slot0.pages_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.RefreshFirstRechargeGroup(slot0)
	slot0.firstRechargeGroupGoList_ = {
		slot0.tree_:GetGroupGameObjectById(6),
		slot0.tree_:GetGroupGameObjectById(7)
	}
	slot2 = slot0.tree_
	slot4 = slot2
	slot5 = 8
	slot0.firstRechargeGroupGoList_[3] = slot2.GetGroupGameObjectById(slot4, slot5)

	for slot4, slot5 in ipairs(slot0.firstRechargeGroupGoList_) do
		SetActive(slot5, ActivityNewbieTools.GetRechargeIsOpen(slot4))
	end

	if ActivityNewbieTools.GetFirstRechargeStatus() and slot1.firstGearStatus == 2 then
		slot0.tree_:GetData().groupDatas[5].defaultIndex = 1
	end
end

return slot0
