slot0 = class("CommunityTaskView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubctivityUI"
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

	slot0.taskList_ = {}
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.scrollView_, ClubTaskItemView)
	slot0.guildExitHandler_ = handler(slot0, slot0.ExitGuild)
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	manager.notify:RegistListener(GUILD_EXIT, slot0.guildExitHandler_)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.taskList_[slot1])
end

function slot0.RefreshUI(slot0)
	slot0.identity_ = CommunityData:GetIdentity()

	slot0:RefreshBar()

	slot0.taskList_ = TaskData:GetSortTaskIDList(TaskConst.TASK_TYPE.CLUB_TASK)

	slot0.scrollHelper_:StartScroll(#slot0.taskList_)
end

function slot0.RefreshBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function slot0.OnTaskListChange(slot0)
	slot0.taskList_ = TaskData:GetSortTaskIDList(TaskConst.TASK_TYPE.CLUB_TASK)

	slot0.scrollHelper_:StartScroll(#slot0.taskList_)
end

function slot0.ExitGuild(slot0)
	slot0:Go("/home")
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(GUILD_EXIT, slot0.guildExitHandler_)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
