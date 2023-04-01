slot0 = class("FishingGivePageView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.friendInfoOfFriendId_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, FishingGiveItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	if not slot0.friendInfoOfFriendId_[slot0.friendRequestDataList_[slot1].friendId] then
		slot0.friendInfoOfFriendId_[slot3] = FriendsData:GetInfoByID(slot3)
	end

	slot2:SetData(slot0.friendRequestDataList_[slot1], slot0.friendInfoOfFriendId_[slot3])
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(FRIENDS_REQUEST_FISH_INFO_CHANGE, function ()
		uv0.friendRequestDataList_ = FishingData:GetFriendRequestFishInfo()

		uv0:UpdateView()
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0.uiList_:StartScroll(0)
	slot0:AddEventListeners()
	FishingAction.GetFriendNeedFish(ActivityConst.SUMMER_FISHING)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.UpdateView(slot0)
	slot0.uiList_:StartScroll(#slot0.friendRequestDataList_)
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
