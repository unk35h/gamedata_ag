slot0 = class("FishingGiveItemView", ReduxView)

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

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.fishListGo_, FishIcon)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetId(slot0.data_.fishList[slot1], 1)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.giveBtn_, nil, function ()
		if FishingData:IsFriendGiveMax(uv0.friendInfo_.user_id) then
			ShowTips("DAILY_GIVE_RARE_FISH_LIMIT_TIP")

			return
		end

		JumpTools.OpenPageByJump("fishingGivePop", {
			data = uv0.data_
		})
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.friendInfo_ = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.playerNameLabel_.text = slot0.friendInfo_.nick
	slot0.playerHeadIcon_.sprite = ItemTools.getItemSprite(slot0.friendInfo_.icon)

	slot0.uiList_:StartScroll(#slot0.data_.fishList)

	if FishingData:IsFriendGiveMax(slot0.data_.friendId) then
		slot0.statusController_:SetSelectedState("full")
	else
		slot0.statusController_:SetSelectedState("normal")
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
