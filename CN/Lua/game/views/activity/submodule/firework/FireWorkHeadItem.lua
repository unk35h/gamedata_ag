slot0 = class("FireWorkHeadItem", ReduxView)

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

	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, , function ()
		if not ActivityTools.GetActivityIsOpenWithTip(uv0.id) then
			return
		end

		if uv0.callback_ then
			uv0.callback_(uv0.id)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.id = slot1
	slot0.m_icon.sprite = getSpriteWithoutAtlas("Textures/EmptyDream/letter_role_title/role_small/" .. ActivityFireWorkCfg[slot1].icon)

	slot0:RefrenTime()

	if FireWorkData:GetInvited(slot0.id) then
		slot0.stateController:SetSelectedIndex(1)
	else
		slot0.stateController:SetSelectedIndex(0)
	end

	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.FIRE_WORK, slot0.id))
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
end

function slot0.RefrenTime(slot0)
	if ActivityData:GetActivityIsOpen(slot0.id) then
		slot0.lockController:SetSelectedIndex(0)
	else
		slot0.lockController:SetSelectedIndex(1)

		slot1 = manager.time:GetServerTime()

		if ActivityData:GetActivityData(slot0.id) and slot1 < slot2.startTime then
			slot0.m_lockLab.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot2.startTime))
		else
			slot0.m_lockLab.text = GetTips("TIME_OVER")
		end
	end
end

function slot0.UpdateSelect(slot0, slot1)
	slot0.selectController:SetSelectedIndex(slot1 == slot0.id and 1 or 0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
	uv0.super.Dispose(slot0)
end

return slot0
