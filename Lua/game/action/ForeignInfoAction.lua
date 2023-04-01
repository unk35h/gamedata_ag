return {
	TryToCheckForeignDetailInfo = function (slot0, slot1)
		if manager.windowBar:GetWhereTag() == nil and slot1 == tostring(PlayerData:GetPlayerInfo().userID) then
			JumpTools.OpenPageByJump("/userinfo", nil, ViewConst.SYSTEM_ID.PLAYER_INFO)

			return
		end

		if FriendsData:GetInfoByID(slot1) and slot2.relationship == FriendsConst.FRIEND_TYPE.BLACKLIST then
			ShowTips("BLACKLIST_TIP")

			return
		end

		manager.net:SendWithLoadingNew(32018, {
			user_id = slot1
		}, 32019, handler(slot0, slot0.OnTryToCheckForeignDetailInfo))
	end,
	OnTryToCheckForeignDetailInfo = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			slot3 = FriendsData:GetInfoByID(slot2.user_id)

			JumpTools.OpenPageByJump("/userinfo", {
				isForeign = true,
				data = {
					user_id = slot1.user_id,
					nick = slot1.nick,
					level = slot1.level,
					icon = slot1.icon,
					icon_frame = slot1.icon_frame,
					sign = slot1.sign,
					sticker_show_info = PlayerData:InitStickerShowList(slot1.sticker_show_info),
					sticker_background = slot1.sticker_background,
					hero_list = slot1.hero_list or {},
					is_online = slot1.is_online,
					ip = (slot1.ip_location == nil or slot1.ip_location == "") and GetTips("IP_UNKNOWN") or slot1.ip_location,
					guildID = slot1.club_id,
					guildName = slot1.club_name,
					achieveNum = slot1.achievement_num,
					heroNum = slot1.hero_num,
					servantNum = slot1.weapon_servant_num,
					stickerNum = slot1.sticker_num,
					postGril = slot0:GetPostID(slot1.poster_hero),
					birthdayMonth = slot1.birthday.month,
					birthdayDay = slot1.birthday.day
				}
			})
		else
			ShowTips(slot1.result)
		end
	end,
	GetPostID = function (slot0, slot1)
		if slot1.hero_id ~= 0 then
			if slot1.using_skin ~= 0 then
				return slot1.using_skin
			else
				return slot1.hero_id
			end
		end

		return 1084
	end,
	TryToCheckForeignHeroInfo = function (slot0, slot1, slot2, slot3, slot4)
		manager.net:SendWithLoadingNew(32020, {
			user_id = slot1,
			type = slot3 or 1
		}, 32021, function (slot0, slot1)
			if isSuccess(slot0.result) then
				ForeignInfoData:SetForeignHeroInfo(slot0.hero_list or {})

				if uv0 then
					uv0()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end
}
