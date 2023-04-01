slot0 = class("GuildManagerView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubManagementUI_new"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.tree_ = LuaTree.New(slot0.goTree_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect), handler(slot0, slot0.OnItemSelect))

	slot0.memberUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, GuildManagerItem)
	slot0.refreshMemberHandler_ = handler(slot0, slot0.RefreshMember)
	slot0.refreshRequestHandler_ = handler(slot0, slot0.RefreshRequest)
	slot0.exitGuildHandler_ = handler(slot0, slot0.ExitGuild)
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.isManagerController_ = ControllerUtil.GetController(slot0.transform_, "isManager")
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)

	if slot0.params_.isBack then
		slot0.tree_:SelectGroup(slot0.page_)
	else
		slot0.tree_:SelectGroup(1)
	end

	manager.notify:RegistListener(GUILD_REFRESH_MEMBER, slot0.refreshMemberHandler_)
	manager.notify:RegistListener(GUILD_REFRESH_REQUEST, slot0.refreshRequestHandler_)
	manager.notify:RegistListener(GUILD_EXIT, slot0.exitGuildHandler_)
	slot0:RefreshSettingBtn()
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(1), RedPointConst.GUILD_IMPEACH, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(2), RedPointConst.GUILD_REQUEST, {
		x = 0,
		y = 0
	})
	slot0:RefreshToggle()
end

function slot0.OnExit(slot0)
	if slot0.memberUIList_ then
		slot0.memberUIList_:StopRender()
	end

	slot0.scrollPos_ = clone(slot0.memberUIList_:GetScrolledPosition())

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(GUILD_REFRESH_MEMBER, slot0.refreshMemberHandler_)
	manager.notify:RemoveListener(GUILD_REFRESH_REQUEST, slot0.refreshRequestHandler_)
	manager.notify:RemoveListener(GUILD_EXIT, slot0.exitGuildHandler_)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(1), RedPointConst.GUILD_IMPEACH)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(2), RedPointConst.GUILD_REQUEST)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.refreshMemberHandler_ = nil
	slot0.refreshRequestHandler_ = nil
	slot0.exitGuildHandler_ = nil

	slot0.tree_:Dispose()

	slot0.tree_ = nil

	slot0.memberUIList_:Dispose()

	slot0.memberUIList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonSetting_, nil, function ()
		JumpTools.OpenPageByJump("guildRequestSetting")
	end)
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 1 then
		slot0:SwitchPage(GuildConst.MANAGER_LIST_TYPE.MEMBER)
	else
		slot0:SwitchPage(GuildConst.MANAGER_LIST_TYPE.REQUEST)
	end
end

function slot0.OnItemSelect(slot0, slot1, slot2, slot3, slot4)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot0.memberList_[slot1], slot0.page_ == GuildConst.MANAGER_LIST_TYPE.MEMBER)
end

function slot0.SwitchPage(slot0, slot1)
	if slot1 == GuildConst.MANAGER_LIST_TYPE.MEMBER then
		slot0.memberList_ = GuildData:GetGuildMemberIDList()
	else
		slot0.memberList_ = GuildData:GetGuildRequestIDList()
	end

	if slot0.page_ ~= slot1 then
		slot0.page_ = slot1

		slot0.memberUIList_:StartScroll(#slot0.memberList_)
	else
		slot0.memberUIList_:StartScrollWithoutAnimator(#slot0.memberList_, slot0.scrollPos_)
	end

	slot0:RefreshTitlePanel()
end

function slot0.RefreshMember(slot0)
	if slot0.page_ == GuildConst.MANAGER_LIST_TYPE.MEMBER then
		if GuildConst.GUILD_POST.DEPUTY < GuildData:GetGuildInfo().post then
			slot0:Go("/guildEntrace/guildMain")
		else
			slot0.scrollPos_ = clone(slot0.memberUIList_:GetScrolledPosition())

			slot0:SwitchPage(slot0.page_)
		end
	end

	slot0:RefreshSettingBtn()
	slot0:RefreshToggle()
end

function slot0.RefreshRequest(slot0)
	if slot0.page_ == GuildConst.MANAGER_LIST_TYPE.REQUEST then
		slot0.scrollPos_ = clone(slot0.memberUIList_:GetScrolledPosition())

		slot0:SwitchPage(slot0.page_)
	end
end

function slot0.RefreshSettingBtn(slot0)
	SetActive(slot0.goSetting_, GuildData:GetGuildInfo().post <= GuildConst.GUILD_POST.DEPUTY)
end

function slot0.RefreshToggle(slot0)
	if GuildData:GetGuildInfo().post == GuildConst.GUILD_POST.CAPTAIN or slot1.post == GuildConst.GUILD_POST.DEPUTY then
		slot0.isManagerController_:SetSelectedState("true")
	else
		slot0.isManagerController_:SetSelectedState("false")
	end
end

function slot0.ExitGuild(slot0)
	slot0:Go("/home")
end

function slot0.RefreshTitlePanel(slot0)
	if slot0.page_ == GuildConst.MANAGER_LIST_TYPE.MEMBER then
		slot0.typeController_:SetSelectedState("false")
	else
		slot0.typeController_:SetSelectedState("true")
	end
end

return slot0
