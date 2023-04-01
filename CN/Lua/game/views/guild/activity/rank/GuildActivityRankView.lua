slot0 = class("GuildActivityRankView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivityUI/GuildActivityRankUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, GuildActivityRaceRankItem)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.rankList_[slot1])
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.rankList_ = GuildActivityData:GetRankList()

	slot0.scrollHelper_:StartScroll(#slot0.rankList_)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
