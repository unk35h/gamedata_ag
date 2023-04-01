require("game.data.BattleTeamDataTemplate")

slot0 = singletonClass("BattleTeamData")

function slot0.Init(slot0)
	slot0.battleTeam_ = {}
	slot0.stageTeam_ = {}
	slot0.stageTeamTrial_ = {}
	slot0.trialActivityData_ = {}
	slot0.teamRawData_ = {}
	slot0.reservesTeamList_ = {}
	slot0.reservesTempTeamList_ = {}
end

function slot0.InitTeam(slot0, slot1)
	slot5 = slot1
	slot0.teamRawData_ = slot0:CreateTeamRawData(slot5)

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot6.stage_type
		slot0.battleTeam_[slot7] = slot0.battleTeam_[slot7] or {}
		slot0.battleTeam_[slot7][GetHeroTeamActivityID(slot7, slot6.activity_id or 0)] = {}
		slot10 = {}
		slot11 = ipairs
		slot13 = slot6.cont_teams or {}

		for slot14, slot15 in slot11(slot13) do
			slot16 = {
				teams = {},
				cont_id = slot15.cont_id
			}
			slot17 = cleanProtoTable(slot15.teams)
			slot18 = ipairs
			slot20 = slot15.teams or {}

			for slot21, slot22 in slot18(slot20) do
				slot23 = {
					id = slot22.id,
					result = slot22.result
				}
				slot24 = {}
				slot25 = {}
				slot26 = {}
				slot27 = ipairs
				slot29 = slot22.hero_list or {}

				for slot30, slot31 in slot27(slot29) do
					if slot31.hero_type == 1 or slot31.hero_id == 0 then
						slot24[slot30] = slot31.hero_id
						slot25[slot30] = 0
						slot26[slot30] = {
							hero_id = 0,
							owner_id = 0
						}
					elseif slot31.hero_type == 2 then
						slot24[slot30] = HeroStandardSystemCfg[slot31.hero_id].hero_id
						slot25[slot30] = slot31.hero_id
						slot26[slot30] = {
							hero_id = 0,
							owner_id = 0
						}
					else
						slot24[slot30] = 0
						slot25[slot30] = 0
						slot26[slot30] = {
							hero_id = slot31.hero_id,
							owner_id = tonumber(slot31.owner_id)
						}
					end
				end

				for slot30 = 1, 3 do
					slot24[slot30] = slot24[slot30] or 0
					slot25[slot30] = slot25[slot30] or 0
					slot26[slot30] = slot26[slot30] or {
						hero_id = 0,
						owner_id = 0
					}
				end

				slot23.singleTeam = slot24
				slot23.heroTrialList = slot25
				slot23.heroAssistList = slot26
				slot23.combo = slot22.cooperate_unique_skill_id
				slot23.mimir = {
					id = slot22.mimir_info.mimir_id,
					chip = cleanProtoTable(slot22.mimir_info.chip_list or {})
				}

				table.insert(slot16.teams, slot23)
			end

			table.insert(slot10, slot16)
		end

		slot11 = {
			chess_data_info_1 = {},
			chess_data_info_2 = {}
		}

		for slot15, slot16 in ipairs(slot6.data.chess_data_info_1) do
			table.insert(slot11.chess_data_info_1, {
				cont_id = slot16.cont_id,
				chess_pos = cleanProtoTable(slot16.chess_pos)
			})
		end

		for slot15, slot16 in ipairs(slot6.data.chess_data_info_2) do
			table.insert(slot11.chess_data_info_2, {
				cont_id = slot16.cont_id,
				team_id = slot16.team_id,
				chess_ai_chip_list = cleanProtoTable(slot16.chess_ai_chip_list)
			})
		end

		slot0.battleTeam_[slot7][slot9].cont_teams = slot10
		slot0.battleTeam_[slot7][slot9].data = slot11
	end
end

