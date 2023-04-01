slot0 = class("ActivityNewbieDailyItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.buttonReceive_.transform, "stage")
	slot0.lockTroller_ = ControllerUtil.GetController(slot0.transform_, "conName")
	slot0.countDownController_ = ControllerUtil.GetController(slot0.transform_, "countDown")
	slot0.parentWidth_ = slot0.transformParent_.rect.width / 2
	slot0.itemWidth_ = slot0.transform_.rect.width / 2
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.rewardItem_ then
		slot0.rewardItem_:Dispose()

		slot0.rewardItem_ = nil
	end

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RegistListener(slot0, slot1)
	slot0.func_ = slot1
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonReceive_, nil, function ()
		slot1 = AssignmentCfg[uv0.taskID_]

		if TaskData:GetNewbieDailyTask()[uv0.taskID_] then
			if slot0.complete_flag >= 1 then
				return
			elseif slot0.progress < slot1.need then
				JumpTools.JumpToPage2(slot1.source)
			else
				TaskAction.SubmitTask(uv0.taskID_, function (slot0)
					if isSuccess(slot0.result) then
						getReward(AssignmentCfg[uv0.taskID_].reward)
						TaskData:NewbieDailyTaskSubmit(uv0.taskID_)
						uv0.controller_:SetSelectedState("2")

						if uv0.func_ then
							uv0.func_()
						end
					else
						ShowTips(slot0.result)
					end
				end)
			end
		end
	end)
end

function slot0.RefreshCountDown(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot3 = TaskData:GetNewbieDailyTask()[AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER][slot0.index_ - 1]]

	if not TaskData:GetNewbieDailyTask()[slot0.taskID_] and slot3 and slot3.complete_flag == 1 then
		slot0.countdownText_.text = string.format(GetTips("TIME_DISPLAY_1"), tostring(manager.time:DescCDTime(manager.time:GetNextFreshTime() - manager.time:GetServerTime())))

		slot0.countDownController_:SetSelectedState("true")

		slot0.timer_ = Timer.New(function ()
			slot0 = manager.time:GetNextFreshTime() - manager.time:GetServerTime()
			uv0.countdownText_.text = string.format(GetTips("TIME_DISPLAY_1"), tostring(manager.time:DescCDTime(slot0)))

			if slot0 <= 0 then
				uv0:RefreshUI(uv0.index_)
				uv0.timer_:Stop()

				uv0.timer_ = nil
			end
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.countDownController_:SetSelectedState("false")
	end
end

function slot0.RefreshUI(slot0, slot1)
	slot0.index_ = slot1

	if slot1 < 10 then
		slot0.textDay_.text = string.format("0<color=#3D3D3D>%s</color>", slot1)
	else
		slot0.textDay_.text = string.format("<color=#3D3D3D>%s</color>", slot1)
	end

	slot3 = AssignmentCfg[AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER][slot1]]

	if slot0.rewardItem_ == nil then
		slot0.rewardItem_ = RewardPoolItem.New(slot0.itemParent_, slot3.reward[1])
	end

	if slot0.taskID_ ~= slot2 then
		slot0.rewardItem_:SetData(slot3.reward[1])
	end

	slot0.taskID_ = slot2
	slot4 = slot3.desc
	slot5 = nil
	slot6 = 0

	if TaskData:GetNewbieDailyTask()[slot2] then
		if slot3.need < slot7.progress then
			slot6 = slot3.need
		end

		if slot7.complete_flag == 0 then
			if slot3.need <= slot6 then
				slot0.controller_:SetSelectedState("1")
			else
				slot0.controller_:SetSelectedState("0")
			end
		else
			slot0.controller_:SetSelectedState("2")

			slot6 = slot3.need
		end

		slot5 = string.format("%s/%s", slot6, slot3.need)

		slot0.lockTroller_:SetSelectedState("0")
	else
		slot0.controller_:SetSelectedState("0")
		slot0.lockTroller_:SetSelectedState("1")

		slot4 = ""
		slot5 = ""
	end

	slot0.textDesc_.text = slot4
	slot0.textProgress_.text = slot5

	slot0:RefreshCountDown()
end

function slot0.RefreshAlpha(slot0)
	slot0.canvasGroup_.alpha = 1 - math.abs(slot0.parentWidth_ - slot0.transformParent_:InverseTransformPoint(slot0.transform_:TransformPoint(Vector3.zero)).x - slot0.itemWidth_) / slot0.parentWidth_ * 0.5
end

return slot0
