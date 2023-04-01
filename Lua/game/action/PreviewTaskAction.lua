slot1 = false
slot2 = manager.net

slot2:Bind(28023, function (slot0)
	if uv0 == false then
		uv0 = true

		PreviewTaskAction.InitRedPoint()
	end

	PreviewTaskData:TaskModify(slot0.assignment_list)
	PreviewTaskAction.OnTaskChange()
end)

slot2 = manager.net

slot2:Bind(28021, function (slot0)
	PreviewTaskData:TaskModify(slot0.progress_list)
	PreviewTaskAction.OnTaskChange()
end)

return {
	TryToSubmitTask = function (slot0)
		slot2 = manager.net

		slot2:SendWithLoadingNew(28024, {
			id_list = {
				slot0
			}
		}, 28025, function (slot0)
			PreviewTaskAction.OnTryToSubmitTaskList(slot0, uv0)
		end)
	end,
	TryToSubmitTaskList = function (slot0)
		slot2 = manager.net

		slot2:SendWithLoadingNew(28024, {
			id_list = slot0
		}, 28025, function (slot0)
			PreviewTaskAction.OnTryToSubmitTaskList(slot0, uv0)
		end)
	end,
	OnTryToSubmitTaskList = function (slot0, slot1)
		slot2 = {}

		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)

			return
		end

		for slot6, slot7 in ipairs(slot1.id_list) do
			PreviewTaskData:TaskSubmit({
				{
					vary = 1,
					id = slot7
				}
			})
			table.insertto(slot2, AssignmentCfg[slot7].reward or {})
		end

		if #slot2 > 0 then
			getReward(slot2)
		end

		PreviewTaskAction.OnTaskChange()
	end,
	OnTaskChange = function ()
		manager.notify:CallUpdateFunc(PREVIEW_TASK_LIST_CHANGE)
		PreviewTaskAction.RefreshRedPoint()
	end,
	InitRedPoint = function ()
		slot0 = {}

		for slot5, slot6 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.PREVIEW_TASK]) do
			slot0[#slot0 + 1] = string.format("%s_%s", RedPointConst.PREVIEW_TASK, slot6)
		end

		manager.redPoint:addGroup(RedPointConst.PREVIEW_TASK, slot0)
	end,
	RefreshRedPoint = function ()
		for slot4, slot5 in pairs(PreviewTaskData:GetActivityIDList()) do
			slot6 = 0

			if ActivityData:GetActivityIsOpen(slot4) and AssignmentCfg.get_id_list_by_activity_id[slot4] ~= nil then
				for slot11, slot12 in ipairs(slot7) do
					slot15 = PreviewTaskData:GetTaskComplete(slot12)

					if AssignmentCfg[slot12].need <= PreviewTaskData:GetTaskProgress(slot12) and not slot15 then
						slot6 = 1

						break
					end
				end
			end

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.PREVIEW_TASK, slot4), slot6)
		end
	end
}
