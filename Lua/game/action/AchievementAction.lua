slot1 = manager.net

slot1:Bind(53001, function (slot0)
	AchievementData:UpdateAchievementList(slot0.achievement_list, true)
	AchievementData:InitAchievementStoryReadList(slot0.story_line)
end)

slot1 = manager.net

slot1:Bind(53003, function (slot0)
	AchievementData:UpdateAchievementList(slot0.achievement_progress, false)
end)

slot1, slot2, slot3, slot4 = nil
slot5 = {}
slot6 = manager.net

slot6:Bind(12089, function (slot0)
	uv0 = slot0.is_first_draw
	uv1 = slot0.is_first_draw_limited
	uv2 = slot0.is_first_draw_lucky
	uv3 = slot0.total_buy_fatigue_times
end)

return {
	GetReceiveReward = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(53004, {
			id = slot0
		}, 53005, function (slot0)
			uv0(slot0)
		end)
	end,
	ReadAchievementStory = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(53006, {
			id = slot0
		}, 53007, function (slot0)
			AchievementData:UpdateStoryRead(uv0)
			uv1(slot0)
		end)
	end,
	SendMessageForDrawAction = function (slot0, slot1)
		if uv0 == 1 then
			uv0 = 0

			SendMessageManagerToSDK("gacha_complete")
		end

		if uv1 == 1 and DrawPoolCfg[slot1.pool].pool_type == 3 then
			uv1 = 0
		end

		slot2 = false

		for slot7, slot8 in ipairs(slot0.item) do
			if ItemCfg[slot8.id].rare == 5 then
				slot2 = true

				SendMessageManagerToSDK("roll_complete_140", {
					poolID = slot1.pool
				})
			end
		end

		if slot2 and uv2 == 1 and DrawPoolCfg[slot1.pool].pool_type == 5 then
			uv2 = 0

			SendMessageManagerToSDK("roll_complete_40")
		end
	end
}
