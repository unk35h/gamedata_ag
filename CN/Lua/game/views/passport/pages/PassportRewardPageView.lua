slot0 = class("PassportRewardPageView", ReduxView)

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

	slot0.isFreeController_ = ControllerUtil.GetController(slot0.nextBonusTransform_, "isFree")
	slot0.statusController_ = ControllerUtil.GetController(slot0.nextBonusTransform_, "status")
	slot0.haveBonusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "haveBonus")
	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, PassportRewardItemView)
	slot0.nextCommonItem1_ = CommonItem.New(slot0.rightCommonItem1_)
	slot0.nextCommonItem2_ = CommonItem.New(slot0.rightCommonItem2_)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.rewardIdList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.list_

	slot1:SetHeadTailChangeHandler(handler(slot0, slot0.HeadTailChangeHandler))

	slot1 = slot0.nextCommonItem1_

	slot1:RegistCallBack(function (slot0)
		if PassportData:GetRewardStatus(uv0.nearestBonusIndex_, BattlePassCfg[uv0.rewardIdList_[uv0.nearestBonusIndex_]].id) ~= "freeCanGet" and slot2 ~= "payCanGet" then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot0.id,
				slot0.number
			})

			return
		end

		PassportAction.RequestGetBonus(slot1.id, PassportData:GetPayLevel() > 0 and 1 or 0)
	end)

	slot1 = slot0.nextCommonItem2_

	slot1:RegistCallBack(function (slot0)
		if PassportData:GetRewardStatus(uv0.nearestBonusIndex_, BattlePassCfg[uv0.rewardIdList_[uv0.nearestBonusIndex_]].id) ~= "payCanGet" and slot2 ~= "payHalfCanGet" then
			ShowPopItem(POP_SOURCE_ITEM, {
				slot0.id,
				slot0.number
			})

			return
		end

		PassportAction.RequestGetBonus(slot1.id, PassportData:GetPayLevel() > 0 and 1 or 0)
	end)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		JumpTools.OpenPageByJump("passportBuy")
	end)
	slot0:AddBtnListener(slot0.oneKeyGetBtn_, nil, function ()
		if #PassportData:GetCanGetBonusList() > 0 then
			PassportAction.OneKeyGet(slot0)
		end
	end)
	slot0:AddBtnListener(slot0.commonItem2_, nil, function ()
		JumpTools.OpenPageByJump("passportBuy")
	end)
end

function slot0.HeadTailChangeHandler(slot0, slot1, slot2)
	slot2 = math.max(1, slot2 + 1)

	if not slot0.minEndIndex_ then
		slot0.minEndIndex_ = slot2
	end

	slot0.nearestBonusIndex_ = slot0:GetNextBonusIndex(slot2)

	slot0:UpdateNextBonus()
end

function slot0.UpdateNextBonus(slot0)
	slot1 = BattlePassCfg[slot0.rewardIdList_[slot0.nearestBonusIndex_]]
	slot2 = GameLevelSetting[slot0.nearestBonusIndex_]
	slot0.nextBonusLevelLabel_.text = string.format("%d", slot0.nearestBonusIndex_)
	slot0.nextBonusBottomLabel_.text = string.format("%d", slot0.nearestBonusIndex_)

	slot0.nextCommonItem1_:RefreshData({
		id = slot1.reward_free[1][1],
		number = slot1.reward_free[1][2]
	})
	slot0.nextCommonItem2_:RefreshData({
		id = slot1.reward_pay[1][1],
		number = slot1.reward_pay[1][2]
	})

	slot3 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP)
	slot6 = PassportData:GetPayLevel() > 0 and "pay" or "free"

	if PassportData:HaveGetBonus(slot1.id) then
		slot0.statusController_:SetSelectedState(slot6 .. "HaveGet")
	elseif slot2.battlepass_lv_exp_sum <= slot3 then
		if slot6 == "free" then
			slot0.statusController_:SetSelectedState(slot6 .. "CanGet")
		elseif PassportData:HaveReceiveInfo(slot1.id) then
			slot0.statusController_:SetSelectedState(slot6 .. "HalfCanGet")
		else
			slot0.statusController_:SetSelectedState(slot6 .. "CanGet")
		end
	else
		slot0.statusController_:SetSelectedState(slot6 .. "CannotGet")
	end
end

function slot0.GetNextBonusIndex(slot0, slot1)
	for slot5 = slot1, #slot0.rewardIdList_ do
		if not BattlePassCfg[slot0.rewardIdList_[slot5]] then
			print("rewardData is null")
		end

		if slot6.display == 1 then
			return slot5
		end
	end

	return slot0.nearestBonusIndex_
end

function slot0.InitData(slot0)
	slot0.rewardIdList_ = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type]
	slot0.nearestBonusIndex_ = slot0:GetNextBonusIndex(slot0.minEndIndex_ or 1)
end

function slot0.UpdateView(slot0)
	if PassportData:GetPayLevel() == 202 then
		SetActive(slot0.unlockBtn_.gameObject, false)
	else
		SetActive(slot0.unlockBtn_.gameObject, true)
	end

	if PassportData:GetPayLevel() > 0 then
		SetActive(slot0.leftLockIconGo_, false)
	else
		SetActive(slot0.leftLockIconGo_, true)
	end

	if #PassportData:GetCanGetBonusList() > 0 then
		slot0.haveBonusController_:SetSelectedState("true")
	else
		slot0.haveBonusController_:SetSelectedState("false")
	end
end

function slot0.GetFirstIndex(slot0)
	slot1, slot2 = PassportData:GetCurrentStatus()

	if slot1 > 0 then
		return slot1
	end

	if slot2 > 0 then
		return slot2
	end

	return 1
end

function slot0.OnEnter(slot0)
	slot0:AdaptScreen()
	slot0:InitData()
	slot0.list_:StartScroll(#slot0.rewardIdList_, slot0:GetFirstIndex())
	slot0:UpdateView()
	slot0:AddEventListeners()
	manager.redPoint:bindUIandKey(slot0.oneKeyGetBtn_.transform, RedPointConst.PASSPORT_BONUS)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(GET_BONUS_SUCCESS, handler(slot0, slot0.OnGetBonus))
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		if slot0 == CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP then
			uv0.list_:Refresh()
			uv0:UpdateView()
			uv0:UpdateNextBonus()
		end
	end)
	slot0:RegistEventListener(PASSPORT_BUYED, handler(slot0, slot0.OnPassportBuyed))
end

function slot0.OnPassportBuyed(slot0)
	slot0.list_:Refresh()
	slot0:UpdateView()
	slot0:UpdateNextBonus()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.oneKeyGetBtn_.transform, RedPointConst.PASSPORT_BONUS)
	slot0:RemoveAllEventListener()
end

function slot0.OnGetBonus(slot0, slot1)
	slot0:UpdateView()

	if slot1 == BattlePassCfg[slot0.rewardIdList_[slot0.nearestBonusIndex_]].id or slot1 == 0 then
		slot0:UpdateNextBonus()
	end
end

function slot0.Show(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.OnBuyPassportLevel(slot0)
	slot0.list_:Refresh()
	slot0:UpdateView()
	slot0:UpdateNextBonus()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	if slot0.nextCommonItem1_ then
		slot0.nextCommonItem1_:Dispose()

		slot0.nextCommonItem1_ = nil
	end

	if slot0.nextCommonItem2_ then
		slot0.nextCommonItem2_:Dispose()

		slot0.nextCommonItem2_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
