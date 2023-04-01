slot0 = class("RemindSettingView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
	slot0:OnEnter()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.cooperationFriendController = ControllerUtil.GetController(slot0.m_cooperationFriend, "switch")
	slot0.cooperationGuildController = ControllerUtil.GetController(slot0.m_cooperationGuild, "switch")
	slot0.cooperationRecentController = ControllerUtil.GetController(slot0.m_cooperationRecent, "switch")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.signReminderBtn_, nil, function ()
		SettingAction.ChangeRemindSetting("activity_sign_reminder", 1 - uv0.settingData_.activity_sign_reminder)
	end)
	slot0:AddBtnListener(slot0.monthCardReminderBtn_, nil, function ()
		SettingAction.ChangeRemindSetting("month_card_reminder", 1 - uv0.settingData_.month_card_reminder)
	end)
	slot0:AddBtnListener(slot0.fatigueFullReminderBtn_, nil, function ()
		SettingAction.ChangeRemindSetting("fatigue_full_reminder", 1 - uv0.settingData_.fatigue_full_reminder)
	end)
	slot0:AddBtnListener(slot0.diamondBuyItemBtn_, nil, function ()
		SettingAction.ChangeRemindSetting("diamond_buy_item_reminder", 1 - uv0.settingData_.diamond_buy_item_reminder)
	end)
	slot0:AddBtnListener(slot0.coreEquipBuyItemBtn_, nil, function ()
		SettingAction.ChangeRemindSetting("core_equip_buy_item_reminder", 1 - uv0.settingData_.core_equip_buy_item_reminder)
	end)
	slot0:AddBtnListener(slot0.infoBadgeTopBuyItemBtn_, nil, function ()
		SettingAction.ChangeRemindSetting("info_badge_top_buy_item_reminder", 1 - uv0.settingData_.info_badge_top_buy_item_reminder)
	end)
	slot0:AddBtnListener(slot0.bossChallengeSBuyItemBtn_, nil, function ()
		SettingAction.ChangeRemindSetting("boss_challenge_s_buy_item_reminder", 1 - uv0.settingData_.boss_challenge_s_buy_item_reminder)
	end)
	slot0:AddBtnListener(slot0.diamondBuyFatigueBtn_, nil, function ()
		SettingAction.ChangeRemindSetting("diamond_buy_fatigue_reminder", 1 - uv0.settingData_.diamond_buy_fatigue_reminder)
	end)
	slot0:AddBtnListener(slot0.diamondBuyGoldBtn_, nil, function ()
		SettingAction.ChangeRemindSetting("diamond_buy_gold_reminder", 1 - uv0.settingData_.diamond_buy_gold_reminder)
	end)
	slot0:AddBtnListener(slot0.spiritRefineBtn_, nil, function ()
		SettingAction.ChangeRemindSetting("spirit_refine_reminder", 1 - uv0.settingData_.spirit_refine_reminder)
	end)
	slot0:AddBtnListener(slot0.servantPromoteBtn_, nil, function ()
		SettingAction.ChangeRemindSetting("servant_promote_reminder", 1 - uv0.settingData_.servant_promote_reminder)
	end)
	slot0:AddBtnListener(slot0.refreshEnchantmentTimesBtn_, nil, function ()
		SettingAction.ChangeRemindSetting("refresh_enchantment_times_reminder", 1 - uv0.settingData_.refresh_enchantment_times_reminder)
	end)
	slot0:AddBtnListener(slot0.uninstallEquipBtn_, nil, function ()
		SettingAction.ChangeRemindSetting("uninstall_equip_reminder", 1 - uv0.settingData_.uninstall_equip_reminder)
	end)
	slot0:AddBtnListener(slot0.rebuildHeroEquipBtn_, nil, function ()
		SettingAction.ChangeRemindSetting("rebuild_hero_equip_reminder", 1 - uv0.settingData_.rebuild_hero_equip_reminder)
	end)
	slot0:AddBtnListener(slot0.m_cooperationFriendBtn, nil, function ()
		CooperationAction.SetInviteRestrict(1, CooperationData:GetInviteRestrict(1) and 2 or 1)
	end)
	slot0:AddBtnListener(slot0.m_cooperationGuildBtn, nil, function ()
		CooperationAction.SetInviteRestrict(2, CooperationData:GetInviteRestrict(2) and 2 or 1)
	end)
	slot0:AddBtnListener(slot0.m_cooperationRecentBtn, nil, function ()
		CooperationAction.SetInviteRestrict(3, CooperationData:GetInviteRestrict(3) and 2 or 1)
	end)
end

