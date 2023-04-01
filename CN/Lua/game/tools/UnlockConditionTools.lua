return {
	IsUnlockCondition = function (slot0)
		return uv0.IsUnlockConditionByValue(slot0, HistoryData:GetHistoryData(slot0[1]))
	end,
	IsUnlockConditionByValue = function (slot0, slot1)
		slot2 = slot0[1]

		if slot1 then
			return slot0[2] <= slot1, slot1, slot0[2]
		elseif slot2 == 1001 then
			return slot0[2] <= PlayerData:GetPlayerInfo().userLevel, slot3, slot0[2]
		elseif slot2 == 2001 then
			return slot0[3] <= HeroData:GetHeroData(slot0[2]).level, slot3, slot0[3]
		elseif slot2 == 2002 then
			return slot0[3] <= HeroTools.CountHeroTotalSkilllv(slot0[2]), slot3, slot0[3]
		elseif slot2 == 2003 then
			return slot0[3] <= HeroTools.GetTotalSkillLv(slot0[2], HeroCfg[slot0[2]].skills[GameSetting.hero_combo_skill_relate.value[1]]), slot4, slot0[3]
		elseif slot2 == 2004 then
			slot3 = HeroData:GetHeroData(slot0[2]).weapon_info.level or 0

			return slot0[3] <= slot3, slot3, slot0[3]
		elseif slot2 == 2005 then
			return slot0[3] <= HeroData:GetHeroData(slot0[2]).break_level, slot3, slot0[3]
		elseif slot2 == 2006 then
			return slot0[3] <= HeroData:GetHeroData(slot0[2]).star, HeroConst.Hero_Star[HeroStarCfg[slot3].star], HeroConst.Hero_Star[HeroStarCfg[slot0[3]].star]
		elseif slot2 == 3001 then
			return slot0[3] <= ArchiveData:GetArchive(HeroTools.GetHeroOntologyID(slot0[2])).lv, slot4, slot0[3]
		elseif slot2 == 3002 then
			slot3 = HeroTools.GetHeroOntologyID(slot0[2])
			slot5 = ArchiveData:GetArchive(slot3).gift_list[HeroRecordCfg[slot3].gift_like_id1[1]] or 0

			return slot0[3] <= slot5, slot5, slot0[3]
		elseif slot2 == 3009 then
			return slot0[3] <= HeroTools.GetHeroProficiency(slot0[2]), slot3, slot0[3]
		elseif slot2 == 4001 then
			if BattleTeachData:GetHeroTeachInfo(slot0[2], HeroCfg[slot0[2]].study_stage[1]) > 0 then
				return true, 1, 1
			else
				return false, 0, 1
			end
		elseif slot2 == 4101 then
			if TowerData:GetTowerMaxId() and slot3 <= slot0[2] then
				return false, 0, 1
			else
				return true, 1, 1
			end
		elseif slot2 == 4002 then
			slot5 = BattleStageData:GetStageData()[slot0[2]] and slot4.clear_times > 0 and 1 or 0

			return slot5 >= 1, slot5, 1
		elseif slot2 == 8001 then
			slot4 = HeroData:GetHeroData(slot0[2]) and slot3.level or 0

			return slot0[3] <= slot4, slot4, slot0[3]
		elseif slot2 == 20202 then
			if ChessTools.IsFinish(slot0[2]) then
				return true, 1, 1
			else
				return false, 0, 1
			end
		elseif slot2 == 20005 then
			return slot0[2] <= MatrixData:GetTerminalLevel(), slot3, slot0[2]
		end
	end,
	GetConditionDesc = function (slot0)
		slot2 = UnlockConditionCfg[slot0[1]]

		if #slot0 == 1 then
			return slot2.desc
		elseif #slot0 == 2 then
			if slot1 == 4001 then
				return slot2.desc
			elseif slot1 == 4002 then
				slot3, slot4 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot0[2])

				return string.format(slot2.desc, GetTips(BattleConst.HARD_LANGUAGE[ChapterCfg[getChapterIDByStageID(slot0[2])].difficulty]), slot3, slot4)
			elseif slot1 == 4101 then
				return string.format(slot2.desc, BattleTowerStageCfg[slot0[2]].name)
			elseif slot1 == 20001 then
				slot3 = MatrixTierCfg[slot0[2]]

				return string.format(slot2.desc, slot3.tier, slot3.level)
			elseif slot1 == 20202 then
				return string.format(slot2.desc, ChapterCfg[slot0[2]].subhead)
			else
				return string.format(slot2.desc, slot0[2])
			end
		elseif slot1 == 2001 or slot1 == 2002 or slot1 == 2003 or slot1 == 2004 or slot1 == 2005 or slot1 == 3001 or slot1 == 3002 or slot1 == 3009 then
			return string.format(slot2.desc, slot0[3])
		elseif slot1 == 2006 then
			return string.format(slot2.desc, HeroConst.Hero_Star[HeroStarCfg[slot0[3]].star])
		elseif slot1 == 8001 then
			return string.format(slot2.desc, HeroCfg[slot0[2]].suffix, slot0[3])
		else
			return string.format(slot2.desc, slot0[3])
		end
	end,
	GetProgressText = function (slot0, slot1, slot2)
		if UnlockConditionCfg[slot0].progress_show == 1 then
			return string.format("%s/%s", slot1, slot2)
		else
			return ""
		end
	end
}
