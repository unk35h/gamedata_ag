slot0 = class("BattleBossAdvanceRewardItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.rewardList_ = {}
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.rewardList_) do
		slot5:Dispose()
	end

	slot0.rewardList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if #BattleBossChallengeAdvanceData:GetReceiveRewardList() <= 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("BOSS_CHALLENGE_REWARD_TIPS"),
				OkCallback = function ()
					uv0:ClickItem()
				end
			})
		else
			uv0:ClickItem()
		end
	end)
end

function slot0.ClickItem(slot0)
	slot1 = BattleBossChallengeAdvanceData

	BattleBossChallengeAction.RequireBossPointExchange(BossChallengeAdvanceCfg[slot1:GetChooseModeID()].reward[slot0.index_][1], function (slot0)
		if isSuccess(slot0.result) then
			getReward(getRewardFromDropCfg(uv0[2], true))
			BattleBossChallengeAdvanceData:ModifyReceiveReward(uv0[1])
			manager.notify:Invoke(BOSS_CHALLENGE_RECEIVE_STAR_REWARD)
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.index_ = slot1
	slot3 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].reward[slot1]
	slot0.descText_.text = string.format(GetTips("CHALLENGE_MAX_POINT"), slot3[1])

	if table.keyof(BattleBossChallengeAdvanceData:GetReceiveRewardList(), slot3[1]) then
		slot0.controller_:SetSelectedState("rewarded")
	elseif slot3[1] <= BattleBossChallengeAdvanceData:GetTotalPoint() then
		slot0.controller_:SetSelectedState("success")
	else
		slot0.controller_:SetSelectedState("unfinished")
	end

	for slot8, slot9 in ipairs(getRewardFromDropCfg(slot3[2], true)) do
		if slot0.rewardList_[slot8] then
			slot0.rewardList_[slot8]:SetData(slot9, false)
		else
			slot0.rewardList_[slot8] = RewardPoolItem.New(slot0.rewardParent_, slot9, false)
		end

		slot0.rewardList_[slot8]:Show(true)
	end

	for slot8 = #slot4 + 1, #slot0.rewardList_ do
		slot0.rewardList_[slot8]:Show(false)
	end
end

return slot0
