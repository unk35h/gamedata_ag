ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("AnniversaryFirstView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return "UI/VersionUI/XuHeng1stUI/XH1stYearsHomeUI/XH1stYearsHomeUI"
end

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.anniversaryGiftView_ = AnniversaryGiftView.New(slot0.giftGo_)
	slot0.taskUpdateHandler_ = handler(slot0, slot0.TaskUpdate)
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, AnniversaryTaskItem)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0.anniversaryGiftView_:OnEnter()
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, slot0.taskUpdateHandler_)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0.anniversaryGiftView_:OnExit()
	manager.notify:RemoveListener(OSIRIS_TASK_UPDATE, slot0.taskUpdateHandler_)
end

function slot0.Dispose(slot0)
	slot0.taskUpdateHandler_ = nil

	slot0.scrollHelper_:Dispose()
	slot0.anniversaryGiftView_:Dispose()

	slot0.anniversaryGiftView_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.infoButton_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ANNIVERSARY_INFO",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ANNIVERSARY_INFO")
		})
	end)
end

function slot0.Show(slot0, slot1)
	uv0.super.Show(slot0, slot1)

	if slot1 then
		slot0.scrollHelper_:StartScroll(#TaskData:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK))
	end
end

function slot0.TaskUpdate(slot0)
	slot0.scrollHelper_:StartScroll(#TaskData:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK))
	slot0.anniversaryGiftView_:UpdateItem()
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(TaskData:GetActivityTaskSortList(ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK)[slot1].id)
end

return slot0
