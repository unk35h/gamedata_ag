slot0 = singletonClass("PlayerData")
slot1 = {
	birthday_day = 0,
	remain_exp = 0,
	show_hero_flag = 1,
	nick = "",
	show_sticker_flag = 1,
	is_changed_nick = 0,
	userID = 1,
	plot_progress = 0,
	signUserId = "",
	portrait = 1084,
	userLevel = 10,
	icon_frame = 2001,
	sticker_background = 0,
	ip = "",
	extra_chang_nick_time = 0,
	timestamp = 0,
	poster_girl = 1084,
	hero_num = 0,
	sign = "",
	register_timestamp = 0,
	originalLevel = 1,
	total_exp = 0,
	birthday_month = 0,
	sticker_show = {},
	all_background_list = {},
	all_sticker_list = {},
	sticker_show_info = {},
	unlocked_portraits = {},
	icon_frame_list = {},
	heroes = {},
	storylist = {},
	levelUpInfos = {}
}
slot2 = {}
slot3 = {}
slot4 = {}
slot5 = {}
slot6 = {}
slot7 = {}
slot8 = {}

function slot0.PlayInfoInit(slot0, slot1)
	uv0.total_exp = slot1.total_exp
	uv0.userLevel, uv0.remain_exp = LvTools.CheckExp(1, uv0.total_exp, "user_level_exp")
	uv0.is_changed_nick = slot1.is_changed_nick
	uv0.extra_chang_nick_time = slot1.system_change_nick_times or 0

	if uv0.nick ~= "" and uv0.nick ~= slot1.nick then
		manager.notify:CallUpdateFunc(CHANGE_NAME, slot1)
	end

	uv0.nick = slot1.nick
	uv0.hero_num = slot1.hero_num
	uv0.plot_progress = slot1.plot_progress

	manager.notify:Invoke(PLAYER_MODIFIED)

	if uv0.ip == "" then
		uv0.ip = GetTips("IP_UNKNOWN")
	end
end

function slot0.SetPlayerIP(slot0, slot1)
	uv0.ip = slot1.ip_location or GetTips("IP_UNKNOWN")
end

function slot0.SetPlayerBirthday(slot0, slot1)
	uv0.birthday_month = slot1.month
	uv0.birthday_day = slot1.day

	manager.redPoint:setTip(RedPointConst.BRITHDAY, slot1.month == 0 and 1 or 0)
end

function slot0.GetPlayerBrithday(slot0)
	return uv0.birthday_month, uv0.birthday_day
end

function slot0.GetPlayerInfo(slot0)
	uv0.icon_frame = slot0:GetCurFrame()

	return uv0
end

function slot0.GetStoryList(slot0)
	return uv0.storylist
end

function slot0.GetlevelUpInfos(slot0)
	return uv0.levelUpInfos and deepClone(uv0.levelUpInfos) or {}
end

function slot0.UserBaseInfoInit(slot0, slot1)
	uv0.userID = slot1.userID
	uv0.register_timestamp = slot1.register_timestamp
	uv0.signUserId = slot1.uid_sign
end

function slot0.UserLoginTimestampInit(slot0, slot1)
	uv0.timestamp = slot1.timestamp
end

function slot0.PlayerProtraitChange(slot0, slot1)
	uv0.portrait = slot1.portrait
end

function slot0.PlayerNicknameChange(slot0, slot1, slot2)
	uv0.is_changed_nick = slot2
	uv0.nick = slot1
end

function slot0.PlayerExtraChangeNickTime(slot0, slot1)
	uv0.extra_chang_nick_time = slot1
end

function slot0.GetExtraChangeNickTime(slot0)
	return uv0.extra_chang_nick_time
end

function slot0.GetIsChangeNick(slot0)
	return uv0.is_changed_nick
end

function slot0.GetIP(slot0)
	return uv0.ip
end

function slot0.EXPChange(slot0, slot1)
	uv0.total_exp = uv0.total_exp + slot1
	uv0.userLevel, uv0.remain_exp = LvTools.CheckExp(1, uv0.total_exp, "user_level_exp")

	if uv0.userLevel ~= uv0.userLevel then
		manager.notify:Invoke(PLAYER_LEVEL_UP, slot2, slot3)
		SDKTools.SetDefaultPublicAttribute()
		SendMessageManagerToSDK("role_level", {
			level = slot3
		})
	end
end

