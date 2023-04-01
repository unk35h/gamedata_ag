slot0 = class("RegressionCapsuleToysPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot3 = Object.Instantiate(Asset.Load("UI/ReturnTwoUI/RT2stTwistedEggUI"), slot1)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.rewardItemList_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.descText_.text = GetTips("REGRESSION_GASHAPON_DESCRIPE")
	slot1 = GameSetting.regression_gashapon_cost
	slot0.drawOnceIcon_.sprite = ItemTools.getItemSprite(slot1.value[1])
	slot0.drawOnceCostText_.text = "x" .. slot1.value[2]
	slot0.drawMultiIcon_.sprite = ItemTools.getItemSprite(slot1.value[1])
	slot0.drawMultiCostText_.text = "x" .. tostring(slot1.value[2] * 10)
	slot0.drawController_ = ControllerUtil.GetController(slot0.transform_, "draw")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.drawOnceBtn_, nil, function ()
		if not RegressionData:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			return
		end

		uv0.drawController_:SetSelectedState("true")

		slot0 = GameSetting.regression_gashapon_cost

		if slot0.value[2] <= CurrencyData:GetCurrencyNum(slot0.value[1]) then
			RegressionAction.RegressionCapsuleToysDraw(1, handler(uv0, uv0.OnCapsuleToysDraw))
		else
			ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
		end
	end)
	slot0:AddBtnListener(slot0.drawMultipleBtn_, nil, function ()
		if not RegressionData:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			return
		end

		uv0.drawController_:SetSelectedState("true")

		slot0 = GameSetting.regression_gashapon_cost

		if CurrencyData:GetCurrencyNum(slot0.value[1]) >= slot0.value[2] * 2 then
			RegressionAction.RegressionCapsuleToysDraw(math.floor(slot1 / slot2) <= 10 and slot3 or 10, handler(uv0, uv0.OnCapsuleToysDraw))
		else
			ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
		end
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("capsuleToysReward")
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.rewardItemList_ then
		for slot4, slot5 in ipairs(slot0.rewardItemList_) do
			slot5:Dispose()
		end

		slot0.rewardItemList_ = nil
	end

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 == false and slot0.timer_ ~= nil then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.drawController_:SetSelectedState("false")
end

function slot0.SetData(slot0)
	slot0.version_ = RegressionData:GetRegressionVersion()
	slot0.rewardCfgList_ = {}

	for slot5, slot6 in ipairs(RegressionCfg[slot0.version_].gashapon) do
		if RegressionCapsuleToysCfg[slot6].reward_type == 1 then
			slot0.rewardCfgList_[#slot0.rewardCfgList_ + 1] = slot6
		end
	end

	for slot5, slot6 in ipairs(slot0.rewardCfgList_) do
		if not slot0.rewardItemList_[slot5] then
			slot0.rewardItemList_[slot5] = CapsuleToysRewardItem.New(slot0.goRewardPanel_, slot0.rewardGo_, false)
		end

		slot0.rewardItemList_[slot5]:SetData(slot6)
	end

	for slot5 = #slot0.rewardCfgList_ + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot5]:Show(false)
	end

	slot0:RefreshMultiDrawBtn()
end

function slot0.OnCapsuleToysDraw(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		slot3 = {}

		for slot7, slot8 in ipairs(slot1.reward_id_list) do
			if slot8 ~= 0 and RegressionCapsuleToysCfg[slot8] then
				slot3[#slot3 + 1] = RegressionCapsuleToysCfg[slot8].reward
			elseif slot8 == 0 then
				slot3[#slot3 + 1] = GameSetting.regression_gashapon_reward.value
			end
		end

		slot4 = GameSetting.regression_gashapon_cost

		CurrencyData:CurrencyModify(slot4.value[1], -1 * slot4.value[2] * slot2.times)
		RegressionData:SetCapsuleToysStatus(slot1.reward_id_list)
		getRewardData(mergeReward(slot3))
		slot0:GetCapsuleReward(slot3)
	else
		ShowTips(slot1.result)
		slot0.drawController_:SetSelectedState("false")
	end
end

function slot0.GetCapsuleReward(slot0, slot1)
	slot0:RefreshMultiDrawBtn()
	slot0.animator_:Play("Fx_niudanji_cx", -1, 0)
	slot0.animator_:Update(0)

	if slot0.timer_ ~= nil then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.timer_ = Timer.New(function ()
		if uv0.animator_:GetCurrentAnimatorStateInfo(0):IsName(uv1) and slot0.normalizedTime >= 1 then
			if uv0.timer_ ~= nil then
				uv0.timer_:Stop()

				uv0.timer_ = nil
			end

			uv0:SetData()

			for slot4, slot5 in ipairs(uv2) do
				if slot5[1] == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS or slot5[1] == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS then
					slot5[1] = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE
				end
			end

			uv0.drawController_:SetSelectedState("false")
			JumpTools.OpenPageByJump("capsuleToysGetReward", {
				list = uv2
			})
		end
	end, 0.033, -1)

	slot0.timer_:Start()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_NEW_RETURN_COIN
	})
end

function slot0.RefreshMultiDrawBtn(slot0)
	slot1 = GameSetting.regression_gashapon_cost
	slot4 = 2

	if CurrencyData:GetCurrencyNum(slot1.value[1]) >= slot1.value[2] * 2 then
		slot4 = math.floor(slot2 / slot3) <= 10 and slot5 or 10
	end

	slot0.multiDrawTimesText_.text = string.format(GetTips("REGRESSION_GASHAPON_EXTRACT"), slot4)
	slot0.drawMultiCostText_.text = "x" .. tostring(slot3 * slot4)
end

function slot0.OnExit(slot0)
	if slot0.timer_ ~= nil then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
