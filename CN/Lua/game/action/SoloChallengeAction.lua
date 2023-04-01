slot1 = manager.net

slot1:Bind(60031, function (slot0)
	SoloChallengeData:SetData(slot0)
end)

return {
	SaveCustomList = function (slot0, slot1)
		slot2 = SoloChallengeData
		slot3 = manager.net

		slot3:SendWithLoadingNew(60032, slot2:GetActivityTeamData(slot0), 60033, function (slot0)
			if isSuccess(slot0.result) then
				SoloChallengeData:SaveLocalCustomList(uv0)

				if uv1 ~= nil then
					uv1(slot0, uv0)
				end
			else
				ShowTips(slot0.result)
				SoloChallengeData:RevertTeamData(uv0)
				manager.notify:CallUpdateFunc(SOLO_CHALLENGE_REVERT_TEAM_DATA)
			end
		end)
	end,
	RequireReceive = function (slot0, slot1, slot2)
		slot4 = manager.net

		slot4:SendWithLoadingNew(60034, {
			activity_id = slot0,
			difficult = slot1
		}, 60035, function (slot0)
			uv0(slot0)
		end)
	end,
	SaveDifficulty = function (slot0, slot1, slot2)
		slot4 = manager.net

		slot4:SendWithLoadingNew(60038, {
			activity_id = slot0,
			difficult = slot1
		}, 60039, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 ~= nil then
					uv0(slot0, uv1)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ResetData = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(60036, {
			activity_id = slot0
		}, 60037, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 ~= nil then
					uv0(slot0, uv1)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	InitRedPoint = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(ActivityCfg[slot0].sub_activity_list) do
			table.insert(slot1, string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, slot0, slot6))
		end

		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.SOLO_CHALLENGE, slot0), slot1)
	end
}
