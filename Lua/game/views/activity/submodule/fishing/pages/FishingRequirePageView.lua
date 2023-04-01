slot0 = class("FishingRequirePageView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.requireList_ = LuaList.New(handler(slot0, slot0.indexRequireItem), slot0.requireListGo_, FishIcon)
	slot0.currentList_ = LuaList.New(handler(slot0, slot0.indexCurrentItem), slot0.currentListGo_, FishIcon)
end

function slot0.indexRequireItem(slot0, slot1, slot2)
	slot2:RegisterClickListener(function (slot0)
		uv0:SwitchSelect(slot0)
	end)

	slot3 = RareFishCfg.all[slot1]

	slot2:SetId(slot3)

	if table.indexof(slot0.currentRequireDataList_, slot3) then
		slot2:SetSelected(true)
	else
		slot2:SetSelected(false)
	end
end

function slot0.SwitchSelect(slot0, slot1)
	if table.indexof(slot0.currentRequireDataList_, slot1) then
		table.remove(slot0.currentRequireDataList_, slot2)
	else
		if #slot0.currentRequireDataList_ >= 3 then
			return
		end

		table.insert(slot0.currentRequireDataList_, slot1)
	end

	slot0.requireList_:Refresh()
end

function slot0.indexCurrentItem(slot0, slot1, slot2)
	slot2:SetId(slot0.currentRequireDataList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.setBtn_, nil, function ()
		FishingAction.UpdateRequest(ActivityConst.SUMMER_FISHING, uv0.currentRequireDataList_)
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(FISHING_REQUEST_CHANGE, function ()
		uv0.currentRequireDataList_ = FishingData:GetActivityData().request_infos

		uv0.requireList_:StartScroll(#RareFishCfg.all)
		uv0.currentList_:StartScroll(#uv0.currentRequireDataList_)
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.currentRequireDataList_ = FishingData:GetActivityData().request_infos

	slot0.requireList_:StartScroll(#RareFishCfg.all)
	slot0.currentList_:StartScroll(#slot0.currentRequireDataList_)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.requireList_ then
		slot0.requireList_:Dispose()

		slot0.requireList_ = nil
	end

	if slot0.currentList_ then
		slot0.currentList_:Dispose()

		slot0.currentList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
