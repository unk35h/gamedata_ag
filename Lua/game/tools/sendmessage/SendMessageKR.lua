slot1 = {}
slot2 = _G.deviceInfo or {}

return {
	typeToFunction = {
		role_create = function ()
			SDKTools.SetParamsAttribute("af_Createrole", {
				subType = 0
			})
			SDKTools.SetParamsAttribute("Fire_Createrole", {
				subType = 0
			})
		end,
		SDKLogin = function ()
			uv0 = {
				load_name = "SDK登录触发",
				load_id = 1014,
				load_time = 0,
				sub_id = uv1.subId,
				model = tostring(uv1.model)
			}

			SDKTools.SetParamsAttribute("game_start", uv0)
		end,
		SDKLoginSuccess = function ()
			uv0 = {
				load_name = "SDK登录成功",
				load_id = 1016,
				load_time = 0,
				sub_id = uv1.subId,
				model = tostring(uv1.model)
			}

			SDKTools.SetParamsAttribute("game_start", uv0)
		end,
		SDKLoginFailed = function ()
			uv0 = {
				load_name = "SDK登录报错",
				load_id = 1015,
				load_time = 0,
				sub_id = uv1.subId,
				model = tostring(uv1.model)
			}

			SDKTools.SetParamsAttribute("game_start", uv0)
		end,
		purchase_complete_skin = function ()
			SDKTools.SetParamsAttribute("af_buy_skin", {
				subType = 0
			})
			SDKTools.SetParamsAttribute("Fire_buy_skin", {
				subType = 0
			})
		end,
		purchase_crystal = function (slot0)
			SDKTools.SetParamsAttribute("af_buy_pay" .. tostring(slot0.purchaseNum), {
				subType = 0
			})
			SDKTools.SetParamsAttribute("Fire_buy_pay" .. tostring(slot0.purchaseNum), {
				subType = 0
			})
		end,
		roll_complete_1 = function ()
			SDKTools.SetParamsAttribute("Fire_SUMMON_1", {
				subType = 0
			})
			SDKTools.SetParamsAttribute("af_SUMMON_1", {
				subType = 0
			})
		end,
		roll_complete_10 = function ()
			SDKTools.SetParamsAttribute("Fire_SUMMON_10", {
				subType = 0
			})
			SDKTools.SetParamsAttribute("af_SUMMON_10", {
				subType = 0
			})
		end,
		gacha_complete = function ()
			SDKTools.SetParamsAttribute("af_SUMMON_New", {
				subType = 0
			})
			SDKTools.SetParamsAttribute("Fire_SUMMON_New", {
				subType = 0
			})
		end,
		role_login = function ()
			SDKTools.SetParamsAttribute("Fire_login", {
				subType = 0
			})

			uv0 = {
				sub_id = uv1.subId
			}

			SDKTools.SetParamsAttribute("account_login", uv0)

			uv0 = {
				AFInAppEventType = "LOGIN",
				subType = 0,
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime()
			}

			SDKTools.SetParamsAttribute("af_login", uv0)
		end,
		account_create_ys = function ()
			uv0 = {
				sub_id = tostring(uv1.subId),
				model = tostring(uv1.model),
				os_version = tostring(uv1 and uv1.system or nil),
				ram = tostring(UnityEngine.SystemInfo.systemMemorySize),
				rom = tostring(LuaForUtil.GetFreeDiskSpace()),
				cpu_hardware = _G.CPUINFO,
				network = _G.NETTYPE,
				mac = tostring(uv1.mac),
				ip = _G.TCP_ADDR
			}

			SDKTools.SetParamsAttribute("register", uv0)
			SDKTools.SetParamsAttribute("Fire_completeregistration", {
				subType = 0
			})

			uv0 = {
				AFInAppEventType = "COMPLETE_REGISTRATION",
				subType = 0,
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime()
			}

			SDKTools.SetParamsAttribute("af_completeregistration", uv0)
		end,
		purchase_first_ys = function ()
			SDKTools.SetParamsAttribute("af_FirstPurchase", {
				subType = 0
			})
			SDKTools.SetParamsAttribute("Fire_FirstPurchase", {
				subType = 0
			})
		end,
		purchase_click = function ()
			uv0 = {
				AFInAppEventType = "INITIATED_CHECKOUT",
				subType = 0,
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime()
			}

			SDKTools.SetParamsAttribute("af_initiatedcheckout", uv0)
			SDKTools.SetParamsAttribute("Fire_initiatedcheckout", {
				subType = 0
			})
		end,
		role_level = function (slot0)
			uv0 = {
				AFInAppEventType = "LEVEL_ACHIEVED",
				subType = 0,
				user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime()
			}

			if slot0.level == 7 or slot0.level == 10 or slot0.level == 15 or slot0.level == 30 then
				SDKTools.SetParamsAttribute("af_levelachieved" .. tostring(slot0.level), uv0)
				SDKTools.SetParamsAttribute("Fire_levelachieved" .. tostring(slot0.level), {
					subType = 0
				})
			end
		end
	}
}
