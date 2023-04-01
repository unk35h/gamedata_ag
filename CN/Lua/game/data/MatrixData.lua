require("game.data.MatrixDataTemplate")

slot0 = {}
slot1 = {}
slot2 = {}
slot3 = 0
slot4 = 1
slot5 = {}
slot6 = {}
slot7 = 0
slot8 = 0
slot9 = {}
slot10 = {}
slot11 = 0
slot12 = nil
slot13 = {}
slot14 = {}
slot15 = {}
slot16 = {}
slot17 = nil
slot18 = {}
slot19 = {}
slot20 = nil
slot21 = 0
slot22 = 0
slot23 = 0
slot24 = 0
slot25 = {}
slot26 = 0
slot27 = {}
slot28 = 0
slot29 = 0
slot30 = {}
slot31 = nil
slot32 = 0
slot33 = {}
slot34 = nil
slot35 = 0
slot36 = {}
slot37 = nil
slot38 = 0
slot39 = {}
slot40 = nil
slot41 = singletonClass("MatrixData")

function slot41.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = 0
	uv4 = 1
	uv5 = {}
	uv6 = {}
	uv7 = 0
	uv8 = 0
	uv9 = {}
	uv10 = {}
	uv11 = 0
	uv12 = nil
	uv13 = {}
	uv14 = {}
	uv15 = {}
	uv16 = {}
	uv17 = nil
	uv18 = {}
	uv19 = {}
	uv20 = nil
	uv21 = {}
	uv22 = 0
	uv23 = 0
	uv24 = 0
	uv25 = 0
	uv26 = {}
	uv27 = 0
	uv28 = {}
	uv29 = nil
	uv30 = 0
	uv31 = {}
	uv32 = nil
	uv33 = 0
	uv34 = {}
	uv35 = nil
	uv36 = 0
	uv37 = {}
	uv38 = nil
end

function slot41.InitMatrixSystem(slot0, slot1)
	uv0 = {}
	uv1 = {}

	for slot5, slot6 in ipairs(slot1.ready_hero_list) do
		slot7 = slot6.hero_standard_id

		table.insert(uv0, slot7)

		uv1[HeroStandardSystemCfg[slot7].hero_id] = slot6.skin_id
	end

	uv2 = {}

	for slot5, slot6 in ipairs(slot1.difficulty_list) do
		table.insert(uv2, MatrixDifficultyTemplate.New(slot6))
	end

	if uv3 ~= 0 and uv3 ~= slot1.next_refresh_timestamp then
		CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, -CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_MATRIX_PT))
	end

	uv3 = slot1.next_refresh_timestamp
end

function slot41.InitMatrixUser(slot0, slot1)
	uv0 = slot1.game_state

	MatrixData:UpdateTerminalLevel()

	uv1 = {}

	for slot5, slot6 in ipairs(slot1.point_reward_list) do
		slot7 = {
			rank = slot6.rank,
			item_list = {}
		}

		for slot11 = 1, #slot6.item_list do
			slot12 = slot6.item_list[slot11]

			table.insert(slot7.item_list, {
				item_id = slot12.item_id,
				item_num = slot12.item_num
			})
		end

		slot7.is_got_reward = slot6.is_got_reward
		slot7.need_level = slot6.need_level

		table.insert(uv1, slot7)
	end

	MatrixTools.UpdateSortScoreList()

	uv2 = {}

	for slot5, slot6 in ipairs(slot1.terminal.gift_list) do
		uv2[slot6.id] = slot6.level
	end

	uv3 = {}

	for slot5, slot6 in ipairs(slot1.unlocked_beacon_id_list) do
		table.insert(uv3, slot6)
	end

	if MatrixConst.STATE_TYPE.NOTSTARTED == uv0 then
		return
	end

	if slot1.current_progress then
		uv4 = slot2.tier_id
		uv5 = {}

		for slot6, slot7 in ipairs(slot2.artifact_list) do
			table.insert(uv5, {
				id = slot7.id,
				wins = slot7.wins
			})
		end

		uv6 = MatrixDifficultyTemplate.New(slot2.difficulty)
		slot6 = uv6.price_template_id
		uv7 = MatrixPhaseTemplate.New(slot2.phase, slot6)
		uv8 = {}
		uv9 = {}

		for slot6, slot7 in ipairs(slot2.hero_list) do
			if HeroStandardSystemCfg[slot7.hero_id] then
				slot10 = slot9.hero_id
				slot11 = nil
				slot11 = (uv6.difficulty ~= 3 or MatrixOwnerHeroTemplate.New(slot10, slot8)) and MatrixHeroTemplate.New(slot10, slot8)

				slot11:InitData(slot7)

				uv8[slot10] = slot11

				table.insert(uv9, slot10)
			end
		end

		uv10 = {}

		for slot6, slot7 in ipairs(slot2.custom_affix_id_list) do
			table.insert(uv10, slot7)
		end

		uv11 = {}

		for slot6, slot7 in ipairs(slot2.attribute_list) do
			uv11[slot7.id] = slot7.value
		end

		uv12 = {}

		for slot6, slot7 in ipairs(slot2.beacon_id_list) do
			table.insert(uv12, slot7)
		end

		uv13 = {}

		for slot6, slot7 in ipairs(slot2.current_terminal.gift_list) do
			uv13[slot7.id] = slot7.level
		end
	end
