slot1 = manager.net

slot1:Bind(18001, function (slot0)
	slot1 = slot0.game.progress.hero_list
	slot2 = nil

	if PolyhedronData:GetPolyhedronInfo() ~= nil then
		slot2 = PolyhedronData:GetPolyhedronInfo():GetHeroList()
	end

	slot4 = slot2 == nil and 0 or #slot2

	PolyhedronData:InitPolyhedronGameData(slot0)
	manager.notify:CallUpdateFunc(POLYHEDRON_GAME_UPDATE)

	if #slot1 >= 1 and slot4 >= 1 and slot4 < slot3 then
		slot6 = ComboSkillTools.GetRecommendSkillID(cleanProtoTable(slot0.game.progress.fight_hero_id_list), true)

		BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID(), slot6)
		manager.notify:Invoke(COMBO_SKILL_SELECT, slot6)
	elseif not SkillTools.CanUseComboSkill(slot0.game.progress.cooperate_unique_skill_id, PolyhedronData:GetPolyhedronInfo():GetFightHeroList()) then
		BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID(), 0)
		manager.notify:Invoke(COMBO_SKILL_SELECT, 0)
	elseif BattleTeamData:GetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID()) ~= slot5 then
		BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID(), slot5)
		manager.notify:Invoke(COMBO_SKILL_SELECT, slot5)
	end

	uv0.RefreshPolicyRedPoint()
	uv0.CheckBeaconRedPoint()
	uv0.CheckTerminalRedPoint()
	uv0:RefreshHeroesRedPoint()
end)

slot1 = manager.net

slot1:Bind(18003, function (slot0)
	PolyhedronData:UpdatePolyhedronProcess(slot0)
	manager.notify:CallUpdateFunc(POLYHEDRON_PROCESS_UPDATE)
end)

slot1 = manager.net

slot1:Bind(18005, function (slot0)
	PolyhedronData:UpdatePolyhedronSettlement(slot0)
	uv0.RefreshPolicyRedPoint()
end)

slot1 = manager.notify

slot1:RegistListener(CURRENCY_UPDATE, function (slot0)
	if slot0 == CurrencyConst.CURRENCY_TYPE_POLYHEDRON_TERMINAL_EXP then
		PolyhedronData:UpdateTerminalLevel()

		if PolyhedronData:GetTerminalLevel() ~= PolyhedronData:GetTerminalLevel() then
			uv0.CheckTerminalRedPoint()
		end
	end
end)

slot1 = nil
slot2 = manager.notify

slot2:RegistListener(CURRENCY_UPDATE, function (slot0)
	if slot0 == CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS then
		uv0:RefreshHeroesRedPoint()
	end
end)

slot2 = PolyhedronConst.RANK_TYPE.ALL
slot3 = PolyhedronConst.RANK_SUB_TYPE.SCORE
slot4 = nil

