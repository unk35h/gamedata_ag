slot0 = class("GameHelpProView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/GameHelpPro"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, GameHelpProItem)
end

function slot0.AddUIListeners(slot0)
	slot1 = slot0.list_

	slot1:SetPageChangeHandler(handler(slot0, slot0.OnPageChange))
	slot0:AddBtnListener(slot0.m_preBtn, nil, function ()
		uv0.list_:SwitchToPage(uv0.pageIndex_ - 1)
	end)
	slot0:AddBtnListener(slot0.m_nextBtn, nil, function ()
		uv0.list_:SwitchToPage(uv0.pageIndex_ + 1)
	end)
end

function slot0.OnPageChange(slot0, slot1)
	slot0.pageIndex_ = slot1

	SetActive(slot0.m_preBtn.gameObject, slot1 > 1)
	SetActive(slot0.m_nextBtn.gameObject, slot1 < #slot0.pages)
end

function slot0.OnTop(slot0)
	if slot0.hideHomeBtn then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.pages = slot0.params_.pages or {}
	slot0.hideHomeBtn = slot0.params_.hideHomeBtn or nil
	slot1 = slot0.params_.startIndex or 1

	slot0.list_:StartScroll(#slot0.pages, slot1, true, false)
	slot0:OnPageChange(slot1)

	slot0.params_.startIndex = nil
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.pages[slot1], #slot0.pages)
end

function slot0.OnExit(slot0)
	OperationRecorder.RecordStayView("STAY_VIEW_GAME_HELP", slot0:GetStayTime(), 50103)
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
