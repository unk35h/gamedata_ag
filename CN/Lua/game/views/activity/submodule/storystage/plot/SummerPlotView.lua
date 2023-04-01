slot0 = class("SummerPlotView", ReduxView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerPlotUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.plotUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, SummerPlotItem)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistHomeCallBack(function ()
		uv0:HideRedPoint()
		uv0:Go("/home")
	end)
	manager.windowBar:RegistBackCallBack(function ()
		uv0:HideRedPoint()
		uv0:Back()
	end)

	slot0.plotList_ = ActivityStoryCollect[slot0.params_.theme].story_id
	slot2, slot3 = ActivityTools.GetActivityChessProgress(ActivityConst.SUMMER_CHESS_ISLAND)
	slot0.value_ = math.floor(slot2 / slot3)

	slot0.plotUIList_:StartScroll(#slot0.plotList_, 1)
	slot0:RefreshText()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.plotUIList_ then
		slot0.plotUIList_:Dispose()

		slot0.plotUIList_ = nil
	end
end

function slot0.AddListeners(slot0)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot0.plotList_[slot1], ActivityStoryCollect[slot0.params_.theme].unlock_value[slot1] or 100, slot0.value_)
end

function slot0.RefreshText(slot0)
	slot0.finishRateText_.text = string.format("%d%%", slot0.value_)
end

function slot0.HideRedPoint(slot0)
	slot1 = ActivityConst.SUMMER_CHESS_ISLAND
	slot2, slot3 = ActivityTools.GetActivityChessProgress(slot1)
	slot4 = slot2 / slot3

	for slot10, slot11 in pairs(ActivityStoryCollect[ActivityCfg[slot1].activity_theme].story_id) do
		slot12 = string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, slot5, slot11)

		if slot6.unlock_value[slot10] <= slot4 then
			WarChessAction.SetActivityChessPlotRedPoint(slot5, slot11)
		end
	end
end

return slot0
