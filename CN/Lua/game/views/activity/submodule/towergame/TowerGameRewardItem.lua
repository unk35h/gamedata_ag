slot0 = class("TowerGameRewardBlock", ReduxView)

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

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listgo_, FactorySoloChallengeRewardCommonItem)
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "statu")
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.rewradCfg_[slot1], POP_ITEM)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		TowerGameACtion:GetReward(uv0.rewardpointid_)
	end)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.levelid_ = slot2
	slot0.rewardpointid_ = ActivityPointRewardCfg.get_id_list_by_activity_id[slot2][slot1]
	slot0.cfg_ = ActivityPointRewardCfg[slot0.rewardpointid_]
	slot0.text_.text = string.format(GetTips("ACTIVITY_TOWER_DEFENSE_REWARD"), slot0.cfg_.need)

	slot0.controller_:SetSelectedState(TowerGameData:GetRewardStatuByLevelIDAndPointId(slot2, slot0.rewardpointid_))

	slot0.rewradCfg_ = slot0.cfg_.reward_item_list

	slot0.list_:StartScroll(#slot0.rewradCfg_)
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
