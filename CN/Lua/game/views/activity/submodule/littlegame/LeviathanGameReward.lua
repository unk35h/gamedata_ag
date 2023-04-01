slot0 = class("LeviathanGameReward", ReduxView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerQuestEewardsPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.itemList_ = {}

	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.scrollerHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, LeviathanGameRewardItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	slot0:UpdateDate()
	slot0.scrollerHelper_:StartScroll(#slot0.itemList_)
end

function slot0.OnExit(slot0)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.itemList_[slot1])
end

function slot0.UpdateDate(slot0)
	slot0.itemList_ = deepClone(ActivityBubblesCfg.all)

	table.sort(slot0.itemList_, function (slot0, slot1)
		if SummerLittleGameData:GetLeviathanState(slot0) == SummerLittleGameData:GetLeviathanState(slot1) then
			return slot0 < slot1
		end

		slot4 = {
			[0] = 2,
			1,
			3
		}

		return slot4[slot2] < slot4[slot3]
	end)
end

function slot0.Dispose(slot0)
	slot0.scrollerHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnGetLeviathanReward(slot0)
	slot0:UpdateDate()
	slot0.scrollerHelper_:Refresh()
end

return slot0
