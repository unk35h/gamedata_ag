slot0 = class("RegressionBPTaskPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot3 = Object.Instantiate(Asset.Load("UI/ReturnTwoUI/RT2stBPUI"), slot1)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.taskItemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiList_, RegressionBPTaskItem)
	slot0.gsPayCallback_ = handler(slot0, slot0.OnPaySuccess)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.ReceiveBtn_, nil, function ()
		if not RegressionData:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			return
		end

		RegressionAction.ReceiveBPReward(uv0:GetCanReceiveTaskList(), handler(uv0, uv0.OnRegressionBPTaskReceive))
	end)
	slot0:AddBtnListener(slot0.UpgradeBtn_, nil, function ()
		if not RegressionData:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			return
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_regression_bp_buy = 0
		})
		PayAction.RequestGSPay(601, 1)
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.taskItemList_ then
		slot0.taskItemList_:Dispose()

		slot0.taskItemList_ = nil
	end

	slot0.gsPayCallback_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.SetData(slot0)
	slot0.taskList_ = RegressionCfg[RegressionData:GetRegressionVersion()].regression_bp
	slot2 = RegressionData:GetBPTaskStatus()
	slot3 = RegressionData:GetBPTaskIsRecharge()
	slot4 = RegressionData:GetAccumulateCurrency()
	slot5 = 1
	slot6 = false

	for slot10, slot11 in ipairs(slot0.taskList_) do
		if RegressionBPTaskCfg[slot11].need <= slot4 then
			if slot2[slot11] == nil then
				slot6 = true
			elseif slot2[slot11].is_receive_reward < 1 or slot3 >= 1 and slot2[slot11].is_receive_recharge_reward < 1 then
				slot6 = true
			end
		end

		if slot6 == true then
			slot5 = slot10

			break
		end
	end

	slot0.ReceiveBtn_.interactable = slot6

	slot0.taskItemList_:StartScroll(#slot0.taskList_, slot5)
	SetActive(slot0.UpgradeGo_, slot3 < 1)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskList_[slot1])
	slot2:SetReceiveHandler(handler(slot0, slot0.OnRegressionBPTaskReceive))
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 == true then
		manager.redPoint:bindUIandKey(slot0.ReceiveBtn_.transform, RedPointConst.REGRESSION_BP)
		manager.notify:RegistListener(RECHARGE_SUCCESS, slot0.gsPayCallback_)
	else
		manager.redPoint:unbindUIandKey(slot0.ReceiveBtn_.transform, RedPointConst.REGRESSION_BP)
		manager.notify:RemoveListener(RECHARGE_SUCCESS, slot0.gsPayCallback_)
	end
end

function slot0.OnPaySuccess(slot0)
	RegressionAction.SetBPTaskIsRecharge()
	slot0:SetData()
end

function slot0.OnRegressionBPTaskReceive(slot0)
	slot0:SetData()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.GetCanReceiveTaskList(slot0)
	slot1 = {}
	slot4 = RegressionData:GetBPTaskStatus()
	slot5 = RegressionData:GetBPTaskIsRecharge()
	slot6 = RegressionData:GetAccumulateCurrency()

	for slot10, slot11 in ipairs(RegressionCfg[RegressionData:GetRegressionVersion()].regression_bp) do
		if RegressionBPTaskCfg[slot11].need <= slot6 then
			if slot4[slot11] then
				if slot4[slot11].is_receive_reward < 1 then
					slot1[#slot1 + 1] = {
						receive_type = 1,
						id = slot11
					}
				end

				if slot5 >= 1 and slot4[slot11].is_receive_recharge_reward < 1 then
					slot1[#slot1 + 1] = {
						receive_type = 2,
						id = slot11
					}
				end
			else
				slot1[#slot1 + 1] = {
					receive_type = 1,
					id = slot11
				}

				if slot5 >= 1 then
					slot1[#slot1 + 1] = {
						receive_type = 2,
						id = slot11
					}
				end
			end
		end
	end

	return slot1
end

return slot0
