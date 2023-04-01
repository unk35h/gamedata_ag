slot0 = singletonClass("BattleController")
slot1 = nil

function slot0.GetBattleStageData(slot0)
	return uv0
end

function slot0.SetBattleStageData(slot0, slot1)
	uv0 = slot1
end

function slot0.LaunchBattle(slot0, slot1, slot2)
	WaitStartBattle = nil
	slot3 = slot1:GetType()
	slot4 = slot1:GetDest()
	slot5 = slot1:GetMultiple()
	slot6 = slot1:GetType()
	slot7, slot8 = slot1:GetHeroTeam()
	slot9 = slot1:GetAssistHeroOwnerList()
	slot11 = clone(slot8)

	for slot15 = #clone(slot7), 1, -1 do
		if slot10[slot15] == 0 then
			table.remove(slot10, slot15)
			table.remove(slot11, slot15)
		end
	end

	for slot15 = 1, 2 do
		for slot19 = slot15 + 1, 3 do
			if slot10[slot15] and slot10[slot19] and slot10[slot15] ~= 0 and slot10[slot15] == slot10[slot19] then
				ShowTips("TEAM_REPEAT_HERO")

				return
			end
		end
	end

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot6 or BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == slot6 then
		slot11 = slot1:GetSystemHeroTeam()
	end

	slot12 = slot1:GetComboSkillID() or 0
	slot13 = slot1:GetSystemHeroTeam()
	slot14 = {}

	for slot18, slot19 in ipairs(slot10) do
		slot14[slot18] = {}

		if slot8[slot18] ~= 0 and slot8[slot18] ~= nil then
			slot14[slot18].hero_type = 2
			slot14[slot18].owner_id = 0
			slot14[slot18].hero_id = slot8[slot18]
		elseif slot13[slot18] ~= 0 and slot13[slot18] ~= nil then
			slot14[slot18].hero_type = 2
			slot14[slot18].owner_id = 0
			slot14[slot18].hero_id = slot13[slot18]
		else
			slot14[slot18].owner_id = 0
			slot14[slot18].hero_id = slot10[slot18]
			slot14[slot18].owner_id = slot9[slot18] or 0
			slot14[slot18].hero_type = tonumber(slot14[slot18].owner_id) == 0 and 1 or 3
		end

		slot14[slot18].owner_id = tonumber(slot14[slot18].owner_id)
	end

	slot15 = manager.net

	slot15:SendWithLoadingNew(54030, {
		hero_list = slot14,
		dest = slot4,
		activity_id = slot1:GetActivityID() or 0,
		battle_times = slot5,
		type = slot6,
		index = slot1:GetServerExtant(),
		cooperate_unique_skill_id = slot12,
		battle_vs = LuaForUtil.GetBattleVersion(),
		mimir_info = {
			{
				mimir_id = ChipData:GetCurEnabledChipManagerID(),
				chip_list = ChipData:GetCurChipManagerList(ChipData:GetCurEnabledChipManagerID())
			}
		}
	}, 54031, function (slot0)
		if uv0 then
			uv0(slot0)
		end

		if isSuccess(slot0.result) then
			uv1 = uv2

			manager.net:RegistPushWaiting(54007, function ()
			end)
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.LaunchCooperationBattle(slot0)
	slot1 = manager.net

	slot1:SendWithLoadingNew(37014, {}, 37015, function (slot0)
		if isSuccess(slot0.result) then
			WaitStartBattle = nil
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.LaunchStoryBattle(slot0, slot1, slot2, slot3)
	slot4 = manager.story

	slot4:CheckBattleStory(slot2, manager.story.BEFORE, function ()
		slot0 = gameContext

		slot0:Go("/blank")

		slot0 = manager.net

		slot0:SendWithLoadingNew(54034, {
			stage_id = uv0,
			activity_id = uv1
		}, 54035, function (slot0)
			if isSuccess(slot0.result) then
				uv3 = BattleStageFactory.Produce(uv0, uv1, uv2)
				slot2 = uv3

				slot2:SetIsStoryTag(true)

				slot3 = manager.net

				slot3:SendWithLoadingNew(54032, {
					battle_id = slot0.battle_id
				}, 54033, function (slot0, slot1)
					gameContext:Back()
					manager.story:RemovePlayer()
					BattleFieldData:FinishBattle(slot0)
					GotoTeam(uv0, slot0.battle_result)
				end)

				return
			end

			ShowTips(slot0.result)
			gameContext:Back()
			manager.story:RemovePlayer()
		end)
	end, false)
end

function slot0.UpdateHeroTeam(slot0, slot1)
	if not uv0 then
		error("Loss Current BattleStageData In UpdateHeroTeam")

		return
	end

	uv0:UpdateRoleDatas(slot1)
end

function slot0.StartBattle(slot0, slot1)
	if not uv0 then
		error("Loss Current BattleStageData In StartBattle")

		return
	end

	slot2 = uv0
	slot3 = BattleFieldData
	slot3 = slot3:GetServerBattleID()
	slot4 = BattleFieldData
	slot4, slot5 = slot4:GetBattleServerIPAndPort()
	slot6 = GetSceneDataForExcehange()
	slot6.leftTime = slot2:GetBattleTime() * 1000
	slot6.typeIDListAffix, slot6.levelList, slot6.enemyTypes = slot2:GetStageAffix()
	slot6.mSceneID, slot11 = slot2:GetMap()

	LuaExchangeHelper.SetNewbie(slot11)

	slot6.needResurrect, slot13, slot6.coinNumber, slot6.coinConsume, slot16 = slot2:GetRevive()

	if pcall(function ()
		slot0 = uv0.maxCoinNumber
	end) then
		slot6.maxCoinNumber = slot16 or 0
	end

	slot6.resurrectHP = slot2:GetResurrectHP()
	slot6.resurrectImmediately = slot2:GetResurrectImmediately()
	slot6.challengeFactor = slot2:GetMultiple()
	slot6.mMissionClearTimes = slot2:GetClearTime()
	slot6.difficulty = slot2:GetAILevel()
	slot6.adaptiveEnemyLevel = slot2:GetEnemyLevel()
	slot6.roleDataInLua = slot2:GetRoleDatas()
	slot17 = slot2:GetAttributeFactor()
	slot6.attributeFactor = Int3.New(slot17.x * 1000, slot17.y * 1000, slot17.z * 1000)
	slot6.cooperateUniqueSkillID = slot2:GetComboSkillID()
	slot6.maxRaceID, slot6.maxRacePlayerCount = slot2:GetMaxRaceData()
	slot6.targetEnemyID = slot2:GetTargetEnemyID()

	LuaExchangeHelper.SetIPAndPort(slot4, slot5)

	slot6.battleID = slot3
	slot6.Uuid = PlayerData:GetPlayerInfo().userID
	slot6.isMultiplayer = slot1
	slot20 = SettingData:GetSettingData()

	LuaExchangeHelper.SetPlayerQuality(slot20.pic.resolution)
	LuaExchangeHelper.SetAIQuality(slot20.pic.teammate_effect - 1)
	LuaExchangeHelper.SetCooperateUniqueSkillPlayControlledType(slot20.game.cus_full_play_controlled_type)

	slot21 = manager.time:GetServerTime()

	function slot22()
		if manager.time:GetServerTime() - uv0 > 1500 then
			ConnectionHelper.ShowReturnToLoginTip()
			manager.story:RemovePlayer()

			return
		end

		uv1:TryToStartBattle()
	end

	if slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		manager.story:CheckChessBattleStory(manager.story.BEFORE, slot22)
	else
		manager.story:CheckBattleStory(slot2:GetStageId(), manager.story.BEFORE, slot22)
	end

	BattleCallLuaCallBackWait = true
end

function slot0.TryToStartBattle(slot0)
	SetForceShowQuanquan(true)
	LuaExchangeHelper.Launcher(GetSceneDataForExcehange(), function ()
		SetForceShowQuanquan(false)
		manager.story:RemovePlayer()

		_G.BATTLE_SERVER_ERROR_TIME = 0
		whereami = "battle"

		DestroyLua()
	end)
end

function slot0.SetHeroData(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = nil

	if slot2 and slot2 ~= 0 then
		slot5, slot6 = GetVirtualData(slot2)
	else
		slot5, slot6 = GetPracticalData(slot1)
	end

	slot8, slot9, slot10 = HeroTools.CalTransitionSkillAttribute(slot5, slot6)
	slot11 = RoleDataForExchange.New()
	slot11.UID = slot3
	slot11.playerLevel = slot4
	slot11.ID = slot5.skin_id
	slot11.Level = LvTools.CheckHeroExp(1, slot5.exp, HeroConst.HERO_LV_MAX)
	slot12 = {}
	slot13 = {}

	for slot17, slot18 in pairs(GetHeroFinalAttr(slot5, slot6, slot2)) do
		if PublicAttrCfg[slot17] then
			table.insert(slot12, slot19.id)
			table.insert(slot13, slot18)
		end
	end

	slot19 = slot5.weapon_module_level
	slot14, slot15 = BattleTools.FixBattleAttributeListAndWeaponModule(slot12, slot13, slot5.skin_id, slot19)
	slot11.attributeID = slot14
	slot11.attributeValue = slot15
	slot14 = {}
	slot15 = {}

	for slot19, slot20 in pairs(slot9) do
		table.insert(slot14, slot19)
		table.insert(slot15, slot20)
	end

	slot11.equipSkillID = slot14
	slot11.equipSkillLv = slot15
	slot16 = {}
	slot17 = AstrolabeTools.GetTotalEffect(slot5.using_astrolabe)

	for slot21 = 1, 6 do
		slot16[slot21] = slot17[slot21] or 0
	end

	slot11.astrolabe = slot16
	slot18 = {}

	for slot23, slot24 in pairs(EquipTools.GetEffectS(slot6, slot5)) do
		table.insert(slot18, slot23)
	end

	slot11.equipment = slot18
	slot20 = {}
	slot21 = HeroCfg[slot5.id]
	slot22 = {}

	for slot26, slot27 in ipairs(slot5.skill) do
		slot22[slot27.skill_id] = slot27.skill_level
	end

	for slot26, slot27 in pairs(slot10) do
		slot22[slot26] = (slot22[slot26] or 1) + slot27
	end

	for slot26, slot27 in ipairs(slot21.skills) do
		slot20[slot26] = slot22[slot27] or 1
	end

	slot11.skillLevel = slot20

	if slot5.servant.id and slot5.servant.id ~= 0 then
		slot11.weaponEffectID = WeaponServantCfg[slot5.servant.id].effect[1]
		slot11.weaponEffectLevel = slot5.servant.stage + HeroTools.GetHeroWeaponAddLevel(slot5)
	end

	slot23 = {}

	if (uv0:GetChipManagerID() or 0) ~= 0 then
		table.insert(slot23, slot24)
	end

	if uv0:GetChipOfHeroDic()[slot11.ID] then
		if slot24 ~= 0 then
			slot27 = ChipData
			slot29 = slot27

			for slot28, slot29 in ipairs(slot27.GetCurChipManagerList(slot29, slot24)) do
				table.insert(slot23, slot29)
			end
		end

		slot27 = uv0
		slot29 = slot27
		slot28 = slot11.ID

		for slot28, slot29 in ipairs(slot27.GetChipOfHeroDic(slot29)[slot28]) do
			table.insert(slot23, slot29)
		end
	elseif uv0:GetChipList() then
		for slot29, slot30 in ipairs(slot25) do
			table.insert(slot23, slot30)
		end
	end

	slot11.AIChip = slot23

	return slot11
end

function slot0.SetMatrixHeroData(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot1:GetStandardId()
	slot6, slot7 = nil

	if slot1:GetIsOwnerHero() then
		slot6, slot7 = GetPracticalData(slot1:GetEntrySnapShot())
	else
		slot6, slot7 = GetVirtualData(slot5)
	end

	slot8 = RoleDataForExchange.New()
	slot9 = HeroStandardSystemCfg[slot5]

	if slot4 then
		slot6.skin_id = ActivityMatrixData:GetHeroSkin(slot4, slot9.hero_id)
	else
		slot6.skin_id = MatrixData:GetHeroSkin(slot9.hero_id)
	end

	slot8.UID = slot2
	slot8.playerLevel = slot3
	slot8.ID = slot6.skin_id
	slot8.Level = LvTools.CheckHeroExp(1, slot6.exp, HeroConst.HERO_LV_MAX)
	slot16 = slot1
	slot10 = GetMatrixtHeroPracticalAttr(slot6, slot7, slot5, slot4, slot16)
	slot10[3] = slot1:GetHeroMaxHP()
	slot10[2002] = slot1:GetHeroHP()
	slot11 = {}
	slot12 = {}

	for slot16, slot17 in pairs(slot10) do
		if PublicAttrCfg[slot16] or slot16 == 2002 then
			table.insert(slot11, slot16)
			table.insert(slot12, slot17)
		end
	end

	slot8.attributeID = slot11
	slot8.attributeValue = slot12
	slot13 = {}
	slot14 = slot1:GetAstrolabeEffectList()

	for slot18 = 1, 6 do
		slot13[slot18] = slot14[slot18] or 0
	end

	slot8.astrolabe = slot13
	slot15 = {}
	slot8.equipment = slot1:GetEquipEffectList()
	slot17 = {}
	slot18 = HeroCfg[slot6.id]
	slot19 = {}

	for slot23, slot24 in ipairs(slot6.skill) do
		slot19[slot24.skill_id] = slot24.skill_level + HeroTools.GetHeroSkillAddLevel(slot6, slot24.skill_id)
	end

	for slot23, slot24 in ipairs(slot18.skills) do
		slot17[slot23] = slot19[slot24] or 1
	end

	slot8.skillLevel = slot17

	if slot1:GetWeaponServantEffect() ~= 0 then
		slot8.weaponEffectID = WeaponServantCfg[slot20].effect[1]
		slot8.weaponEffectLevel = slot1:GetWeaponServantEffectLevel()
	end

	slot21 = {}

	if uv0:GetChipManagerID() ~= 0 then
		slot26 = slot22

		table.insert(slot21, slot26)

		slot25 = uv0
		slot27 = slot25

		for slot26, slot27 in ipairs(slot25.GetChipList(slot27)) do
			table.insert(slot21, slot27)
		end
	end

	slot8.AIChip = slot21

	return slot8
end

function slot0.SetChessHeroData(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = nil

	if slot2 and slot2 ~= 0 then
		slot5, slot6 = GetVirtualData(slot2)
	else
		slot5, slot6 = GetPracticalData(slot1)
	end

	slot8, slot9, slot10 = HeroTools.CalTransitionSkillAttribute(slot5, slot6)
	slot11 = RoleDataForExchange.New()
	slot11.UID = slot3
	slot11.playerLevel = slot4
	slot11.ID = slot5.skin_id
	slot11.Level = LvTools.CheckHeroExp(1, slot5.exp, HeroConst.HERO_LV_MAX)
	slot12 = {}
	slot13 = {}

	for slot17, slot18 in pairs(GetHeroFinalAttr(slot5, slot6, slot2)) do
		if PublicAttrCfg[slot17] or slot17 == 2002 then
			table.insert(slot12, slot17)
			table.insert(slot13, slot18)
		end
	end

	slot19 = slot5.weapon_module_level
	slot14, slot15 = BattleTools.FixBattleAttributeListAndWeaponModule(slot12, slot13, slot5.skin_id, slot19)
	slot11.attributeID = slot14
	slot11.attributeValue = slot15
	slot14 = {}
	slot15 = {}

	for slot19, slot20 in pairs(slot9) do
		table.insert(slot14, slot19)
		table.insert(slot15, slot20)
	end

	slot11.equipSkillID = slot14
	slot11.equipSkillLv = slot15
	slot16 = {}
	slot17 = AstrolabeTools.GetTotalEffect(slot5.using_astrolabe)

	for slot21 = 1, 6 do
		slot16[slot21] = slot17[slot21] or 0
	end

	slot11.astrolabe = slot16
	slot18 = {}

	for slot23, slot24 in pairs(EquipTools.GetEffectS(slot6, slot5)) do
		table.insert(slot18, slot23)
	end

	slot11.equipment = slot18
	slot20 = {}
	slot21 = HeroCfg[slot5.id]
	slot22 = {}

	for slot26, slot27 in ipairs(slot5.skill) do
		slot22[slot27.skill_id] = slot27.skill_level + HeroTools.GetHeroSkillAddLevel(slot5, slot27.skill_id)
	end

	for slot26, slot27 in pairs(slot10) do
		slot22[slot26] = (slot22[slot26] or 1) + slot27
	end

	for slot26, slot27 in ipairs(slot21.skills) do
		slot20[slot26] = slot22[slot27] or 1
	end

	slot11.skillLevel = slot20

	if slot5.servant.id and slot5.servant.id ~= 0 then
		slot11.weaponEffectID = WeaponServantCfg[slot5.servant.id].effect[1]
		slot11.weaponEffectLevel = slot5.servant.stage + HeroTools.GetHeroWeaponAddLevel(slot5)
	end

	slot23 = {}

	if uv0:GetChipManagerID() ~= 0 then
		slot28 = slot24

		table.insert(slot23, slot28)

		slot27 = uv0
		slot29 = slot27

		for slot28, slot29 in ipairs(slot27.GetChipList(slot29)) do
			table.insert(slot23, slot29)
		end
	end

	slot11.AIChip = slot23

	return slot11
end

function slot0.SetEquipBreakThroughMaterialHeroData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7 = nil

	if slot3 and slot3 ~= 0 then
		slot6, slot7 = GetVirtualData(slot3)
	else
		slot6, slot7 = GetPracticalData(slot2)
	end

	slot8 = GetHeroFinalAttr(slot6, slot7, slot3)
	slot9, slot10, slot11 = HeroTools.CalTransitionSkillAttribute(slot6, slot7)
	slot12 = RoleDataForExchange.New()
	slot12.UID = slot4
	slot12.playerLevel = slot5
	slot12.ID = slot6.skin_id
	slot12.Level = LvTools.CheckHeroExp(1, slot6.exp, HeroConst.HERO_LV_MAX)
	slot13 = {}
	slot14 = {}

	if EquipBreakThroughMaterialData:GetHeroState()[slot1] and EquipBreakThroughMaterialData:GetHeroState()[slot1].rate or 10000 then
		slot8[2002] = math.ceil(slot15 / 10000 * slot8[3])
	end

	for slot19, slot20 in pairs(slot8) do
		if PublicAttrCfg[slot19] or slot19 == 2002 then
			table.insert(slot13, slot19)
			table.insert(slot14, slot20)
		end
	end

	slot21 = slot6.weapon_module_level
	slot16, slot17 = BattleTools.FixBattleAttributeListAndWeaponModule(slot13, slot14, slot6.skin_id, slot21)
	slot12.attributeID = slot16
	slot12.attributeValue = slot17
	slot16 = {}
	slot17 = {}

	for slot21, slot22 in pairs(slot10) do
		table.insert(slot16, slot21)
		table.insert(slot17, slot22)
	end

	slot12.equipSkillID = slot16
	slot12.equipSkillLv = slot17
	slot18 = {}
	slot19 = AstrolabeTools.GetTotalEffect(slot6.using_astrolabe)

	for slot23 = 1, 6 do
		slot18[slot23] = slot19[slot23] or 0
	end

	slot12.astrolabe = slot18
	slot20 = {}

	for slot25, slot26 in pairs(EquipTools.GetEffectS(slot7, slot6)) do
		table.insert(slot20, slot25)
	end

	slot12.equipment = slot20
	slot22 = {}
	slot23 = HeroCfg[slot6.id]
	slot24 = {}

	for slot28, slot29 in ipairs(slot6.skill) do
		slot24[slot29.skill_id] = slot29.skill_level + HeroTools.GetHeroSkillAddLevel(slot6, slot29.skill_id)
	end

	for slot28, slot29 in pairs(slot11) do
		slot24[slot28] = (slot24[slot28] or 1) + slot29
	end

	for slot28, slot29 in ipairs(slot23.skills) do
		slot22[slot28] = slot24[slot29] or 1
	end

	slot12.skillLevel = slot22

	if slot6.servant.id and slot6.servant.id ~= 0 then
		slot12.weaponEffectID = WeaponServantCfg[slot6.servant.id].effect[1]
		slot12.weaponEffectLevel = slot6.servant.stage + HeroTools.GetHeroWeaponAddLevel(slot6)
	end

	slot12.AIChip = uv0:GetChipAndAIList(slot12.ID)

	return slot12
end

function slot0.SetPolyhedronHeroData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7 = nil

	if slot2 == nil then
		slot6, slot7 = GetVirtualData(slot3)
	else
		slot6, slot7 = GetPracticalData(slot2)
	end

	slot8 = GetPolyhedronHeroPracticalAttr(slot1, slot6, slot7, slot3)
	slot9, slot10, slot11 = HeroTools.CalTransitionSkillAttribute(slot6, slot7)
	slot12 = RoleDataForExchange.New()
	slot12.UID = slot4
	slot12.playerLevel = slot5
	slot12.ID = slot6.skin_id
	slot12.Level = LvTools.CheckHeroExp(1, slot6.exp, HeroConst.HERO_LV_MAX)
	slot13 = {}
	slot14 = {}
	slot16 = slot1:GetHeroPolyData(slot6.id)
	slot8[3] = slot16:GetHeroMaxHP()
	slot20 = slot16
	slot8[2002] = slot16.GetHeroHP(slot20)

	for slot20, slot21 in pairs(slot8) do
		if PublicAttrCfg[slot20] or slot20 == 2002 then
			table.insert(slot13, slot20)
			table.insert(slot14, slot21)
		end
	end

	slot12.attributeID = slot13
	slot12.attributeValue = slot14
	slot17 = {}
	slot18 = {}

	for slot22, slot23 in pairs(slot10) do
		table.insert(slot17, slot22)
		table.insert(slot18, slot23)
	end

	slot12.equipSkillID = slot17
	slot12.equipSkillLv = slot18
	slot19 = {}
	slot20 = AstrolabeTools.GetTotalEffect(slot6.using_astrolabe)

	for slot24 = 1, 6 do
		slot19[slot24] = slot20[slot24] or 0
	end

	slot12.astrolabe = slot19
	slot21 = {}

	for slot26, slot27 in pairs(EquipTools.GetEffectS(slot7, slot6)) do
		table.insert(slot21, slot26)
	end

	slot12.equipment = slot21
	slot23 = {}
	slot24 = HeroCfg[slot6.id]
	slot25 = {}

	for slot29, slot30 in ipairs(slot6.skill) do
		slot25[slot30.skill_id] = slot30.skill_level + HeroTools.GetHeroSkillAddLevel(slot6, slot30.skill_id)
	end

	for slot29, slot30 in pairs(slot11) do
		slot25[slot29] = (slot25[slot29] or 1) + slot30
	end

	for slot29, slot30 in ipairs(slot24.skills) do
		slot23[slot29] = slot25[slot30] or 1
	end

	slot12.skillLevel = slot23

	if slot6.servant.id and slot6.servant.id ~= 0 then
		slot12.weaponEffectID = WeaponServantCfg[slot6.servant.id].effect[1]
		slot12.weaponEffectLevel = slot6.servant.stage + HeroTools.GetHeroWeaponAddLevel(slot6)
	end

	slot12.AIChip = {}

	return slot12
end

return slot0
