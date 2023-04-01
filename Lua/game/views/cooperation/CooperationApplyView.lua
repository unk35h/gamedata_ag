slot0 = class("CooperationApplyView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Cooperation/CooperationApplyUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.friendController = ControllerUtil.GetController(slot0.m_friendBtn.transform, "toggle")
	slot0.guildController = ControllerUtil.GetController(slot0.m_guildBtn.transform, "toggle")
	slot0.nearController = ControllerUtil.GetController(slot0.m_nearBtn.transform, "toggle")
	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, CooperationApplyItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_friendBtn, function ()
		slot0 = not CooperationData:GetInviteVisible(1)

		CooperationData:SetInviteVisible(1, slot0)
		uv0.friendController:SetSelectedIndex(slot0 and 0 or 1)
		uv0:RefreshUI()
	end)
	slot0:AddBtnListener(nil, slot0.m_guildBtn, function ()
		slot0 = not CooperationData:GetInviteVisible(2)

		CooperationData:SetInviteVisible(2, slot0)
		uv0.guildController:SetSelectedIndex(slot0 and 0 or 1)
		uv0:RefreshUI()
	end)
	slot0:AddBtnListener(nil, slot0.m_nearBtn, function ()
		slot0 = not CooperationData:GetInviteVisible(3)

		CooperationData:SetInviteVisible(3, slot0)
		uv0.nearController:SetSelectedIndex(slot0 and 0 or 1)
		uv0:RefreshUI()
	end)
	slot0:AddBtnListener(nil, slot0.m_mask, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(nil, slot0.m_refreshBtn, function ()
		uv0:RefreshUI()
	end)
	slot0:AddBtnListener(nil, slot0.m_clearBtn, function ()
		CooperationAction.ClearInvite()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.room_type = slot0.params_.room_type

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COOPERATION_INVIT, slot0.room_type), 0)
	slot0:RefreshInviteVisible()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.RefreshInviteVisible(slot0)
	slot0.friendController:SetSelectedIndex(CooperationData:GetInviteVisible(1) and 0 or 1)
	slot0.guildController:SetSelectedIndex(CooperationData:GetInviteVisible(2) and 0 or 1)
	slot0.nearController:SetSelectedIndex(CooperationData:GetInviteVisible(3) and 0 or 1)
end

function slot0.RefreshUI(slot0)
	slot1 = {}

	for slot5 = 1, 3 do
		if CooperationData:GetInviteVisible(slot5) then
			table.insert(slot1, slot5)
		end
	end

	slot0.data = CooperationData:GetInviteList(slot1)

	slot0.list:StartScrollWithoutAnimator(#slot0.data)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.data[slot1])
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnCooperationInviteRefuse(slot0)
	for slot5, slot6 in pairs(slot0.list:GetItemList()) do
		slot6:UpdateState()
	end
end

function slot0.OnCooperationInviteClear(slot0)
	slot0:RefreshUI()
end

function slot0.OnCooperationInviteReceive(slot0)
	slot1 = {}

	for slot5 = 1, 3 do
		if CooperationData:GetInviteVisible(slot5) then
			table.insert(slot1, slot5)
		end
	end

	slot0.data = CooperationData:GetInviteList(slot1)

	slot0.list:StartScrollWithoutAnimator(#slot0.data, slot0.list:GetScrolledPosition())
end

return slot0
