slot1 = manager.net

slot1:Bind(64061, function (slot0)
	SpringFestivalRiddleData:InitData(slot0)
	uv0.InitRedPoint(slot0.activity_id)
end)

slot1 = nil

return {
	ChoiceAnswer = function (slot0, slot1, slot2, slot3)
		slot4 = manager.net

		slot4:SendWithLoadingNew(64062, {
			activity_id = slot0,
			quiz_id = slot1,
			answer = slot2
		}, 64063, function (slot0)
			if isSuccess(slot0.result) then
				-- Nothing
			end

			uv0(slot0)
		end)
	end,
	InitRedPoint = function (slot0)
		uv0.StopTimer()

		if ActivityData:GetActivityIsOpen(slot0) then
			slot3 = SpringFestivalRiddleData:GetLastAnswerTime(slot0) + GameSetting.activity_spring_festival_riddle_punish_time.value[1] * 60
			slot5 = manager.time:GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0)

			if SpringFestivalRiddleData:CanAnswer(slot0) then
				slot6 = manager.time:GetServerTime()

				if ActivityData:GetActivityIsOpen(slot0) and (slot3 <= slot6 or slot5 - slot2 > 86400) then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_RIDDLE, slot0), 1)

					return
				end

				uv1 = Timer.New(function ()
					uv0 = manager.time:GetNextTime(uv1, 0, 0)

					if ActivityData:GetActivityIsOpen(uv2) and (uv3 <= manager.time:GetServerTime() or uv0 - uv4 > 86400) then
						manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_RIDDLE, uv2), 1)
						uv5.StopTimer()

						return
					end
				end, 1, -1)

				uv1:Start()
			else
				uv1 = Timer.New(function ()
					uv0 = manager.time:GetNextTime(uv1, 0, 0)

					if ActivityData:GetActivityIsOpen(uv2) and uv0 - uv3 > 86400 then
						manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_RIDDLE, uv2), 1)
						uv4.StopTimer()

						return
					end
				end, 1, -1)

				uv1:Start()
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_RIDDLE, slot0), 0)
	end,
	HideRedPoint = function (slot0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_RIDDLE, slot0), 0)
	end,
	RefreshRedPoint = function (slot0)
		uv0.InitRedPoint(slot0)
	end,
	StopTimer = function ()
		if uv0 then
			uv0:Stop()

			uv0 = nil
		end
	end,
	Dispose = function ()
		uv0.StopTimer()
	end
}
