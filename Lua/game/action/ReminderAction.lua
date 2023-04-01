slot1 = manager.net

slot1:Bind(21001, function (slot0)
	slot1 = slot0.setting

	SettingAction.ChangeRemindSetting("activity_sign_reminder", slot1.sign_in_propel_switch)
	SettingAction.ChangeRemindSetting("month_card_reminder", slot1.month_card_propel_switch)
end)

return {
	GetSetting = function (slot0)
		manager.net:SendWithLoadingNew(21010, {}, 21011, handler(slot0, slot0.OnGetSetting))
	end,
	OnGetSetting = function (slot0, slot1, slot2)
		if not isSuccess(slot1.result) then
			ShowTips(slot1.result)
		end
	end,
	SettingMotify = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(21012, {
			setting = {
				sign_in_propel_switch = slot1,
				month_card_propel_switch = slot2
			}
		}, 21013, handler(slot0, slot0.OnSettingMotify))
	end,
	OnSettingMotify = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			slot3 = slot2.setting

			SettingAction.ChangeRemindSetting("activity_sign_reminder", slot3.sign_in_propel_switch)
			SettingAction.ChangeRemindSetting("month_card_reminder", slot3.month_card_propel_switch)
		else
			ShowTips(slot1.result)
		end
	end
}
