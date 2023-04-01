slot1 = manager.notify

slot1:RegistListener(OSIRIS_TASK_UPDATE, function ()
	uv0.UpdateTaskRedPoint(ActivityConst.ACTIVITY_2_0_SEAL)
end)

slot1 = manager.net

slot1:Bind(64101, function (slot0)
	XH1stSealData:OnServerData(slot0)
end)

return {
	Init = function ()
		uv0.UpdateTaskRedPoint(ActivityConst.ACTIVITY_2_0_SEAL)
	end,
	InitRedPointKey = function (slot0)
		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.XH1ST_SEAL, slot0), {
			RedPointConst.XH1ST_SEAL_TASK
		})
	end,
	UpdateTaskRedPoint = function (slot0)
		slot1 = false

		for slot6, slot7 in ipairs(AssignmentCfg.get_id_list_by_activity_id[slot0]) do
			slot8 = AssignmentCfg[slot7]

			if TaskData:GetActivityTask(slot0, slot7) ~= nil then
				slot10 = slot9.progress

				if not TaskData:GetActivityTaskComplete(slot0, slot7) and slot8.need <= slot10 then
					slot1 = true

					break
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.XH1ST_SEAL_TASK, slot1 and 1 or 0)
	end,
	ResetSeal = function (slot0, slot1)
		manager.net:SendWithLoadingNew(64102, {
			activity_id = slot0,
			ticket_id = slot1
		}, 64103, uv0.OnResetSealCallback)
	end,
	OnResetSealCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			XH1stSealData:ResetTicket()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	RequestSeal = function (slot0, slot1)
		manager.net:SendWithLoadingNew(64112, {
			activity_id = slot0,
			ticket_id = slot1
		}, 64113, uv0.OnRequestSealCallback)
	end,
	OnRequestSealCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item

			MaterialAction.MaterialModify(slot2[1], -1 * slot2[2])
			manager.notify:CallUpdateFunc(XH1ST_ON_SEAL_RESULT, slot0, slot1)
		else
			ShowTips(GetTips(slot0.result))
		end
	end
}
