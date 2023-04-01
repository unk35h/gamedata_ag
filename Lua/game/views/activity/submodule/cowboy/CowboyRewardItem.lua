slot0 = class("CowboyRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardBtn_ = {}
	slot0.rewardCon_ = {}
	slot0.rewardBoxs_ = {}
	slot0.rewardNeed_ = {}
	slot0.rewardPanel_ = {}

	for slot4 = 1, 3 do
		slot0.rewardBtn_[slot4] = slot0["rewardBtn_" .. slot4]
		slot0.rewardCon_[slot4] = ControllerUtil.GetController(slot0.transform_, "reward_" .. slot4)
		slot0.rewardBoxs_[slot4] = {}
		slot0.rewardNeed_[slot4] = slot0["need_" .. slot4]
		slot0.rewardPanel_[slot4] = slot0["rewardPanel_" .. slot4]
	end
end

function slot0.AddUIListeners(slot0)
	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0.rewardBtn_[slot4], nil, function ()
			CowboyAction:GetReward(uv0.activityID_, uv0.infos_[uv1].point_id)
		end)
	end
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.mainActivityID_ = slot1
	slot0.activityID_ = slot2

	slot0:RefreshData()
	slot0:RefreshReward()
	slot0:RefreshState()
end

function slot0.RefreshData(slot0)
	slot0.data_ = CowboyData:GetData(slot0.activityID_)
	slot0.infos_ = slot0.data_.reward
	slot0.titleText_.text = string.format(GetTips("ACTIVITY_COWBOY_ROUND"), table.indexof(ActivityCfg[slot0.mainActivityID_].sub_activity_list, slot0.activityID_))
end

function slot0.RefreshReward(slot0)
	slot0.rewardInfo_ = ActivityPointRewardCfg.get_id_list_by_activity_id[slot0.activityID_]

	for slot4, slot5 in ipairs(slot0.rewardInfo_) do
		slot6 = ActivityPointRewardCfg[slot5]
		slot11 = GetTips("ACTIVITY_LIMIT_CALCULATION_POINT_REACHED")
		slot12 = slot6.need
		slot0.rewardNeed_[slot4].text = string.format(slot11, slot12)

		for slot11, slot12 in ipairs(slot6.reward_item_list) do
			if not slot0.rewardBoxs_[slot4][slot11] then
				slot0.rewardBoxs_[slot4][slot11] = RewardItem.New(slot0.rewardItem_, slot0.rewardPanel_[slot4], true)

				slot0.rewardBoxs_[slot4][slot11]:UpdateCommonItemAni()
			end

			slot0.rewardBoxs_[slot4][slot11]:SetData(slot12)
		end

		for slot11 = #slot7 + 1, #slot0.rewardBoxs_[slot4] do
			slot0.rewardBoxs_[slot4][slot11]:Show(false)
		end
	end
end

function slot0.RefreshState(slot0)
	slot1 = slot0.data_.score

	for slot5, slot6 in ipairs(slot0.infos_) do
		if slot6.point_reward_state == 2 then
			slot0.rewardCon_[slot5]:SetSelectedState("rewarded")
		elseif ActivityPointRewardCfg[slot6.point_id].need <= slot1 then
			slot0.rewardCon_[slot5]:SetSelectedState("success")
		else
			slot0.rewardCon_[slot5]:SetSelectedState("unfinished")
		end
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.rewardBoxs_) do
		for slot9, slot10 in ipairs(slot5) do
			slot10:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
