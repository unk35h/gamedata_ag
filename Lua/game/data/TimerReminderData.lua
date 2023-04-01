slot0 = singletonClass("TimerReminderData")
slot1 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.SetReminder(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = {
			id = slot1
		}
	end

	if slot1 == TimerReminderConst.FATIGUE then
		slot5 = nil
		slot6 = manager.time:GetServerTime() + (GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max <= CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY) and 0 or (slot3 - slot4 - 1) * slot6 + (CurrencyData:GetLastFatigueRecoverTime() == 0 and slot6 or slot6 - (manager.time:GetServerTime() - CurrencyData:GetLastFatigueRecoverTime()) % slot6))

		if uv0[slot1].lastReminderTime == nil then
			if uv0[slot1].nextReminderTime and uv0[slot1].nextReminderTime == slot6 then
				return
			end

			uv0[slot1].nextReminderTime = slot6
		else
			if uv0[slot1].nextReminderTime and uv0[slot1].nextReminderTime == slot6 then
				return
			end

			if uv0[slot1].nextReminderTime <= manager.time:GetServerTime() then
				uv0[slot1].lastReminderTime = uv0[slot1].nextReminderTime
			end

			if slot6 <= uv0[slot1].lastReminderTime + GameSetting.push_notification_fatigue_cooldown * 60 then
				slot0:CancelReminder(slot1)

				return
			end

			uv0[slot1].nextReminderTime = slot6
		end

		slot7 = PushNotificationCfg.get_id_list_by_type[slot1]
		slot9 = PushNotificationCfg[slot7[math.round(math.random(#slot7))]]

		print("体力推送", slot1, slot9.title, slot9.content, slot5 * 1000)

		if slot5 * 1000 >= 1000 then
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", slot1, slot9.title, slot9.content, slot5 * 1000))
		end
	else
		print("未设置此推送类型", slot1)
	end
end

function slot0.CancelReminder(slot0, slot1)
	if slot1 == nil or uv0[slot1] == nil then
		print("未设置此推送", slot1)

		return
	end

	GameToSDK.SendMessage(string.format("{\"messageType\" : \"CancelNotification\" , \"msgId\" : \"%d\"}", slot1))
end

return slot0
