slot0 = class("EnchantmentInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/EnchantmentStageUI"
end

function slot1(slot0, slot1)
	if GameSetting.fm_stage_unlock.value[slot0] <= PlayerData:GetPlayerInfo().userLevel then
		return false
	end

	if slot1 then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot2))
	end

	return true
end

slot2 = GameSetting.fm_free_refresh_limit_count.value[1]
slot3 = GameSetting.fm_item_refresh_limit_count.value[1]
slot4 = GameSetting.fm_item_refresh_cost.value
slot5 = GameSetting.fm_stage_unlock.value[1]
slot6 = GameSetting.fm_get_refresh_count.value[1]

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.selectedDifficulty_ = 1
	slot0.itemS = {}
	slot0.isBtnActive_ = false

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.btnCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "btnCon")
	slot0.diffCon_ = ControllerUtil.GetController(slot0.selectdifficultbtnBtn_.transform, "conName")
	slot0.diffCon1 = ControllerUtil.GetController(slot0.levelbtn1.transform, "conName")
	slot0.diffCon2 = ControllerUtil.GetController(slot0.levelbtn2.transform, "conName")
	slot4 = "conName"
	slot0.diffCon3 = ControllerUtil.GetController(slot0.levelbtn3.transform, slot4)

	for slot4 = 1, 3 do
		slot0.itemS[slot4] = EnchantmentItemView.New(slot0["item" .. slot4 .. "Go_"], slot0.commonitemsmallGo_, handler(slot0, slot0.ShowAffixInfo))
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		if not checkMoney(GameSetting.fm_item_refresh_cost.value[BattleEnchantmentData:GetData().allRefreshedTimes + 1][2]) then
			return
		end

		if _G.SkipTip.SkipEnchantmentRefreshTip then
			BattleEnchantAction.EnchantmentRefresh(2, GameSetting.fm_item_refresh_cost.value[slot0.allRefreshedTimes + 1])

			return
		end

		slot2 = false

		ShowMessageBox({
			title = "Warning!",
			content = {
				GetTips("WHETHER_TO_CONSUME"),
				{
					CurrencyConst.CURRENCY_TYPE_DIAMOND,
					slot1
				},
				GetTips("ENCHANTMENT_STAGE_REFRESH_ONCE")
			},
			OkCallback = function ()
				BattleEnchantAction.EnchantmentRefresh(2, GameSetting.fm_item_refresh_cost.value[uv0.allRefreshedTimes + 1])

				_G.SkipTip.SkipEnchantmentRefreshTip = uv1
			end,
			ToggleCallback = function (slot0)
				uv0 = slot0
			end
		})
	end)
	slot0:AddBtnListener(slot0.freeBtn_, nil, function ()
		slot0 = SettingData:GetRemindSettingData()

		if not _G.SkipTip.SkipRefreshEnchantmentTimesTip and slot0.refresh_enchantment_times_reminder == 1 then
			slot1 = false

			for slot6, slot7 in ipairs(BattleEnchantmentData:GetData().enchantmentBattleList) do
				if StageGroupCfg[slot7].level >= 3 then
					slot1 = true

					break
				end
			end

			if slot1 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("EQUIP_STAGE_REFRESH"),
					OkCallback = function ()
						_G.SkipTip.SkipRefreshEnchantmentTimesTip = uv0.SkipRefreshEnchantmentTimesTip_

						BattleEnchantAction.EnchantmentRefresh(1)
					end,
					ToggleCallback = function (slot0)
						uv0.SkipRefreshEnchantmentTimesTip_ = slot0
					end
				})

				return
			end
		end

		BattleEnchantAction.EnchantmentRefresh(1)
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:RefreshDifficultButton()
	end)
	slot0:AddBtnListener(slot0.selectdifficultbtnBtn_, nil, function ()
		uv0:RefreshDifficultButton()
	end)
	slot0:AddBtnListener(slot0.levelbtn1, nil, function ()
		if uv0(1, true) then
			uv1:RefreshDifficultButton()

			return
		end

		BattleEnchantAction.SetSelectLevel(1)

		uv1.selectedDifficulty_ = 1

		uv1:RefreshDifficultButton()
		uv1:RefreshContent()
	end)
	slot0:AddBtnListener(slot0.levelbtn2, nil, function ()
		if uv0(2, true) then
			uv1:RefreshDifficultButton()

			return
		end

		BattleEnchantAction.SetSelectLevel(2)

		uv1.selectedDifficulty_ = 2

		uv1:RefreshDifficultButton()
		uv1:RefreshContent()
	end)
	slot0:AddBtnListener(slot0.levelbtn3, nil, function ()
		if uv0(3, true) then
			uv1:RefreshDifficultButton()

			return
		end

		BattleEnchantAction.SetSelectLevel(3)

		uv1.selectedDifficulty_ = 3

		uv1:RefreshDifficultButton()
		uv1:RefreshContent()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetGameHelpKey("ENCHANTMENT_DESCRIPE")
end

function slot0.OnEnter(slot0)
	slot0.isBtnActive_ = true
	slot0.resttimeText_.text = string.format(GetTips("TIME_DISPLAY_5"), TimeMgr:DescCDTime(slot0:during()))
	slot0.selectedDifficulty_ = BattleEnchantAction.GetSelectLevel()

	if slot0.selectedDifficulty_ == 0 then
		for slot4 = 1, 3 do
			if not uv0(slot4) and slot0.selectedDifficulty_ < slot4 then
				slot0.selectedDifficulty_ = slot4
			end
		end

		BattleEnchantAction.SetSelectLevel(slot0.selectedDifficulty_)
	end

	slot0:RefreshDiffBtn()
	slot0:RefreshDifficultButton()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end

	manager.windowBar:HideBar()
end

function slot0.OnEnchantmentRefresh(slot0)
	slot0:RefreshUI()
end

function slot0.OnEnchantmentInit(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshTip()
	slot0:RefreshTimePanel()
	slot0:RefreshContent()
end

function slot0.RefreshTimePanel(slot0)
	slot0:RefreshCoundown()
	slot0:RefreshBtn()
end

function slot0.during(slot0)
	return _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime()
end

function slot0.RefreshCoundown(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot1 = nil
	slot0.timer_ = Timer.New(function ()
		uv0 = uv1:during()
		uv1.resttimeText_.text = string.format(GetTips("TIME_DISPLAY_5"), TimeMgr:DescCDTime(uv0))

		if uv0 <= 0 then
			uv1.timer_:Stop()

			uv1.timer_ = nil
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.RefreshBtn(slot0)
	if BattleEnchantmentData:GetData().freeRefreshTimes > 0 then
		slot0.freecntText_.text = string.format("<color=#FFFFFF><size=34>%d</size></color>/%d", slot1.freeRefreshTimes, uv0)

		slot0.btnCon_:SetSelectedState("free")
	elseif slot1.allRefreshedTimes < uv1 then
		slot0.numText_.text = string.format("(%d/%d)", slot1.allRefreshedTimes, uv1)
		slot0.costText_.text = uv2[slot1.allRefreshedTimes + 1][2]

		slot0.btnCon_:SetSelectedState("buy")
	else
		slot0.btnCon_:SetSelectedState("max")
	end
end

function slot0.RefreshTip(slot0)
end

function slot0.RefreshDifficultButton(slot0)
	slot0.isBtnActive_ = not slot0.isBtnActive_

	SetActive(slot0.difficultpanelGo_, slot0.isBtnActive_)
	SetActive(slot0.maskGo_, slot0.isBtnActive_)
end

function slot0.RefreshDiffBtn(slot0)
	for slot4 = 1, 3 do
		slot0["diffCon" .. slot4]:SetSelectedState(uv0(slot4) and "lock" or "unLock")
	end
end

function slot0.RefreshContent(slot0)
	slot5 = 0

	slot0.itempanelAni_:Play("aniEnchantmentStageUI_itemPanel", slot5, 0)

	slot1 = BattleEnchantmentData:GetData()

	for slot5 = 1, 3 do
		slot6 = slot1.enchantmentBattleList[slot5]

		slot0.itemS[slot5]:RefreshUI(StageGroupCfg[slot6].stage_list[slot0.selectedDifficulty_], StageGroupCfg[slot6].level)
	end

	SetActive(slot0.affixinfoTrs_.gameObject, false)
	slot0.diffCon_:SetSelectedState(slot0.selectedDifficulty_)

	slot0.diffText_.text = GetTips("HARD_LEVEL")
end

function slot0.ShowAffixInfo(slot0, slot1, slot2)
	slot0.affixinfoTrs_:SetParent(slot1)

	slot0.affixinfoTrs_.localPosition = Vector3(0, 0, 0)

	SetActive(slot0.affixinfoTrs_.gameObject, true)

	if slot2 and slot2 ~= "" then
		slot0.affixcontentText_.text = getAffixDesc(slot2)
		slot0.affixnameText_.text = getAffixName(slot2)
	else
		slot0.affixcontentText_.text = ""
		slot0.affixnameText_.text = ""
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.affixinfoTrs_)

	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end

	slot0.countdownTimer_ = Timer.New(function ()
		SetActive(uv0.affixinfoTrs_.gameObject, false)
	end, 2, -1)

	slot0.countdownTimer_:Start()
end

function slot0.Dispose(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end

	for slot4 = 1, 3 do
		slot0.itemS[slot4]:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
