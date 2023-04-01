slot0 = class("BattleBossAdvanceRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BossChallenge/BossIntegralRewardPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.rewardUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, BattleBossAdvanceRewardItem)
	slot0.refreshHandler_ = handler(slot0, slot0.RefreshScroll)
end

function slot0.OnEnter(slot0)
	slot0.rewardUIList_:StartScroll(#BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].reward, 1)

	slot0.pointText_.text = BattleBossChallengeAdvanceData:GetTotalPoint()

	slot0:RefreshAllReceiveBtn()
	manager.notify:RegistListener(BOSS_CHALLENGE_RECEIVE_STAR_REWARD, slot0.refreshHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_RECEIVE_STAR_REWARD, slot0.refreshHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.refreshHandler_ = nil

	if slot0.rewardUIList_ then
		slot0.rewardUIList_:Dispose()

		slot0.rewardUIList_ = nil
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if #BattleBossChallengeAdvanceData:GetReceiveRewardList() <= 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("BOSS_CHALLENGE_REWARD_TIPS"),
				OkCallback = function ()
					uv0:ClickReceiveBtn()
				end
			})
		else
			uv0:ClickReceiveBtn()
		end
	end)
end

function slot0.RefreshScroll(slot0)
	slot0.rewardUIList_:Refresh()
	slot0:RefreshAllReceiveBtn()
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(BattleBossChallengeAdvanceData:GetSortRewardList()[slot1])
end

function slot0.RefreshAllReceiveBtn(slot0)
	slot3 = BattleBossChallengeAdvanceData:GetTotalPoint()
	slot4 = BattleBossChallengeAdvanceData:GetReceiveRewardList()

	for slot8, slot9 in ipairs(BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].reward) do
		if slot9[1] <= slot3 and not table.keyof(slot4, slot9[1]) then
			SetActive(slot0.receiveGo_, true)

			return
		end
	end

	SetActive(slot0.receiveGo_, false)
end

function slot0.ClickReceiveBtn(slot0)
	BattleBossChallengeAction.RequireAllBossPointExchange(function (slot0)
		if isSuccess(slot0.result) then
			slot3 = BattleBossChallengeAdvanceData:GetTotalPoint()
			slot4 = BattleBossChallengeAdvanceData:GetReceiveRewardList()
			slot5 = {}

			for slot9, slot10 in ipairs(BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].reward) do
				if slot10[1] <= slot3 and not table.keyof(slot4, slot10[1]) then
					slot5 = mergeRewardList(slot5, getRewardFromDropCfg(slot10[2], true))
				end
			end

			getReward(slot5)
			BattleBossChallengeAdvanceData:ModifyAllReceiveReward()
			manager.notify:Invoke(BOSS_CHALLENGE_RECEIVE_STAR_REWARD)
		else
			ShowTips(slot0.result)
		end
	end)
end

return slot0