end

function slot41.MatrixOverData(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.currency_list) do
		uv0[slot6.id] = slot6.num
	end

	uv1 = slot1.clear_time
	uv2 = slot1.min_clear_time or slot1.clear_time
	uv3 = slot1.difficulty_complete_times
	uv4 = {}

	for slot5, slot6 in ipairs(slot1.evaluate_id_list) do
		table.insert(uv4, slot6)
	end

	if #uv4 > 1 then
		table.sort(uv4, function (slot0, slot1)
			return MatrixEvaluateCfg[slot1].value < MatrixEvaluateCfg[slot0].value
		end)
	end

	uv5 = slot1.score
end

function slot41.UpdateTerminalLevel(slot0)
	uv0, uv1 = MatrixTools.MatrixExpToLevel(CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_MATRIX_TERMINAL_EXP))
end

function slot41.GetGameState(slot0)
	return uv0
end

function slot41.GetMatrixPhaseData(slot0)
	return uv0
end

function slot41.GetMatrixHeroTeam(slot0)
	return uv0
end

function slot41.GetMatrixBattleHeroTeam(slot0)
	return uv0 or uv1
end

function slot41.SetMatrixBattleHeroTeam(slot0, slot1)
	uv0 = slot1
end

function slot41.GetHeroData(slot0, slot1)
	return uv0[slot1]
end

function slot41.GetTierID(slot0)
	return uv0
end

function slot41.GetDifficulty(slot0)
	return uv0.difficulty
end

function slot41.GetDifficultyData(slot0)
	return uv0
end

function slot41.GetArtifactList(slot0)
	return uv0
end

function slot41.GetCustomAffix(slot0)
	return uv0
end

function slot41.GetPointRewardList(slot0)
	return uv0
end

function slot41.GetTerminalLevel(slot0)
	return uv0
end

function slot41.GetTerminalExp(slot0)
	return uv0
end

function slot41.GetTerminalGift(slot0)
	return uv0
end

function slot41.GetCurrentTerminalGifi(slot0)
	return uv0
end

function slot41.SetTerminalGift(slot0, slot1)
	uv0 = slot1
end

function slot41.GetBeaconIsLock(slot0, slot1)
	return not table.indexof(uv0, slot1)
end

function slot41.GetUnlockBeaconList(slot0)
	return uv0
end

function slot41.GetUseBeaconList(slot0)
	return uv0
end

function slot41.GetChipManagerID(slot0)
	return uv0:GetChipManagerID()
end

function slot41.GetChipList(slot0)
	return uv0:GetChipIDList()
end

function slot41.GetTierScore(slot0, slot1)
	if slot1 == nil then
		slot1 = uv0
	end

	if MatrixTierCfg[slot1] and slot2.level_reward[slot0:GetDifficulty()] then
		return math.floor(slot3 * (1 + slot0:GetAffixDifficultyRate() + slot0:GetScoreAddition()))
	end

	return 0
end

function slot41.GetAffixDifficultyRate(slot0)
	slot1 = 0
	slot4 = MatrixData:GetCustomAffix()

	for slot8, slot9 in ipairs(MatrixData:GetDifficultyData():GetRegularAffix()) do
		slot1 = slot1 + MatrixAffixCfg[slot9].multiple
	end

	for slot8, slot9 in ipairs(slot4) do
		slot1 = slot1 + MatrixAffixCfg[slot9].multiple
	end

	return slot1 / 1000
end

function slot41.GetReadyHeroList(slot0)
	return uv0
end

function slot41.GetHeroSkin(slot0, slot1)
	if (HeroData:GetHeroData(slot1) and slot2.using_skin or 0) == 0 then
		slot3 = slot1
	end

	return slot3
end

