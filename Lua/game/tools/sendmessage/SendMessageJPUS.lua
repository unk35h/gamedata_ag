slot1 = {}

return {
	typeToFunction = {
		role_create = function (slot0)
			uv0 = {
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				role_name = slot0.curNameText
			}

			SDKTools.SetParamsAttribute("role_create", uv0)
		end,
		purchase_complete_skin = function ()
			SDKTools.SetBaseAttribute("purchase_complete_skin")
		end,
		guild_join = function ()
			SDKTools.SetBaseAttribute("guild_join")
		end,
		purchase_crystal = function (slot0)
			uv0 = {
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				num = slot0.purchaseNum
			}

			SDKTools.SetParamsAttribute("purchase_crystal", uv0)
		end,
		passport_complete = function ()
			SDKTools.SetBaseAttribute("purchase_complete_gp_once")
		end,
		purchase_click_montlycard = function ()
			SDKTools.SetBaseAttribute("purchase_click_montlycard")
		end,
		roll_complete_10 = function ()
			SDKTools.SetBaseAttribute("roll_complete_10")
		end,
		gacha_complete = function ()
			SDKTools.SetBaseAttribute("gacha_complete")
		end,
		limited_gacha_complete = function ()
			SDKTools.SetBaseAttribute("limited_gacha_complete")
		end,
		roll_complete_140 = function (slot0)
			uv0 = {
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				pool_id = slot0.poolID
			}

			SDKTools.SetParamsAttribute("roll_complete_140", uv0)
		end,
		roll_complete_40 = function ()
			SDKTools.SetBaseAttribute("roll_complete_40")
		end,
		charge_junior = function ()
			SDKTools.SetBaseAttribute("charge_junior")
		end,
		charge_medium = function ()
			SDKTools.SetBaseAttribute("charge_medium")
		end,
		charge_senior = function ()
			SDKTools.SetBaseAttribute("charge_senior")
		end,
		purchase_click_gp_once = function ()
			SDKTools.SetBaseAttribute("purchase_click_gp_once")
		end,
		purchase_click_skin = function ()
			SDKTools.SetBaseAttribute("purchase_click_skin")
		end,
		role_login = function ()
			SDKTools.SetBaseAttribute("role_login")
		end,
		day_retention = function ()
			uv0 = {
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				days = manager.time:DiffDay2(getData("SDK", "register_timestamp"), manager.time:GetServerTime())
			}

			SDKTools.SetParamsAttribute("day_retention", uv0)
		end,
		account_create_ys = function ()
			uv0 = {
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				account_id = PlayerPrefs.GetString("AccountID")
			}

			SDKTools.SetParamsAttribute("account_create_ys", uv0)
		end,
		day_retention_return = function ()
			uv0 = {
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				days = getData("SDK", "continueTime") + 1
			}

			SDKTools.SetParamsAttribute("day_retention_return", uv0)
		end,
		purchase_complete_montlycard = function ()
			SDKTools.SetBaseAttribute("purchase_complete_montlycard")
		end,
		purchase_first_ys = function ()
			SDKTools.SetBaseAttribute("purchase_first_ys")
		end,
		purchase_complete = function ()
			SDKTools.SetBaseAttribute("purchase_complete")
		end,
		purchase_ys = function (slot0)
			uv0 = {
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				payment = slot0.value,
				order_id = slot0.order_id
			}

			SDKTools.SetParamsAttribute("purchase_ys", uv0)
		end,
		purchase_click = function ()
			SDKTools.SetBaseAttribute("purchase_click")
		end,
		unlockStage = function (slot0)
			if slot0.chapterID == 2011 then
				SDKTools.SetBaseAttribute("coin_stage5")
			elseif slot0.chapterID == 2012 then
				SDKTools.SetBaseAttribute("mod_ex_stage5")
			elseif slot0.chapterID == 2013 then
				SDKTools.SetBaseAttribute("skillpoint_stage5")
			elseif slot0.chapterID == 2014 then
				SDKTools.SetBaseAttribute("access_key_stage5")
			elseif slot0.chapterID == 2015 then
				SDKTools.SetBaseAttribute("elite_stage5")
			elseif slot0.chapterID == 2016 then
				SDKTools.SetBaseAttribute("mod_elite_stage5")
			elseif slot0.chapterID == 202 then
				-- Nothing
			end
		end,
		add_friend = function ()
			SDKTools.SetBaseAttribute("add_friend")
		end,
		role_level = function (slot0)
			uv0 = {
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				role_level = slot0.level
			}

			if math.floor(slot0.level % 10) == 0 then
				SDKTools.SetParamsAttribute("role_level", uv0)
			elseif slot0.level <= 30 and slot0.level > 4 and math.floor(slot0.level % 5) == 0 then
				SDKTools.SetParamsAttribute("role_level", uv0)
			end

			if slot0.level == 45 then
				SDKTools.SetBaseAttribute("sigil_stage5")
			end
		end,
		role_logout = function ()
			SDKTools.SetBaseAttribute("role_logout")
		end,
		tutorial_complete = function ()
			SDKTools.SetBaseAttribute("tutorial_complete")
		end,
		purchase_swigs = function (slot0)
			uv0 = {
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				times = slot0.buyFatigueNum
			}

			SDKTools.SetParamsAttribute("purchase_swigs", uv0)
		end,
		chapter_main = function (slot0)
			uv0 = {
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				chapter = slot0.passChapter
			}

			SDKTools.SetParamsAttribute("chapter_main", uv0)
		end,
		blackzone_clear = function (slot0)
			SDKTools.SetParamsAttribute("blackzone_clear", {
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				difficult = slot0.partition
			})
		end,
		bossrush_star = function (slot0)
			uv0 = {
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				star_num = slot0.curStarCnt
			}

			SDKTools.SetParamsAttribute("bossrush_star", uv0)
		end,
		tutorial = function (slot0)
			uv0 = {
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				phase = slot0.guideId
			}

			SDKTools.SetParamsAttribute("tutorial", uv0)
		end,
		charge_Total = function (slot0)
			if slot0.total >= 5 and slot0.total < 10 then
				SDKTools.SetBaseAttribute("charge_junior")
			elseif slot0.total >= 10 and slot0.total < 50 then
				SDKTools.SetBaseAttribute("charge_medium")
			elseif slot0.total >= 50 then
				SDKTools.SetBaseAttribute("charge_senior")
			end
		end
	}
}
