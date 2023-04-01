slot0 = class("EquipRecView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Equip/NewEquipRecommendUI"
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

	slot0.items_ = {}
	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, EquipRecGroupItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.equipRecIdList_[slot1], slot0.heroId_)
end

function slot0.AddUIListeners(slot0)
	slot1 = slot0.list_

	slot1:SetPageChangeHandler(handler(slot0, slot0.OnPageChange))
	slot0:AddBtnListener(slot0.prevBtn_, nil, function ()
		uv0.list_:SwitchToPage(uv0.pageIndex_ - 1)
	end)
	slot0:AddBtnListener(slot0.nextBtn_, nil, function ()
		uv0.list_:SwitchToPage(uv0.pageIndex_ + 1)
	end)
end

function slot0.RemoveUIListeners(slot0)
	slot0.list_:SetPageChangeHandler(nil)
end

function slot0.OnPageChange(slot0, slot1)
	slot0.pageIndex_ = slot1
	slot0.params_.pageIndex = slot1

	SetActive(slot0.prevBtn_.gameObject, slot1 > 1)
	SetActive(slot0.nextBtn_.gameObject, slot1 < 3)

	if slot0.params_.onPageChange then
		slot0.params_.onPageChange(slot1)
	end
end

function slot0.OnEnter(slot0)
	slot0.heroId_ = slot0.params_.hid
	slot0.cfg = EquipRecommendCfg[slot0.heroId_]
	slot0.equipRecIdList_ = {
		slot0.cfg.equip_list1,
		slot0.cfg.equip_list2,
		slot0.cfg.equip_list3
	}

	if slot0.params_.pageIndex ~= nil and slot0.params_.pageIndex > 0 then
		slot0.list_:StartScroll(3, slot0.params_.pageIndex, true, false)
		slot0.list_:SwitchToPage(slot0.params_.pageIndex)
	else
		slot0.list_:StartScroll(3, 1, true, false)
		slot0.list_:SwitchToPage(1)
	end
end

function slot0.OnAddProposal(slot0)
	ShowTips("SUCCESS_SAVE_EQUIP_PROPOSAL")
end

function slot0.OnMainHomeViewTop(slot0)
	slot0.params_.pageIndex = nil
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		uv0.params_.index = 1

		uv0:Back()

		uv0.scrollPos_ = nil
	end)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveUIListeners()
	slot0:RemoveAllListeners()

	if slot0.items_ then
		for slot4, slot5 in ipairs(slot0.items_) do
			slot5:Dispose()
		end

		slot0.items_ = nil
	end

	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
