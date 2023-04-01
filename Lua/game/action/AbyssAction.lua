slot1 = manager.notify

slot1:RegistListener(NEW_DAY, function ()
	uv0.UpdateChallengeRedPoints()
end)

slot1 = manager.net

slot1:Bind(55001, function (slot0)
	AbyssData:InitFromServer(slot0)
	uv0.UpdateRedPoints()
	manager.notify:CallUpdateFunc(ABYSS_TIME_OUT_UPDATE)
end)

slot1 = manager.net

slot1:Bind(55009, function (slot0)
	AbyssData:UpdateResetTime(slot0)
	uv0.UpdateRedPoints()
end)

slot1 = manager.net

slot1:Bind(55011, function (slot0)
	AbyssData:UpdateBossInfo(slot0)
	uv0.UpdateRedPoints()
end)

slot1 = manager.net

slot1:Bind(55015, function (slot0)
	AbyssData:UpdateNormalLayerHeroLock(slot0)
	uv0.UpdateRedPoints()
end)

slot1 = manager.net

slot1:Bind(55017, function (slot0)
	AbyssData:UpdateLayerUnlock(slot0)
	uv0.UpdateRedPoints()
end)

slot1, slot2 = nil

return {
	UpdateRedPoints = function ()
		uv0.UpdateRewardRedPoints()
		uv0.UpdateChallengeRedPoints()
	end,
	UpdateRewardRedPoints = function ()
		slot1 = AbyssData:GetCanGetLayers()

		if PlayerData:GetPlayerInfo().userLevel < ChapterClientCfg[502].level then
			manager.redPoint:setTip(RedPointConst.ABYSS_REWARD, 0)
		elseif #slot1 > 0 then
			manager.redPoint:setTip(RedPointConst.ABYSS_REWARD, 1)
		else
			manager.redPoint:setTip(RedPointConst.ABYSS_REWARD, 0)
		end
	end,
	UpdateChallengeRedPoints = function ()
		slot0 = false

		for slot4, slot5 in ipairs(AbyssCfg.all) do
			for slot10, slot11 in ipairs(AbyssCfg[slot5].stage_list) do
				if AbyssData:GetStageData(slot5, slot10) and slot12.is_completed then
					slot0 = true

					break
				end
			end

			if slot0 then
				break
			end
		end

		slot1 = AbyssData:HaveGetBonusNum()
		slot2 = getData("abyss", "click_time") or 0
		slot3 = _G.gameTimer:GetNextDayFreshTime()

		if PlayerData:GetPlayerInfo().userLevel < ChapterClientCfg[502].level then
			manager.redPoint:setTip(RedPointConst.ABYSS_CHALLENGE, 0)
		elseif slot0 or slot1 > 0 or slot3 > 0 and slot3 <= slot2 then
			manager.redPoint:setTip(RedPointConst.ABYSS_CHALLENGE, 0)
		else
			manager.redPoint:setTip(RedPointConst.ABYSS_CHALLENGE, 1)
		end
	end,
	ClickChallengeRedPoint = function ()
		saveData("abyss", "click_time", _G.gameTimer:GetNextDayFreshTime())
		uv0.UpdateChallengeRedPoints()
	end,
	ResetLayer = function (slot0)
		manager.net:SendWithLoadingNew(55002, {
			layer = slot0
		}, 55003, uv0.OnResetLayerCallback)
	end,
	OnResetLayerCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			AbyssData:OnResetLayer(slot1.layer)
			uv0.UpdateRedPoints()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	ResetStage = function (slot0, slot1, slot2)
		uv0 = slot0
		uv1 = slot1

		manager.net:SendWithLoadingNew(55004, {
			stage_id = slot2
		}, 55005, uv2.OnResetStageCallback)
	end,
	OnResetStageCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			AbyssData:OnResetStage(uv0, uv1, slot1.stage_id)

			uv0 = nil
			uv1 = nil

			uv2.UpdateRedPoints()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	GetLayerBonus = function (slot0)
		manager.net:SendWithLoadingNew(55006, {
			layer_list = slot0
		}, 55007, uv0.OnGetLayerBonusCallback)
	end,
	OnGetLayerBonusCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {}

			for slot6, slot7 in ipairs(slot1.layer_list) do
				table.insertto(slot2, AbyssCfg[slot7].reward_list)
			end

			getReward(mergeReward(slot2))
			AbyssData:OnLayerBonusGet(slot1.layer_list)
			uv0.UpdateRedPoints()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	SaveProgress = function (slot0, slot1)
		manager.net:SendWithLoadingNew(55012, {
			stage_id = slot0,
			is_save = slot1
		}, 55013, uv0.OnSaveProgressCallback)
	end,
	OnSaveProgressCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			uv0.UpdateRedPoints()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	GetRankData = function (slot0, slot1)
		manager.net:SendWithLoadingNew(55018, {
			start = slot0,
			stop = slot1,
			version = AbyssData:GetCurRankVersion()
		}, 55019, uv0.OnGetRankDataCallback)
	end,
	OnGetRankDataCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			AbyssData:OnGetRankList(slot0)
		end

		manager.notify:Invoke(ABYSS_RANK_UPDATE, "all")
	end,
	ReadBackFlag = function ()
		manager.net:SendWithLoadingNew(55020, {}, 55021, uv0.OnReadBackFlagCallback)
	end,
	OnReadBackFlagCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			AbyssData:OnReadBackFlag()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	ClearTeamCache = function (slot0)
		AbyssData:ClearTeamCache(slot0)
	end,
	GetGuildRankInfo = function ()
		manager.net:SendWithLoadingNew(33306, {}, 33307, uv0.OnCallback)
	end,
	OnCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			AbyssData:OnGetGuildRankList(slot0)
			manager.notify:Invoke(ABYSS_RANK_UPDATE, "guild")
		else
			ShowTips(GetTips(slot0.result))
		end
	end
}
