slot0 = class("XH1stSealSealItemView", ReduxView)

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
	slot0:StopAnimators()

	slot0.rewardController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "reward")
	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.commonItem_

	slot1:RegistCallBack(function (slot0)
		if uv0.onItemClick_ ~= nil then
			uv0.onItemClick_(slot0)
		end
	end)
end

function slot0.SetItemClick(slot0, slot1)
	slot0.onItemClick_ = slot1
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.id_ = slot2
	slot0.cfg_ = ActivitySealTicketCfg[slot2]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.commonItem_:RefreshData({
		id = slot0.cfg_.reward_item_list[1][1],
		number = slot0.cfg_.reward_item_list[1][2]
	})

	if XH1stSealData:HaveGotSeal(slot0.cfg_.ticket_id, slot0.cfg_.row, slot0.cfg_.column) then
		slot0.rewardController_:SetSelectedState("normal")
	else
		slot0.rewardController_:SetSelectedState("seal")
	end
end

function slot0.EnableReward(slot0)
	slot0.rewardController_:SetSelectedState("normal")
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.StopAnimators(slot0)
	slot0.sealAnimator_:Play("sealAnimator", -1, 0)

	slot0.sealAnimator_.speed = 0

	slot0.linkAnimator_:Play("linkAnimator", -1, 0)

	slot0.linkAnimator_.speed = 0
end

function slot0.Dispose(slot0)
	slot0.onItemClick_ = nil
	slot0.data_ = nil

	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