function slot0.OnEnter(slot0)
	slot1 = slot0.content_.localPosition
	slot0.content_.localPosition = Vector3(slot1.x, 0, slot1.z)
	slot0.settingData_ = SettingData:GetRemindSettingData()

	slot0:RefreshSignReminder()
	slot0:RefreshMonthCardReminder()
	slot0:RefreshFatigueFullReminder()
	slot0:RefreshDiamondBuyItemReminder()
	slot0:RefreshCoreEquipBuyItemReminder()
	slot0:RefreshInfoBadgeTopBuyItemReminder()
	slot0:RefreshBossChallengeSBuyItemReminder()
	slot0:RefreshDiamondBuyFatigueReminder()
	slot0:RefreshDiamondBuyGoldReminder()
	slot0:RefreshSpiritRefineReminder()
	slot0:RefreshServantPromoteReminder()
	slot0:RefreshRefreshEnchantmentTimesReminder()
	slot0:RefreshUninstallEquipReminder()
	slot0:RefreshRebuildHeroEquipReminder()

	slot0.tmpSettingData_ = deepClone(slot0.settingData_)

	slot0:RefreshCooperationRestrict()
end

function slot0.OnExit(slot0)
end

function slot0.RefreshCooperationRestrict(slot0)
	slot0.cooperationFriendController:SetSelectedIndex(CooperationData:GetInviteRestrict(1) and 0 or 1)
	slot0.cooperationGuildController:SetSelectedIndex(CooperationData:GetInviteRestrict(2) and 0 or 1)
	slot0.cooperationRecentController:SetSelectedIndex(CooperationData:GetInviteRestrict(3) and 0 or 1)
end

function slot0.OnCooperationRestrictUpdate(slot0)
	slot0:RefreshCooperationRestrict()
end

function slot0.OnRemindChange(slot0, slot1, slot2)
	if slot2.key == "allData" then
		slot0:RefreshSignReminder()
		slot0:RefreshMonthCardReminder()
		slot0:RefreshFatigueFullReminder()
		slot0:RefreshDiamondBuyItemReminder()
		slot0:RefreshCoreEquipBuyItemReminder()
		slot0:RefreshInfoBadgeTopBuyItemReminder()
		slot0:RefreshBossChallengeSBuyItemReminder()
		slot0:RefreshDiamondBuyFatigueReminder()
		slot0:RefreshDiamondBuyGoldReminder()
		slot0:RefreshSpiritRefineReminder()
		slot0:RefreshRefreshEnchantmentTimesReminder()
		slot0:RefreshUninstallEquipReminder()
		slot0:RefreshRebuildHeroEquipReminder()
		slot0:RefreshServantPromoteReminder()
	elseif slot2.key == "activity_sign_reminder" then
		slot0:RefreshSignReminder()
	elseif slot2.key == "month_card_reminder" then
		slot0:RefreshMonthCardReminder()
	elseif slot2.key == "fatigue_full_reminder" then
		slot0:RefreshFatigueFullReminder()
	elseif slot2.key == "diamond_buy_item_reminder" then
		slot0:RefreshDiamondBuyItemReminder()
	elseif slot2.key == "core_equip_buy_item_reminder" then
		slot0:RefreshCoreEquipBuyItemReminder()
	elseif slot2.key == "info_badge_top_buy_item_reminder" then
		slot0:RefreshInfoBadgeTopBuyItemReminder()
	elseif slot2.key == "boss_challenge_s_buy_item_reminder" then
		slot0:RefreshBossChallengeSBuyItemReminder()
	elseif slot2.key == "diamond_buy_fatigue_reminder" then
		slot0:RefreshDiamondBuyFatigueReminder()
	elseif slot2.key == "diamond_buy_gold_reminder" then
		slot0:RefreshDiamondBuyGoldReminder()
	elseif slot2.key == "spirit_refine_reminder" then
		slot0:RefreshSpiritRefineReminder()
	elseif slot2.key == "refresh_enchantment_times_reminder" then
		slot0:RefreshRefreshEnchantmentTimesReminder()
	elseif slot2.key == "uninstall_equip_reminder" then
		slot0:RefreshUninstallEquipReminder()
	elseif slot2.key == "rebuild_hero_equip_reminder" then
		slot0:RefreshRebuildHeroEquipReminder()
	elseif slot2.key == "servant_promote_reminder" then
		slot0:RefreshServantPromoteReminder()
	end
end

function slot0.RefreshSignReminder(slot0)
	slot1 = slot0.settingData_.activity_sign_reminder == 1

	SetActive(slot0.signReminderOnGo_, slot1)
	SetActive(slot0.signReminderOffGo_, not slot1)
end

function slot0.RefreshMonthCardReminder(slot0)
	slot1 = slot0.settingData_.month_card_reminder == 1

	SetActive(slot0.monthCardReminderOnGo_, slot1)
	SetActive(slot0.monthCardReminderOffGo_, not slot1)
end

