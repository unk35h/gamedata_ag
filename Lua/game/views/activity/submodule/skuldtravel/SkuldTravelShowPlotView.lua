slot0 = class("SkuldTravelShowPlotView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelrecord"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemlist_ = {}

	for slot4 = 1, 9 do
		slot0.itemlist_[slot4] = SkuldTravelShowPlotItem.New(slot0["itemgo_" .. slot4])
	end
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.RefreshUI(slot0)
	for slot4, slot5 in pairs(slot0.itemlist_) do
		slot5:SetData(TravelSkuldStoryCfg.all[slot4])
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	if slot0.itemlist_ then
		for slot4, slot5 in pairs(slot0.itemlist_) do
			slot5:Dispose()

			slot0.itemlist_[slot4] = nil
		end

		slot0.itemlist_ = nil
	end

	slot0.super.Dispose(slot0)
end

return slot0
