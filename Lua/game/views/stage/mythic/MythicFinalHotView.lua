slot0 = class("MythicFinalHotView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI(slot0.gameObject_)
	slot0:AddListeners()

	slot0.List_ = LuaList.New(handler(slot0, slot0.RefreshFilterItem), slot0.uiList_, MythicFinalHotItem)
	slot0.levelList_ = MythicFinalCfg.all
	slot0.handler_ = handler(slot0, slot0.OnMythicFinalHotItemClick)
end

function slot0.OnEnter(slot0)
	slot0.filterID_ = 1

	if MythicData:GetCurHotLevelId() then
		slot0.filterID_ = table.indexof(MythicFinalCfg.all, slot1) or 1
	end

	slot0:RefreshUI()
	slot0.List_:StartScroll(#slot0.levelList_, slot0.filterID_)
	manager.notify:RegistListener(MYTHIC_FINAL_HOTITEM_CLICK, slot0.handler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(MYTHIC_FINAL_HOTITEM_CLICK, slot0.handler_)
	SetActive(slot0.filterPanel_, false)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.mask_, nil, function ()
		SetActive(uv0.filterPanel_, false)
	end)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		SetActive(uv0.filterPanel_, true)
	end)
	slot0:AddBtnListener(slot0.closebtn_, nil, function ()
		SetActive(uv0.filterPanel_, false)
	end)
end

function slot0.RefreshFilterItem(slot0, slot1, slot2)
	slot2:SetSpectID(slot0.levelList_[slot1], slot1, slot0.filterID_)
end

function slot0.OnMythicFinalHotItemClick(slot0, slot1)
	slot0.filterID_ = slot1

	SetActive(slot0.filterPanel_, false)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.levelText_.text = MythicFinalCfg[slot0.filterID_].id
	slot0.hotlevelText_.text = string.format(MythicFinalCfg[slot0.filterID_].level_diffuculty)

	MythicData:SetCurHotLevelId(MythicFinalCfg[slot0.filterID_].id)

	if MythicData:GetHotLevelIsPass(MythicData:GetCurHotLevelId()) then
		SetActive(slot0.ispassGo_, true)
	else
		SetActive(slot0.ispassGo_, false)
	end
end

function slot0.OnMythicFinalUpdate(slot0)
	slot0.filterID_ = 1

	if MythicData:GetCurHotLevelId() then
		slot0.filterID_ = table.indexof(MythicFinalCfg.all, slot1) or 1
	end

	slot0:RefreshUI()
	slot0.List_:StartScroll(#slot0.levelList_, 1)
end

function slot0.Dispose(slot0)
	if slot0.List_ then
		slot0.List_:Dispose()

		slot0.List_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
