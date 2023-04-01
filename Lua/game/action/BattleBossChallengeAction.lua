slot0 = manager.net

slot0:Bind(45201, function (slot0)
	BattleBossChallengeData:InitData(slot0)
end)

slot0 = manager.net

slot0:Bind(45001, function (slot0)
	BattleBossChallengeNormalData:InitData(slot0)
	manager.notify:Invoke(BOSS_CHALLENGE_UPDATE)
end)

slot0 = manager.net

slot0:Bind(45003, function (slot0)
	BattleBossChallengeNormalData:SetUsedCnt(slot0.use_times)
	manager.notify:Invoke(BOSS_CHALLENGE_UPDATE_CHALLENGE_CNT)
end)

slot0 = manager.net

slot0:Bind(45101, function (slot0)
	BattleBossChallengeAdvanceData:InitData(slot0)
end)

return {
	RequireBossChallengeData = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(45202, {
			select = slot0
		}, 45203, function (slot0)
			if isSuccess(slot0.result) then
				uv0()
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ResetHardMode = function (slot0)
		slot1 = manager.net

		slot1:SendWithLoadingNew(45204, {}, 45205, function (slot0)
			BattleBossChallengeAdvanceData:Init()
			BattleBossChallengeData:Reset()
			uv0(slot0)
		end)
	end,
	ResetNormalModeBoss = function (slot0, slot1)
		slot2 = BattleBossChallengeNormalData
		slot3 = manager.net

		slot3:SendWithLoadingNew(45006, {
			group_id = slot2:GetBossList()[slot0]
		}, 45007, function (slot0)
			BattleBossChallengeNormalData:ResetBoss(uv0)
			uv1(slot0)
		end)
	end,
	ResetHardModeBoss = function (slot0, slot1)
		slot2 = BattleBossChallengeAdvanceData
		slot3 = manager.net

		slot3:SendWithLoadingNew(45106, {
			boss_id = slot2:GetBossList()[slot0].id
		}, 45107, function (slot0)
			BattleBossChallengeAdvanceData:ResetBoss(uv0)
			uv1(slot0)
		end)
	end,
	ChangeBossHeroTeam = function (slot0, slot1)
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NORMAL then
			slot3 = BattleBossChallengeNormalData
			slot4 = BattleBossChallengeNormalData

			slot4:SetCacheHeroTeam(slot0, slot1)

			slot4 = manager.net

			slot4:SendWithLoadingNew(45110, {
				group_id = slot3:GetBossList()[slot0],
				heroes_cfg = slot1
			}, 45111, function (slot0)
			end)
		else
			slot3 = BattleBossChallengeAdvanceData
			slot5 = BattleBossChallengeAdvanceData

			slot5:SetCacheHeroTeam(slot0, slot1)

			slot5 = manager.net

			slot5:SendWithLoadingNew(45108, {
				id = slot3:GetBossList()[slot0].id,
				heroes_cfg = slot1
			}, 45109, function (slot0)
			end)
		end
	end,
	RequireBossExchange = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(45004, {
			star = slot0
		}, 45005, function (slot0)
			uv0(slot0)
		end)
	end,
	ClientModifyThreeStar = function (slot0, slot1)
		BattleBossChallengeNormalData:ClientModifyThreeStar(slot0, slot1)
	end,
	RequireBossPointExchange = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(45102, {
			point = slot0
		}, 45103, function (slot0)
			uv0(slot0)
		end)
	end,
	RequireAllBossPointExchange = function (slot0)
		slot1 = manager.net

		slot1:SendWithLoadingNew(45112, {}, 45113, function (slot0)
			uv0(slot0)
		end)
	end,
	ModifySelectAffix = function (slot0, slot1, slot2, slot3, slot4, slot5)
		slot6 = manager.net

		slot6:SendWithLoadingNew(45104, {
			id = slot0,
			affix_index_list = slot4,
			time_index_list = slot2,
			boss_ai_index_list = slot3,
			diffculty_index = slot1
		}, 45105, function (slot0)
			uv0(slot0)
		end)
	end,
	BossChallengeBackEntrace = function ()
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_REFRESH_DATA"),
			OkCallback = function ()
				if #BattleBossChallengeData:GetOpenModeList() >= 2 then
					gameContext:OverrideUrl("/bossSwitch", "/bossMode")
					gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode")
					gameContext:Go("/bossMode")
				else
					gameContext:Go("/bossSwitch")
				end
			end,
			MaskCallback = function ()
				if #BattleBossChallengeData:GetOpenModeList() >= 2 then
					gameContext:OverrideUrl("/bossSwitch", "/bossMode")
					gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode")
					gameContext:Go("/bossMode")
				else
					gameContext:Go("/bossSwitch")
				end
			end
		})
	end,
	EnterBossChallenge = function ()
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
			if #BattleBossChallengeData:GetOpenModeList() >= 2 then
				gameContext:Go("/bossMode")
			else
				gameContext:Go("/bossSwitch")
			end
		elseif slot0 == BossConst.MODE_NORMAL then
			gameContext:Go("/bossSwitch")
		else
			gameContext:Go("/bossAdvanceSwitch")
		end
	end
}
