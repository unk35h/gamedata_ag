slot0 = class("CooperationInvitationItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.onlineController = ControllerUtil.GetController(slot0.transform_, "online")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_invitBtn, function ()
		if CooperationData:GetRoomData():IsFull() then
			ShowTips("COOPERATION__NO_ALLOW_INVITE_FULL")
		end

		CooperationAction.InvitePlayer(uv0.uid, uv0.type)
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.type = slot2
	slot3 = -1

	if slot2 == 1 then
		slot4 = FriendsData:GetInfoByID(slot1)
		slot0.m_name.text = slot4.nick
		slot0.m_lvLab.text = ""
		slot0.m_icon.sprite = ItemTools.getItemSprite(slot4.icon)
		slot0.m_frame.sprite = ItemTools.getItemSprite(slot4.icon_frame ~= 0 and slot4.icon_frame or 2001)
		slot3 = slot4.online_state or -1
		slot0.m_lvLab.text = GetTips("LEVEL") .. string.format("%s", slot4.level or 0)
		slot0.uid = slot1
	elseif slot2 == 2 then
		slot4 = GuildData:GetGuildMemberData(slot1)
		slot0.m_name.text = slot4.name
		slot0.m_lvLab.text = GetTips("LEVEL") .. string.format("%s", slot4.level)
		slot0.m_icon.sprite = ItemTools.getItemSprite(slot4.icon)
		slot0.m_frame.sprite = ItemTools.getItemSprite(slot4.frame)
		slot3 = slot4.offlineStamptime
		slot0.uid = slot1
	else
		slot4 = slot1
		slot0.m_name.text = slot4.nick
		slot0.m_lvLab.text = GetTips("LEVEL") .. string.format("%s", slot4.level)
		slot0.m_icon.sprite = ItemTools.getItemSprite(slot4.icon)
		slot0.m_frame.sprite = ItemTools.getItemSprite(slot4.icon_frame)
		slot3 = slot4.timestamp
		slot0.uid = slot4.uid
	end

	if slot3 == 0 then
		slot0.m_timeLab.text = GetTips("ONLINE")

		slot0.onlineController:SetSelectedIndex(0)
	else
		slot0.m_timeLab.text = manager.time:GetOnLineText(slot3)

		slot0.onlineController:SetSelectedIndex(1)
	end

	slot0:UpdateState()
end

function slot0.UpdateState(slot0)
	if CooperationData:GetHadInvited(slot0.uid, slot0.type) then
		slot0.stateController:SetSelectedIndex(1)
	else
		slot0.stateController:SetSelectedIndex(0)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
