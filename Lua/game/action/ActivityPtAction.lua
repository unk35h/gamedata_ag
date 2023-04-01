slot1 = manager.net

slot1:Bind(28019, function (slot0)
	ActivityPtData:TaskDailyGetRewardInit(slot0.pt_list)
	ActivityPtAction:UpdateActivityPt()
end)

return {
	TaskDailyGetReward = function (slot0, slot1, slot2)
		slot3 = ActivityPtCfg[slot2].reward[slot1]
		slot4 = ActivityPtData
		slot5 = manager.net

		slot5:SendWithLoadingNew(28016, {
			need_active_point = slot4:GetGiftPt(slot2, slot1),
			activity_pt_id = slot2
		}, 28017, function (slot0)
			if isSuccess(slot0.result) then
				ActivityPtData:TaskDailySubmit({
					activityID = uv0,
					activityPt = uv1
				})
				uv2:UpdateActivityPt()
				getReward(uv3)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ActivityPtModify = function (slot0, slot1, slot2)
		ActivityPtData:ActivityPtModify(slot1, slot2)
		slot0:UpdateActivityPt()
	end,
	UpdateActivityPt = function (slot0)
		TaskAction:UpdateDailyTaskRedTip()
		TaskAction:UpdateWeekTaskRedTip()
		MoonBoData:FreshCanGetCount()
		manager.notify:CallUpdateFunc(ACTIVITY_PT_UPDATE)
	end
}
