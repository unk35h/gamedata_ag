slot1 = manager.net

slot1:Bind(10999, function (slot0)
	ReconnectLogic.ReconnectError(slot0.reason)
end)

slot1 = manager.net

slot1:Bind(10051, function (slot0)
	if slot0.timestamp and slot0.verify_timestamp then
		manager.time:SetServerTime(slot0.timestamp, slot0.verify_timestamp)
	end
end)

slot1 = manager.net

slot1:Bind(10501, function (slot0)
	uv0.OnRequestNewDayData(slot0)
end)

slot1 = manager.net

slot1:Bind(12019, function (slot0)
	uv0.OnClientModuleSwitch(slot0)
end)

slot1 = manager.net

slot1:Bind(12023, function (slot0)
	PlayerData:SetUnclaimedListFromServer(slot0)
end)

slot1 = manager.net

slot1:Bind(23009, function (slot0)
	uv0.PlayInfoInit(slot0)
end)

slot1 = manager.net

slot1:Bind(23015, function (slot0)
	uv0.SetPlayerIP(slot0)
end)

slot1 = manager.net

slot1:Bind(12001, function (slot0)
	uv0.StoryInit(slot0.story_list)
end)

slot1 = manager.net

slot1:Bind(12033, function (slot0)
	uv0.PlayerBrithdayInit(slot0)
end)

slot1 = manager.net

slot1:Bind(12009, function (slot0)
	uv0.PlayerOriginalLevel(slot0)
end)

slot1 = manager.net

slot1:Bind(32009, function (slot0)
	uv0.PlayerCardInit(slot0)
end)

slot1 = manager.net

slot1:Bind(32007, function (slot0)
	uv0.InitOverdueFrameList(slot0)
end)

slot1 = manager.net

slot1:Bind(12099, function (slot0)
	HideInfoData:InitHideData(slot0)
	ComboSkillTools.InitComboList()
end)

