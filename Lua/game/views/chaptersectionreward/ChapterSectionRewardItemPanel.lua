slot0 = class("ChapterSectionRewardItemPanel", ReduxView)
slot1 = 0
slot2 = 1
slot3 = 2

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.rewardIndex_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.rewardItemList_ = {}

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.SetData(slot0, slot1)
	slot0.chapterID_ = slot1

	slot0:RefreshData()
	slot0:RefreshUI()
	slot0:RefreshState()
	slot0:RefreshItem()
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
			OperationRecorder.Record(uv0.class.__cname, "collect_get_reward")

			slot2 = uv0.rewardState_

			BattleStageAction.GetChapterStarReward(uv0.chapterID_, uv0.rewardIndex_, function (slot0)
				if isSuccess(slot0.result) then
					getReward(uv0.rewradCfg_)
					BattleStageData:SetChapterStarReward(uv1, uv2)
					uv0:GetRewardState()

					if uv3 == uv4 and uv0.rewardState_ == uv5 then
						uv0:RefreshState()
					end
				else
					ShowTips(slot0.result)
				end
			end)
		end
	end)
end

function slot0.RemoveListeners(slot0)
end

function slot0.RefreshData(slot0)
	slot2 = slot0.chapterID_

	if slot0.rewardIndex_ == 1 then
		slot0.rewradCfg_ = ChapterCfg[slot2].first_reward
	elseif slot1 == 2 then
		slot0.rewradCfg_ = ChapterCfg[slot2].second_reward
	else
		slot0.rewradCfg_ = ChapterCfg[slot2].third_reward
	end

	slot3 = 0
	slot5 = BattleStageData:GetStageData()

	for slot9, slot10 in ipairs(ChapterCfg[slot2].section_id_list) do
		if slot5[slot10] then
			for slot15, slot16 in ipairs(slot11.stars) do
				if slot16 == 1 then
					slot3 = slot3 + 1
				end
			end
		end
	end

	slot0.curStarCnt_ = slot3
	slot0.totalStarCnt_ = ChapterCfg[slot2].star_need[slot1]

	slot0:GetRewardState()
end

function slot0.GetRewardState(slot0)
	slot1 = slot0.rewardIndex_
	slot2 = slot0.chapterID_
	slot3 = nil
	slot0.rewardState_ = slot0.curStarCnt_ < slot0.totalStarCnt_ and uv0 or BattleStageData:GetChapterStarRewardState()[slot2] and slot4[slot2][slot1] and slot4[slot2][slot1] >= 1 and uv1 or uv2
end

function slot0.RefreshUI(slot0)
	slot1 = slot0.rewardIndex_
	slot0.progressCntText_.text = slot0.totalStarCnt_
	slot2 = slot0.totalStarCnt_ < slot0.curStarCnt_ and slot0.totalStarCnt_ or slot0.curStarCnt_
	slot0.progressText_.text = string.format("%s/%s", slot2, slot0.totalStarCnt_)
	slot0.progressBar_.fillAmount = slot2 / slot0.totalStarCnt_
end

function slot0.RefreshState(slot0)
	SetActive(slot0.mask_, slot0.rewardState_ == uv0)
	SetActive(slot0.unlockGo_, slot0.rewardState_ == uv1)
	SetActive(slot0.receiveBtnGo_, slot0.rewardState_ == uv2)
end

function slot0.RefreshItem(slot0)
	for slot5, slot6 in pairs(slot0.rewradCfg_) do
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
