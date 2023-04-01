slot0 = class("PassportTaskItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:StartTimer()
end

function slot0.StartTimer(slot0)
	if not slot0.timer_ then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.RemoveTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.UpdateTimer(slot0)
	if slot0.taskInfo_ == nil then
		slot0.lastTimeLabel_.text = ""

		slot0.timeController_:SetSelectedState("false")

		return
	end

	if (slot0.taskInfo_.expired_timestamp or 0) > 0 then
		slot0.timeController_:SetSelectedState("true")

		slot0.lastTimeLabel_.text = string.format(GetTips("PASSPORT_TASK_LAST_TIME"), tostring(manager.time:GetLostTimeStr(slot1)))
	else
		slot0.timeController_:SetSelectedState("false")
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.timeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "time")
	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, CommonItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.rewardList_[slot1][1],
		number = slot0.rewardList_[slot1][2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_OTHER_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.JumpToPage2(uv0.taskCfg_.source)
	end)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		slot0 = true

		if getData("passport_task", "tip_deadline") and manager.time:GetServerTime() < tonumber(slot1) then
			slot0 = false
		end

		if slot0 and (uv0.taskCfg_.type == 7 or uv0.taskCfg_.type == 8) and GameSetting.battlepass_exp_limit_weekly.value[1] <= PassportData:GetExpWeekly() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("PASSPORT_WEEKLY_EXP_LIMIT_TIP"),
				toggleText = GetTips("WEEKLY_MUTE_TIP"),
				OkCallback = function ()
					TaskAction:TryToSubmitTask(uv0.taskCfg_.id)
				end,
				ToggleCallback = function (slot0)
					if slot0 then
						saveData("passport_task", "tip_deadline", tostring(_G.gameTimer:GetNextWeekFreshTime()))
					end
				end
			})
		else
			TaskAction:TryToSubmitTask(uv0.taskCfg_.id)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.taskCfg_ = AssignmentCfg[slot1]
	slot0.taskInfo_ = TaskData:GetTask(slot1)
	slot0.rewardList_ = slot0.taskCfg_.reward or {}

	slot0:UpdateView()
	slot0:UpdateTimer()
end

function slot0.UpdateView(slot0)
	slot0.list_:StartScroll(#slot0.rewardList_)

	slot0.typeLabel_.text = slot0.taskCfg_.name
	slot0.descLabel_.text = slot0.taskCfg_.desc

	if slot0.taskCfg_.need < TaskData:GetTaskProgress(slot0.taskCfg_.id) then
		slot1 = slot2
	end

	slot0.progressLabel_.text = string.format("%d/%d", slot1, slot2)
	slot0.progressSlider_.fillAmount = slot1 / slot2

	if slot0.taskInfo_.complete_flag == 1 then
		slot0.statusController_:SetSelectedState("haveGet")
	elseif slot2 <= slot1 then
		slot0.statusController_:SetSelectedState("canGet")
	else
		slot0.statusController_:SetSelectedState("cannotGet")
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	slot0:RemoveTimer()
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	slot0:RemoveTimer()
	uv0.super.Dispose(slot0)
end

return slot0
