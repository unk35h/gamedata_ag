require("game.data.PolyhedronDataTemplate")

slot0 = singletonClass("PolyhedronData")
slot1, slot2 = nil
slot3 = 0
slot4 = {}
slot5 = 1
slot6 = 0
slot7 = {}
slot8 = 0
slot9 = {}
slot10 = {}
slot11 = {}
slot12 = {}
slot13 = 0
slot14 = {}
slot15 = nil
slot16 = 0
slot17 = {}
slot18 = nil
slot19 = {}
slot20 = 0
slot21 = 0
slot22 = {}
slot23 = {}
slot24 = true
slot25 = {}
slot26 = 0
slot27 = 1
slot28 = {}
slot29 = {}
slot30 = {}
slot31 = 1

function slot0.Init(slot0)
	uv0 = nil
	uv1 = nil
	uv2 = 0
	uv3 = {}
	uv4 = 1
	uv5 = 0
	uv6 = {}
	uv7 = 0
	uv8 = {}
	uv9 = {}
	uv10 = {}
	uv11 = 0
	uv12 = {}
	uv13 = nil
	uv14 = 0
	uv15 = {}
	uv16 = nil
	uv17 = 0
	uv18 = {}
	uv19 = 0
	uv20 = {}
	uv21 = {}
	uv22 = 0
	uv23 = 1
	uv24 = {}
	uv25 = {}
end

function slot0.InitPolyhedronGameData(slot0, slot1)
	uv0 = slot1.activity_id

	if slot1.activity_id == 1 then
		uv0 = 161101
	end

	slot0:UpdateTerminalLevel()

	slot2 = slot1.terminal
	uv1 = slot2.reset_times
	uv2 = {}

	for slot6, slot7 in ipairs(slot2.upgrade_id_list) do
		table.insert(uv2, slot7)
	end

	uv3 = {}

	for slot6, slot7 in ipairs(slot1.beacon_id_list) do
		table.insert(uv3, slot7)
	end

	slot3 = slot1.game

	if not uv4 then
		uv4 = PolyhedronTemplate.New(slot3)
	else
		uv4:UpdateGame(slot3)
	end

	uv5 = uv4:GetTipsList()
	uv6 = 1

	for slot9, slot10 in ipairs(slot1.decision.apply_id_list) do
		uv7[slot10] = true
	end

	uv8 = {}

	for slot9, slot10 in ipairs(slot1.unlocked_hero_id_list) do
		table.insert(uv8, slot10)
	end

	uv9 = {}

	for slot9, slot10 in ipairs(slot1.clear_difficulty_list) do
		table.insert(uv9, slot10)
	end

	table.sort(uv9, function (slot0, slot1)
		return slot1 < slot0
	end)

	uv10 = {}

	for slot10, slot11 in ipairs(slot1.manual.sample_list) do
		uv10[slot11.id] = slot11.state
	end
end

function slot0.UpdatePolyhedronProcess(slot0, slot1)
	if uv0 then
		uv0:UpdateProcess(slot1.progress)
	else
		error("UpdatePolyhedronProcess error")
	end

	uv1 = uv0:GetTipsList()
	uv2 = 1
end

function slot0.UpdatePolyhedronSettlement(slot0, slot1)
	slot2 = slot1.end_info
	uv0 = {
		point = slot2.point,
		decision_exp = slot2.decision_exp,
		terminal_exp = slot2.terminal_exp
	}
end

function slot0.GetPolyhedronInfo(slot0)
	return uv0
end

function slot0.GetPolyhedronSettlement(slot0)
	return uv0
end

function slot0.GetClearMaxDifficulty(slot0)
	return uv0[1] or 0
end

function slot0.UpdateTerminalLevel(slot0)
	uv0, uv1 = PolyhedronTools.PolyhedronTerminalExpToLevel(CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_POLYHEDRON_TERMINAL_EXP))
end

function slot0.GetTerminalLevel(slot0)
	return uv0
end

function slot0.GetTerminalExp(slot0)
	return uv0
end

function slot0.GetTerminalGift(slot0)
	return uv0
end

