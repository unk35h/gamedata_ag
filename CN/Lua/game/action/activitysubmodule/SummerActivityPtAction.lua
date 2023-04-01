slot1 = false

return {
	Init = function ()
		SummerActivityPtData:Reset()

		if uv0 then
			return
		end

		slot0 = manager.net

		slot0:Bind(61009, function (slot0)
			SummerActivityPtData:InitWithServer(slot0.pt_challenge_info)
			uv0.UpdateRedPoint(slot0.activity_id)
		end)

		uv0 = true
	end,
	UpdateRedPoint = function (slot0)
		slot1 = RedPointConst.SUMMER_ACTIVITY_PT_OPEN .. "_" .. slot0

		if not ActivityData:GetActivityData(slot0):IsActivitying() then
			manager.redPoint:setTip(slot1, 0)

			return
		end

		if ActivityData:GetActivityData(slot0) ~= nil and slot2.startTime <= manager.time:GetServerTime() and manager.time:GetServerTime() <= slot2.stopTime then
			if not getData("activity_pt_" .. slot0, "opened") then
				manager.redPoint:setTip(slot1, 1)
			else
				manager.redPoint:setTip(slot1, 0)
			end
		else
			manager.redPoint:setTip(slot1, 0)
		end
	end
}
