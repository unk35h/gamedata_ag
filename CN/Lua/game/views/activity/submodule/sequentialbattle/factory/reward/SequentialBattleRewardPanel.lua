slot0 = class("SequentialBattleRewardPanel", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.rewardUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.listgo_, SequentialBattleRewardItem)
	slot0.refreshRewardHandler_ = handler(slot0, slot0.RefreshReward)

	manager.notify:RegistListener(SEQUENTIAL_BATTLE_REWARD, slot0.refreshRewardHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(SEQUENTIAL_BATTLE_REWARD, slot0.refreshRewardHandler_)

	slot0.refreshRewardHandler_ = nil

	slot0.rewardUIList_:Dispose()

	slot0.rewardUIList_ = nil
end

function slot0.SetData(slot0, slot1)
	slot0.activityID_ = slot1

	slot0.rewardUIList_:StartScroll(#SequentialBattleChapterCfg[slot0.activityID_].reward_item_list)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot0.activityID_, SequentialBattleData:GetSortRewardList(slot0.activityID_)[slot1])

	slot0.title_.text = SequentialBattleChapterCfg[slot0.activityID_].stage_name
end

function slot0.RefreshReward(slot0)
	slot0.rewardUIList_:StartScroll(#SequentialBattleChapterCfg[slot0.activityID_].reward_item_list)
end

return slot0
