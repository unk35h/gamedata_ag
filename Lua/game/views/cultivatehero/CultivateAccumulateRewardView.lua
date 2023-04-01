slot0 = class("CultivateAccumulateRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng1stUI/XH1stReceivedUI/XH1stRewardPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, CultivateAccumulateRewardItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.scoreText_.text = ItemTools.getItemNum(ActivityCultivateHeroCfg[slot0.activityID_].coin_id)
	slot0.icon_.sprite = ItemTools.getItemSprite(ActivityCultivateHeroCfg[slot0.activityID_].coin_id)

	slot0:RefreshScroll()
end

function slot0.RefreshScroll(slot0)
	slot0.scrollHelper_:StartScroll(slot0:GetAwardListLength())
end

function slot0.GetAwardListLength(slot0)
	slot0.taskIDList_ = ActivityCultivateHeroCfg[slot0.activityID_].task_list

	return #slot0.taskIDList_
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.taskIDList_[slot1], slot0.activityID_)
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
