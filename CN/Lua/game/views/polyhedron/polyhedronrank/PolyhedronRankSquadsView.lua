slot0 = class("PolyhedronRankSquadsView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Polyhedron/PolyhedronRankpupUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, PolyhedronRankSquadsItem)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.heroList_ = slot0.params_.list

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot0.list_:StartScroll(#slot0.heroList_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.heroList_[slot1], slot1 == 1)
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
