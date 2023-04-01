slot0 = class("PassportMainView", ReduxView)

function slot0.UIName(slot0)
	return PassportData:GetUIRoot() .. "Passport/PassportMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.curPageIndex_ = -1
	slot0.prefabList_ = {
		PassportData:GetUIRoot() .. "Passport/PassportRewardPageUI"
	}
	slot0.ClassList_ = {
		PassportRewardPageView
	}
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.pages_ = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.buyLevelBtn_, nil, function ()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_bp_level = PassportData:GetLevel()
		})
		JumpTools.OpenPageByJump("passportBuyLevel", nil, ViewConst.SYSTEM_ID.PASSPORT_BUY_LEVEL)
	end)
	slot0:AddBtnListener(slot0.taskBtn_, nil, function ()
		JumpTools.OpenPageByJump("/passportTask")
	end)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		JumpTools.GoToSystem("/shop", {
			shopId = 34
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
end

function slot0.SwitchPage(slot0, slot1)
	if slot0.curPageIndex_ == slot1 then
		return
	end

	if slot0.pages_[slot0.curPageIndex_] then
		slot2:Hide()
	end

	slot0.curPageIndex_ = slot1
	slot0.params_.page = slot1

	if not slot0.pages_[slot1] then
		if slot0.prefabList_[slot1] and slot0.ClassList_[slot1] then
			slot0.pages_[slot1] = slot0.ClassList_[slot1].New(Object.Instantiate(Asset.Load(slot0.prefabList_[slot1]), slot0.container_))

			slot0:CheckPageEnter(slot1)
		end
	else
		slot0.pages_[slot0.curPageIndex_]:Show()
	end
end

function slot0.CheckPageEnter(slot0, slot1)
	slot2 = manager.time:GetServerTime()

	if not PassportData:IsOpen() or PassportData:GetEndTimestamp() <= slot2 then
		return
	end

	if not slot0.enteredPage_[slot1] then
		slot0.pages_[slot1]:OnEnter()

		slot0.enteredPage_[slot1] = true
	end
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "passportNote",
		type = "jump",
		params = {}
	})
end

function slot0.UpdateView(slot0)
	slot0.levelLabel_.text = PassportData:GetLevel()
	slot1 = PassportData:GetCurrentExp()
	slot2 = PassportData:GetUpgradeNeedExp()

	if PassportData:GetMaxLevel() <= PassportData:GetLevel() then
		slot1 = slot2
	end

	if slot2 < slot1 then
		slot1 = slot2
	end

	slot0.expProgress_.value = slot1 / slot2
	slot0.expLabel_.text = string.format("%d/%d", slot1, slot2)
	slot0.expLimitLabel_.text = string.format("%d/%d", PassportData:GetExpWeekly(), GameSetting.battlepass_exp_limit_weekly.value[1])

	if PassportData:GetMaxLevel() <= PassportData:GetLevel() then
		SetActive(slot0.buyLevelBtn_.gameObject, false)
	else
		SetActive(slot0.buyLevelBtn_.gameObject, true)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.bglvTransform_)
end

function slot0.OnEnter(slot0)
	slot0.enteredPage_ = {}

	if slot0:CheckOutofDate() then
		return
	end

	for slot4, slot5 in pairs(slot0.pages_) do
		slot0:CheckPageEnter(slot4)
	end

	slot0:SwitchPage(1)
	slot0:UpdateView()

	if not slot0.timer_ then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
	slot0:UpdateTimer()
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		if slot0 == CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP then
			uv0:UpdateView()
		end
	end)

	if getData("passport", "poster_" .. PassportData:GetId()) ~= "1" then
		slot6 = PassportData

		saveData("passport", "poster_" .. slot6:GetId(), "1")
		TimeTools.StartAfterSeconds(0.1, function ()
			JumpTools.OpenPageByJump("passportPoster")
		end, {})
	end

	slot0:RegisterRedPoint()
end

function slot0.UpdateTimer(slot0)
	slot0.lastDayLabel_.text = string.format(GetTips("TIME_DISPLAY_6"), manager.time:GetLostTimeStr(PassportData:GetEndTimestamp()))
	slot0.duringLabel1_.text = string.format("%s-%s", manager.time:STimeDescS(PassportData:GetStartTimestamp(), "!%Y/%m/%d %H:%M:%S"), manager.time:STimeDescS(PassportData:GetEndTimestamp(), "!%Y/%m/%d %H:%M:%S"))

	slot0:CheckOutofDate()
end

function slot0.CheckOutofDate(slot0)
	slot1 = manager.time:GetServerTime()

	if not PassportData:IsOpen() or PassportData:GetEndTimestamp() <= slot1 then
		TimeTools.StartAfterSeconds(0.1, function ()
			uv0:Go("/home")
			ShowTips("BATTLEPASS_EXPIRED")
		end, {})

		return true
	end

	return false
end

function slot0.OnBuyPassportLevel(slot0)
	for slot4, slot5 in pairs(slot0.pages_) do
		if slot5.OnBuyPassportLevel then
			slot5:OnBuyPassportLevel()
		end
	end
end

function slot0.OnExit(slot0)
	slot0:UnRegisterRedPoint()
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.pages_) do
		if slot5 ~= nil then
			slot5:OnExit()
		end
	end

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RegisterRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.taskBtn_.transform, RedPointConst.PASSPORT_TASKS)
end

function slot0.UnRegisterRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.taskBtn_.transform, RedPointConst.PASSPORT_TASKS)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnMainHomeViewTop(slot0)
	slot0.params_.page = 1

	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:OnMainHomeViewTop()
		end
	end
end

function slot0.Dispose(slot0)
	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:Dispose()
		end

		slot0.pages_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
