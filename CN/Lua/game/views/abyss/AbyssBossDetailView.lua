slot0 = class("AbyssBossDetailView", ReduxView)

function slot0.UIName(slot0)
	return "UI/AbyssUI/AbyssBoss"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, AbyssBossDetailItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.bossIdList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.uiList_

	slot1:SetPageChangeHandler(handler(slot0, slot0.OnPageChange))
	slot0:AddBtnListener(slot0.leftBtn_, nil, function ()
		if uv0.pageIndex_ > 1 then
			uv0.pageIndex_ = uv0.pageIndex_ - 1

			uv0.uiList_:SwitchToPage(uv0.pageIndex_)
		end
	end)
	slot0:AddBtnListener(slot0.rightBtn_, nil, function ()
		if uv0.pageIndex_ < uv0.maxLv_ then
			uv0.pageIndex_ = uv0.pageIndex_ + 1

			uv0.uiList_:SwitchToPage(uv0.pageIndex_)
		end
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnPageChange(slot0, slot1)
	slot0.pageIndex_ = slot1

	slot0:RefreshBtn()
end

function slot0.RefreshBtn(slot0)
	SetActive(slot0.leftBtn_.gameObject, slot0.pageIndex_ > 1)
	SetActive(slot0.rightBtn_.gameObject, slot0.pageIndex_ < #slot0.bossIdList_)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	slot0:ShowDefaultBar()
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.pageIndex_ = 1
	slot0.bossIdList_ = slot0.params_.bossIdList

	slot0.uiList_:StartScroll(#slot0.bossIdList_)
	slot0:RefreshBtn()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
