slot0 = class("SequentialBattleRewardItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddLisetners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "statu")
	slot0.rewardItemList_ = {}
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.rewardID_ = slot2

	slot0:RefreshRewardItem()
	slot0:RefreshBtnStatus()
end

function slot0.AddLisetners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		SequentialBattleAction.ReceiveReward(uv0.activityID_, uv0.rewardID_, function (slot0)
			if isSuccess(slot0.result) then
				getReward(SequentialBattleChapterCfg[uv0.activityID_].reward_item_list[uv0.rewardID_][2])
				SequentialBattleData:ReceiveReward(uv0.activityID_, uv0.rewardID_)
				manager.notify:Invoke(SEQUENTIAL_BATTLE_REWARD)
			else
				ShowTips(slot0.result)
			end
		end)
	end)
end

function slot0.RefreshBtnStatus(slot0)
	slot1 = SequentialBattleChapterCfg[slot0.activityID_].reward_item_list[slot0.rewardID_]
	slot3 = table.length(SequentialBattleData:GetFinishStageList(slot0.activityID_))

	if table.keyof(SequentialBattleData:GetRewadList(slot0.activityID_), slot0.rewardID_) then
		slot0.controller_:SetSelectedState("finished")
	elseif slot1[1] <= slot3 then
		slot0.controller_:SetSelectedState("normal")
	else
		slot0.controller_:SetSelectedState("unfinished")
	end
end

function slot0.RefreshRewardItem(slot0)
	for slot6, slot7 in ipairs(SequentialBattleChapterCfg[slot0.activityID_].reward_item_list[slot0.rewardID_][2]) do
		if slot0.rewardItemList_[slot6] then
			slot0.rewardItemList_[slot6]:SetData(slot7)
		else
			slot0.rewardItemList_[slot6] = RewardPoolFactoryItem.New(slot0.rewardPanel_, slot7, true)
		end
	end

	for slot6 = #slot2[2] + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot6]:Show(false)
	end

	if slot2[1] >= #slot1.stage_id then
		slot0.text_.text = GetTips("PASS_ALL")
	else
		slot0.text_.text = string.format(GetTips("AT_LAST_CNT"), slot3)
	end
end

return slot0
