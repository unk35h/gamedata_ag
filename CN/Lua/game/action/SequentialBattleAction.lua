slot1 = manager.net

slot1:Bind(61071, function (slot0)
	SequentialBattleData:InitData(slot0)
	uv0.UpdateRedPoint(slot0.activity_id)
end)

slot1 = manager.notify

slot1:RegistListener(ZERO_REFRESH, function ()
	for slot3, slot4 in pairs(uv0.refreshActivityIDList_) do
		uv0.UpdateRedPoint(slot4)
	end
end)

return {
	SaveTeam = function (slot0, slot1, slot2, slot3)
		for slot7 = 1, #SequentialBattleChapterCfg[slot0].stage_id do
			if slot7 ~= slot1 then
				slot8 = false
				slot13 = slot7

				for slot13, slot14 in ipairs(SequentialBattleData:GetHeroTeam(slot0, slot13)) do
					if table.keyof(slot2, slot14.heroID) then
						slot14.heroID = 0
						slot14.trialID = 0
						slot8 = true
					end
				end

				if slot8 then
					slot13 = slot0

					SequentialBattleData:SetComboSkillID(slot13, slot7, 0, true)

					for slot13 = 3, 1, -1 do
						if slot9[slot13] and (slot9[slot13].heroID == nil or slot9[slot13].heroID == 0) then
							table.remove(slot9, slot13)
						end
					end
				end
			end
		end

		SequentialBattleData:SaveHeroTeam(slot0, slot1, slot2, slot3)

		slot7 = slot0

		SequentialBattleData:SetComboSkillID(slot7, slot1, 0, true)

		for slot7 = 1, #SequentialBattleChapterCfg[slot0].stage_id do
			uv0.SaveEnabledBuff(slot0, slot7)
		end

		SequentialBattleData:SaveLocalAllTeam(slot0)
	end,
	SaveEnabledBuff = function (slot0, slot1)
		for slot5 = 1, #SequentialBattleChapterCfg[slot0].stage_id do
			uv0.RefreshEnabeldBuff(slot0, slot1)
		end
	end,
	RefreshEnabeldBuff = function (slot0, slot1)
		slot4 = SequentialBattleBuffCfg.get_id_list_by_activity_id[SequentialBattleChapterCfg[slot0].main_id]
		slot5 = {}

		for slot9, slot10 in pairs(SequentialBattleData:GetChapterData(slot0).team[slot1].heroList) do
			if slot10.heroID and slot10.heroID ~= 0 then
				table.insert(slot5, slot10.heroID)
			end
		end

		slot6 = {}

		for slot10, slot11 in ipairs(slot4) do
			slot12 = SequentialBattleBuffCfg[slot11].type
			slot13 = SequentialBattleTools.GetConditionStatus(slot5, slot12)
			slot14 = true

			for slot18, slot19 in ipairs(slot12) do
				if slot13[slot18] < slot19[3] then
					slot14 = false

					break
				end
			end

			if slot14 then
				table.insert(slot6, slot11)
			end
		end

		slot2.enabledBuff = slot6
	end,
	SaveAllTeam = function (slot0, slot1)
		slot2 = {}
		slot4 = SequentialBattleChapterCfg[slot0]

		for slot8, slot9 in pairs(SequentialBattleData:GetHeroTeamData(slot0)) do
			slot2[slot8] = {
				id = slot4.stage_id[slot8],
				ai_chip_list = {},
				hero_list = {}
			}

			for slot13, slot14 in ipairs(slot9.heroList) do
				if slot14.heroID and slot14.heroID ~= 0 then
					slot15 = slot14.heroID
					slot16 = 1

					if slot14.trialID ~= 0 then
						slot15 = slot14.trialID
						slot16 = 2
					end

					slot2[slot8].hero_list[slot13] = {
						owner_id = 0,
						hero_id = slot15,
						hero_type = slot16
					}
				end
			end

			slot2[slot8].cooperate_unique_skill_id = slot9.comboSkillID
			slot2[slot8].ai_chip_list = {}

			if slot9.chipID then
				table.insert(slot2[slot8].ai_chip_list, slot9.chipID)
			end
		end

		slot6 = manager.net

		slot6:SendWithLoadingNew(63000, {
			teams_info_list = {
				stage_type = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
				activity_id = slot0,
				teams = slot2
			}
		}, 63001, function (slot0)
			uv0(slot0)
		end)
	end,
	ResetTeam = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(63002, {
			stage_type = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE
		}, 63003, function (slot0)
			uv0(slot0)
		end)
	end,
	ReceiveReward = function (slot0, slot1, slot2)
		slot3 = manager.net

		slot3:SendWithLoadingNew(61072, {
			activty_id = slot0,
			award_id = slot1
		}, 61073, function (slot0)
			uv0(slot0)
		end)
	end,
	initActivityIDList_ = {},
	refreshActivityIDList_ = {},
	InitRedPoint = function (slot0)
		if table.keyof(uv0.initActivityIDList_, slot0) then
			return
		end

		table.insert(uv0.initActivityIDList_, slot0)

		slot1 = {}

		for slot5, slot6 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			slot7 = string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE, slot6)

			manager.redPoint:addGroup(slot7, {
				string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, slot6),
				string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, slot6)
			})
			table.insert(slot1, slot7)
		end

		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE, slot0), slot1)
	end,
	UpdateRedPoint = function (slot0)
		uv0.InitRedPoint(SequentialBattleChapterCfg[slot0].main_id)

		if table.keyof(uv0.refreshActivityIDList_, slot0) == nil then
			table.insert(uv0.refreshActivityIDList_, slot0)
		end

		if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0).stopTime and slot3 > (getData("sequentialBattle", "activityID_" .. slot0) or 0) and #SequentialBattleData:GetChapterData(slot0).historyFinishStage < #SequentialBattleChapterCfg[slot0].stage_id then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, slot0), 1)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, slot0), 0)
		end
	end,
	StopRedPoint = function (slot0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, slot0), 0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, slot0), 0)
	end,
	ClickDayRedPoint = function (slot0)
		if manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_DAY, slot0)) ~= 0 then
			manager.redPoint:setTip(slot1, 0)
			saveData("sequentialBattle", "activityID_" .. slot0, _G.gameTimer:GetNextDayFreshTime())
		end
	end,
	ResetData = function (slot0)
		uv0.initActivityIDList_ = {}
		uv0.refreshActivityIDList_ = {}
	end
}