function slot0.RefreshFatigueFullReminder(slot0)
	slot1 = slot0.settingData_.fatigue_full_reminder == 1

	SetActive(slot0.FatigueFullReminderOnGo_, slot1)
	SetActive(slot0.FatigueFullReminderOffGo_, not slot1)
end

function slot0.RefreshDiamondBuyItemReminder(slot0)
	slot1 = slot0.settingData_.diamond_buy_item_reminder == 1

	SetActive(slot0.diamondBuyItemOnGo_, slot1)
	SetActive(slot0.diamondBuyItemOffGo_, not slot1)
end

function slot0.RefreshCoreEquipBuyItemReminder(slot0)
	slot1 = slot0.settingData_.core_equip_buy_item_reminder == 1

	SetActive(slot0.coreEquipBuyItemOnGo_, slot1)
	SetActive(slot0.coreEquipBuyItemOffGo_, not slot1)
end

function slot0.RefreshInfoBadgeTopBuyItemReminder(slot0)
	slot1 = slot0.settingData_.info_badge_top_buy_item_reminder == 1

	SetActive(slot0.infoBadgeTopBuyItemOnGo_, slot1)
	SetActive(slot0.infoBadgeTopBuyItemOffGo_, not slot1)
end

function slot0.RefreshBossChallengeSBuyItemReminder(slot0)
	slot1 = slot0.settingData_.boss_challenge_s_buy_item_reminder == 1

	SetActive(slot0.bossChallengeSBuyItemOnGo_, slot1)
	SetActive(slot0.bossChallengeSBuyItemOffGo_, not slot1)
end

function slot0.RefreshDiamondBuyFatigueReminder(slot0)
	slot1 = slot0.settingData_.diamond_buy_fatigue_reminder == 1

	SetActive(slot0.diamondBuyFatigueOnGo_, slot1)
	SetActive(slot0.diamondBuyFatigueOffGo_, not slot1)
end

function slot0.RefreshDiamondBuyGoldReminder(slot0)
	slot1 = slot0.settingData_.diamond_buy_gold_reminder == 1

	SetActive(slot0.diamondBuyGoldOnGO_, slot1)
	SetActive(slot0.diamondBuyGoldffGO_, not slot1)
end

function slot0.RefreshSpiritRefineReminder(slot0)
	slot1 = slot0.settingData_.spirit_refine_reminder == 1

	SetActive(slot0.spiritRefineOnGo_, slot1)
	SetActive(slot0.spiritRefineOffGo_, not slot1)
end

function slot0.RefreshServantPromoteReminder(slot0)
	slot1 = slot0.settingData_.servant_promote_reminder == 1

	SetActive(slot0.servantPromoteOn_, slot1)
	SetActive(slot0.servantPromoteOff_, not slot1)
end

function slot0.RefreshRefreshEnchantmentTimesReminder(slot0)
	slot1 = slot0.settingData_.refresh_enchantment_times_reminder == 1

	SetActive(slot0.refreshEnchantmentTimesOnGo_, slot1)
	SetActive(slot0.refreshEnchantmentTimesOffGo_, not slot1)
end

function slot0.RefreshUninstallEquipReminder(slot0)
	slot1 = slot0.settingData_.uninstall_equip_reminder == 1

	SetActive(slot0.uninstallEquipOnGo_, slot1)
	SetActive(slot0.uninstallEquipOffGo_, not slot1)
end

function slot0.RefreshRebuildHeroEquipReminder(slot0)
	slot1 = slot0.settingData_.rebuild_hero_equip_reminder == 1

	SetActive(slot0.uninstallRebuildHeroEquipOnGo_, slot1)
	SetActive(slot0.uninstallRebuildHeroEquipOffGo_, not slot1)
end

function slot0.CheckDataChange(slot0, slot1)
	if slot0.tmpSettingData_ and not table.equal(slot0.tmpSettingData_, slot0.settingData_, "all") then
		return true
	end

	return false
end

function slot0.SaveData(slot0)
	if slot0:CheckDataChange() then
		SDKTools.SendMessageToSDK("remind_setting", {
			signin_push_setting = slot0.settingData_.activity_sign_reminder,
			insider_push_setting = slot0.settingData_.month_card_reminder,
			dundun_push_setting = slot0.settingData_.fatigue_full_reminder
		})

		if slot0.settingData_.fatigue_full_reminder == 0 then
			TimerReminderData:CancelReminder(TimerReminderConst.FATIGUE)
		end

		ReminderAction:SettingMotify(slot0.settingData_.activity_sign_reminder, slot0.settingData_.month_card_reminder)
	end

	slot0.tmpSettingData_ = deepClone(slot0.settingData_)
end

function slot0.RecoverTmpData(slot0)
	if slot0:CheckDataChange() then
		SettingAction.ChangeRemindSetting("allData", slot0.tmpSettingData_)
	end
end

function slot0.Dispose(slot0)
	slot0.hander_ = nil

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
