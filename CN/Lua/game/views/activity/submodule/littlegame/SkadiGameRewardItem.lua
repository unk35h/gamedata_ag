slot0 = class("LeviathanGameRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardList_ = {}
	slot0.receiveCon_ = {
		ControllerUtil.GetController(slot0.statebtnTrs_1, "stateBtn"),
		ControllerUtil.GetController(slot0.statebtnTrs_2, "stateBtn"),
		ControllerUtil.GetController(slot0.statebtnTrs_3, "stateBtn")
	}
end

function slot0.AddUIListeners(slot0)
	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["statebtnBtn_" .. slot4], nil, function ()
			SummerLittleGameAction.GetSkadiReward(uv0.activityID_, uv1)
		end)
	end
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.activityID_ = slot1
	slot0.textText_.text = ActivityCrossWaveCfg[slot0.activityID_].name

	for slot5 = 1, 3 do
		slot0:RefreshReward(slot5)
		slot0:RefreshType(slot5)
	end
end

function slot0.RefreshReward(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityCrossWaveCfg[slot0.activityID_].reward_item_list[slot1]) do
		if not slot0.rewardList_[slot1] then
			slot0.rewardList_[slot1] = {}
		end

		if not slot0.rewardList_[slot1][slot6] then
			slot0.rewardList_[slot1][slot6] = RewardItem.New(slot0.rewardItem_, slot0["rewardParent_" .. slot1])

			slot0.rewardList_[slot1][slot6]:UpdateCommonItemAni()
		end

		slot0.rewardList_[slot1][slot6]:SetData(slot7)
	end

	for slot6 = #slot2 + 1, #slot0.rewardList_[slot1] do
		slot0.rewardList_[slot1][slot6]:Show(false)
	end
end

function slot0.RefreshType(slot0, slot1)
	slot3 = SummerLittleGameData:GetSkadiReward(slot0.activityID_)

	if slot1 > #SummerLittleGameData:GetSkadiStars(slot0.activityID_) then
		slot0.receiveCon_[slot1]:SetSelectedState("unfinished")
	elseif table.indexof(slot3, slot1) then
		slot0.receiveCon_[slot1]:SetSelectedState("rewarded")
	else
		slot0.receiveCon_[slot1]:SetSelectedState("success")
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.rewardList_) do
		for slot9, slot10 in ipairs(slot5) do
			slot10:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
