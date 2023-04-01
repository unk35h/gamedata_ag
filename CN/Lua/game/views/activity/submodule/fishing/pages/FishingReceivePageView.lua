slot0 = class("FishingReceivePageView", ReduxView)

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

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, FishingReceiveItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.receiveDataList_[slot1])
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(RECEIVE_FISH_CHANGE, function ()
		uv0.receiveDataList_ = FishingData:GetFishReceiveInfo()

		uv0:UpdateView()
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
	FishingAction.GetReceiveInfo(ActivityConst.SUMMER_FISHING, function ()
		uv0.receiveDataList_ = FishingData:GetFishReceiveInfo()

		uv0:UpdateView()
	end)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.UpdateView(slot0)
	slot0.uiList_:StartScroll(#slot0.receiveDataList_)
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
