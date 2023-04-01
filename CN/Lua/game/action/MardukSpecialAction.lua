slot1 = manager.net

slot1:Bind(64001, function (slot0)
	MardukSpecialData:InitDataFromServer(slot0)
	uv0.UpdateNotFightRedPoint(slot0.activity_id)
end)

slot1 = manager.notify

slot1:RegistListener(ACTIVITY_REWARD_GET, function (slot0)
	MardukSpecialData:OnGotReward(slot0.point_reward_id_list)
end)

return {
	Init = function (slot0)
	end,
	UpdateRedPoint = function (slot0)
		slot1 = false

		for slot6, slot7 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			slot8 = MardukSpecialData:GetPoint(slot7)
			slot9 = nil

			for slot13, slot14 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot7]) do
				slot16 = MardukSpecialData:HaveGotReward(slot7, slot14)

				if ActivityPointRewardCfg[slot14].need <= slot8 and not slot16 then
					slot1 = true
					slot9 = true

					break
				end
			end

			if slot9 then
				break
			end
		end

		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.FACTORY_MARDUK), slot1 and 1 or 0)
	end,
	UpdateNotFightRedPoint = function (slot0)
		slot2 = true

		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, slot0), (MardukSpecialData:GetPoint(slot0) <= 0 or false) and (not getData(tostring(slot0), "nextTime") or manager.time:GetServerTime() >= slot4) and 1 or 0)
	end,
	ClickMardukSpecial = function (slot0)
		saveData(tostring(slot0), "nextTime", _G.gameTimer:GetNextDayFreshTime())
		uv0.UpdateNotFightRedPoint(slot0)
	end
}
