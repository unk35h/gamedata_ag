return {
	GotoMainView = function ()
		slot0 = ""

		if ActivityNoobData:IsOpenCurVersion() then
			slot0 = "/activityNoob"
		elseif ActivityNewbieData:IsOpenCurVersion() then
			slot0 = "/activityNewbie"
		end

		JumpTools.OpenPageByJump(slot0, nil, ViewConst.SYSTEM_ID.NEWBIE_ACTIVITY)
	end,
	IsFinishAllActivity = function ()
		slot0 = nil

		if ActivityNoobData:IsOpenCurVersion() then
			slot0 = ActivityNoobData
		elseif ActivityNewbieData:IsOpenCurVersion() then
			slot0 = ActivityNewbieData
		end

		return slot0.IsFinishAllActivity(slot0)
	end,
	GetRechargeIsOpen = function (slot0)
		slot1 = nil

		if ActivityNoobData:IsOpenCurVersion() then
			slot1 = ActivityNoobData
		elseif ActivityNewbieData:IsOpenCurVersion() then
			slot1 = ActivityNewbieData
		end

		if slot1 == nil then
			return false
		end

		if slot0 == 1 then
			return slot1:GetFirstRechargeStatus().signTimes < 3 or slot2.firstGearStatus < 1
		elseif slot0 == 2 then
			return not slot1.GetFirstMonthlyCardStatus(slot1).heroRewardFlag
		else
			return slot1:GetBpRewardStatus() <= 1
		end
	end,
	ReceiveRechargeReward = function (slot0, slot1, slot2)
		slot3, slot4 = nil

		if ActivityNoobData:IsOpenCurVersion() then
			slot3 = ActivityNoobAction
			slot4 = ActivityNoobData
		elseif ActivityNewbieData:IsOpenCurVersion() then
			slot3 = ActivityNewbieAction
			slot4 = ActivityNewbieData
		end

		slot3.ReceiveRechargeReward(slot0, slot1, function (slot0)
			if isSuccess(slot0.result) then
				slot1 = {}

				if uv0 == 1 then
					if uv1 == 0 then
						slot1[1] = GameSetting.newbie_first_charge_reward_6.value[3]

						uv2:ReceiveFirstRecharge(0)
					else
						for slot7 = 2, #GameSetting.newbie_first_charge_reward_18.value[3][uv2:GetFirstRechargeStatus().signTimes + 1] do
							slot1[#slot1 + 1] = slot3[slot7]
						end

						uv2:ReceiveFirstRecharge(1)
					end

					uv3.RefreshFirstRechargeRedPoint()
				elseif uv0 == 2 then
					if uv1 == 0 then
						slot1[1] = GameSetting.newbie_first_monthly_card_reward.value[1]

						uv2:ReceiveMonthlyCard(0)
					else
						slot1[1] = GameSetting.newbie_first_monthly_card_cumulative.value[2]

						uv2:ReceiveMonthlyCard(1)
					end

					uv3.RefreshMonthlyCardRedPoint()
				elseif uv0 == 3 then
					slot1[1] = GameSetting.first_battle_pass_reward.value[1]

					uv2:SetBpRewardStatus()
					uv3.RefreshBpRedPoint()
				end

				getReward(slot1, {
					ItemConst.ITEM_TYPE.HERO,
					ItemConst.ITEM_TYPE.HERO_SKIN
				})

				if uv4 then
					uv4(slot0)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	GetFirstRechargeStatus = function ()
		if ActivityNoobData:IsOpenCurVersion() then
			return ActivityNoobData:GetFirstRechargeStatus()
		elseif ActivityNewbieData:IsOpenCurVersion() then
			return ActivityNewbieData:GetFirstRechargeStatus()
		end

		return nil
	end,
	RefreshFirstRechargeRedPoint = function ()
		slot0 = nil

		if ActivityNoobData:IsOpenCurVersion() then
			slot0 = ActivityNoobData
		elseif ActivityNewbieData:IsOpenCurVersion() then
			slot0 = ActivityNewbieData
		end

		slot1 = slot0.GetFirstRechargeStatus(slot0)
		slot2 = uv0.GetSelectFirstRecharge(1)
		slot3 = 0

		if not uv0.GetRechargeIsOpen(1) then
			slot3 = 0
		elseif not slot2 or slot1.firstGearStatus == 1 then
			slot3 = 1
		end

		manager.redPoint:setTip(RedPointConst.NOOB_FIRST_RECHARGE_1, slot3)

		slot4 = #GameSetting.newbie_first_charge_reward_18.value[3]
		slot5 = slot1.secondGearStatus
		slot6 = slot1.signTimes
		slot7 = slot1.lastSignTimestamp
		slot2 = uv0.GetSelectFirstRecharge(2)
		slot8 = 0

		if not uv0.GetRechargeIsOpen(1) then
			slot8 = 0
		elseif not slot2 then
			slot8 = 1
		elseif not slot5 then
			slot8 = 0
		elseif slot6 < slot4 and slot7 < manager.time:GetTodayFreshTime() then
			slot8 = 1
		end

		manager.redPoint:setTip(RedPointConst.NOOB_FIRST_RECHARGE_2, slot8)
	end,
	SetSelectFirstRecharge = function (slot0)
		saveData(string.format("newbie_first_recharge_%d", slot0), "select", true)
		uv0.RefreshFirstRechargeRedPoint()
	end,
	GetSelectFirstRecharge = function (slot0)
		return getData(string.format("newbie_first_recharge_%d", slot0), "select")
	end,
	GetFirstMonthlyCardStatus = function ()
		if ActivityNoobData:IsOpenCurVersion() then
			return ActivityNoobData:GetFirstMonthlyCardStatus()
		elseif ActivityNewbieData:IsOpenCurVersion() then
			return ActivityNewbieData:GetFirstMonthlyCardStatus()
		end

		return nil
	end,
	SetMonthlyCardSign = function ()
		slot0 = nil

		if ActivityNoobData:IsOpenCurVersion() then
			slot0 = ActivityNoobData
		elseif ActivityNewbieData:IsOpenCurVersion() then
			slot0 = ActivityNewbieData
		end

		if slot0 == nil then
			return
		end

		slot0.SetMonthlyCardSign(slot0)
		uv0.RefreshMonthlyCardRedPoint()
	end,
	RefreshMonthlyCardRedPoint = function ()
		slot0 = nil

		if ActivityNoobData:IsOpenCurVersion() then
			slot0 = ActivityNoobData
		elseif ActivityNewbieData:IsOpenCurVersion() then
			slot0 = ActivityNewbieData
		end

		slot2 = uv0.GetSelectMonthlyRecharge()

		if GameSetting.newbie_first_monthly_card_cumulative.value[1] <= slot0.GetFirstMonthlyCardStatus(slot0).signTimes and slot1.signRewardFlag == false then
			manager.redPoint:setTip(RedPointConst.NOOB_MONTHLY_RECHARGE_SIGN, 1)
		else
			manager.redPoint:setTip(RedPointConst.NOOB_MONTHLY_RECHARGE_SIGN, 0)
		end

		if not uv0.GetRechargeIsOpen(2) then
			manager.redPoint:setTip(RedPointConst.NOOB_MONTHLY_RECHARGE, 0)
		elseif not slot2 then
			manager.redPoint:setTip(RedPointConst.NOOB_MONTHLY_RECHARGE, 1)
		elseif slot1.isRecharged and not slot1.heroRewardFlag then
			manager.redPoint:setTip(RedPointConst.NOOB_MONTHLY_RECHARGE, 1)
		else
			manager.redPoint:setTip(RedPointConst.NOOB_MONTHLY_RECHARGE, 0)
		end
	end,
	SetSelectMonthlyRecharge = function ()
		saveData("newbie_monthly_card", "select", true)
		uv0.RefreshMonthlyCardRedPoint()
	end,
	GetSelectMonthlyRecharge = function ()
		return getData("newbie_monthly_card", "select")
	end,
	GetBpRewardStatus = function ()
		if ActivityNoobData:IsOpenCurVersion() then
			return ActivityNoobData:GetBpRewardStatus()
		elseif ActivityNewbieData:IsOpenCurVersion() then
			return ActivityNewbieData:GetBpRewardStatus()
		end

		return nil
	end,
	RefreshBpRedPoint = function ()
		slot0 = nil

		if ActivityNoobData:IsOpenCurVersion() then
			slot0 = ActivityNoobData
		elseif ActivityNewbieData:IsOpenCurVersion() then
			slot0 = ActivityNewbieData
		end

		slot1 = slot0.GetBpRewardStatus(slot0)
		slot2 = uv0.GetSelectBpRecharge()
		slot3 = 0

		if not uv0.GetRechargeIsOpen(3) then
			slot3 = 0
		elseif not slot2 or slot1 == 1 then
			slot3 = 1
		end

		manager.redPoint:setTip(RedPointConst.NOOB_BP_RECHARGE, slot3)
	end,
	SetSelectBpRecharge = function ()
		saveData("newbie_bp", "select", true)
		uv0.RefreshBpRedPoint()
	end,
	GetSelectBpRecharge = function ()
		return getData("newbie_bp", "select")
	end
}
