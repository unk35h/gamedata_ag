slot0 = class("SurviveSoloRewardItem", ReduxView)

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

	slot0.btn_ = {}
	slot0.title_ = {}
	slot0.rewards_ = {}
	slot0.stateCon_ = {}
	slot0.rewardPanel_ = {}

	for slot4 = 1, 3 do
		slot0.btn_[slot4] = slot0["btn_" .. slot4]
		slot0.title_[slot4] = slot0["title_" .. slot4]
		slot0.rewards_[slot4] = {}
		slot0.stateCon_[slot4] = ControllerUtil.GetController(slot0["item_" .. slot4].transform, "state")
		slot0.rewardPanel_[slot4] = slot0["rewardPanel_" .. slot4]
	end
end

function slot0.AddUIListeners(slot0)
	for slot4, slot5 in ipairs(slot0.btn_) do
		slot0:AddBtnListener(slot0.btn_[slot4], nil, function ()
			SurviveSoloAction:GetReward(uv0.activityID_, uv0.cfg_.reward_item_list[uv1][1])
		end)
	end
end

function slot0.OnEnter(slot0)
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.mainActivityID_ = slot2
	slot0.cfg_ = ActivitySoloSlayerCfg[slot0.activityID_]

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.level_.text = BattleSoloSlayerCfg[slot0.cfg_.stage_id].name
	slot1 = SurviveSoloData:GetData(slot0.activityID_)

	for slot5 = 1, 3 do
		slot6 = slot0.cfg_.reward_item_list[slot5]
		slot10 = GetTips("ACTIVITY_SOLO_SLAYER_REWARD")
		slot11 = slot6[1]
		slot0.title_[slot5].text = string.format(slot10, slot11)

		for slot10, slot11 in ipairs(slot6[2]) do
			if not slot0.rewards_[slot5][slot10] then
				slot0.rewards_[slot5][slot10] = SurviveSoloTools.GetRewardItemSkin(slot0.mainActivityID_).New(Object.Instantiate(slot0.rewardItem_, slot0.rewardPanel_[slot5]), slot0.rewardPanel_[slot5])
			end

			slot0.rewards_[slot5][slot10]:SetData(slot11, POP_ITEM)
		end

		for slot10 = #slot6[2] + 1, #slot0.rewards_[slot5] do
			slot0.rewards_[slot5][slot10]:Show(false)
		end

		if slot1 and slot6[1] <= slot1.time then
			if table.indexof(slot1.rewards, slot6[1]) then
				slot0.stateCon_[slot5]:SetSelectedState("received")
			else
				slot0.stateCon_[slot5]:SetSelectedState("complete")
			end
		else
			slot0.stateCon_[slot5]:SetSelectedState("incomplete")
		end
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = 1, 3 do
		for slot8, slot9 in ipairs(slot0.rewards_[slot4]) do
			slot9:Dispose()

			slot9 = nil
		end

		slot0.rewards_[slot4] = nil
	end

	slot0.rewards_ = {}

	uv0.super.Dispose(slot0)
end

return slot0