function slot0.PlayerCardInit(slot0, slot1)
	uv0.sign = slot1.sign
	uv0.heroes = cleanProtoTable(slot1.heroes)
	uv0.sticker_show = cleanProtoTable(slot1.sticker_show, {
		"sticker_id",
		"location"
	})
	uv0.all_background_list = cleanProtoTable(slot1.all_background_list)
	uv0.sticker_show_info = uv1:InitStickerShowList(slot1.sticker_show_info or {})
	uv0.sticker_background = slot1.sticker_background or GameSetting.sticker_background_default.value[1]
	uv0.all_sticker_list = cleanProtoTable(slot1.all_sticker_list)
	uv0.unlocked_portraits = cleanProtoTable(slot1.icon_list)
	uv0.icon_frame_list = cleanProtoTable(slot1.icon_frame_list, {
		"icon_frame_id",
		"lasted_time"
	})

	if slot1.poster_girl and slot1.poster_girl ~= 0 then
		uv0.poster_girl = slot1.poster_girl
	else
		uv0.poster_girl = 1084
	end

	if slot1.icon and slot1.icon ~= 0 and slot1.icon ~= 1 then
		uv0.portrait = slot1.icon
	else
		uv0.portrait = 2110841
	end

	if slot1.icon_frame and slot1.icon_frame ~= 0 and slot1.icon_frame ~= 1 then
		uv0.icon_frame = slot1.icon_frame
	else
		uv0.icon_frame = 2001
	end

	uv1:InitStickerList()
	uv1:InitStickerBgList()
	uv1:InitPortraitList()
	uv1:InitFrameList()

	uv2 = {}
end

function slot0.InitStickerShowList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = {}

		for slot12, slot13 in ipairs(slot7.sticker_display_info) do
			slot8[slot13.location] = {
				stickerID = slot13.sticker_id,
				size = slot13.size
			}
		end

		slot2[slot7.page_id] = {
			index = slot7.page_id,
			viewID = slot7.template_id,
			sticker = slot8
		}
	end

	return slot2
end

function slot0.InitOverdueFrameList(slot0, slot1)
	if #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(uv0, {
				num = 1,
				id = slot6.id,
				time_valid = slot6.time_valid
			})
		end
	end
end

function slot0.PlayerSignChange(slot0, slot1)
	uv0.sign = slot1
end

function slot0.PlayerShowHeroChange(slot0, slot1)
	uv0.heroes = cleanProtoTable(slot1)
end

function slot0.PlayerPosterGirlChange(slot0, slot1)
	uv0.poster_girl = slot1
end

function slot0.StoryInit(slot0, slot1)
	uv0.storylist = {}

	for slot5, slot6 in ipairs(slot1) do
		uv0.storylist[slot6] = true
	end
end

function slot0.StoryModify(slot0, slot1)
	uv0.storylist[slot1] = true
end

function slot0.PlayerOriginalLevel(slot0, slot1)
	uv0.originalLevel = slot1.user_level
end

function slot0.ChangeLevel(slot0, slot1)
	if not uv0.levelUpInfos then
		uv0.levelUpInfos = {}
	end

	table.insert(uv0.levelUpInfos, {
		fromLevel = slot1.fromLevel,
		toLevel = slot1.toLevel
	})
end

function slot0.LevelUpFinish(slot0, slot1)
	if uv0.levelUpInfos then
		while table.getn(uv0.levelUpInfos) > 0 do
			table.remove(uv0.levelUpInfos, 1)
		end
	end
end

function slot0.InitModuleSwitchData(slot0, slot1)
end

function slot0.GetModuleSwitchData(slot0, slot1)
	return uv0[slot1]
end

function slot0.InitStickerList(slot0)
	uv0 = {
		get_sticker_id_list = {}
	}

	for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.STICKER]) do
		uv0[slot6] = {
			unlock = 0,
			id = slot6
		}

		table.insert(uv0.get_sticker_id_list, slot6)
	end

	for slot5, slot6 in ipairs(uv1.all_sticker_list) do
		if uv0[slot6] then
			uv0[slot6].unlock = 1
		end
	end
end

function slot0.InitStickerBgList(slot0)
	uv0 = {
		get_sticker_bg_id_list = {}
	}

	for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.STICKER_BG]) do
		uv0[slot6] = {
			unlock = 0,
			id = slot6
		}

		table.insert(uv0.get_sticker_bg_id_list, slot6)
	end

	for slot5, slot6 in ipairs(uv1.all_background_list) do
		if uv0[slot6] then
			uv0[slot6].unlock = 1
		end
	end
end

function slot0.InitPortraitList(slot0)
	uv0 = {
		get_portrait_id_list = {}
	}

	for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.PORTRAIT]) do
		uv0[slot6] = {
			unlock = 0,
			id = slot6
		}

		table.insert(uv0.get_portrait_id_list, slot6)
	end

	for slot5, slot6 in ipairs(uv1.unlocked_portraits) do
		if uv0[slot6] then
			uv0[slot6].unlock = 1
		end
	end
end

function slot0.InitFrameList(slot0)
	uv0 = {
		get_frame_id_list = {}
	}

	for slot5, slot6 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.FRAME]) do
		if ItemCfg[slot6].sub_type ~= 1203 then
			uv0[slot6] = {
				lasted_time = 0,
				unlock = 0,
				id = slot6
			}

			table.insert(uv0.get_frame_id_list, slot6)
		end
	end

	slot2 = nil

	for slot6, slot7 in ipairs(uv1.icon_frame_list) do
		if uv0[slot7.icon_frame_id] then
			uv0[slot2].unlock = 1
			uv0[slot2].lasted_time = slot7.lasted_time
		end
	end
end

