slot0 = class("FishingGivePopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Fishing/FishingGivePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0.curId_ = 0

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.currentList_ = LuaList.New(handler(slot0, slot0.indexCurrentItem), slot0.currentListGo_, FishIcon)
	slot0.requireList_ = LuaList.New(handler(slot0, slot0.indexRequireItem), slot0.requireListGo_, FishIcon)
end

function slot0.indexCurrentItem(slot0, slot1, slot2)
	slot2:RegisterClickListener(function (slot0)
		uv0:SwitchSelect(slot0)
	end)

	if slot0.curId_ == slot0.fishDataList_[slot1].id then
		slot2:SetSelected(true)
	else
		slot2:SetSelected(false)
	end

	slot2:SetId(slot0.fishDataList_[slot1].id, slot0.fishDataList_[slot1].num)
end

function slot0.indexRequireItem(slot0, slot1, slot2)
	slot2:SetId(slot0.params_.data.fishList[slot1])
end

function slot0.SwitchSelect(slot0, slot1)
	slot0.curId_ = slot1

	slot0.currentList_:Refresh()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.giveBtn_, nil, function ()
		if uv0.curId_ ~= 0 then
			FishingAction.GiveRareFish(ActivityConst.SUMMER_FISHING, uv0.curId_, uv0.params_.data.friendId, function ()
				uv0:Back()
			end)
		end
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.fishDataList_ = {}
	slot3 = FishingData
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetActivityData(slot5).fish_infos) do
		if slot5.num > 0 then
			table.insert(slot0.fishDataList_, slot5)
		end
	end

	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.UpdateView(slot0)
	slot0.requireList_:StartScroll(#slot0.params_.data.fishList)
	slot0.currentList_:StartScroll(#slot0.fishDataList_)
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
