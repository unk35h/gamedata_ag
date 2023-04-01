slot1, slot2 = nil
slot3 = manager.net

slot3:Bind(36001, function (slot0)
	GuildActivityData:InitMainDataFromServer(slot0)
	uv0.UpdateRedPoint(ActivityConst.GUILD_ACTIVITY_START)
end)

slot3 = manager.net

slot3:Bind(36003, function (slot0)
	GuildActivityData:UpdateGridsDataFromServer(slot0.grid_status)
end)

slot3 = manager.net

slot3:Bind(36005, function (slot0)
	GuildActivityData:UpdateGuildActivityHeroes(slot0.hero_list)
	uv0.UpdateOnFightNotFullRedPoint(ActivityConst.GUILD_ACTIVITY_START)
end)

slot3 = manager.net

slot3:Bind(36007, function (slot0)
	GuildActivityData:UpdateSelfGridDataFromServer(slot0)
end)

slot3 = manager.net

slot3:Bind(36009, function (slot0)
	GuildActivityData:SetIsSignFromServer(slot0.is_sign)
	uv0.UpdateUnregisterRedPoint()
	uv0.UpdateOnFightNotFullRedPoint(ActivityConst.GUILD_ACTIVITY_START)
end)

slot3 = manager.notify

slot3:RegistListener(GUILD_ENTER, function ()
	uv0.UpdateRedPoint(ActivityConst.GUILD_ACTIVITY_START)
end)

slot3 = manager.notify

slot3:RegistListener(HERO_UNLOCK_SUCCESS, function ()
	uv0.UpdateOnFightNotFullRedPoint(ActivityConst.GUILD_ACTIVITY_START)
end)

slot3 = manager.notify

slot3:RegistListener(HISTORY_UPDATE, function ()
	if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) == true then
		GuildActivityData:RefreshRateRedPoint(ActivityConst.GUILD_ACTIVITY_START)
	end
end)