function slot0.SetTerminalGift(slot0, slot1)
	uv0 = slot1
end

function slot0.GetResetTimes(slot0)
	return uv0
end

function slot0.AddUnlockBeacon(slot0, slot1)
	if not table.indexof(uv0, slot1) then
		table.insert(uv0, slot1)
	end
end

function slot0.GetUnlockBeaconList(slot0)
	return uv0
end

function slot0.GetBeaconIsLock(slot0, slot1)
	return not table.indexof(uv0, slot1)
end

function slot0.GetBeaconMaxBeaconSelect(slot0)
	slot1 = {
		3001,
		3005,
		3011
	}
	slot2 = 0

	for slot6, slot7 in ipairs(uv0) do
		if table.indexof(slot1, slot7) then
			slot2 = slot2 + 1
		end
	end

	return slot2
end

function slot0.GetArtifaceAtlasState(slot0, slot1)
	return uv0[slot1] or 0
end

function slot0.GetPolyhedronHeroUnlock(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.UnlockHero(slot0, slot1)
	if not table.indexof(uv0, slot1) then
		table.insert(uv0, slot1)
	end
end

function slot0.GetUnlockHeroList(slot0)
	return uv0
end

function slot0.GetPolyhedronHeroData(slot0, slot1)
	if HeroData:GetHeroData(slot1).unlock == 1 then
		slot2 = deepClone(slot2)
		slot2.unlock = PolyhedronData:GetPolyhedronHeroUnlock(slot1) and 1 or 0
		slot5 = HeroStandardSystemCfg[PolyhedronHeroCfg[slot1].standard_id]
		slot2.id = slot5.hero_id
		slot2.skin_id = slot5.skin_id
		slot2.exp = GameLevelSetting[slot5.hero_lv].hero_lv_exp_sum
		slot2.star = slot5.star_lv
		slot2.level = slot5.hero_lv
		slot2.break_level = slot5.hero_break
		slot2.using_astrolabe = {}
		slot2.unlocked_astrolabe = {}
		slot2.transition = {}

		if slot5.astrolabe_suit_id and slot5.astrolabe_suit_id ~= 0 then
			slot9 = slot5.astrolabe_suit_id

			for slot9, slot10 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot9]) do
				table.insert(slot2.using_astrolabe, slot10)
				table.insert(slot2.unlocked_astrolabe, slot10)
			end
		end

		slot6 = slot5.skill_lv
		slot2.skill = {}
		slot10 = slot5.hero_id

		for slot10, slot11 in ipairs(HeroCfg[slot10].skills) do
			if slot11 == HeroCfg[slot5.hero_id].avoid[1] then
				table.insert(slot2.skill, {
					skill_level = 1,
					skill_id = slot11
				})
			else
				table.insert(slot2.skill, {
					skill_id = slot11,
					skill_level = slot6 + HeroTools.GetHeroSkillAddLevel(slot2, slot11)
				})
			end
		end

		slot11 = slot5.weapon_level
		slot2.weapon_info = {
			level = WeaponTools.ExpToLv(GameLevelSetting[slot11].weapon_lv_exp_sum),
			exp = GameLevelSetting[slot5.weapon_level].weapon_lv_exp_sum,
			breakthrough = slot5.weapon_break
		}
		slot2.servant_uid = 0
		slot2.servantInfo = {}
		slot2.servant = {
			id = slot5.weapon_key,
			stage = slot5.weapon_stage
		}
		slot2.equip = {}

		for slot11, slot12 in ipairs(EquipTools.GetConstructVirtualEquips(slot4)) do
			table.insert(slot2.equip, {
				pos = slot11,
				equip_id = slot12.equip_id
			})
		end

		return slot2
	end

	return slot2
end

function slot0.GetHeroSkillInfo(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(PolyhedronData:GetPolyhedronHeroData(slot1).skill) do
		slot2[slot8.skill_id] = slot8.skill_level
	end

	slot4 = {}

	for slot8, slot9 in ipairs(HeroCfg[slot1].skills) do
		table.insert(slot4, {
			isCanUp = false,
			addSkillLv = 0,
			id = slot9,
			heroId = slot1,
			lv = slot2[slot9]
		})
	end

	return slot4
end

function slot0.GetPolicyApplyList(slot0)
	return uv0
end

function slot0.SetPolicyApplyList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6] = true
	end
