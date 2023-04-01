slot0 = class("GuildMemberListView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubMemberListUI_new"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.tree_ = LuaTree.New(slot0.goTree_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect), handler(slot0, slot0.OnItemSelect))

	slot0.memberUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, GuildMemberItem)
	slot0.exitGuildHandler_ = handler(slot0, slot0.ExitGuild)
	slot0.refreshMemberHandler_ = handler(slot0, slot0.RefreshMember)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
	slot0:RefreshList()

	if slot0.params_.isBack then
		slot0.tree_:SelectItem(slot0.lastPage_, slot0.lastPageIndex_ or 1)
	else
		slot0.tree_:SelectGroup(1)
	end

	manager.notify:RegistListener(GUILD_EXIT, slot0.exitGuildHandler_)
	manager.notify:RegistListener(GUILD_REFRESH_MEMBER, slot0.refreshMemberHandler_)
end

function slot0.OnExit(slot0)
	slot0.scrollPos_ = clone(slot0.memberUIList_:GetScrolledPosition())

	if slot0.memberUIList_ then
		slot0.memberUIList_:StopRender()
	end

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(GUILD_EXIT, slot0.exitGuildHandler_)
	manager.notify:RemoveListener(GUILD_REFRESH_MEMBER, slot0.refreshMemberHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.tree_:Dispose()

	slot0.tree_ = nil

	slot0.memberUIList_:Dispose()

	slot0.memberUIList_ = nil
	slot0.exitGuildHandler_ = nil
	slot0.refreshMemberHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonExit_, nil, function ()
		if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) then
			ShowTips("ACTIVITY_CLUB_ACTIVITYING_EXIT_CLUB_TIP")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("EXIT_CLUB"),
			OkCallback = function ()
				slot0 = GuildData

				GuildAction.GuildExit(slot0:GetGuildInfo().id, function (slot0)
					if isSuccess(slot0.result) then
						JumpTools.OpenPageByJump("/home")
					else
						ShowTips(slot0.result)
					end
				end)
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 1 then
		slot0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.MEMBER)

		slot0.lastPage_ = 1
	end
end

function slot0.OnItemSelect(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 1 then
		slot0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.WEEK_CONTRIBUTE)

		slot0.lastPage_ = 2
		slot0.lastPageIndex_ = 1
	else
		slot0:SwitchPage(GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE)

		slot0.lastPageIndex_ = 2
	end
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot0.memberList_[slot1], slot0.page_ ~= GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE)
end

function slot0.RefreshList(slot0)
	slot0.memberIDList_ = GuildData:GetGuildMemberIDList()
	slot0.memberWeekContributeList_ = GuildData:GetGuildWeekContributeList()
	slot0.memberContributeList_ = GuildData:GetGuildContributeList()
end

function slot0.SwitchPage(slot0, slot1)
	if slot1 == GuildConst.MEMBER_LIST_TYPE.MEMBER then
		slot0.memberList_ = slot0.memberIDList_
	elseif slot1 == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
		slot0.memberList_ = slot0.memberContributeList_
	else
		slot0.memberList_ = slot0.memberWeekContributeList_
	end

	if slot0.page_ ~= slot1 then
		slot0.page_ = slot1

		slot0.memberUIList_:StartScroll(#slot0.memberList_)
	else
		slot0.memberUIList_:StartScrollWithoutAnimator(#slot0.memberList_, slot0.scrollPos_)
	end
end

function slot0.ExitGuild(slot0)
	slot0:Go("/home")
end

function slot0.RefreshMember(slot0)
	slot0:RefreshList()

	if slot0.page_ == GuildConst.MEMBER_LIST_TYPE.MEMBER then
		slot0.memberList_ = slot0.memberIDList_
	elseif slot0.page_ == GuildConst.MEMBER_LIST_TYPE.CONTRIBUTE then
		slot0.memberList_ = slot0.memberContributeList_
	else
		slot0.memberList_ = slot0.memberWeekContributeList_
	end

	slot0.memberUIList_:StartScrollWithoutAnimator(#slot0.memberList_, slot0.memberUIList_:GetScrolledPosition())
end

return slot0
