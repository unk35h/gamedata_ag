slot0 = class("PassportBuyView", ReduxView)

function slot0.UIName(slot0)
	return PassportData:GetUIRoot() .. "Passport/PassportBuyUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list1_ = LuaList.New(handler(slot0, slot0.indexItem1), slot0.listGo1_, CommonItem)
	slot0.list2_ = LuaList.New(handler(slot0, slot0.indexItem2), slot0.listGo2_, CommonItem)
	slot4 = "buyedLevel"
	slot0.buyedLevelController_ = ControllerUtil.GetController(slot0.gameObject_.transform, slot4)
	slot0.item68_ = {}

	for slot4 = 1, 10 do
		if slot0["item68_" .. slot4] then
			slot5 = CommonItem.New(slot0["item68_" .. slot4])

			slot5:RegistCallBack(function (slot0)
				ShowPopItem(POP_SOURCE_ITEM, {
					slot0.id,
					slot0.number
				})
			end)
			table.insert(slot0.item68_, slot5)
		end
	end

	slot0.item128_ = {}

	for slot4 = 1, 10 do
		if slot0["item128_" .. slot4] then
			slot5 = CommonItem.New(slot0["item128_" .. slot4])

			slot5:RegistCallBack(function (slot0)
				ShowPopItem(POP_SOURCE_ITEM, {
					slot0.id,
					slot0.number
				})
			end)
			table.insert(slot0.item128_, slot5)
		end
	end
end

function slot0.indexItem1(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.dataList1_[slot1][1],
		number = slot0.dataList1_[slot1][2]
	})
end

function slot0.indexItem2(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.dataList2_[slot1][1],
		number = slot0.dataList2_[slot1][2]
	})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cheepBtn_, nil, function ()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_bp_buy = 68
		})

		if PassportData:GetEndTimestamp() - TimeMgr.GetInstance():GetServerTime() < 1200 then
			ShowTips("NOT_ENOUGH_TIME_TO_BUY")

			return
		end

		if PassportData:GetPayLevel() == 201 then
			ShowTips("ERROR_BATTLEPASS_HAS_BUY")

			return
		end

		PayAction.RequestGSPay(201, 1)
	end)
	slot0:AddBtnListener(slot0.expensiveBtn_, nil, function ()
		if PassportData:GetEndTimestamp() - TimeMgr.GetInstance():GetServerTime() < 1200 then
			ShowTips("NOT_ENOUGH_TIME_TO_BUY")

			return
		end

		if PassportData:GetPayLevel() == 202 then
			ShowTips("ERROR_BATTLEPASS_HAS_BUY")

			return
		end

		if PassportData:GetPayLevel() == 201 then
			PayAction.RequestGSPay(203, 1)
		else
			PayAction.RequestGSPay(202, 1)
		end
	end)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	if not slot0.timer_ then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()

	slot0.dataList1_ = BattlePassListCfg[PassportData:GetId()].display_reward_01
	slot0.dataList2_ = BattlePassListCfg[PassportData:GetId()].display_reward_02

	slot0:UpdateView()
	slot0:UpdateTimer()
	slot0:RegisterEventListeners()
end

function slot0.RegisterEventListeners(slot0)
	slot0:RegistEventListener(RECHARGE_SUCCESS, function (slot0)
		uv0:UpdateView()
	end)
end

function slot0.UpdateView(slot0)
	if PassportData:GetPayLevel() >= 202 then
		slot0.buyedLevelController_:SetSelectedState("202")
	elseif PassportData:GetPayLevel() >= 201 then
		slot0.buyedLevelController_:SetSelectedState("201")
	else
		slot0.buyedLevelController_:SetSelectedState("0")
	end

	for slot4, slot5 in ipairs(slot0.item68_) do
		slot5:RefreshData({
			number = "",
			id = slot0.dataList1_[slot4][1]
		})

		slot5.customNameText_.text = ItemCfg[slot0.dataList1_[slot4][1]].name
	end

	for slot4, slot5 in ipairs(slot0.item128_) do
		slot5:RefreshData({
			number = "",
			id = slot0.dataList2_[slot4][1]
		})

		slot5.customNameText_.text = ItemCfg[slot0.dataList2_[slot4][1]].name
	end
end

function slot0.UpdateTimer(slot0)
	slot0.timeLabel_.text = manager.time:STimeDescS(PassportData:GetEndTimestamp() - 1200, "!%Y-%m-%d %H:%M:%S")
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.Dispose(slot0)
	if slot0.list1_ then
		slot0.list1_:Dispose()

		slot0.list1_ = nil
	end

	if slot0.list2_ then
		slot0.list2_:Dispose()

		slot0.list2_ = nil
	end

	if slot0.item68_ then
		for slot4, slot5 in pairs(slot0.item68_) do
			slot5:Dispose()
		end

		slot0.item68_ = nil
	end

	if slot0.item128_ then
		for slot4, slot5 in pairs(slot0.item128_) do
			slot5:Dispose()
		end

		slot0.item128_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
