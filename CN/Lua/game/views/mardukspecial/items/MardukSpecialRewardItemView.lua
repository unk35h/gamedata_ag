slot0 = class("MardukSpecialRewardItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.items_ = {
		MardukSpecialRewardConditionItemView.New(slot0.itemGo1_),
		MardukSpecialRewardConditionItemView.New(slot0.itemGo2_),
		MardukSpecialRewardConditionItemView.New(slot0.itemGo3_)
	}
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.activityId_ = slot2
	slot0.quickTrainingCfg_ = BattleQuickTrainingCfg[BattleQuickTrainingCfg.all[slot1]]
	slot0.rewardIdList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[slot2]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.nameLabel.text = slot0.quickTrainingCfg_.name
	slot3 = MardukSpecialData
	slot5 = slot3
	slot6 = slot0.activityId_
	slot0.scoreLabel1_.text = slot3.GetPoint(slot5, slot6)
	slot0.scoreLabel2_.text = "/" .. ActivityPointRewardCfg[slot0.rewardIdList_[#slot0.rewardIdList_]].need

	for slot5, slot6 in ipairs(slot0.items_) do
		slot6:SetData(slot5, slot0.rewardIdList_[slot5], slot0.activityId_)
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	for slot4, slot5 in ipairs(slot0.items_) do
		slot5:OnEnter()
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	for slot4, slot5 in ipairs(slot0.items_) do
		slot5:OnExit()
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	if slot0.items_ then
		for slot4, slot5 in pairs(slot0.items_) do
			slot5:Dispose()
		end

		slot0.items_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
