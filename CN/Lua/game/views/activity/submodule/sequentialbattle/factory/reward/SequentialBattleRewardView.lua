slot0 = class("SequentialBattleRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/continuousBattle/MardukContinuousRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.refreshRewardHandler_ = handler(slot0, slot0.RefreshReward)
	slot0.rewardUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.listgo_, SequentialBattleRewardPanel)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	slot0.rewardUIList_:StartScroll(1)
	manager.notify:RegistListener(SEQUENTIAL_BATTLE_REWARD, slot0.refreshRewardHandler_)
	slot0:RefreshCnt()

	slot0.alltext_.text = string.format("/%s", #SequentialBattleChapterCfg[slot0.activityID_].reward_item_list)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(SEQUENTIAL_BATTLE_REWARD, slot0.refreshRewardHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.refreshRewardHandler_ = nil

	slot0.rewardUIList_:Dispose()

	slot0.rewardUIList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot0.activityID_)
end

function slot0.RefreshCnt(slot0)
	slot0.gettext_.text = table.length(SequentialBattleData:GetRewadList(slot0.activityID_))
end

function slot0.RefreshReward(slot0)
	slot0:RefreshCnt()
end

return slot0