return {
	RequestNewDayData = function ()
		manager.net:SendWithLoadingNew(10500, {}, 10501, uv0.OnRequestNewDayData)
	end,
	OnRequestNewDayData = function (slot0, slot1)
		manager.time:SetServerTime(slot0.timestamp, slot0.verify_timestamp)
		_G.gameTimer:SetNextDayFreshTime(slot0.next_refresh_time)
		_G.gameTimer:SetNextWeekFreshTime(slot0.next_weekly_refresh_time)
		_G.gameTimer:SetNextMonthFreshTime(slot0.next_monthly_refresh_time)

		if isSuccess(slot0.result) then
			manager.notify:Invoke(NEW_DAY)
		end
	end,
	ChangeNickname = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(23012, {
			nick = slot0
		}, 23013, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 == 1 then
					CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_CHANGE_NAME_CARD, -1)
					PlayerData:PlayerNicknameChange(uv1, PlayerData:GetIsChangeNick())
				elseif PlayerData:GetExtraChangeNickTime() > 0 then
					PlayerData:PlayerExtraChangeNickTime(slot1 - 1)
					PlayerData:PlayerNicknameChange(uv1, PlayerData:GetIsChangeNick())
				else
					PlayerData:PlayerNicknameChange(uv1, 2)
				end

				manager.notify:CallUpdateFunc(CHANGE_NAME, {
					nick = uv1
				})
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ChangeSign = function (slot0)
		manager.net:SendWithLoadingNew(32012, {
			sign = slot0
		}, 32013, uv0.OnChangeSign)
	end,
	OnChangeSign = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:PlayerSignChange(slot1.sign)
			manager.notify:CallUpdateFunc(CHANGE_SIGN, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangeHeros = function (slot0)
		manager.net:SendWithLoadingNew(32014, {
			heroes = slot0
		}, 32015, uv0.OnChangeHeros)
	end,
	OnChangeHeros = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:ChangeHeros(slot1.heroes)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangePosterGirl = function (slot0)
		manager.net:SendWithLoadingNew(32016, {
			poster_girl = slot0
		}, 32017, uv0.OnChangePosterGirl)
	end,
	OnChangePosterGirl = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:PlayerPosterGirlChange(slot1.poster_girl)
			manager.notify:CallUpdateFunc(CHANGE_POSTER_GIRL, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangeStoryList = function (slot0, slot1)
		slot3 = {
			story_id = slot0
		}

		if PlayerData:GetStoryList()[slot0] then
			PlayerData:StoryModify(slot0)
			IllustratedAction.ModifyPlot(slot0)

			if slot1 then
				slot1({
					result = 1
				}, slot3)
			end
		else
			uv0.OnChangeStoryListCallBack = slot1

			manager.net:SendWithLoadingNew(12002, slot3, 12003, uv0.OnChangeStoryList)
		end
	end,
	OnChangeStoryList = function (slot0, slot1)
		PlayerData:StoryModify(slot1.story_id)
		IllustratedAction.ModifyPlot(slot1.story_id)

		if uv0.OnChangeStoryListCallBack then
			uv0.OnChangeStoryListCallBack(slot0, slot1)

			uv0.OnChangeStoryListCallBack = nil
		end
	end,
	ChangePortrait = function (slot0)
		manager.net:SendWithLoadingNew(32032, {
			icon_id = slot0
		}, 32033, uv0.OnChangePortrait)
	end,
	OnChangePortrait = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:ChangePortrait(slot1.icon_id)
			manager.notify:CallUpdateFunc(CHANGE_PORTRAIT)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangePlayerBirthday = function (slot0, slot1)
		manager.net:SendWithLoadingNew(12030, {
			month = slot0,
			day = slot1
		}, 12031, uv0.OnChangeBirthday)
	end,
	OnChangeBirthday = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:SetPlayerBirthday(slot1)
			manager.notify:CallUpdateFunc(CHANGE_BIRTHDAY)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangeFrameIcon = function (slot0)
		manager.net:SendWithLoadingNew(32034, {
			iconframe_id = slot0
		}, 32035, uv0.OnChangeFrameIcon)
	end,
	OnChangeFrameIcon = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:ChangeFrameIcon(slot1.iconframe_id)
			manager.notify:CallUpdateFunc(CHANGE_FRAME)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangeStickerList = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0.info) do
			slot7 = {}

			for slot12, slot13 in ipairs(StickViewTemplateCfg[slot6.viewID].range_list) do
				slot14 = slot6.sticker[slot12]
				slot7[slot12] = {
					sticker_id = slot14.stickerID,
					location = slot12,
					size = slot14.size
				}
			end

			table.insert(slot1, {
				page_id = slot6.index,
				template_id = slot6.viewID,
				sticker_display_info = slot7
			})
		end

		manager.net:SendWithLoadingNew(32038, {
			sticker_show_info = slot1,
			sticker_background = slot0.stickerBg
		}, 32039, uv0.OnChangeStickerList)
	end,
	OnChangeStickerList = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:ChangeStickerList(slot1.sticker_show_info, slot1.sticker_background)
		else
			ShowTips(slot0.result)
		end
	end,
	PlayInfoInit = function (slot0)
		PlayerData:PlayInfoInit(slot0)
	end,
	PlayerBrithdayInit = function (slot0)
		PlayerData:SetPlayerBirthday({
			month = slot0.month,
			day = slot0.day
		})
	end,
	SetPlayerIP = function (slot0)
		PlayerData:SetPlayerIP(slot0)
	end,
	UserBaseInfoInit = function (slot0)
		PlayerData:UserBaseInfoInit(slot0)
	end,
	UserLoginTimestampInit = function (slot0)
		PlayerData:UserLoginTimestampInit(slot0)
	end,
	LevelUpFinish = function (slot0)
		PlayerData:LevelUpFinish(slot0)
	end,
	ChangeLevel = function (slot0, slot1)
		PlayerData:ChangeLevel({
			fromLevel = slot0,
			toLevel = slot1
		})
		ActivityNewbieAction.PlayerUpgradeRedPoint()
		BattleStageAction.UpdateSubPlotRedPoint()
	end,
	EXPChange = function (slot0)
		PlayerData:EXPChange(slot0)
	end,
	ModifyHeroNick = function (slot0)
		PlayerData:ModifyHeroNick(slot0)
	end,
	PlayerOriginalLevel = function (slot0)
		PlayerData:PlayerOriginalLevel(slot0)
	end,
	StoryModify = function (slot0)
		PlayerData:StoryModify(slot0)
	end,
	StoryInit = function (slot0)
		PlayerData:StoryInit(slot0)
	end,
	PlayerShowHeroChange = function (slot0)
		PlayerData:PlayerShowHeroChange(slot0)
	end,
	PlayerCardInit = function (slot0)
		PlayerData:PlayerCardInit(slot0)

		for slot5, slot6 in ipairs(PlayerData:GetPlayerInfo().all_background_list) do
			slot7 = PlayerData:GetStickerBg(slot6)

			if slot6 ~= 4002 and slot7 and slot7.unlock == 1 and not RedPointData:GetIsRedPointOpen(RedPointConst.STICKER_BG_RANGE + slot6) then
				manager.redPoint:setTip(RedPointConst.STICKER_BG .. "_" .. slot6, 1)
			end
		end
	end,
	InitOverdueFrameList = function (slot0)
		PlayerData:InitOverdueFrameList(slot0.icon_frame_list or {})
	end,
	PlayerProtraitChange = function (slot0)
		PlayerData:PlayerProtraitChange(slot0)
	end,
	UnlockSticker = function (slot0)
		PlayerData:UnlockSticker(slot0)
	end,
	UnlockStickerBg = function (slot0)
		PlayerData:UnlockStickerBg(slot0)
	end,
	UnlockPortrait = function (slot0)
		PlayerData:UnlockPortrait(slot0)
	end,
	UnlockFrame = function (slot0)
		PlayerData:UnlockFrame(slot0)
	end,
	LockFrame = function (slot0, slot1)
		PlayerData:LockFrame(slot1)
	end,
	OnClientModuleSwitch = function (slot0)
		PlayerData:InitModuleSwitchData(slot0)
	end,
	AwakeName = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(23012, {
			nick = slot0
		}, 23013, function (slot0)
			if isSuccess(slot0.result) then
				PlayerData:PlayerNicknameChange(uv0, 1)
				uv1()
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	DealOverdueFrame = function ()
		manager.net:SendWithLoadingNew(32040, {
			nothing = 1
		}, 32041, uv0.OnDealOverdueFrame)
	end,
	OnDealOverdueFrame = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	ReadUnclaimedMessage = function (slot0)
		manager.net:SendWithLoadingNew(12024, {
			id = slot0
		}, 12025, uv0.OnReadUnclaimedMessageCallback)
	end,
	OnReadUnclaimedMessageCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PlayerData:ReadUnclaimed(slot1.id)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	CheckRecommendEquip = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(32042, {
			role_id = slot0
		}, 32043, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 then
					uv0()
				end
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	CheckHeroVoice = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(32044, {
			role_id = slot0
		}, 32045, function (slot0)
			if isSuccess(slot0.result) then
				if uv0 then
					uv0()
				end
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end
}
