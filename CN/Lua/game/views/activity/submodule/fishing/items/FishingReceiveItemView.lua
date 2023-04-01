slot0 = class("FishingReceiveItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:AddEventListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.fishIcon_ = FishIcon.New(slot0.fishIconGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		FishingAction.GetFriendsFish(ActivityConst.SUMMER_FISHING, uv0.data_.giver_id, uv0.data_.timestamp)
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.playerNameLabel_.text = slot0.data_.giver_nick
	slot0.playerHeadIcon_.sprite = ItemTools.getItemSprite(slot0.data_.giver_icon)

	slot0.fishIcon_:SetId(slot0.data_.fish_id, 1)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	if slot0.fishIcon_ then
		slot0.fishIcon_:Dispose()

		slot0.fishIcon_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
