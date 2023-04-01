slot1 = false
slot2 = manager.net

slot2:Bind(64111, function (slot0)
	ActivityPt2Data:SetHardScore(slot0)
end)

return {
	Init = function ()
		ActivityPt2Data:Init()

		if uv0 then
			return
		end

		slot0 = manager.net

		slot0:Bind(64105, function (slot0)
			ActivityPt2Data:SetNormalData(slot0)
			ActivityPt2Action:RefreshRedPoint(slot0.activity_id)
		end)

		slot0 = manager.net

		slot0:Bind(64107, function (slot0)
			ActivityPt2Data:SetChallengeData(slot0)
			ActivityPt2Action:RefreshRedPoint(slot0.activity_id)
		end)

		slot0 = manager.net

		slot0:Bind(64109, function (slot0)
			ActivityPt2Data:SetHardData(slot0)
			ActivityPt2Action:RefreshRedPoint(slot0.activity_id)
		end)

		uv0 = true
	end,
	InitRedPointKey = function (slot0)
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_PT_2 .. "_" .. slot0, {
			RedPointConst.ACTIVITY_PT_2_OPEN .. "_" .. slot0,
			RedPointConst.ACTIVITY_TASK .. "_" .. ActivityPt2Tools:GetTaskActivityID(slot0)
		})
	end,
	RefreshRedPoint = function (slot0, slot1)
		slot2 = nil

		for slot7, slot8 in ipairs(ActivityCfg.get_id_list_by_activity_theme[ActivityCfg[slot1].activity_theme]) do
			if ActivityCfg[slot8].activity_template == ActivityTemplateConst.ACTIVITY_PT_2 then
				slot2 = slot8

				break
			end
		end

		if manager.redPoint:getTipValue(RedPointConst.ACTIVITY_PT_2 .. "_" .. slot2) == 1 then
			return
		end

		slot4 = true

		if ActivityCfg[slot1].activity_template == ActivityTemplateConst.ACTIVITY_PT_2_NORMAL then
			slot5 = ActivityPt2Data:GetNormalDataList(slot1) or {}

			for slot9, slot10 in pairs(slot5) do
				if slot10.clear_time > 0 then
					slot4 = false

					break
				end
			end
		elseif ActivityCfg[slot1].activity_template == ActivityTemplateConst.ACTIVITY_PT_2_CHALLENGE then
			slot5 = ActivityPt2Data:GetChallengeDataList(slot1) or {}

			for slot9, slot10 in pairs(slot5) do
				if slot10.clear_time > 0 then
					slot4 = false

					break
				end
			end
		elseif ActivityPt2Data:GetHardData(slot1) and slot5.clear_time > 0 then
			slot4 = false
		end

		if not ActivityTools.IsUnlockActivity(slot2) then
			slot4 = false
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_2_OPEN .. "_" .. slot2, slot4 and 1 or 0)
	end
}
