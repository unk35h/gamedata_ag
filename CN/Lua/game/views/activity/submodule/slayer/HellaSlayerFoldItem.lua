slot0 = class("HellaSlayerFoldItem", ReduxView)

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

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, CommonItem)
	slot0.buttonController = ControllerUtil.GetController(slot0.m_btnController, "stateBtn")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_receiveBtn, nil, function ()
		SlayerAction.QueryPointReward(uv0.slayer_activity_id, uv0.pointRewardId)
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.slayer_activity_id = slot1
	slot0.pointRewardId = slot2
	slot0.m_pointLab.text = ActivitySlayerPointRewardCfg[slot2] and slot3.need or ""
	slot0.rewards = slot3 and slot3.reward_item_list or {}

	slot0.list:StartScroll(#slot0.rewards)

	slot4 = SlayerData:GetPoint(slot1, slot3.activity_id)

	if SlayerData:GetReceivedReward(slot1, slot2) then
		slot0.buttonController:SetSelectedIndex(2)
	elseif slot3.need <= slot4 then
		slot0.buttonController:SetSelectedIndex(0)
	else
		slot0.buttonController:SetSelectedIndex(1)
	end
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
