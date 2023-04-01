slot0 = class("SkadiGameReward", ReduxView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummeChallengePop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.itemList_ = {}

	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.scrollerHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uilistGo_, SkadiGameRewardItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:HideBar()

	slot0.activityID_ = slot0.params_.activityID

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.RefreshUI(slot0)
	slot0:UpdateDate()
	slot0.scrollerHelper_:StartScroll(#slot0.itemList_)

	slot0.numText_.text = SummerLittleGameData:GetSkadiRewardNum() .. "/" .. #slot0.itemList_ * 3
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.itemList_[slot1])
end

function slot0.UpdateDate(slot0)
	slot0.itemList_ = deepClone(ActivityCrossWaveCfg.all)

	table.sort(slot0.itemList_, function (slot0, slot1)
		slot7 = #SummerLittleGameData:GetSkadiReward(slot1) < #SummerLittleGameData:GetSkadiStars(slot1)

		if #SummerLittleGameData:GetSkadiReward(slot0) < #SummerLittleGameData:GetSkadiStars(slot0) and not slot7 then
			return true
		end

		if not slot6 and slot7 then
			return false
		end

		return slot0 < slot1
	end)
end

function slot0.OnGetSkadiReward(slot0)
	slot0.scrollerHelper_:Refresh()

	slot0.numText_.text = SummerLittleGameData:GetSkadiRewardNum() .. "/" .. #slot0.itemList_ * 3
end

function slot0.Dispose(slot0)
	slot0.scrollerHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