function slot0.ChangeHeros(slot0, slot1)
	for slot5 = 1, 3 do
		uv0.heroes[slot5] = slot1[slot5]
	end
end

function slot0.ChangeHeroShow(slot0, slot1)
	uv0.show_hero_flag = slot1
end

function slot0.ChangeStickerShow(slot0, slot1)
	uv0.show_sticker_flag = slot1
end

function slot0.ChangeStickerList(slot0, slot1, slot2)
	uv0.sticker_show_info = uv1:InitStickerShowList(slot1)
	uv0.sticker_background = slot2

	manager.notify:CallUpdateFunc(CHANGE_STICKER_LIST, uv0.sticker_show_info, uv0.sticker_background)
end

function slot0.ChangePortrait(slot0, slot1)
	uv0.portrait = slot1
end

function slot0.ChangeFrameIcon(slot0, slot1)
	uv0.icon_frame = slot1
end

function slot0.GetHeroShowList(slot0)
	return uv0.heroes
end

function slot0.GetCurPortrait(slot0)
	return uv0.portrait
end

function slot0.GetCurFrame(slot0)
	if uv0[uv1.icon_frame] and slot1.lasted_time > 0 and slot1.unlock == 1 and slot1.lasted_time < manager.time:GetServerTime() then
		slot0:RefreshFrameList(function ()
			return uv0.icon_frame
		end)
	end

	return uv1.icon_frame
end

function slot0.GetStickerShow(slot0)
	return uv0.sticker_show_info
end

function slot0.GetStickerList(slot0)
	return uv0.get_sticker_id_list
end

function slot0.GetSticker(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetStickerBg(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetPortraitList(slot0)
	return uv0.get_portrait_id_list
end

function slot0.GetPortrait(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetFrameList(slot0)
	return uv0.get_frame_id_list
end

function slot0.GetFrame(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetIsStickerShow(slot0)
	return uv0.show_sticker_flag
end

function slot0.UnlockSticker(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].unlock = 1

		table.insert(uv1.all_sticker_list, slot1)
	end
end

function slot0.UnlockStickerBg(slot0, slot1)
	if uv0[slot1] and uv0[slot1].unlock == 0 then
		uv0[slot1].unlock = 1

		manager.redPoint:setTip(RedPointConst.STICKER_BG .. "_" .. slot1, 1)
	end
end

function slot0.UnlockPortrait(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].unlock = 1

		table.insert(uv1.unlocked_portraits, slot1)
	end
end

function slot0.UnlockFrame(slot0, slot1)
	frameID = ItemCfg[slot1].param[1]

	if uv0[frameID] then
		if slot2.sub_type == 1203 then
			slot4 = 0

			if slot2.param[2] == 0 then
				slot4 = 0
			elseif slot3 == 1 then
				slot4 = 7
			elseif slot3 == 2 then
				slot4 = 14
			elseif slot3 == 3 then
				slot4 = 30
			end

			if uv0[frameID].unlock == 0 then
				uv0[frameID].unlock = 1
				uv0[frameID].lasted_time = manager.time:GetServerTime() + slot4 * 86400

				table.insert(uv1.icon_frame_list, {
					icon_frame_id = frameID,
					lasted_time = uv0[frameID].lasted_time
				})
			elseif uv0[frameID].lasted_time == 0 then
				return
			else
				uv0[frameID].lasted_time = uv0[frameID].lasted_time + slot4 * 86400
			end
		else
			uv0[frameID].unlock = 1
			uv0[frameID].lasted_time = 0
		end
	end
end

function slot0.LockFrame(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].unlock = 0
		slot2 = nil

		for slot6, slot7 in ipairs(uv1.icon_frame_list) do
			if slot7.icon_frame_id == slot1 then
				table.remove(uv1.icon_frame_list, slot6)
			end
		end
	end
end

function slot0.RefreshFrameList(slot0, slot1)
	slot2 = nil
	slot3 = false
	slot4 = uv0.icon_frame
	slot5 = manager.time:GetServerTime()

	for slot9, slot10 in ipairs(uv1.get_frame_id_list) do
		if uv1[slot10].unlock == 1 and slot2.lasted_time > 0 and slot2.lasted_time < slot5 then
			slot0:LockFrame(slot10)

			if slot10 == slot4 then
				slot3 = true
			end
		end
	end

	if slot3 then
		PlayerAction.ChangeFrameIcon(GameSetting.profile_avatar_frame_default.value[1])
	end

	if slot1 then
		slot1()
	end
end

function slot0.DealOverdueFrame(slot0)
	if uv0 and #uv0 > 0 then
		JumpTools.OpenPageByJump("FrameExpired", {
			materialList = uv0
		})
		PlayerAction.DealOverdueFrame()

		uv0 = {}
	end
end

function slot0.SetUnclaimedListFromServer(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.reward) do
		uv0[slot6.id] = slot6.stage
	end
end

function slot0.GetUnclaimed(slot0, slot1)
	return uv0[slot1] or nil
end

function slot0.ReadUnclaimed(slot0, slot1)
	uv0[slot1] = nil
end

return slot0