return {
	Init = function ()
		uv0 = false
		uv1 = false
	end,
	UpdateRedPoint = function (slot0)
		uv0.UpdateUnregisterRedPoint()
		uv0.UpdateCoinRedPoint(slot0)
		uv0.UpdateOnFightNotFullRedPoint(slot0)

		slot1 = nil

		if not ActivityData:GetActivityIsOpen(slot0) then
			manager.redPoint:setTip(string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, slot0), 0)
			manager.redPoint:setTip(string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_RATE, slot0), 0)
		end
	end,
	UpdateUnregisterRedPoint = function ()
		slot0 = true

		if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
			slot0 = false
		end

		manager.redPoint:setTip(RedPointConst.GUILD_ACTIVITY_UNREGISTER, slot0 and not uv0.GetUnRegisterRedPointClicked() and not GuildActivityData:HaveRegister() and (ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) or ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_REGISTER)) and 1 or 0)
	end,
	UpdateCoinRedPoint = function (slot0)
		slot1 = true

		if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
			slot1 = false
		end

		slot2 = GuildActivityData:IsAllAffixMax(slot0)
		slot4 = false

		if GameSetting.activity_club_red_dot_need.value[1] <= GuildActivityData:GetTotalCoinToGet() then
			slot4 = true
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_UNGET_COIN, slot0), slot1 and not slot2 and ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) and not uv0.GetCoinRedPointClicked() and slot4 and 1 or 0)
	end,
	UpdateOnFightNotFullRedPoint = function (slot0)
		slot1 = true

		if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
			slot1 = false
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_ON_FIGHT_NOT_FULL, slot0), slot1 and ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) and GuildActivityData:HaveRegister() and not (math.min(GuildActivityData:CanTakeOnFightNum(), HeroData:GetHeroNum()) <= GuildActivityData:HaveTakeOnFightNum()) and 1 or 0)
	end,
	SetUnRegisterRedPointClicked = function (slot0)
		uv0 = slot0

		uv1.UpdateUnregisterRedPoint()
	end,
	GetUnRegisterRedPointClicked = function ()
		return uv0
	end,
	SetCoinRedPointClicked = function (slot0, slot1)
		uv0 = slot0

		uv1.UpdateCoinRedPoint(slot1)
	end,
	GetCoinRedPointClicked = function ()
		return uv0
	end,
	Register = function (slot0)
		slot2 = manager.net

		slot2:SendWithLoadingNew(36010, {}, 36011, function (slot0, slot1)
			if isSuccess(slot0.result) then
				ShowTips("ACTIVITY_CLUB_REGISTER_SUCCESS")
				GuildActivityData:SignUpSuccess()
				uv0()
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	EnterGuildWarField = function (slot0)
		slot2 = manager.net

		slot2:SendWithLoadingNew(36012, {}, 36013, function (slot0, slot1)
			if isSuccess(slot0.result) then
				GuildActivityData:InitGridsDataFromServer(slot0.grid_status)
				uv0()
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	ExitGuildWarField = function (slot0)
		slot2 = manager.net

		slot2:SendWithLoadingNew(36014, {}, 36015, function (slot0, slot1)
			if isSuccess(slot0.result) then
				uv0()
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	LockNode = function (slot0)
		manager.net:SendWithLoadingNew(36016, {
			id = slot0
		}, 36017, uv0.OnLockNodeCallback)
	end,
	OnLockNodeCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildActivityData:OnGridOccupying(slot1.id)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	UnlockNode = function (slot0)
		manager.net:SendWithLoadingNew(36018, {
			id = slot0
		}, 36019, uv0.OnUnLockNodeCallback)
	end,
	OnUnLockNodeCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildActivityData:OnGridCancelOccupy(slot1.id)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	GetFightRecord = function (slot0, slot1)
		slot3 = manager.net

		slot3:SendWithLoadingNew(36020, {
			id = slot0
		}, 36021, function (slot0, slot1)
			if isSuccess(slot0.result) then
				slot2 = {}

				for slot6, slot7 in ipairs(slot0.records) do
					table.insert(slot2, {
						uid = slot7.uid,
						icon = slot7.icon,
						icon_frame = slot7.icon_frame,
						name = slot7.name,
						damage = slot7.damage,
						hero_list = slot7.hero_list,
						timestamp = slot7.timestamp
					})
				end

				table.sort(slot2, function (slot0, slot1)
					return slot1.damage < slot0.damage
				end)
				uv0(slot2)
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	OnGetFightRecordCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildActivityData:InitFightRecordFromServer(slot0.records)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	SetFightMember = function (slot0, slot1)
		manager.net:SendWithLoadingNew(36022, {
			up_hero_id_list = slot0,
			down_hero_id_list = slot1
		}, 36023, uv0.OnSetFightMemberCallback)
	end,
	OnSetFightMemberCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildActivityData:OnSetFightMember()
			uv0.UpdateOnFightNotFullRedPoint(ActivityConst.GUILD_ACTIVITY_START)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	UpgradeAffix = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(36024, {
			id = slot0
		}, 36025, function (slot0, slot1)
			if uv0 ~= nil then
				uv0(slot0, slot1)
				uv1.UpdateCoinRedPoint(ActivityConst.GUILD_ACTIVITY_START)
			end
		end)
	end,
	RequireReceive = function (slot0, slot1)
		manager.net:SendWithLoadingNew(36036, {
			level = ActivityClubLevelSettingCfg[slot0].user_level
		}, 36037, slot1)
	end,
	QueryRankList = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(36032, {
			id = slot0
		}, 36033, function (slot0, slot1)
			if isSuccess(slot0.result) then
				GuildActivityData:SetRankData(slot0)
				uv0()
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	GiveUpNode = function (slot0)
		manager.net:SendWithLoadingNew(36030, {
			id = slot0
		}, 36031, uv0.OnGiveUpNodeCallback)
	end,
	OnGiveUpNodeCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildActivityData:OnGridGiveUp(slot1.id)
			MaterialAction.MaterialModify(MaterialConst.GUILD_ACTIVITY_COIN, slot0.item_num)
			GuildActivityData:RefreshAffixRedPoint(ActivityConst.GUILD_ACTIVITY_START)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	EnterNext = function (slot0)
		manager.net:SendWithLoadingNew(36028, {
			id = slot0
		}, 36029, uv0.OnEnterNextCallback)
	end,
	OnEnterNextCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:CallUpdateFunc(GUILD_ACTIVITY_ENTER_NEW_LEVEL)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	SaveEliteCombatResult = function (slot0)
		manager.net:SendWithLoadingNew(36026, {
			is_save = slot0
		}, 36027, uv0.OnSaveEliteCombatResultCallback)
	end,
	OnSaveEliteCombatResultCallback = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(GetTips(slot0.result))
		end
	end,
	GetCoin = function ()
		manager.net:SendWithLoadingNew(36034, {}, 36035, uv0.OnGetCoinCallback)
	end,
	OnGetCoinCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildActivityData:OnGetCoin(slot0.last_receive_time)
			MaterialAction.MaterialModify(MaterialConst.GUILD_ACTIVITY_COIN, slot0.item_num)
			manager.notify:CallUpdateFunc(GUILD_ACTIVITY_CHECK_RATE_UPGRADE)
			manager.notify:Invoke(GUILD_ACTIVITY_COIN_GET_FINISH, {})
			uv0.UpdateCoinRedPoint(ActivityConst.GUILD_ACTIVITY_START)
			GuildActivityData:RefreshAffixRedPoint(ActivityConst.GUILD_ACTIVITY_START)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	ExitGuildActivity = function ()
		manager.windowBar:ClearWhereTag()
		manager.net:SendWithLoadingNew(36014, {}, 36015, uv0.OnExitGuildActivityCallback)
	end,
	OnExitGuildActivityCallback = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(GetTips(slot0.result))
		end
	end,
	OnLogout = function ()
		if whereami == "guildActivity" then
			SceneManager.UnloadSceneAsync("GuildActivity")
		end
	end
}