function slot41.GetReadyDifficultyData(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		if slot6:GetDifficulty() == slot1 then
			return slot6
		end
	end

	error("cant find Matrix Difficulty id :" .. slot1)

	return nil
end

function slot41.GetNextRefreshTime(slot0)
	return uv0
end

function slot41.GetEvaluateList(slot0)
	return uv0
end

function slot41.GetCurrentClearTime(slot0)
	return uv0
end

function slot41.GetMinClearTime(slot0)
	return uv0
end

function slot41.GetMatrixCurrencyList(slot0)
	return uv0
end

function slot41.GetDifficultyClearTime(slot0)
	return uv0
end

function slot41.GetMatrixOverScore(slot0)
	return uv0
end

function slot41.GetWeaponServantLevel(slot0)
	return uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.WEAPON_LEVEL] or 0
end

function slot41.GetHeroEquipMaxCount(slot0)
	return uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.MAX_EQUIP_COUNT] or 0
end

function slot41.GetAstrolabeMaxCount(slot0)
	return uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.MAX_ASTROLABE_COUNT] or 0
end

function slot41.GetShoRefreshTimes(slot0)
	return uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_REFRESH_TIMES] or 0
end

function slot41.GetShopFressRefreshTimes(slot0)
	return uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_FRESS_REFRESH_TIMES] or 0
end

function slot41.GetFirstGoodsDiscount(slot0)
	return uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_FIRST_GOODS_DISCOUNT] or 1
end

function slot41.GetCanChangeCaptain(slot0)
	if uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.CHANGE_TEAM_LEADER] == 1 then
		return true
	end

	return false
end

function slot41.GetScoreAddition(slot0)
	if not uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SCORE_ADDITION] then
		return 0
	end

	return slot1 / 1000
end

function slot41.GetGiveUpRewardAddition(slot0)
	if not uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.GIVE_UP_REWARD_ADDITION] then
		return 0
	end

	return slot1 / 1000
end