end

function slot0.GetActivityID(slot0)
	return uv0
end

function slot0.InitCurRank(slot0, slot1, slot2)
	if slot2 == PolyhedronConst.RANK_SUB_TYPE.SCORE then
		uv0 = PolyhedronRankTemplate.New(slot1.my_rank)
		uv1 = slot1.total
	else
		uv2 = {}

		for slot6, slot7 in ipairs(slot1.hero_rank_list) do
			uv2[slot7.hero_id] = {
				id = slot7.hero_id,
				rankData = PolyhedronRankTemplate.New(slot7.my_rank),
				total = slot7.total
			}
			uv3 = true
		end
	end
end

function slot0.InitRankData(slot0, slot1, slot2)
	if PolyhedronConst.RANK_SUB_TYPE.SCORE == slot2.type then
		uv0 = {}

		for slot7, slot8 in ipairs(slot1.rank_list) do
			table.insert(uv0, PolyhedronRankTemplate.New(slot8))
		end

		uv1 = PolyhedronRankTemplate.New(slot1.my_rank)
		uv2 = slot1.total
		uv3 = slot1.version
	elseif PolyhedronConst.RANK_SUB_TYPE.HERO == slot3 then
		slot5 = {
			id = slot2.hero_id,
			rank_list = {}
		}

		for slot9, slot10 in ipairs(slot1.rank_list) do
			table.insert(slot5.rank_list, PolyhedronRankTemplate.New(slot10))
		end

		slot5.cur_rank_hero = PolyhedronRankTemplate.New(slot1.my_rank)
		slot5.rank_total_people_hero = slot1.total
		slot5.rank_version_hero = slot1.version
		uv4[slot4] = slot5
	end
end

function slot0.GetRankVersion(slot0, slot1, slot2)
	if PolyhedronConst.RANK_SUB_TYPE.SCORE == slot1 then
		return uv0
	elseif PolyhedronConst.RANK_SUB_TYPE.HERO == slot1 then
		if uv1[slot2] then
			return uv1[slot2].rank_version_hero
		else
			return 0
		end
	else
		return 0
	end
end

function slot0.GetRankList(slot0, slot1, slot2)
	if PolyhedronConst.RANK_SUB_TYPE.SCORE == slot1 then
		return uv0
	elseif PolyhedronConst.RANK_SUB_TYPE.HERO == slot1 then
		if uv1[slot2] then
			return uv1[slot2].rank_list
		else
			return {}
		end
	else
		return {}
	end
end

function slot0.GetCurRank(slot0, slot1, slot2)
	if PolyhedronConst.RANK_SUB_TYPE.SCORE == slot1 then
		return uv0
	elseif PolyhedronConst.RANK_SUB_TYPE.HERO == slot1 then
		if uv1[slot2] then
			return uv1[slot2].cur_rank_hero
		else
			return nil
		end
	else
		return nil
	end
end

function slot0.GetRankTotalPeople(slot0, slot1, slot2)
	if PolyhedronConst.RANK_SUB_TYPE.SCORE == slot1 then
		return uv0
	elseif PolyhedronConst.RANK_SUB_TYPE.HERO == slot1 then
		if uv1[slot2] then
			return uv1[slot2].rank_total_people_hero
		else
			return 0
		end
	else
		return 0
	end
end

