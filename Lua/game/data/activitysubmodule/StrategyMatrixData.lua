require("game.data.ActivitySubmodule.StrategyMatrixDataTemplata")

slot0 = singletonClass("StrategyMatrixData")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = nil

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = nil
end

function slot0.InitMatrixUser(slot0, slot1)
	if uv0[slot1.activity_id] then
		uv0[slot2]:SetData(slot1)
	else
		uv0[slot2] = StrategyMartixUserTemplata.New(slot1)
	end

	manager.notify:Invoke(ACTIVITY_MATRIX_PROCESS_CHANGE)
end

function slot0.UpdateMatrixProcess(slot0, slot1, slot2, slot3)
	if not uv0[slot1] then
		return
	end

	uv0[slot1].game_state = slot2

	uv0[slot1]:UpdateProcess(slot3)
	manager.notify:Invoke(ACTIVITY_MATRIX_PROCESS_CHANGE)
end

function slot0.InitMatrixOver(slot0, slot1)
	if uv0[slot1.activity_id] then
		uv0[slot2]:SetData(slot1)

		return
	end

	uv0[slot2] = ActivityMartixOverTemplata.New(slot1)
end

function slot0.GetMatrixData(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetGameState(slot0, slot1)
	return uv0[slot1].game_state
end

function slot0.GetMatrixPhaseData(slot0, slot1)
	return uv0[slot1].phase
end

function slot0.GetIsClearance(slot0, slot1)
	if not uv0[slot1] then
		return true
	end

	return uv0[slot1]:GetIsClearance()
end

function slot0.GetMatrixHeroTeam(slot0, slot1)
	return uv0[slot1].matrix_hero_id_net_rec
end

function slot0.GetMatrixBattleHeroTeam(slot0, slot1)
	return uv0[slot1].battle_hero_id_list_cache or uv0[slot1].matrix_hero_id_net_rec
end

function slot0.SetMatrixBattleHeroTeam(slot0, slot1, slot2)
	uv0[slot1].battle_hero_id_list_cache = slot2
end

function slot0.GetHeroData(slot0, slot1, slot2)
	return uv0[slot1].matrix_hero_net_rec[slot2]
end

function slot0.GetTierID(slot0, slot1)
	return uv0[slot1].tier_id
end

function slot0.GetArtifactList(slot0, slot1)
	return uv0[slot1].artifact_list
end

function slot0.GetCustomAffix(slot0, slot1)
	return uv0[slot1].custom_affix_id_list
end

function slot0.GetHeroSkin(slot0, slot1, slot2)
	if (HeroData:GetHeroData(slot2) and slot3.using_skin or 0) == 0 then
		slot4 = slot2
	end

	return slot4
end

function slot0.GetCurrentClearTime(slot0, slot1)
	return uv0[slot1].currentClearTime_
end

function slot0.GetMinClearTime(slot0, slot1)
	return uv0[slot1].minClearTime_
end

function slot0.GetMatrixCurrencyList(slot0, slot1)
	return uv0[slot1].currencyList_
end

function slot0.GetMatrixOverPoint(slot0, slot1)
	return uv0[slot1].point
end

function slot0.GetMatrixIsFirstClear(slot0, slot1)
	return not uv0[slot1].success_times == 0
end

function slot0.GetWeaponServantLevel(slot0, slot1)
	return uv0[slot1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.WEAPON_LEVEL] or 0
end

function slot0.GetHeroEquipMaxCount(slot0, slot1)
	return uv0[slot1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.MAX_EQUIP_COUNT] or 0
end

function slot0.GetAstrolabeMaxCount(slot0, slot1)
	return uv0[slot1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.MAX_ASTROLABE_COUNT] or 0
end

function slot0.GetShoRefreshTimes(slot0, slot1)
	return uv0[slot1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_REFRESH_TIMES] or 0
end

function slot0.GetShopFressRefreshTimes(slot0, slot1)
	return uv0[slot1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_FRESS_REFRESH_TIMES] or 0
end

function slot0.GetFirstGoodsDiscount(slot0, slot1)
	return uv0[slot1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_FIRST_GOODS_DISCOUNT] or 1
end

function slot0.GetCanChangeCaptain(slot0, slot1)
	if uv0[slot1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.CHANGE_TEAM_LEADER] == 1 then
		return true
	end

	return false
end

function slot0.GetScoreAddition(slot0, slot1)
	if not uv0[slot1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SCORE_ADDITION] then
		return 0
	end

	return slot3 / 1000
end

function slot0.GetGiveUpRewardAddition(slot0, slot1)
	if not uv0[slot1].attribute_list[MatrixConst.MATRIX_ATTRIBUTE_TYPE.GIVE_UP_REWARD_ADDITION] then
		return 0
	end

	return slot3 / 1000
end

function slot0.GetRaceEffect(slot0, slot1)
	return false
end

function slot0.GetAffixList(slot0, slot1)
	if uv0[slot1] then
		slot2 = {}

		for slot7, slot8 in ipairs(uv0[slot1].custom_affix_id_list) do
			if MatrixAffixCfg[slot8] then
				table.insert(slot2, slot9.affix)
			end
		end

		return slot2
	end

	return {}
end

function slot0.GetArtifactAffixList(slot0, slot1)
	if uv0[slot1] then
		slot2 = {}

		for slot7, slot8 in ipairs(uv0[slot1].artifact_list) do
			slot10 = slot8.wins

			if MatrixItemCfg[slot8.id] and MatrixTools.GetAffixByEffectId(slot11.params[1], slot10) then
				table.insert(slot2, slot13)
			end
		end

		return slot2
	end

	return {}
end

function slot0.GetInitAffixList(slot0, slot1)
	slot2 = {}

	if uv0[slot1] then
		for slot7, slot8 in ipairs(uv0[slot1]:GetEffectList()) do
			if MatrixTools.GetAffixByEffectId(slot8.id, slot8.level) then
				table.insert(slot2, slot9)
			end
		end
	end

	return slot2
end

function slot0.GetTotalAffix(slot0, slot1)
	slot2 = {}

	table.insertto(slot2, slot0:GetAffixList(slot1))
	table.insertto(slot2, slot0:GetInitAffixList(slot1))

	return slot2
end

function slot0.CalMatrixAttribute(slot0, slot1)
	slot2 = {}

	if uv0[slot1] then
		for slot7, slot8 in ipairs(uv0[slot1]:GetEffectList()) do
			MatrixTools.GetAttrByEffectId(slot2, slot8.id)
		end
	end

	return slot2
end

function slot0.GetMatrixCoint(slot0, slot1)
	return uv0[slot1] and uv0[slot1]:GetMatrixCoint() or 0
end

function slot0.GetMatrixScore(slot0, slot1)
	return uv0[slot1] and uv0[slot1]:GetMatrixScore() or 0
end

function slot0.GetMapId(slot0, slot1)
	return uv0[slot1]:GetMapId()
end

function slot0.GetNodeList(slot0, slot1)
	return uv0[slot1]:GetNodeList()
end

function slot0.GetRead(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.SetRead(slot0, slot1)
	if not table.indexof(uv0, slot1) then
		table.insert(uv0, slot1)
	end
end

function slot0.SetDifficultySelect(slot0, slot1)
	uv0 = slot1

	saveData("StrategyMatrix", "difficulty", uv0)
end

function slot0.GetDifficultySelect(slot0)
	if uv0 then
		return uv0
	else
		uv0 = getData("StrategyMatrix", "difficulty") or 1

		return uv0
	end
end

return slot0
