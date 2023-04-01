slot0 = class("XH1stSealHomeView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/VersionUI/XuHeng1stUI/XH1stSealUI/XH1stSealHomeUI"), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.oneclickController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "oneclick")
	slot0.endController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "end")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, XH1stSeamItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.assignmentIdList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.OpenPageByJump("/xH1stSealGame", {
			activityId = ActivityConst.ACTIVITY_2_0_SEAL
		})
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		slot1 = {}

		if #TaskData:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_2_0_SEAL) > 0 then
			for slot5, slot6 in ipairs(slot0) do
				table.insert(slot1, slot6.id)
			end
		end

		TaskAction:TryToSubmitActivityTaskList(slot1)
	end)
	slot0:AddBtnListener(slot0.tipBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "XH1ST_SEAL_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("XH1ST_SEAL_DESC")
		})
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, function ()
		uv0:UpdateList()
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	slot1 = ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item
	slot2 = MaterialData:GetMaterial(slot1[1])

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		slot1[1]
	})
	manager.windowBar:SetBarCanAdd(slot1[1], true)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	if slot0:IsTimeOver() then
		slot0.uiList_:StartScroll(0)
		slot0.oneclickController_:SetSelectedState("no")
		slot0.endController_:SetSelectedState("on")
	else
		slot0:UpdateList()
		slot0:StartTimer()
		slot0:UpdateTimer()
	end

	slot0.contentText_.text = GetTips("XH1ST_SEAL_CONTENT")
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.UpdateTimer(slot0)
	slot0.timeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_SEAL).stopTime)
end

function slot0.IsTimeOver(slot0)
	if ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_SEAL).stopTime <= manager.time:GetServerTime() then
		return true
	end

	return false
end

function slot0.UpdateList(slot0)
	slot0.assignmentIdList_ = {}

	table.insertto(slot0.assignmentIdList_, AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_2_0_SEAL], 1)
	table.sort(slot0.assignmentIdList_, function (slot0, slot1)
		if uv0:GetTaskStatus(slot0) ~= uv0:GetTaskStatus(slot1) then
			return slot2 < slot3
		end

		if AssignmentCfg[slot0].type ~= AssignmentCfg[slot1].type then
			return slot4.type < slot5.type
		end

		return slot4.id < slot5.id
	end)
	slot0.uiList_:StartScroll(#slot0.assignmentIdList_)

	if #TaskData:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_2_0_SEAL) > 0 then
		slot0.oneclickController_:SetSelectedState("ok")
	else
		slot0.oneclickController_:SetSelectedState("no")
	end
end

function slot0.GetTaskStatus(slot0, slot1)
	slot2 = AssignmentCfg[slot1]
	slot4 = TaskData:GetActivityTask(ActivityConst.ACTIVITY_2_0_SEAL, slot1).progress

	if TaskData:GetActivityTaskComplete(ActivityConst.ACTIVITY_2_0_SEAL, slot1) then
		return 3
	elseif slot2.need <= slot4 then
		return 1
	else
		return 2
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	slot0:StopTimer()
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0:UpdateList()
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