return {
	QueryStartPolyhedron = function (slot0, slot1, slot2)
		slot3, slot4 = pcall(function ()
			manager.net:SendWithLoadingNew(18010, {
				hero_id_list = uv0,
				beacon_id_list = uv1,
				difficulty = uv2
			}, 18011, uv3.StartPolyhedronCallBack)
		end)

		if slot4 then
			slot5 = ""

			if slot0 ~= nil then
				for slot9, slot10 in ipairs(slot0) do
					slot5 = slot5 .. slot0[slot9]

					if slot9 ~= #slot0 then
						slot5 = slot5 .. ","
					end
				end
			else
				slot5 = "nil"
			end

			slot6 = ""

			if slot1 ~= nil then
				for slot10, slot11 in ipairs(slot1) do
					slot6 = slot6 .. slot1[slot10]

					if slot10 ~= #slot1 then
						slot6 = slot6 .. ","
					end
				end
			else
				slot5 = "nil"
			end

			error(string.format("发给服务端的数据错误：hero_id_list = {%s}, beacon_id_list = {%s}, difficulty = %s", slot5, slot6, tostring(slot2)))
		end
	end,
	StartPolyhedronCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			uv0.LaunchPolyhedronBattle()
		else
			ShowTips(slot0.result)
		end
	end,
	QueryRewardPolyhedron = function (slot0)
		manager.net:SendWithLoadingNew(18012, {
			index = slot0
		}, 18013, uv0.RewardPolyhedronCallBack)
	end,
	RewardPolyhedronCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if PolyhedronConst.SAVE_POINT_TYPE.REWARD == PolyhedronData:GetPolyhedronInfo():GetSavePoint() then
				gameContext:Go("polyhedronReward")
			else
				JumpTools.OpenPageByJump("/polyhedronBlank/polyhedronBattle")
				DoPolyhedronNextTrigger()
			end
		else
			ShowTips(slot0.result)
		end
	end,
	QueryResetRewardPolyhedron = function ()
		manager.net:SendWithLoadingNew(18030, {}, 18031, uv0.ResetRewardPolyhedronCallBack)
	end,
	ResetRewardPolyhedronCallBack = function (slot0)
		if isSuccess(slot0.result) then
			gameContext:Go("polyhedronReward")
		else
			ShowTips(slot0.result)
		end
	end,
	QuerySelectStagePolyhedron = function (slot0)
		manager.net:SendWithLoadingNew(18014, {
			index = slot0
		}, 18015, uv0.SelectStagePolyhedronCallBack)
	end,
	SelectStagePolyhedronCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			uv0.LaunchPolyhedronBattle()
		else
			ShowTips(slot0.result)
		end
	end,
	QueryUnlockHero = function (slot0)
		if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS) > 0 then
			manager.net:SendWithLoadingNew(18036, {
				hero_id = slot0
			}, 18037, uv0.UnlockHeroCallBack)
		else
			ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
		end
	end,
	UnlockHeroCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CurrencyData:CurrencyModify(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS, -1)
			PolyhedronData:UnlockHero(slot1.hero_id)
			uv0:RefreshHeroesRedPoint()
			manager.notify:CallUpdateFunc(POLYHEDRON_HERO_UNLOCK)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryPolyhedronReset = function ()
		manager.net:SendWithLoadingNew(18016, {}, 18017, uv0.PolyhedronResetCallBack)
	end,
	PolyhedronResetCallBack = function (slot0)
		if isSuccess(slot0.result) then
			BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, 0, 0)
			manager.notify:Invoke(COMBO_SKILL_SELECT, 0)
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
		else
			ShowTips(slot0.result)
		end
	end,
	QueryPolyhedronGiveUp = function (slot0)
		manager.net:SendWithLoadingNew(18018, {}, 18019, slot0)
	end,
	QueryEnlistHero = function (slot0)
		uv0 = slot0.enlist_type

		manager.net:SendWithLoadingNew(18020, {
			hero_id = slot0.heroId
		}, 18021, uv1.EnlistHeroCallBack)
	end,
	EnlistHeroCallBack = function (slot0)
		if isSuccess(slot0.result) then
			if uv0 == PolyhedronConst.ENLIST_TYPE.BATTLE then
				DoPolyhedronNextBattleTrigger()
			else
				DoPolyhedronNextTrigger()
			end

			gameContext:Go("/polyhedronBlank")
		else
			ShowTips(slot0.result)
		end
	end,
	QueryBuyShopItem = function (slot0)
		manager.net:SendWithLoadingNew(18022, {
			index = slot0
		}, 18023, uv0.BuyShopItemCallBack)
	end,
	BuyShopItemCallBack = function (slot0)
		if isSuccess(slot0.result) then
			ShowTips("TRANSACTION_SUCCESS")
		else
			ShowTips(slot0.result)
		end
	end,
	QueryRefreshShop = function ()
		slot0 = PolyhedronData:GetPolyhedronInfo()
		slot3 = slot0:GetShopFressRefreshTimes()
		slot4 = slot0:GetCoinCount()

		if slot0:GetShopRefreshTimes() < slot0:GetShopMaxRefreshTimes() then
			if slot3 <= slot1 then
				if slot4 < slot0:GetShopRefreshCost(slot1 - slot3 + 1) then
					ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

					return
				end

				manager.net:SendWithLoadingNew(18024, {}, 18025, uv0.RefreshShopCallBack)
			else
				manager.net:SendWithLoadingNew(18024, {}, 18025, uv0.RefreshShopCallBack)
			end
		end
	end,
	RefreshShopCallBack = function (slot0)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	QueryShopBloodReturn = function ()
		manager.net:SendWithLoadingNew(18026, {}, 18027, uv0.ShopBloodReturnCallBack)
	end,
	ShopBloodReturnCallBack = function (slot0)
		if isSuccess(slot0.result) then
			UpdatePolyhedronBattleHpUI()
		else
			ShowTips(slot0.result)
		end
	end,
	QuerySwitchTeamHero = function (slot0)
		manager.net:SendWithLoadingNew(18028, {
			fight_id_list = slot0
		}, 18029, uv0.SwitchTeamHeroCallBack)
	end,
	SwitchTeamHeroCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = ComboSkillTools.GetRecommendSkillID(slot1.fight_id_list, true)

			BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, 0, slot2)
			manager.notify:Invoke(COMBO_SKILL_SELECT, slot2)
			manager.notify:CallUpdateFunc(POLYHEDRON_SWITCH_HERO)
		else
			ShowTips(slot0.result)
		end
	end,
	LaunchPolyhedronBattle = function ()
		JumpTools.OpenPageByJump("/polyhedronBlank")
		BattleController.GetInstance():LaunchBattle(BattlePolyhedronStageTemplate.New(PolyhedronData:GetPolyhedronInfo():GetStageId()))
	end,
	QuerySetTerminal = function (slot0)
		manager.net:SendWithLoadingNew(18032, {
			upgrade_id_list = slot0
		}, 18033, uv0.SetTerminalCallBack)
	end,
	SetTerminalCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PolyhedronData:SetTerminalGift(slot1.upgrade_id_list)
			uv0.CheckTerminalRedPoint()
		else
			ShowTips(slot0.result)
		end
	end,
	QueryUnlockBeacon = function (slot0)
		manager.net:SendWithLoadingNew(18034, {
			beacon_id = slot0
		}, 18035, uv0.UnlockBeaconCallBack)
	end,
	UnlockBeaconCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PolyhedronData:AddUnlockBeacon(slot1.beacon_id)
			manager.notify:CallUpdateFunc(POLYHEDRON_BEACON_UNLOCK)
			ShowTips(GetTips("POLYHEDRON_BEACON_UNLOCK_SUCCESS"))
			uv0.CheckBeaconRedPoint()
		else
			ShowTips(slot0.result)
		end
	end,
	CheckBeaconRedPoint = function (slot0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
			manager.redPoint:setTip(RedPointConst.POLYHEDRON_BEACON_UNLOCK, 0)

			return
		end

		for slot5, slot6 in ipairs(PolyhedronBeaconCfg.all) do
			if PolyhedronData:GetBeaconIsLock(slot6) and PolyhedronTools.GetBeaconIsUnlockCondition(slot6) then
				manager.redPoint:setTip(RedPointConst.POLYHEDRON_BEACON_UNLOCK, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.POLYHEDRON_BEACON_UNLOCK, 0)
	end,
	CheckTerminalRedPoint = function (slot0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
			manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 0)

			return false
		end

		slot2 = 0

		for slot6, slot7 in pairs(PolyhedronData:GetTerminalGift()) do
			slot2 = slot2 + PolyhedronTerminalCfg[slot7].cost
		end

		if PolyhedronTerminalLevelCfg[PolyhedronData:GetTerminalLevel()].point - slot2 <= 0 then
			manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 0)

			return false
		end

		for slot9, slot10 in ipairs(PolyhedronTerminalCfg.all) do
			if not table.indexof(slot1, slot10) then
				for slot16, slot17 in ipairs(PolyhedronTerminalCfg[slot10].pre_id_list) do
					if (slot17 == 0 or table.indexof(slot1, slot17)) and slot11.cost <= slot5 then
						manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 1)

						return
					end
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 0)

		return false
	end,
	RefreshHeroesRedPoint = function (slot0)
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_HERO_UNLOCK, uv0:GetPolyhedronHeroesRedPointCount())
	end,
	GetPolyhedronHeroesRedPointCount = function (slot0)
		if not PolyhedronHeroCfg.get_id_list_by_is_leader[1] then
			return 0
		end

		for slot5, slot6 in ipairs(slot1) do
			if uv0:GetPolyhedronHeroRedPointCount(slot6) > 0 then
				return 1
			end
		end

		return 0
	end,
	GetPolyhedronHeroRedPointCount = function (slot0, slot1)
		if not HeroTools.GetHeroIsUnlock(slot1) then
			return 0
		end

		if PolyhedronData:GetPolyhedronHeroUnlock(slot1) then
			return 0
		end

		if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS) < 1 then
			return 0
		end

		return PolyhedronData:GetHeroClicked(slot1) and 0 or 1
	end,
	QueryPolicyReward = function (slot0, slot1)
		slot2 = {
			type = slot0
		}

		if slot0 == 2 then
			slot2.level = slot1
		end

		manager.net:SendWithLoadingNew(66000, slot2, 66001, uv0.QueryPolicyRewardCallBack)
	end,
	QueryPolicyRewardCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {}
			slot5 = PolyhedronPolicyCfg.get_id_list_by_activity_id[ActivityCfg[PolyhedronData:GetActivityID()].policy_activity_id]
			slot6 = {}

			if slot1.type == 1 then
				slot7, slot8 = PolyhedronTools.PolyhedronPolicyExpToLevel()
				slot9 = PolyhedronData:GetPolicyApplyList()

				for slot13 = 1, slot7 do
					if slot9[slot13] == nil then
						table.insertto(slot2, PolyhedronPolicyCfg[slot5[slot13]].rewards)

						slot6[#slot6 + 1] = slot13
					end
				end
			else
				slot2 = PolyhedronPolicyCfg[slot5[slot1.level]].rewards
				slot6[#slot6 + 1] = slot1.level
			end

			getReward(mergeReward(slot2))
			PolyhedronData:SetPolicyApplyList(slot6)
			manager.notify:CallUpdateFunc(POLYHEDRON_POLICY_REWARD_RECEIVE)
			uv0.RefreshPolicyRedPoint()
		else
			ShowTips(slot0.result)
		end
	end,
	RefreshPolicyRedPoint = function ()
		slot0, slot1 = PolyhedronTools.PolyhedronPolicyExpToLevel()
		slot2 = PolyhedronData:GetPolicyApplyList()

		for slot6 = 1, slot0 do
			if slot2[slot6] == nil then
				manager.redPoint:setTip(RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD, 0)
	end,
	ResetRankCache = function ()
		uv0 = PolyhedronConst.RANK_TYPE.ALL
		uv1 = PolyhedronConst.RANK_SUB_TYPE.SCORE
		uv2 = nil
	end,
	QueryCurRank = function (slot0, slot1)
		slot2 = manager.net
		slot2 = slot2:Send(65102, {
			type = slot0
		}, 65103)

		slot2:next(function (slot0)
			if isSuccess(slot0.result) then
				PolyhedronData:InitCurRank(slot0, uv0)

				if uv1 then
					uv1()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	QueryOpenRankView = function ()
		if GuildData:GetGuildInfo() == nil or slot0.id == nil then
			uv0 = PolyhedronConst.RANK_TYPE.ALL
		end

		if PolyhedronConst.RANK_TYPE.GUILD == uv0 then
			uv1.QueryGuildRankList(uv2, uv3)
		else
			uv1.QueryRankList(uv2, uv3)
		end
	end,
	QueryRankList = function (slot0, slot1)
		slot5 = {
			start = 1,
			stop = 100,
			version = PolyhedronData:GetRankVersion(slot0, slot1),
			type = slot0
		}

		if slot0 == PolyhedronConst.RANK_SUB_TYPE.HERO then
			slot5.hero_id = slot1
		end

		manager.net:SendWithLoadingNew(65100, slot5, 65101, uv0.OnRankListCallBack)
	end,
	OnRankListCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PolyhedronData:InitRankData(slot0, slot1)
		end

		uv0 = PolyhedronConst.RANK_TYPE.ALL
		uv1 = slot1.type
		uv2 = slot1.hero_id

		JumpTools.OpenPageByJump("/polyhedronRank", {
			type = uv0,
			subType = uv1,
			heroID = uv2
		})
	end,
	QueryGuildRankList = function (slot0, slot1)
		GuildAction.RequiredGuildMemberList(function ()
			slot0 = {
				type = uv0
			}

			if uv0 == PolyhedronConst.RANK_SUB_TYPE.HERO then
				slot0.hero_id = uv1
			end

			manager.net:SendWithLoadingNew(33308, slot0, 33309, uv2.OnGuildRankListCallBack)
		end)
	end,
	OnGuildRankListCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PolyhedronData:InitGuildRankData(slot0, slot1)
		else
			PolyhedronData:ResetGuildRankData()
		end

		uv0 = PolyhedronConst.RANK_TYPE.GUILD
		uv1 = slot1.type
		uv2 = slot1.hero_id

		JumpTools.OpenPageByJump("/polyhedronRank", {
			type = uv0,
			subType = uv1,
			heroID = uv2
		})
	end,
	ResetTerminal = function ()
		manager.net:SendWithLoadingNew(66002, {}, 66003, uv0.OnResetTerminalCallback)
	end,
	OnResetTerminalCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PolyhedronData:ResetTerminalCallback()
		else
			ShowTips(GetTips(slot0.result))
		end
	end
}
