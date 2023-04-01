slot0 = class("GameListener")
slot1 = import("game.tools.SettingTools")
slot2 = import("game.tools.LvTools")

function slot0.StartListen(slot0)
	slot0:AddEventListeners()
	slot0:AddTaskListeners()
end

function slot0.AddEventListeners(slot0)
	manager.notify:RegistListener(PLAYER_LEVEL_UP, handler(slot0, slot0.LevelUp))
end

function slot0.LevelUp(slot0, slot1, slot2)
	slot3 = 0

	PlayerAction.ChangeLevel(slot1, slot2)
	NeedGameUserInfo()
	GameToSDK.UpUserInfo(PlayerTools.PackUserData("LevelUp"))
end

function slot0.AddTaskListeners(slot0)
	if slot0:GetNextTime() ~= 0 then
		if not slot0.timer_ then
			slot0.timer_ = Timer.New(function ()
				if uv0 <= manager.time:GetServerTime() then
					TaskAction:UpdatePassportTaskRedTip()

					uv0 = uv1:GetNextTime()

					if uv0 <= 0 then
						uv1.timer_:Stop()
					end
				end
			end, 1, -1)

			slot0.timer_:Start()
		end
	elseif slot0.timer_ then
		slot0.timer_:Stop()
	end
end

function slot0.GetNextTime(slot0)
	slot2 = manager.time:GetServerTime()
	slot3 = 0
	slot4 = {}

	for slot8, slot9 in ipairs({
		TaskConst.TASK_TYPE.PASSPORT_DAILY,
		TaskConst.TASK_TYPE.PASSPORT_WEEKLY,
		TaskConst.TASK_TYPE.PASSPORT_CHALLENGE
	}) do
		slot13 = slot9

		for slot13, slot14 in ipairs(TaskData:GetTaskIDList(slot13)) do
			if TaskData:GetTask(slot14).expired_timestamp > 0 and slot2 <= slot15.expired_timestamp then
				slot3 = slot3 == 0 and slot15.expired_timestamp or math.min(slot3, slot15.expired_timestamp)
			end
		end
	end

	return slot3
end

function slot0.StopListen(slot0)
	manager.notify:RemoveListener(PLAYER_LEVEL_UP, handler(slot0, slot0.LevelUp))

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
