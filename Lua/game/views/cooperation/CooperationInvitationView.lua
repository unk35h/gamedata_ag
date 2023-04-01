slot0 = class("CooperationInvitationView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Cooperation/CooperationInvitationUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.friendController = ControllerUtil.GetController(slot0.m_friendBtn.transform, "toggle")
	slot0.guildController = ControllerUtil.GetController(slot0.m_guildBtn.transform, "toggle")
	slot0.nearController = ControllerUtil.GetController(slot0.m_nearBtn.transform, "toggle")
	slot0.controllers = {
		slot0.friendController,
		slot0.guildController,
		slot0.nearController
	}
	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, CooperationInvitationItem)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_friendBtn, function ()
		uv0.select = 1

		uv0:UpdateMenu()
	end)
	slot0:AddBtnListener(nil, slot0.m_guildBtn, function ()
		uv0.select = 2

		uv0:UpdateMenu()
	end)
	slot0:AddBtnListener(nil, slot0.m_nearBtn, function ()
		uv0.select = 3

		uv0:UpdateMenu()
	end)
	slot0:AddBtnListener(nil, slot0.m_mask, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	CooperationData:ClearHadInvited()

	slot0.tag = {}

	if GuildData:GetGuildInfo().id == nil then
		SetActive(slot0.m_guildBtn.gameObject, false)
	else
		SetActive(slot0.m_guildBtn.gameObject, true)
	end

	if slot0.select == nil then
		slot0.select = 1
	end

	slot0:UpdateMenu()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateMenu(slot0)
	for slot4, slot5 in ipairs(slot0.controllers) do
		if slot4 == slot0.select then
			slot5:SetSelectedIndex(1)
		else
			slot5:SetSelectedIndex(0)
		end
	end

	slot0.data = {}

	if slot0.select == 1 then
		if slot0.tag[1] then
			slot0.data = FriendsData:GetList(1)

			slot0.list:StartScroll(#slot0.data)
		else
			FriendsAction:TryToRefreshFriendsView(1)
		end
	elseif slot0.select == 2 then
		if slot0.tag[2] then
			slot0.data = GuildData:GetGuildMemberIDList()

			table.removebyvalue(slot0.data, USER_ID)
			slot0.list:StartScroll(#slot0.data)
		else
			GuildAction.RequiredGuildMemberList(handler(slot0, slot0.OnRequiredGuildMemberListBack))
		end
	elseif slot0.tag[3] then
		slot0.data = CooperationData:GetRecentVisitList() or {}

		slot0.list:StartScroll(#slot0.data)
	else
		CooperationAction.QueryRecentVisit()
	end
end

function slot0.OnFriendsListChange(slot0, slot1)
	slot0.tag[1] = true

	if slot0.select == 1 then
		slot0.data = {}

		for slot6, slot7 in ipairs(FriendsData:GetList(1)) do
			if (FriendsData:GetInfoByID(slot7).online_state or -1) <= 345600 then
				table.insert(slot0.data, slot7)
			end
		end

		slot0.list:StartScroll(#slot0.data)
	end
end

function slot0.OnRequiredGuildMemberListBack(slot0, slot1)
	if slot0.select == 2 then
		if isSuccess(slot1.result) then
			slot0.tag[2] = true
			slot0.data = GuildData:GetGuildMemberIDList()

			table.removebyvalue(slot0.data, USER_ID)
			slot0.list:StartScroll(#slot0.data)
		else
			slot0.list:StartScroll(0)
			ShowTips(slot1.result)
		end
	end
end

function slot0.OnCooperationRecentVisitUpdate(slot0)
	slot0.tag[3] = true

	if slot0.select == 3 then
		slot0.data = CooperationData:GetRecentVisitList()

		slot0.list:StartScroll(#slot0.data)
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.data[slot1], slot0.select)
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnCooperationInviteSuccess(slot0)
	for slot5, slot6 in pairs(slot0.list:GetItemList()) do
		slot6:UpdateState()
	end
end

return slot0
