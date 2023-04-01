slot0 = class("CultivateHeroSwitchItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()

	slot0.normalRewardList_ = {}
	slot0.upgradeRewardList_ = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.costBtn_, nil, function ()
		ShowPopItem(POP_ITEM, {
			CurrencyConst.CURRENCY_TYPE_NEW_RETURN_COIN
		})
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.taskID_ = slot1
	slot2 = RegressionData:GetBPTaskIsRecharge()
	slot5 = 0
	slot6 = 0

	if RegressionBPTaskCfg[slot1].need <= RegressionData:GetAccumulateCurrency() then
		slot5 = RegressionData:GetBPTaskStatus()[slot1] and slot7[slot1].is_receive_reward == 1 and 2 or 1

		if slot2 >= 1 then
			slot6 = slot7[slot1] and slot7[slot1].is_receive_recharge_reward == 1 and 2 or 1
		end
	end

	for slot11, slot12 in ipairs(RegressionBPTaskCfg[slot0.taskID_].reward) do
		if not slot0.normalRewardList_[slot11] then
			slot0.normalRewardList_[slot11] = RegressionBPRewardItem.New(slot0.normalRewardPanel_, slot0.rewardGo_, true, nil, handler(slot0, slot0.OnClickReward))
		end

		slot0.normalRewardList_[slot11]:SetData(slot12)
		slot0.normalRewardList_[slot11]:RefreshStatus(slot5)
	end

	for slot11 = #slot7 + 1, #slot0.normalRewardList_ do
		slot0.normalRewardList_[slot11]:Show(false)
	end

	for slot12, slot13 in ipairs(RegressionBPTaskCfg[slot0.taskID_].recharge_reward) do
		if not slot0.upgradeRewardList_[slot12] then
			slot0.upgradeRewardList_[slot12] = RegressionBPRewardItem.New(slot0.upgradeRewardPanel_, slot0.rewardGo_, true, nil, handler(slot0, slot0.OnClickReward))
		end

		slot0.upgradeRewardList_[slot12]:SetData(slot13, false, slot2)
		slot0.upgradeRewardList_[slot12]:RefreshStatus(slot6)
	end

	for slot12 = #slot8 + 1, #slot0.upgradeRewardList_ do
		slot0.upgradeRewardList_[slot12]:Show(false)
	end

	slot9 = RegressionData:GetAccumulateCurrency()
	slot10 = RegressionBPTaskCfg[slot0.taskID_].need
	slot0.progressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), slot9, slot10)
	slot0.progress_.value = slot9 / slot10
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_NEW_RETURN_COIN)
	slot0.descText_.text = GetTips("RETURN_MATERIAL_MAX_POINT")
	slot0.numText_.text = "x" .. slot10
end

function slot0.OnClickReward(slot0)
	if not RegressionData:IsRegressionOpen() then
		ShowTips("TIME_OVER")

		return
	end

	if #slot0:GetCanReceiveTaskList() > 0 then
		RegressionAction.ReceiveBPReward(slot1, slot0.receiveHandler_)

		return true
	end

	return false
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

function slot0.SetReceiveHandler(slot0, slot1)
	slot0.receiveHandler_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.upgradeRewardList_ then
		for slot4, slot5 in ipairs(slot0.upgradeRewardList_) do
			slot5:Dispose()
		end

		slot0.upgradeRewardList_ = nil
	end

	if slot0.normalRewardList_ then
		for slot4, slot5 in ipairs(slot0.normalRewardList_) do
			slot5:Dispose()
		end

		slot0.normalRewardList_ = nil
	end

	slot0.receiveHandler_ = nil
end

return slot0