function slot0.GetSortRankHeroIDList(slot0)
	if not uv0 then
		return uv1
	end

	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in pairs(uv2) do
		slot1[#slot1 + 1] = slot7
		slot3[slot7] = true
	end

	slot4, slot5 = nil

	table.sort(slot1, function (slot0, slot1)
		uv0 = uv1[slot0] and uv1[slot0].rankData.score or 0
		uv2 = uv1[slot1] and uv1[slot1].rankData.score or 0

		if uv0 == uv2 then
			return slot0 < slot1
		else
			return uv2 < uv0
		end
	end)

	for slot10, slot11 in ipairs(PolyhedronHeroCfg.all) do
		if slot3[slot11] == nil and PolyhedronHeroCfg[slot11].is_leader == 1 then
			slot2[#slot2 + 1] = slot11
		end
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0 < slot1
	end)
	table.insertto(slot1, slot2)

	uv1 = slot1
	uv0 = false

	return slot1
end

function slot0.GetMyHeroRankList(slot0)
	return uv0
end

function slot0.InitGuildRankData(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot1.rank_list) do
		if GuildData:GetGuildMemberData(slot8.user_id) then
			table.insert(slot3, PolyhedronRankTemplate.New(slot8))
		end
	end

	table.sort(slot3, function (slot0, slot1)
		if slot0.score == slot1.score then
			if slot0.timestamp == slot1.timestamp then
				return slot1.user_id < slot0.user_id
			else
				return slot0.timestamp < slot1.timestamp
			end
		else
			return slot1.score < slot0.score
		end
	end)

	slot5 = PlayerData:GetPlayerInfo().userID
	slot6 = nil

	for slot10, slot11 in ipairs(slot3) do
		slot11.rank = slot10
		slot12 = GuildData:GetGuildMemberData(slot11.user_id)
		slot11.nick = slot12.name
		slot11.icon = slot12.icon
		slot11.icon_frame = slot12.frame

		if tonumber(slot11.user_id) == slot5 then
			slot6 = slot11
		end
	end

	if PolyhedronConst.RANK_SUB_TYPE.SCORE == slot2.type then
		uv0 = slot3
		uv1 = slot6
	elseif PolyhedronConst.RANK_SUB_TYPE.HERO == slot7 then
		slot8 = slot2.hero_id
		uv2[slot8] = {
			id = slot8,
			rank_list = slot3,
			cur_rank_hero = slot6
		}
	end
end

function slot0.ResetGuildRankData(slot0)
	uv0 = {}
	uv1 = nil
	uv2 = {}
end

function slot0.GetGuildRankList(slot0, slot1, slot2)
	if PolyhedronConst.RANK_SUB_TYPE.SCORE == slot1 then
		return uv0
	elseif PolyhedronConst.RANK_SUB_TYPE.HERO == slot1 then
		if uv1[slot2] then
			return uv1[slot2].rank_list
		else
			return {}
		end
	else
		return {}
	end
end

function slot0.GetGuildCurRank(slot0, slot1, slot2)
	if PolyhedronConst.RANK_SUB_TYPE.SCORE == slot1 then
		return uv0
	elseif PolyhedronConst.RANK_SUB_TYPE.HERO == slot1 then
		if uv1[slot2] then
			return uv1[slot2].cur_rank_hero
		else
			return nil
		end
	else
		return nil
	end
end

function slot0.ResetTerminalCallback(slot0)
	uv0 = {}

	manager.notify:Invoke(POLYHEDRON_TERMINAL_RESET, {})
end

function slot0.SetCacheSelectHero(slot0, slot1)
	uv0 = slot1
end

function slot0.GetCacheSelectHero(slot0)
	return uv0
end

function slot0.SetCacheSelectDifficulty(slot0, slot1)
	uv0 = slot1
end

function slot0.GetCacheSelectDifficulty(slot0)
	return uv0
end

function slot0.SetCacheBeaconList(slot0, slot1)
	uv0 = slot1
end

function slot0.GetCacheBeaconList(slot0)
	return uv0
end

function slot0.GetStandardId(slot0)
	return 1
end

function slot0.GetHeroClicked(slot0, slot1)
	return uv0[slot1] or false
end

function slot0.SetHeroClicked(slot0, slot1)
	if PolyhedronAction:GetPolyhedronHeroRedPointCount(slot1) > 0 then
		uv0[slot1] = true

		PolyhedronAction:RefreshHeroesRedPoint()
	end
end

function slot0.GetTipsData(slot0)
	if uv0[uv1] then
		uv1 = uv1 + 1

		return deepClone(uv0[uv1])
	else
		return nil
	end
end

return slot0
