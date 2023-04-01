slot0 = class("HellaParkourRewardInfoItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, CommonItem)
	slot0.rewardController = ControllerUtil.GetController(slot0.transform_, "reward")
	slot0.stateController = ControllerUtil.GetController(slot0.m_stateController, "stateBtn")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_receiveBtn, nil, function ()
		ParkourAction.QueryParkourStarReward(uv0.entrust_activity_id, uv0.index)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index = slot1
	slot0.entrust_activity_id = slot2
	slot0.rewards = slot3

	slot0.rewardController:SetSelectedIndex(math.min(3, slot1 - 1))
	slot0.list:StartScroll(#slot0.rewards)

	if not ParkourData:GetParkourEntrustData(slot2) then
		slot0.stateController:SetSelectedIndex(1)

		return
	end

	slot5 = ParkourData:GetStarCount(slot2)

	if table.indexof(slot4.rewards, slot1) then
		slot0.stateController:SetSelectedIndex(2)
	elseif slot1 == 4 and table.indexof(slot4.stars, 4) then
		slot0.stateController:SetSelectedIndex(0)
	elseif slot1 ~= 4 and slot1 <= slot5 then
		slot0.stateController:SetSelectedIndex(0)
	else
		slot0.stateController:SetSelectedIndex(1)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.rewards[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
