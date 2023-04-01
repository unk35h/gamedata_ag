slot0 = class("CooperationApplyItem", ReduxView)

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

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.onlineController = ControllerUtil.GetController(slot0.transform_, "online")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_agreeBtn, function ()
		CooperationAction.ReceiveInvite({
			uv0.uid
		})
	end)
	slot0:AddBtnListener(nil, slot0.m_refuseBtn, function ()
		CooperationAction.DelectInvite({
			uv0.uid
		})
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.data = slot1
	slot0.dest = slot1.dest
	slot0.uid = slot1.uid
	slot0.room_id = slot1.room_id
	slot0.m_name.text = slot1.nick
	slot0.m_lvLab.text = "LV." .. slot1.level
	slot0.m_icon.sprite = ItemTools.getItemSprite(slot1.icon)
	slot0.m_frame.sprite = ItemTools.getItemSprite(slot1.icon_frame)

	if ActivityCooperationDemoCfg[slot0.dest] then
		slot0.m_destName.text = slot2.stage_name
	else
		slot0.m_destName.text = ""
	end

	slot0:UpdateState()
end

function slot0.UpdateState(slot0)
	slot0.stateController:SetSelectedIndex(slot0.data.refuse and 1 or 0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
