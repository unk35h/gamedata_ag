slot0 = class("RecallSystemRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/RecallUI/RC1stRewardUI"
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

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, RecallSystemRewardItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.params_.list[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.UpdateBar(slot0)
end

function slot0.OnTop(slot0)
	manager.windowBar:SetAsLastSibling()
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = slot0.params_.list

	slot0.list_:StartScroll(#slot1)
	getRewardData(slot1)
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
