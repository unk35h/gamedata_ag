slot0 = class("SkuldTravelFinalResultView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelend"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.ItemRenderler), slot0.listgo_, SkuldTravelFinalResultItem)
end

function slot0.ItemRenderler(slot0, slot1, slot2)
	slot2:SetData(slot1)
end

function slot0.OnEnter(slot0)
	if SkuldTravelData:IsOpenNewEnding() then
		slot0.list_:StartScroll(#TravelSkuldEndingCfg.all, #TravelSkuldEndingCfg.all)
	else
		slot0.list_:StartScroll(#TravelSkuldEndingCfg.all - 1)
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnSkuldOpenEnding(slot0)
	slot0.list_:Refresh()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
