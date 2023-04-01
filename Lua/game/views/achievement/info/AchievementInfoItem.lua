slot0 = class("AchievementInfoItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.rewardGos_ = {}
	slot0.rewardItems_ = {}
	slot0.buttonStateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "category")
	slot0.goRewardParent_ = {
		slot0.goItem1_,
		slot0.goItem2_,
		slot0.goItem3_
	}
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonReward_, nil, function ()
		slot0 = uv0.achievementID_
		slot1 = AchievementCfg[slot0]

		AchievementAction.GetReceiveReward(slot0, function (slot0)
			if isSuccess(slot0.result) then
				AchievementData:ChangedAchievementState(uv0, -1)

				slot1 = false
				slot2 = AchievementData:GetCurrentPoint()
				slot3 = AchievementData:GetCurrentLevelPoint()

				for slot7, slot8 in ipairs(uv1.reward) do
					if slot8[1] == CurrencyConst.CURRENCY_TYPE_ACHIEVEMENT_POINT and slot2 < slot3 and slot3 <= slot2 + slot8[2] then
						slot1 = true
					end
				end

				getReward(uv1.reward, nil, function ()
					if uv0 then
						JumpTools.OpenPageByJump("achievementUpgrade", {
							currentPoint = uv1,
							upgradePoint = uv2
						})
					end
				end, true)

				return
			end

			ShowTips(slot0.result)
		end)
	end)
	slot0:AddBtnListener(slot0.buttonGo_, nil, function ()
		if AchievementCfg[uv0.achievementID_].source[1] == nil then
			print("成就的跳转是空的", achievemetnID)

			return
		end

		AchievementData:SetScrollRecord(true)
		JumpTools.JumpToPage2(slot1.source)
	end)
end

function slot0.SetData(slot0, slot1)
	slot2 = AchievementCfg[slot1]

	if slot1 ~= slot0.achievementID_ then
		slot0.textName_.text = slot2.name
		slot0.textContent_.text = slot2.desc

		slot0:RefreshReward(slot2.reward)
	end

	slot3 = AchievementData:GetAchievementData(slot1)
	slot0.textProgress_.text = string.format("%s/%s", slot3.process, slot2.need)
	slot0.progressBar_.fillAmount = slot3.process / slot2.need

	if slot3.rewardState == 0 then
		slot0.buttonStateController_:SetSelectedState("incomplete")
	elseif slot3.rewardState == 1 then
		slot0.buttonStateController_:SetSelectedState("complete")
	else
		slot0.buttonStateController_:SetSelectedState("finish")

		slot0.textFinishTime_.text = manager.time:DescCTime(slot3.timestamp, "%Y/%m/%d")
	end

	slot0.typeController_:SetSelectedState(slot2.type_id)

	slot0.achievementID_ = slot1
end

function slot0.RefreshReward(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot0.rewardItems_[slot5] then
			slot0.rewardItems_[slot5]:SetData(slot6)
		else
			slot0.rewardItems_[slot5] = RewardPoolItem.New(slot0.goRewardParent_[slot5], slot6, false, POP_SOURCE_ITEM)
		end
	end

	for slot5 = #slot1 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot5]:Show(false)
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
