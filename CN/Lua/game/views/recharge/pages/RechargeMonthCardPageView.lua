slot1 = class("RechargeMonthCardPageView", import("game.views.recharge.pages.RechargePageBase"))

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.firstRewardController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "firstRecharge")

	if SDKTools.GetIsOverSea() then
		SetActive(slot0.rewardContainer_.gameObject, true)

		slot0.priceText_.text = GetTips("MONTHLY_CARD_PRICE")
		slot0.immeLabelText_.text = GetTips("MONTHLY_CARD_ONCE_GET_1")
		slot0.immeNumText_.text = GetTips("MONTHLY_CARD_ONCE_GET_2")
		slot0.dailyLabelText_.text = GetTips("MONTHLY_CARD_DAILY_GET_1")
		slot0.dailyNumText_.text = GetTips("MONTHLY_CARD_DAILY_GET_2")
		slot0.buyText_.text = string.gsub(GetTips("MONTHLY_CARD_PRICE"), "<.->", "")
	end

	slot0.rechargeUpdateHandler_ = handler(slot0, slot0.OnRechargeUpdate)
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.helpBtn_, nil, function ()
		JumpTools.OpenPageByJump("rechargeMonthCardDesc")
	end)
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		uv0:BuyMonthCard()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_monthcard = 0
		})
	end)
	slot0:AddBtnListener(slot0.rebuyBtn_, nil, function ()
		uv0:BuyMonthCard()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_monthcard = 1
		})
	end)

	if SDKTools.GetIsInputServer("kr") then
		slot0:AddBtnListener(slot0.refundbtn_, nil, function ()
			JumpTools.OpenPageByJump("gameHelpPro", {
				pages = {
					"Textures/RechargeUI/Refund Policy@kr"
				}
			})
		end)
	end

	if slot0.newbieBtn_ then
		slot0:AddBtnListener(slot0.newbieBtn_, nil, function ()
			ActivityNewbieTools.ReceiveRechargeReward(2, 1, function ()
				uv0:RefreshNewbie(false)
			end)
		end)
	end

	if slot0.newbieRewardBtn_ then
		slot0:AddBtnListener(slot0.newbieRewardBtn_, nil, function ()
			ShowPopItem(POP_ITEM, GameSetting.newbie_first_monthly_card_cumulative.value[2])
		end)
	end
end

function slot1.BuyMonthCard(slot0)
	SendMessageManagerToSDK("purchase_click_montlycard")

	if not RechargeData:HaveMonthCard() then
		RechargeData:ResetSign()
	end

	PayAction.RequestGSPay(101, 1)
end

function slot1.OnTop(slot0)
end

function slot1.UpdateView(slot0)
	slot1 = GameSetting.monthly_card_num_max.value[1]

	if RechargeData:HaveMonthCard() then
		slot2 = RechargeData:GetCardNum()
		slot0.accumulationLabel_.text = string.format("%s/%s", tostring(slot2), tostring(slot1))

		SetActive(slot0.lastDayGo_, true)

		slot0.lastDayLabel_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStr(RechargeData:GetMonthCardDeadTime(), true))

		if slot1 <= slot2 then
			slot0.statusController_:SetSelectedState("limit")
		else
			slot0.statusController_:SetSelectedState("notFirst")
		end
	else
		slot0.accumulationLabel_.text = string.format("%s/%s", tostring(0), tostring(slot1))

		SetActive(slot0.lastDayGo_, false)
		slot0.statusController_:SetSelectedState("first")
	end

	SetActive(slot0.refundGo_, not SDKTools.GetIsInputServer("kr"))
end

function slot1.RefreshNewbie(slot0, slot1)
	if ActivityNewbieTools.GetFirstMonthlyCardStatus() then
		slot3 = slot2.isRecharged
		slot4 = slot2.signTimes
		slot0.progreeeText_.text = string.format("<color=#FA962E>%d</color>/%d", slot4, GameSetting.newbie_first_monthly_card_cumulative.value[1])
		slot0.status_ = 0

		if slot4 == 0 and not slot3 then
			slot0.status_ = 1
		elseif slot4 < slot6 then
			slot0.status_ = 2
		elseif slot2.signRewardFlag == false then
			slot0.status_ = 3
		elseif not slot1 then
			slot0.status_ = 4
		else
			slot0.status_ = 0
		end

		slot0.firstRewardController_:SetSelectedIndex(slot0.status_)
	else
		slot0.firstRewardController_:SetSelectedIndex(0)
	end
end

function slot1.OnEnter(slot0)
	slot0:UpdateView()

	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateView()
		end, 1, -1)
	end

	slot0:RefreshNewbie(true)
	slot0.timer_:Start()
	SetActive(slot0.refundGo_, not SDKTools.GetIsKorea())
	SetActive(slot0.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(slot0.refundbtn_.gameObject, slot0.curPageIndex_ ~= 4 and slot0.curPageIndex_ ~= 6)
	end

	manager.notify:RegistListener(NEWBIE_RECHARGE_UPDATE, slot0.rechargeUpdateHandler_)
end

function slot1.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	manager.notify:RemoveListener(NEWBIE_RECHARGE_UPDATE, slot0.rechargeUpdateHandler_)
end

function slot1.Hide(slot0)
	uv0.super.Hide(slot0)
end

function slot1.Dispose(slot0)
	slot0.rechargeUpdateHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot1.OnRechargeUpdate(slot0, slot1)
	slot0:RefreshNewbie(true)
end

return slot1
