slot0 = class("GuildActivityRecordView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivityUI/GuildActivityRecordUI"
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

	slot0.recordList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, GuildActivityRecordItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.dataList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.dataList_ = slot0.params_.dataList

	slot0.recordList_:StartScroll(#slot0.dataList_)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.recordList_ then
		slot0.recordList_:Dispose()

		slot0.recordList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
