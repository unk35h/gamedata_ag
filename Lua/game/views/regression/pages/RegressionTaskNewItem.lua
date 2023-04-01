slot1 = class("RegressionTaskNewItem", import("game.views.task.daily.TaskDailyItemView"))

function slot1.RefreshUI(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]
	slot0.titleText_.text = slot1.desc
	slot2 = slot1.reward or {}

	for slot6, slot7 in ipairs(slot2) do
		if slot0.rewardItems_[slot6] == nil then
			slot0.rewardItems_[slot6] = CultivateHeroPoolRewardItem.New(slot0.goRewardPanel_, slot0.rewardGo_, slot7, true)
			slot8 = slot0.rewardItems_[slot6].commonItem_

			slot8:RegistCallBack(function ()
				OperationRecorder.Record("task", "task_item")
			end)
		end

		slot0.rewardItems_[slot6]:SetData(slot7, false)
	end

	for slot6 = #slot1.reward + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot6]:Show(false)
	end
end

function slot1.RefreshProgress(slot0)
	slot2 = slot0.taskProgress

	if AssignmentCfg[slot0.taskID_].need < slot0.taskProgress then
		slot2 = slot1.need
	end

	slot0.progressBar_.value = slot2 / slot1.need
	slot0.progressText_.text = string.format("%s/%s", slot2, slot1.need)
	slot3 = slot1.need <= slot0.taskProgress

	if slot0.taskComplete_ then
		slot0.controller_:SetSelectedState("2")
	elseif slot3 then
		slot0.controller_:SetSelectedState("1")
	else
		slot0.controller_:SetSelectedState("0")
	end
end

return slot1
