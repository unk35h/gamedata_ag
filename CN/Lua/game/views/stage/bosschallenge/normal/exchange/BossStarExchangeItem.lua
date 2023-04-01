slot0 = class("BossStarExchangeItem", ReduxView)
slot1 = 0
slot2 = 1
slot3 = 2

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)

	slot0.rewardIndex_ = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.rewardItemList_ = {}

	slot0:InitUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.rewardIndex_ = slot3
	slot0.rewardCfg_ = getRewardFromDropCfg(slot1[2], true)
	slot0.totalStarCnt_ = slot1[1]
	slot0.curStarCnt_ = slot1[1] < slot2 and slot1[1] or slot2

	slot0:GetRewardState()
	slot0:RefreshUI(slot2)
	slot0:RefreshState()
	slot0:RefreshItem()
	SetActive(slot0.arrowGo_, not slot4)
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	for slot4, slot5 in ipairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil
	slot0.rewardPanel_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardPanel_ = {}

	for slot4 = 1, 3 do
		slot0.rewardPanel_[slot4] = slot0[string.format("rewardItem%s_", slot4)]
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if uv0.rewardState_ == uv1 then
			if table.length(BattleBossChallengeNormalData:GetReceiveStarList()) <= 0 then
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
		end
	end)
	slot0:AddBtnListener(slot0.buttonUnfinish_, nil, function ()
		ShowTips("DONOT_MEET_CONDITION")
	end)
end

function slot0.RemoveListeners(slot0)
end

function slot0.ClickItem(slot0)
	slot1 = slot0.rewardState_

	BattleBossChallengeAction.RequireBossExchange(slot0.curStarCnt_, function (slot0)
		if isSuccess(slot0.result) then
			BattleBossChallengeNormalData:SetReceiveStarList(uv0.totalStarCnt_)
			uv0:GetRewardState()
			getReward(uv0.rewardCfg_)

			if uv1 == uv2 and uv0.rewardState_ == uv3 then
				uv0:RefreshState()
				manager.notify:Invoke(BOSS_CHALLENGE_RECEIVE_STAR_REWARD)
			end
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.GetRewardState(slot0)
	slot1 = slot0.rewardIndex_
	slot2 = slot0.chapterID_
	slot3 = nil
	slot0.rewardState_ = slot0.curStarCnt_ < slot0.totalStarCnt_ and uv0 or table.keyof(BattleBossChallengeNormalData:GetReceiveStarList(), slot0.totalStarCnt_) and uv1 or uv2
end

function slot0.RefreshUI(slot0, slot1)
	slot0.progressCntText_.text = slot0.totalStarCnt_
	slot0.progressText_.text = string.format("%s/%s", slot1, slot0.totalStarCnt_)
	slot0.progressBar_.fillAmount = slot1 / slot0.totalStarCnt_
	slot0.textPhase_.text = slot0.rewardIndex_
end

function slot0.RefreshState(slot0)
	slot0.controller_:SetSelectedState(tostring(slot0.rewardState_))
end

function slot0.RefreshItem(slot0)
	for slot5, slot6 in pairs(slot0.rewardCfg_) do
		if slot0.rewardItemList_[slot5] then
			slot0.rewardItemList_[slot5]:SetData(slot6)
		else
			slot0.rewardItemList_[slot5] = RewardPoolItem.New(slot0.rewardPanel_[slot5], slot6)
		end
	end

	for slot5 = #slot1 + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot5]:Show(false)
	end
end

return slot0