function slot41.GetRaceEffect(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if slot6 == 12 then
			return true
		end
	end

	return false
end

function slot41.GetAffixList(slot0)
	if uv0 then
		slot1 = {}

		for slot6, slot7 in ipairs(uv0:GetRegularAffix()) do
			if MatrixAffixCfg[slot7] then
				table.insert(slot1, slot8.affix)
			end
		end

		for slot6, slot7 in ipairs(uv1) do
			if MatrixAffixCfg[slot7] then
				table.insert(slot1, slot8.affix)
			end
		end

		return slot1
	end

	return {}
end

function slot41.GetArtifactAffixList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(uv0) do
		slot8 = slot6.wins

		if MatrixItemCfg[slot6.id] and MatrixTools.GetAffixByEffectId(slot9.params[1], slot8) then
			table.insert(slot1, slot11)
		end
	end

	return slot1
end

function slot41.GetBeaconAffixList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if MatrixBeaconCfg[slot6] then
			for slot11, slot12 in ipairs(slot7.effect_id_list) do
				if MatrixTools.GetAffixByEffectId(slot12) then
					table.insert(slot1, slot13)
				end
			end
		end
	end

	return slot1
end

function slot41.GetTerminalAffixList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if MatrixTerminalGiftCfg[slot5] and MatrixTools.GetAffixByEffectId(slot7.effect_id_list[slot6]) then
			table.insert(slot1, slot9)
		end
	end

	return slot1
end

function slot41.GetTotalAffix(slot0)
	slot1 = {}

	table.insertto(slot1, slot0:GetAffixList())
	table.insertto(slot1, slot0:GetArtifactAffixList())
	table.insertto(slot1, slot0:GetBeaconAffixList())
	table.insertto(slot1, slot0:GetTerminalAffixList())

	return slot1
end

function slot41.InitCurRank(slot0, slot1)
	uv0 = MatrixRankTemplate.New(slot1.my_rank)
	uv1 = slot1.total
end

function slot41.InitRankData(slot0, slot1, slot2)
	if MatrixConst.MatirxRankSubType.COMMON == slot2 then
		uv0 = {}

		for slot6, slot7 in ipairs(slot1.rank_list) do
			table.insert(uv0, MatrixRankTemplate.New(slot7))
		end

		uv1 = MatrixRankTemplate.New(slot1.my_rank)
		uv2 = slot1.total
		uv3 = slot1.version
	elseif MatrixConst.MatirxRankSubType.SPECIAL == slot2 then
		uv4 = {}

		for slot6, slot7 in ipairs(slot1.rank_list) do
			table.insert(uv4, MatrixRankTemplate.New(slot7))
		end

		uv5 = MatrixRankTemplate.New(slot1.my_rank)
		uv6 = slot1.total
		uv7 = slot1.version
	end
end

function slot41.GetRankVersion(slot0, slot1)
	if MatrixConst.MatirxRankSubType.COMMON == slot1 then
		return uv0
	elseif MatrixConst.MatirxRankSubType.SPECIAL == slot1 then
		return uv1
	else
		return 0
	end
end

function slot41.GetRankList(slot0, slot1)
	if MatrixConst.MatirxRankSubType.COMMON == slot1 then
		return uv0
	elseif MatrixConst.MatirxRankSubType.SPECIAL == slot1 then
		return uv1
	else
		return {}
	end
end

function slot41.GetCurRank(slot0, slot1)
	if MatrixConst.MatirxRankSubType.COMMON == slot1 then
		return uv0
	elseif MatrixConst.MatirxRankSubType.SPECIAL == slot1 then
		return uv1
	else
		return nil
	end
end

function slot41.GetRankTotalPeople(slot0, slot1)
	if MatrixConst.MatirxRankSubType.COMMON == slot1 then
		return uv0
	elseif MatrixConst.MatirxRankSubType.SPECIAL == slot1 then
		return uv1
	else
		return 0
	end
end

function slot41.InitGuildRankData(slot0, slot1, slot2)
	GuildAction.RequiredGuildMemberList(function ()
		slot0 = {}

		for slot4, slot5 in ipairs(uv0.rank_list) do
			if GuildData:GetGuildMemberData(slot5.user_id) then
				table.insert(slot0, MatrixRankTemplate.New(slot5))
			end
		end

		table.sort(slot0, function (slot0, slot1)
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

		slot2 = PlayerData:GetPlayerInfo().userID
		slot3 = nil

		for slot7, slot8 in ipairs(slot0) do
			slot8.rank = slot7
			slot9 = GuildData:GetGuildMemberData(slot8.user_id)
			slot8.nick = slot9.name
			slot8.icon = slot9.icon
			slot8.icon_frame = slot9.frame

			if tonumber(slot8.user_id) == slot2 then
				slot3 = slot8
			end
		end

		if MatrixConst.MatirxRankSubType.COMMON == uv1 then
			uv2 = slot0
			uv3 = slot3
		elseif MatrixConst.MatirxRankSubType.SPECIAL == uv1 then
			uv4 = slot0
			uv5 = slot3
		end

		curRankType = MatrixConst.MatirxRankType.GUILD

		JumpTools.OpenPageByJump("/matrixRank", {
			type = curRankType,
			subType = uv1
		}, ViewConst.SYSTEM_ID.MATRIX_RANK)
	end)
end

function slot41.ResetGuildRankData(slot0)
	uv0 = {}
	uv1 = nil
	uv2 = {}
	uv3 = nil
end

function slot41.GetGuildRankList(slot0, slot1)
	if MatrixConst.MatirxRankSubType.COMMON == slot1 then
		return uv0
	elseif MatrixConst.MatirxRankSubType.SPECIAL == slot1 then
		return uv1
	else
		return {}
	end
end

function slot41.GetGuildCurRank(slot0, slot1)
	if MatrixConst.MatirxRankSubType.COMMON == slot1 then
		return uv0
	elseif MatrixConst.MatirxRankSubType.SPECIAL == slot1 then
		return uv1
	else
		return nil
	end
end

function slot41.CalMatrixAttribute(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if MatrixTerminalGiftCfg[slot5] then
			MatrixTools.GetAttrByEffectId(slot1, slot7.effect_id_list[slot6])
		end
	end

	for slot5, slot6 in pairs(uv1) do
		if MatrixBeaconCfg[slot6] then
			for slot11, slot12 in ipairs(slot7.effect_id_list) do
				MatrixTools.GetAttrByEffectId(slot1, slot12)
			end
		end
	end

	return slot1
end

function slot41.CalMatrixSelectHeroAttribute(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if MatrixTerminalGiftCfg[slot5] then
			MatrixTools.GetAttrByEffectId(slot1, slot7.effect_id_list[slot6])
		end
	end

	return slot1
end

function slot41.GetCacheCustomAffix(slot0)
	return uv0
end

function slot41.SetCacheCustomAffix(slot0, slot1)
	uv0 = slot1
end

slot42 = nil

function slot41.SetBattleTier(slot0, slot1)
	uv0 = slot1
end

function slot41.GetBattleTier(slot0)
	return uv0
end

return slot41
