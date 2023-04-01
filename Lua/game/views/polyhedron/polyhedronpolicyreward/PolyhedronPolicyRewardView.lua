slot0 = class("PolyhedronPolicyRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Polyhedron/PolyhedronDeviationUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, PolyhedronPolicyRewardItem)
	slot0.stageRewardItem_ = PolyhedronPolicyRewardItem.New(slot0.stageRewardGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.allReceiveBtn_, nil, function ()
		PolyhedronAction.QueryPolicyReward(1)
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.mainActivityID_ = PolyhedronData:GetActivityID()
	slot0.activityID_ = ActivityCfg[slot0.mainActivityID_].policy_activity_id

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.rewardList_:Dispose()

	slot0.rewardList_ = nil

	slot0.stageRewardItem_:Dispose()

	slot0.stageRewardItem_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.rewardCfg_ = PolyhedronPolicyCfg.get_id_list_by_activity_id[slot0.activityID_]
	slot0.curLevel_, slot0.curExp_ = PolyhedronTools.PolyhedronPolicyExpToLevel()

	slot0:RefreshLevel()
	slot0.rewardList_:StartScroll(#slot0.rewardCfg_, slot0:RefreshReceiveBtn() <= #slot0.rewardCfg_ and slot1 or #slot0.rewardCfg_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.rewardCfg_[slot1], slot0.curLevel_)

	slot4 = 1

	for slot8, slot9 in pairs(slot0.rewardList_:GetItemList()) do
		if slot4 < slot9.level_ then
			slot4 = slot9.level_ or slot4
		end
	end

	if slot0.curStageLevel_ < slot4 or slot4 <= slot0.curStageLevel_ - 10 then
		slot0:RefreshStageReward(slot4)
	end
end

function slot0.RefreshLevel(slot0)
	slot0.levelText_.text = slot0.curLevel_
	slot2 = PolyhedronPolicyCfg.get_id_list_by_activity_id[ActivityCfg[slot0.mainActivityID_].policy_activity_id]
	slot0.levelList_ = slot2
	slot4 = #slot2 >= slot0.curLevel_ + 1 and slot4 or slot3
	slot5 = 0
	slot5 = (slot0.curLevel_ ~= 0 or PolyhedronPolicyCfg[slot2[1]].exp) and (slot0.curLevel_ == slot3 and PolyhedronPolicyCfg[slot2[slot0.curLevel_]].exp - PolyhedronPolicyCfg[slot2[slot0.curLevel_ - 1]].exp or PolyhedronPolicyCfg[slot2[slot4]].exp - PolyhedronPolicyCfg[slot2[slot0.curLevel_]].exp)
	slot0.expText_.text = string.format("%d/%d", slot0.curExp_, slot5)
	slot0.progressSlider_.value = slot0.curExp_ / slot5

	slot0:RefreshStageReward(slot4)
end

function slot0.RefreshStageReward(slot0, slot1)
	if math.ceil(slot1 / 10) * 10 > #slot0.levelList_ then
		slot2 = slot3 or slot2
	end

	slot0.stageRewardItem_:SetData(slot0.rewardCfg_[slot2], slot0.curLevel_)

	slot0.curStageLevel_ = slot2
end

function slot0.RefreshReceiveBtn(slot0)
	slot1 = PolyhedronData:GetPolicyApplyList()

	for slot5 = 1, slot0.curLevel_ do
		if slot1[slot5] == nil then
			SetActive(slot0.allReceiveBtn_.gameObject, true)

			return slot5
		end
	end

	SetActive(slot0.allReceiveBtn_.gameObject, false)

	return slot0.curLevel_ + 1
end

function slot0.OnReceivedPolicyReward(slot0)
	slot0:RefreshUI()
end

return slot0