function slot0.CreateTeamRawData(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot2[slot7.stage_type] = {}
		slot8 = {}

		if slot7.cont_teams[1] and slot7.cont_teams[1].teams[1] then
			slot8 = slot7.cont_teams[1].teams[1].hero_list or {}
		end

		for slot12, slot13 in ipairs(slot8) do
			table.insert(slot2[slot7.stage_type], {
				hero_id = slot13.hero_id,
				owner_id = slot13.owner_id,
				hero_type = slot13.hero_type
			})
		end
	end

	return slot2
end

function slot0.InitReservesTeam(slot0, slot1)
	slot2 = slot1.formation_list or {}

	for slot6 = 1, 10 do
		slot0.reservesTeamList_[slot6] = {
			comboSkill = 0,
			name = "",
			index = slot6,
			hero_list = {
				0,
				0,
				0
			},
			chipInfo = {
				id = 0,
				list = {}
			}
		}
	end

	slot3 = ipairs
	slot5 = slot2 or {}

	for slot6, slot7 in slot3(slot5) do
		slot8 = slot7.id
		slot9 = {
			0,
			0,
			0
		}
		slot10 = ipairs
		slot12 = slot7.hero_list or {}

		for slot13, slot14 in slot10(slot12) do
			slot9[slot13] = slot14
		end

		slot10 = {}
		slot12 = ipairs
		slot14 = (slot7.mimir_info[1] or {}).chip_list or {}

		for slot15, slot16 in slot12(slot14) do
			table.insert(slot10, slot16)
		end

		slot0.reservesTeamList_[slot8] = {
			index = slot8,
			name = slot7.name,
			hero_list = slot9,
			comboSkill = slot7.cooperate_unique_skill_id or 0,
			chipInfo = {
				id = slot11.mimir_id or 0,
				list = slot10 or {}
			}
		}
	end
end

function slot0.SetStageTeam(slot0, slot1, slot2, slot3)
	slot0.stageTeam_[slot1] = slot2
	slot0.stageTeamTrial_[slot1] = slot3
end

function slot0.GetStageTeam(slot0, slot1)
	return clone(slot0.stageTeam_[slot1]), clone(slot0.stageTeamTrial_[slot1])
end

function slot0.SetSingleTeam(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot9 = GetHeroTeamActivityID(slot1, slot2)
	slot10 = slot5 or BattleTeamData:GetComboInfo(slot1, slot2, slot7, slot8)
	slot11 = {}

	if not slot6 then
		slot11.id, slot11.chip = BattleTeamData:GetMimirInfo(slot1, slot2, slot7, slot8)
	else
		slot11.id = slot6.id or 0
		slot11.chip = slot6.chip or {}
	end

	slot0:CreatBaseTeamInfo(slot1, slot9, slot7, slot8)

	slot12 = {}

	if not slot7 or slot7 == 0 then
		if not slot8 then
			slot12 = slot0.battleTeam_[slot1][slot9].cont_teams[1].teams[1]
		else
			for slot16, slot17 in ipairs(slot0.battleTeam_[slot1][slot9].cont_teams[1].teams) do
				if slot17.id == slot8 then
					slot12 = slot17

					break
				end
			end
		end
	else
		for slot16, slot17 in ipairs(slot0.battleTeam_[slot1][slot9].cont_teams) do
			if slot17.cont_id == slot7 then
				if not slot8 then
					slot12 = slot17.teams[1]

					break
				end

				for slot21, slot22 in ipairs(slot17.teams) do
					if slot22.id == slot8 then
						slot12 = slot22

						break
					end
				end

				break
			end
		end
	end

	slot12.singleTeam = deepClone(slot3)
	slot12.heroTrialList = deepClone(slot4)
	slot12.combo = slot10
	slot12.mimir = slot11
end

function slot0.CreatBaseTeamInfo(slot0, slot1, slot2, slot3, slot4)
	slot5 = GetHeroTeamActivityID(slot1, slot2)
	slot0.battleTeam_[slot1] = slot0.battleTeam_[slot1] or {}
	slot0.battleTeam_[slot1][slot5] = slot0.battleTeam_[slot1][slot5] or {}
	slot0.battleTeam_[slot1][slot5].cont_teams = slot0.battleTeam_[slot1][slot5].cont_teams or {}

	if slot0.battleTeam_[slot1][slot5] and not slot3 and not slot4 and #slot0.battleTeam_[slot1][slot5].cont_teams > 0 then
		return
	end

	slot6 = nil

	if slot3 then
		for slot10, slot11 in ipairs(slot0.battleTeam_[slot1][slot5].cont_teams) do
			if slot11.cont_id == slot3 then
				slot6 = slot11
			end
		end
	else
		slot6 = slot0.battleTeam_[slot1][slot5].cont_teams[1]
	end

	slot6 = slot6 or {
		teams = {},
		cont_id = slot3
	}
	slot7 = nil

	if slot4 then
		for slot11, slot12 in ipairs(slot6.teams) do
			if slot12.id == slot4 then
				return
			end
		end
	else
		slot7 = slot6.teams[1]
	end

	table.insert(slot6.teams, slot7 or {
		combo = 0,
		id = slot4,
		singleTeam = {
			0,
			0,
			0
		},
		heroTrialList = {
			0,
			0,
			0
		},
		heroAssistList = {
			{
				hero_id = 0,
				owner_id = 0
			},
			{
				hero_id = 0,
				owner_id = 0
			},
			{
				hero_id = 0,
				owner_id = 0
			}
		},
		mimir = {
			id = 0,
			chip = {}
		}
	})
	table.insert(slot0.battleTeam_[slot1][slot5].cont_teams, slot6)

	slot8 = {
		chess_data_info_1 = {},
		chess_data_info_2 = {}
	}
	slot0.battleTeam_[slot1][slot5].data = slot0.battleTeam_[slot1][slot5].data or tempData
end

function slot0.GetSingleTeam(slot0, slot1, slot2, slot3, slot4)
	slot0:CreatBaseTeamInfo(slot1, GetHeroTeamActivityID(slot1, slot2), slot3, slot4)

	if not slot3 or slot3 == 0 then
		if not slot4 then
			return clone(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams[1].singleTeam or {
				0,
				0,
				0
			}), clone(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams[1].heroTrialList or {
				0,
				0,
				0
			})
		else
			for slot9, slot10 in ipairs(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams) do
				if slot10.id == slot4 then
					return clone(slot10.singleTeam or {
						0,
						0,
						0
					}), clone(slot10.heroTrialList or {
						0,
						0,
						0
					})
				end
			end
		end
	else
		for slot9, slot10 in ipairs(slot0.battleTeam_[slot1][slot5].cont_teams) do
			if slot10.cont_id == slot3 then
				if not slot4 then
					return clone(slot10.teams[1].singleTeam or {
						0,
						0,
						0
					}), clone(slot10.teams[1].heroTrialList or {
						0,
						0,
						0
					})
				else
					for slot14, slot15 in ipairs(slot10.teams) do
						if slot15.id == slot4 then
							return clone(slot15.singleTeam or {
								0,
								0,
								0
							}), clone(slot15.heroTrialList or {
								0,
								0,
								0
							})
						end
					end
				end
			end
		end
	end

	return {
		0,
		0,
		0
	}, {
		0,
		0,
		0
	}
end

function slot0.GetMultiTeam(slot0, slot1, slot2)
	slot3 = GetHeroTeamActivityID(slot1, slot2)

	slot0:CreatBaseTeamInfo(slot1, slot3)

	return slot0.battleTeam_[slot1][slot3]
end

function slot0.GetMimirInfo(slot0, slot1, slot2, slot3, slot4)
	slot0:CreatBaseTeamInfo(slot1, GetHeroTeamActivityID(slot1, slot2), slot3, slot4)

	if not slot3 or slot3 == 0 then
		if not slot4 then
			return clone(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams[1].mimir.id or 0), clone(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams[1].mimir.chip or {})
		else
			for slot9, slot10 in ipairs(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams) do
				if slot10.id == slot4 then
					return clone(slot10.mimir.id or 0), clone(slot10.mimir.chip or {})
				end
			end
		end
	else
		for slot9, slot10 in ipairs(slot0.battleTeam_[slot1][slot5].cont_teams) do
			if slot10.cont_id == slot3 then
				if not slot4 then
					return clone(slot10.teams[1].mimir.id or 0), clone(slot10.teams[1].mimir.chip or {})
				else
					for slot14, slot15 in ipairs(slot10.teams) do
						if slot15.id == slot4 then
							return clone(slot15.mimir.id or 0), clone(slot15.mimir.chip or {})
						end
					end
				end
			end
		end
	end

	return 0, {}
end

function slot0.GetMimirIDInfo(slot0, slot1, slot2, slot3, slot4)
	slot0:CreatBaseTeamInfo(slot1, GetHeroTeamActivityID(slot1, slot2), slot3, slot4)

	if not slot3 or slot3 == 0 then
		if not slot4 then
			return clone(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams[1].mimir.id or 0)
		else
			for slot9, slot10 in ipairs(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams) do
				if slot10.id == slot4 then
					return clone(slot10.mimir.id or 0)
				end
			end
		end
	else
		for slot9, slot10 in ipairs(slot0.battleTeam_[slot1][slot5].cont_teams) do
			if slot10.cont_id == slot3 then
				if not slot4 then
					return clone(slot10.teams[1].mimir.id or 0)
				else
					for slot14, slot15 in ipairs(slot10.teams) do
						if slot15.id == slot4 then
							return clone(slot15.mimir.id or 0)
						end
					end
				end
			end
		end
	end

	return 0
end

function slot0.GetMimirChipInfo(slot0, slot1, slot2, slot3, slot4)
	slot0:CreatBaseTeamInfo(slot1, GetHeroTeamActivityID(slot1, slot2), slot3, slot4)

	if not slot3 or slot3 == 0 then
		if not slot4 then
			return clone(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams[1].mimir.chip or {})
		else
			for slot9, slot10 in ipairs(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams) do
				if slot10.id == slot4 then
					return clone(slot10.mimir.chip or {})
				end
			end
		end
	else
		for slot9, slot10 in ipairs(slot0.battleTeam_[slot1][slot5].cont_teams) do
			if slot10.cont_id == slot3 then
				if not slot4 then
					return clone(slot10.teams[1].mimir.chip or {})
				else
					for slot14, slot15 in ipairs(slot10.teams) do
						if slot15.id == slot4 then
							return clone(slot15.mimir.chip or {})
						end
					end
				end
			end
		end
	end

	return {}
end

function slot0.SetMimirIDInfo(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:CreatBaseTeamInfo(slot1, GetHeroTeamActivityID(slot1, slot2), slot4, slot5)

	slot7 = nil

	if not slot4 or slot4 == 0 then
		if not slot5 then
			slot7 = slot0.battleTeam_[slot1][slot6].cont_teams[1].teams[1].mimir
		else
			for slot11, slot12 in ipairs(slot0.battleTeam_[slot1][slot6].cont_teams[1].teams) do
				if slot12.id == slot5 then
					slot7 = slot12.mimir

					break
				end
			end
		end
	else
		for slot11, slot12 in ipairs(slot0.battleTeam_[slot1][slot6].cont_teams) do
			if slot12.cont_id == slot4 then
				if not slot5 then
					slot7 = slot12.teams[1].mimir

					break
				end

				for slot16, slot17 in ipairs(slot12.teams) do
					if slot17.id == slot5 then
						slot7 = slot17.mimir

						break
					end
				end

				break
			end
		end
	end

	if slot7 then
		slot7.id = slot3 or 0

		if not slot7 or slot3 == 0 then
			slot7.chip = {}
		end
	end
end

function slot0.SetMimirChipInfo(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:CreatBaseTeamInfo(slot1, GetHeroTeamActivityID(slot1, slot2), slot4, slot5)

	if not slot4 or slot4 == 0 then
		if not slot5 then
			slot0.battleTeam_[slot1][slot6].cont_teams[1].teams[1].mimir.chip = clone(slot3 or {})
		else
			for slot10, slot11 in ipairs(slot0.battleTeam_[slot1][slot6].cont_teams[1].teams) do
				if slot11.id == slot5 then
					slot11.mimir.chip = clone(slot3 or {})

					break
				end
			end
		end
	else
		for slot10, slot11 in ipairs(slot0.battleTeam_[slot1][slot6].cont_teams) do
			if slot11.cont_id == slot4 then
				if not slot5 then
					slot11.teams[1].mimir.chip = clone(slot3 or {})

					break
				end

				for slot15, slot16 in ipairs(slot11.teams) do
					if slot16.id == slot5 then
						slot16.mimir.chip = clone(slot3 or {})

						break
					end
				end

				break
			end
		end
	end
end

function slot0.InsertMimirChipInfo(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = {}

	slot0:CreatBaseTeamInfo(slot1, GetHeroTeamActivityID(slot1, slot2), slot4, slot5)

	if not slot4 or slot4 == 0 then
		if not slot5 then
			slot7 = slot0.battleTeam_[slot1][slot6].cont_teams[1].teams[1].mimir.chip
		else
			for slot11, slot12 in ipairs(slot0.battleTeam_[slot1][slot6].cont_teams[1].teams) do
				if slot12.id == slot5 then
					slot7 = slot12.mimir.chip

					break
				end
			end
		end
	else
		for slot11, slot12 in ipairs(slot0.battleTeam_[slot1][slot6].cont_teams) do
			if slot12.cont_id == slot4 then
				if not slot5 then
					slot7 = slot12.teams[1].mimir.chip

					break
				end

				for slot16, slot17 in ipairs(slot12.teams) do
					if slot17.id == slot5 then
						slot7 = slot17.mimir.chip

						break
					end
				end

				break
			end
		end
	end

	ChipTools.InsertChip(slot7, slot3)
end

function slot0.RemoveMimirChipInfo(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = {}

	slot0:CreatBaseTeamInfo(slot1, GetHeroTeamActivityID(slot1, slot2), slot4, slot5)

	if not slot4 or slot4 == 0 then
		if not slot5 then
			slot7 = slot0.battleTeam_[slot1][slot6].cont_teams[1].teams[1].mimir.chip
		else
			for slot11, slot12 in ipairs(slot0.battleTeam_[slot1][slot6].cont_teams[1].teams) do
				if slot12.id == slot5 then
					slot7 = slot12.mimir.chip

					break
				end
			end
		end
	else
		for slot11, slot12 in ipairs(slot0.battleTeam_[slot1][slot6].cont_teams) do
			if slot12.cont_id == slot4 then
				if not slot5 then
					slot7 = slot12.teams[1].mimir.chip

					break
				end

				for slot16, slot17 in ipairs(slot12.teams) do
					if slot17.id == slot5 then
						slot7 = slot17.mimir.chip

						break
					end
				end

				break
			end
		end
	end

	ChipTools.RemoveChip(slot7, slot3)
end

function slot0.GetComboInfo(slot0, slot1, slot2, slot3, slot4)
	slot0:CreatBaseTeamInfo(slot1, GetHeroTeamActivityID(slot1, slot2), slot3, slot4)

	if not slot3 or slot3 == 0 then
		if not slot4 then
			return clone(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams[1].combo or 0)
		else
			for slot9, slot10 in ipairs(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams) do
				if slot10.id == slot4 then
					return clone(slot10.combo or 0)
				end
			end
		end
	else
		for slot9, slot10 in ipairs(slot0.battleTeam_[slot1][slot5].cont_teams) do
			if slot10.cont_id == slot3 then
				if not slot4 then
					return clone(slot10.teams[1].combo or 0)
				else
					for slot14, slot15 in ipairs(slot10.teams) do
						if slot15.id == slot4 then
							return clone(slot15.combo or 0)
						end
					end
				end
			end
		end
	end

	return 0
end

function slot0.SetComboInfo(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:CreatBaseTeamInfo(slot1, GetHeroTeamActivityID(slot1, slot2), slot4, slot5)

	if not slot4 or slot4 == 0 then
		if not slot5 then
			slot0.battleTeam_[slot1][slot6].cont_teams[1].teams[1].combo = slot3
		else
			for slot10, slot11 in ipairs(slot0.battleTeam_[slot1][slot6].cont_teams[1].teams) do
				if slot11.id == slot5 then
					slot11.combo = slot3

					break
				end
			end
		end
	else
		for slot10, slot11 in ipairs(slot0.battleTeam_[slot1][slot6].cont_teams) do
			if slot11.cont_id == slot4 then
				if not slot5 then
					slot11.teams[1].combo = slot3

					break
				end

				for slot15, slot16 in ipairs(slot11.teams) do
					if slot16.id == slot5 then
						slot16.combo = slot3

						break
					end
				end

				break
			end
		end
	end
end

function slot0.ReSetMythicTeamData(slot0)
	slot1 = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
	slot0.battleTeam_[slot1][GetHeroTeamActivityID(slot1)].cont_teams[1].teams = {}
end

function slot0.SetMultiTeamData(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot13 = slot1

	slot0:SetSingleTeam(slot13, GetHeroTeamActivityID(slot1, slot2), slot3, slot4, slot5, slot6, slot7, slot8)

	for slot13 = 1, 3 do
		if slot13 ~= slot8 then
			slot14 = {}
			slot20 = slot7
			slot21 = slot13
			slot15, slot16 = slot0:GetSingleTeam(slot1, slot9, slot20, slot21)

			for slot20, slot21 in ipairs(slot15) do
				slot22 = false

				if slot21 ~= 0 and table.indexof(slot3, slot21) then
					slot22 = true

					if ComboSkillCfg[slot0:GetComboInfo(slot1, slot9, slot7, slot13)] then
						for slot27, slot28 in pairs(ComboSkillCfg[slot23].cooperate_role_ids) do
							if slot21 == slot28 then
								slot0:SetComboInfo(slot1, slot9, 0, slot7, slot13)

								break
							end
						end
					end
				end

				if not slot22 then
					table.insert(slot14, slot21)
				end
			end

			slot0:SetSingleTeam(slot1, slot9, slot14, slot16, nil, , slot7, slot13)
		end
	end
end

function slot0.SwapTeam(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot0:GetMultiTeam(slot1, slot2)
	slot7 = {}

	if not slot3 or slot3 == 0 then
		slot7 = slot6.cont_teams[1]
	else
		for slot11, slot12 in ipairs(slot6.cont_teams) do
			if slot12.cont_id == slot3 then
				slot7 = slot12

				break
			end
		end
	end

	for slot11, slot12 in ipairs(slot7.teams) do
		if slot12.id == slot4 then
			slot12.id = slot5
		elseif slot12.id == slot5 then
			slot12.id = slot4
		end
	end
end

function slot0.SetGuildSingleTeam(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot8 = GetHeroTeamActivityID(slot1, slot2)
	slot9 = slot4 or BattleTeamData:GetComboInfo(slot1, slot2, slot6, slot7)
	slot10 = {}

	if not slot5 then
		slot10.id, slot10.chip = BattleTeamData:GetMimirInfo(slot1, slot2, slot6, slot7)
	else
		slot10.id = slot5.id or 0
		slot10.chip = slot5.chip or {}
	end

	slot0:CreatBaseTeamInfo(slot1, slot8, slot6, slot7)

	slot11 = {}

	if not slot6 or slot6 == 0 then
		if not slot7 then
			slot11 = slot0.battleTeam_[slot1][slot8].cont_teams[1].teams[1]
		else
			for slot15, slot16 in ipairs(slot0.battleTeam_[slot1][slot8].cont_teams[1].teams) do
				if slot16.id == slot7 then
					slot11 = slot16

					break
				end
			end
		end
	else
		for slot15, slot16 in ipairs(slot0.battleTeam_[slot1][slot8].cont_teams) do
			if slot16.cont_id == slot6 then
				if not slot7 then
					slot11 = slot16.teams[1]

					break
				end

				for slot20, slot21 in ipairs(slot16.teams) do
					if slot21.id == slot7 then
						slot11 = slot21

						break
					end
				end

				break
			end
		end
	end

	slot12 = {}
	slot13 = {}
	slot14 = {}
	slot15 = ipairs
	slot17 = slot3 or {}

	for slot18, slot19 in slot15(slot17) do
		if slot19.hero_type == 1 or slot19.hero_id == 0 then
			slot12[slot18] = slot19.hero_id
			slot13[slot18] = 0
			slot14[slot18] = {
				hero_id = 0,
				owner_id = 0
			}
		elseif slot19.hero_type == 2 then
			slot12[slot18] = HeroStandardSystemCfg[slot19.hero_id].hero_id
			slot13[slot18] = slot19.hero_id
			slot14[slot18] = {
				hero_id = 0,
				owner_id = 0
			}
		else
			slot12[slot18] = 0
			slot13[slot18] = 0
			slot14[slot18] = {
				hero_id = slot19.hero_id,
				owner_id = slot19.owner_id
			}
		end
	end

	for slot18 = 1, 3 do
		slot12[slot18] = slot12[slot18] or 0
		slot13[slot18] = slot13[slot18] or 0
		slot14[slot18] = slot14[slot18] or {
			hero_id = 0,
			owner_id = 0
		}
	end

	slot11.singleTeam = deepClone(slot12)
	slot11.heroTrialList = deepClone(slot13)
	slot11.heroAssistList = deepClone(slot14)
	slot11.combo = slot9
	slot11.mimir = slot10
end

function slot0.GetGuildSingleTeam(slot0, slot1, slot2, slot3, slot4)
	slot0:CreatBaseTeamInfo(slot1, GetHeroTeamActivityID(slot1, slot2), slot3, slot4)

	if not slot3 or slot3 == 0 then
		if not slot4 then
			return clone(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams[1].singleTeam or {
				0,
				0,
				0
			}), clone(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams[1].heroTrialList or {
				0,
				0,
				0
			}), clone(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams[1].heroAssistList or {
				{
					hero_id = 0,
					owner_id = 0
				},
				{
					hero_id = 0,
					owner_id = 0
				},
				{
					hero_id = 0,
					owner_id = 0
				}
			})
		else
			for slot9, slot10 in ipairs(slot0.battleTeam_[slot1][slot5].cont_teams[1].teams) do
				if slot10.id == slot4 then
					return clone(slot10.singleTeam or {
						0,
						0,
						0
					}), clone(slot10.heroTrialList or {
						0,
						0,
						0
					}), clone(slot10.heroAssistList or {
						{
							hero_id = 0,
							owner_id = 0
						},
						{
							hero_id = 0,
							owner_id = 0
						},
						{
							hero_id = 0,
							owner_id = 0
						}
					})
				end
			end
		end
	else
		for slot9, slot10 in ipairs(slot0.battleTeam_[slot1][slot5].cont_teams) do
			if slot10.cont_id == slot3 then
				if not slot4 then
					return clone(slot10.teams[1].singleTeam or {
						0,
						0,
						0
					}), clone(slot10.teams[1].heroTrialList or {
						0,
						0,
						0
					}), clone(slot10.teams[1].heroAssistList or {
						{
							hero_id = 0,
							owner_id = 0
						},
						{
							hero_id = 0,
							owner_id = 0
						},
						{
							hero_id = 0,
							owner_id = 0
						}
					})
				else
					for slot14, slot15 in ipairs(slot10.teams) do
						if slot15.id == slot4 then
							return clone(slot15.singleTeam or {
								0,
								0,
								0
							}), clone(slot15.heroTrialList or {
								0,
								0,
								0
							}), clone(slot15.heroAssistList or {
								{
									hero_id = 0,
									owner_id = 0
								},
								{
									hero_id = 0,
									owner_id = 0
								},
								{
									hero_id = 0,
									owner_id = 0
								}
							})
						end
					end
				end
			end
		end
	end

	return {
		0,
		0,
		0
	}, {
		0,
		0,
		0
	}, {
		{
			hero_id = 0,
			owner_id = 0
		},
		{
			hero_id = 0,
			owner_id = 0
		},
		{
			hero_id = 0,
			owner_id = 0
		}
	}
end

function slot0.UpdateHeroTrial(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.hero_trial_list) do
		slot0.trialActivityData_[slot6.activity_id] = {}

		for slot10, slot11 in ipairs(slot6.template_hero_list) do
			table.insert(slot0.trialActivityData_[slot6.activity_id], slot11)
		end
	end
end

function slot0.GetHeroTrial(slot0, slot1)
	if ActivityTools.GetActivityType(slot1) == ActivityTemplateConst.SURVIVE_SOLO_LEVEL then
		return ActivitySoloSlayerCfg[slot1].hero_standard_system_id_list
	end

	return slot0.trialActivityData_[slot1]
end

function slot0.SetTeamRawData(slot0, slot1, slot2)
	slot0.teamRawData_[slot1] = slot2
end

function slot0.GetTeamRawDataByType(slot0, slot1)
	if not slot0.teamRawData_ then
		return nil
	end

	return slot0.teamRawData_[slot1]
end

function slot0.GetTeamRawData(slot0)
	return slot0.teamRawData_
end

function slot0.GetReservesTeamList(slot0)
	return slot0.reservesTeamList_
end

function slot0.GetReservesTeam(slot0, slot1)
	if slot0.reservesTeamList_[slot1] then
		return deepClone(slot0.reservesTeamList_[slot1].hero_list)
	end

	return {
		0,
		0,
		0
	}
end

function slot0.SetReservesTeam(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot6.id
		slot0.reservesTeamList_[slot7].name = slot6.name
		slot0.reservesTeamList_[slot7].hero_list = deepClone(slot6.hero_list)
		slot0.reservesTeamList_[slot7].comboSkill = slot6.cooperate_unique_skill_id
		slot0.reservesTeamList_[slot7].chipInfo = {
			id = slot6.mimir_info[1].mimir_id,
			list = deepClone(slot6.mimir_info[1].chip_list)
		}
		slot0.reservesTempTeamList_[slot7].name = slot6.name
		slot0.reservesTempTeamList_[slot7].hero_list = deepClone(slot6.hero_list)
		slot0.reservesTempTeamList_[slot7].comboSkill = slot6.cooperate_unique_skill_id
		slot0.reservesTempTeamList_[slot7].chipInfo = {
			id = slot6.mimir_info[1].mimir_id,
			list = deepClone(slot6.mimir_info[1].chip_list)
		}
	end
end

function slot0.InitTempList(slot0)
	slot0.reservesTempTeamList_ = {}
	slot0.reservesTempTeamList_ = deepClone(slot0.reservesTeamList_)

	return slot0.reservesTempTeamList_
end

function slot0.SetCurTeam(slot0, slot1, slot2, slot3)
	slot4 = 0

	for slot8, slot9 in ipairs(slot0.reservesTempTeamList_) do
		if slot9.hero_list[1] == 0 then
			slot9.name = ""
			slot9.hero_list = deepClone(slot1)
			slot9.comboSkill = slot2
			slot9.chipInfo = {
				id = slot3.enabledID,
				list = deepClone(slot3.chipList)
			}

			return slot8
		end
	end

	return slot4
end

function slot0.GetReservesTempTeamList(slot0)
	return slot0.reservesTempTeamList_
end

function slot0.SetReservesTempTeamList(slot0, slot1, slot2, slot3)
	slot4 = slot0.reservesTempTeamList_[slot1].hero_list

	if slot3 == 0 then
		if slot2 ~= 2 then
			slot4[slot2] = 0
		else
			slot4[2] = slot4[3]
			slot4[3] = 0
		end
	else
		if table.indexof(slot4, slot3) then
			slot4[table.indexof(slot4, slot3)] = slot4[slot2]
			slot4[slot2] = slot3
		else
			slot4[slot2] = slot3
		end

		if slot4[2] == 0 then
			slot4[2] = slot4[3]
			slot4[3] = 0
		end
	end

	if slot0.reservesTempTeamList_[slot1].comboSkill ~= 0 then
		for slot10, slot11 in ipairs(ComboSkillCfg[slot5].cooperate_role_ids) do
			if not table.indexof(slot4, slot11) then
				slot0.reservesTempTeamList_[slot1].comboSkill = 0

				break
			end
		end
	end
end

function slot0.SetReservesTempTeamChip(slot0, slot1, slot2)
	slot0.reservesTempTeamList_[slot1].chipInfo.id = slot2
end

function slot0.SetReservesTempTeamChipList(slot0, slot1, slot2)
	slot4 = false
	slot5 = 0
	slot7 = ChipCfg.get_id_list_by_spec_char[ChipCfg[slot2].spec_char]

	for slot11, slot12 in ipairs(slot0.reservesTempTeamList_[slot1].chipInfo.list) do
		if ChipCfg[slot12].spec_char ~= 0 and table.keyof(slot7, slot12) and slot12 ~= slot2 then
			slot4 = true
			slot5 = slot12

			break
		end
	end

	if not table.indexof(slot3, slot2) and not slot4 and GameSetting.ai_secondary_chip_equip_num.value[1] <= #slot3 then
		ShowTips("CHIP_CNT_MORE_THEN_MAX")

		return
	end

	if slot4 and table.indexof(slot3, slot5) then
		table.remove(slot3, slot8)
	end

	table.insert(slot3, slot2)
	ShowTips("CHIP_USE_SUCCESS")
	manager.notify:Invoke(ENABLED_CHIP)
end

function slot0.ResetReservesTempTeamChipList(slot0, slot1)
	slot0.reservesTempTeamList_[slot1].chipInfo.list = {}

	ShowTips("CHIP_UNLOAD_SUCCESS")
	manager.notify:Invoke(ENABLED_CHIP)
end

function slot0.UnloadReservesTempTeamChipList(slot0, slot1, slot2)
	if table.indexof(slot0.reservesTempTeamList_[slot1].chipInfo.list, slot2) then
		table.remove(slot3, slot4)
	end

	ShowTips("CHIP_UNLOAD_SUCCESS")
	manager.notify:Invoke(ENABLED_CHIP)
end

function slot0.ReservesTempTeamEnabledSchemeID(slot0, slot1, slot2)
	slot0.reservesTempTeamList_[slot1].chipInfo.list = deepClone(slot2 or {})

	manager.notify:Invoke(ENABLED_SCHEME)
end

function slot0.ChangeComboSkillID(slot0, slot1, slot2)
	slot0.reservesTempTeamList_[slot1].comboSkill = slot2

	manager.notify:Invoke(COMBO_SKILL_SELECT, slot2)
end

function slot0.DelectReservesTeam(slot0, slot1)
	slot0.reservesTeamList_[slot1] = {
		comboSkill = 0,
		name = "",
		index = slot1,
		hero_list = {
			0,
			0,
			0
		},
		chipInfo = {
			id = 0,
			list = {}
		}
	}
	slot0.reservesTempTeamList_[slot1] = {
		comboSkill = 0,
		name = "",
		index = slot1,
		hero_list = {
			0,
			0,
			0
		},
		chipInfo = {
			id = 0,
			list = {}
		}
	}
end

function slot0.IsInList(slot0, slot1, slot2)
	slot3 = slot2.hero_list

	for slot7 = 1, 10 do
		slot8 = slot0.reservesTeamList_[slot7]

		if slot3[1] == slot0.reservesTeamList_[slot7].hero_list[1] and slot3[2] == slot9[2] and slot3[3] == slot9[3] and slot2.comboSkill == slot8.comboSkill and slot2.chipInfo.id == slot8.chipInfo.id and #slot2.chipInfo.list == #slot8.chipInfo.list then
			for slot13, slot14 in ipairs(slot2.chipInfo.list) do
				if not table.indexof(slot8.chipInfo.list, slot14) then
					return false
				end
			end

			return true
		end
	end

	return false
end

return slot0
