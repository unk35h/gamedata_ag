slot1 = {}
slot2 = _G.deviceInfo or {}

return {
	typeToFunction = {
		account_create_ys = function ()
			uv0 = {
				af_customer_user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				yongshi_id = _G.YONGSHI_ID
			}

			SDKTools.SetParamsAttribute("af_complete_registration", uv0)
		end,
		role_login = function ()
			uv0 = {
				af_customer_user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				role_name = PlayerData:GetPlayerInfo().nick
			}

			SDKTools.SetParamsAttribute("af_login", uv0)
		end,
		tutorial = function (slot0)
			if slot0.guideId == 6 then
				uv0 = {
					af_customer_user_id = PlayerData:GetPlayerInfo().userID,
					time = manager.time:GetServerTime()
				}

				SDKTools.SetParamsAttribute("af_tutorial_completion", uv0)
			end
		end,
		day_retention = function (slot0)
			uv0 = {
				af_customer_user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime()
			}

			SDKTools.SetParamsAttribute("af_retention_day" .. tostring(slot0.diff + 1), uv0)
		end,
		purchase_ys = function (slot0)
			uv0 = {
				af_customer_user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime(),
				af_currency = slot0.currency_type,
				af_revenue = slot0.value
			}

			SDKTools.SetParamsAttribute("af_purchase", uv0)
		end,
		purchase_complete_montlycard = function ()
			uv0 = {
				af_customer_user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime()
			}

			SDKTools.SetParamsAttribute("af_purchase_montlycard", uv0)
		end,
		purchase_first_ys = function ()
			uv0 = {
				af_customer_user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime()
			}

			SDKTools.SetParamsAttribute("af_purchase_first", uv0)
		end,
		charge_Total = function (slot0)
			if slot0.total >= 250 and slot0.total < 648 then
				uv0 = {
					af_customer_user_id = PlayerData:GetPlayerInfo().userID,
					time = manager.time:GetServerTime()
				}

				SDKTools.SetParamsAttribute("af_payment_achieved250", uv0)
			end

			if slot0.total >= 648 then
				uv0 = {
					af_customer_user_id = PlayerData:GetPlayerInfo().userID,
					time = manager.time:GetServerTime()
				}

				SDKTools.SetParamsAttribute("af_payment_achieved648", uv0)
			end
		end,
		role_level = function (slot0)
			uv0 = {
				af_customer_user_id = PlayerData:GetPlayerInfo().userID,
				time = manager.time:GetServerTime()
			}

			if slot0.level == 16 or slot0.level == 30 then
				SDKTools.SetParamsAttribute("af_level_achieved" .. tostring(slot0.level), uv0)
			end
		end
	}
}
