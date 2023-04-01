slot0 = class("EnchantmentMultiPop", ReduxView)
slot1 = #GameSetting.challenge_multiple_count_unlock_level.value

function slot0.UIName(slot0)
	return "UI/PopUp/MultipleacquisitionUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.cancelbtnBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okbtnBtn_, nil, function ()
		if not checkVitality(uv0.cost_ * uv0.multiple_) then
			return
		end

		uv0:Go("/sectionSelectHero", {
			section = uv0.stageID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT,
			multiple = uv0.multiple_
		})
	end)
	slot0:AddBtnListener(slot0.leftBtn_, nil, function ()
		uv0.multiple_ = uv0.multiple_ - 1

		uv0:ChangeMultiple()
	end)
	slot0:AddBtnListener(slot0.rightBtn_, nil, function ()
		if uv0.challengeCnt_ <= uv0.multiple_ then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.challenge_multiple_count_unlock_level.value[uv0.multiple_ + 1]))

			return
		end

		uv0.multiple_ = uv0.multiple_ + 1

		uv0:ChangeMultiple()
	end)
	slot0:AddBtnListener(slot0.leftmaxBtn_, nil, function ()
		uv0.multiple_ = 1

		uv0:ChangeMultiple()
	end)
	slot0:AddBtnListener(slot0.rightmaxBtn_, nil, function ()
		slot0 = uv0.maxMultiple_

		if uv0.challengeCnt_ < uv0.maxMultiple_ then
			slot0 = uv0.challengeCnt_
		end

		uv0.multiple_ = slot0

		uv0:ChangeMultiple()
	end)
end

function slot0.ChangeMultiple(slot0)
	slot0:RefreshMultiple()
	slot0:RefreshCost()
end

function slot0.RefreshMultiple(slot0)
	slot0.usenumtextText_.text = "x" .. slot0.multiple_

	if slot0.maxMultiple_ <= slot0.multiple_ or slot0.challengeCnt_ <= slot0.multiple_ then
		slot0.rightmaxBtn_.interactable = false
		slot0.leftmaxBtn_.interactable = true
		slot0.leftBtn_.interactable = true
	elseif slot0.multiple_ <= 1 then
		slot0.rightmaxBtn_.interactable = true
		slot0.leftmaxBtn_.interactable = false
		slot0.leftBtn_.interactable = false
	else
		slot0.rightmaxBtn_.interactable = true
		slot0.leftmaxBtn_.interactable = true
		slot0.leftBtn_.interactable = true
	end

	if slot0.multiple_ == uv0 then
		slot0.rightBtn_.interactable = false
	else
		slot0.rightBtn_.interactable = true
	end

	if slot0.multiple_ <= 1 then
		slot0.leftmaxBtn_.interactable = false
		slot0.leftBtn_.interactable = false
	end
end

function slot0.RefreshCost(slot0)
	slot0.totalText_.text = slot0.cost_ * slot0.multiple_
end

function slot0.RefreshData(slot0)
	slot1 = 1

	for slot5 = uv0, 1, -1 do
		if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY) >= slot0.cost_ * slot5 then
			slot1 = slot5

			break
		end
	end

	slot0.maxMultiple_ = slot1
	slot0.multiple_ = slot0.multiple_ or 1
	slot0.challengeCnt_ = slot0:GetUnlockChallengeCnt()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	slot0:RegistEventListener(CURRENCY_UPDATE, function ()
		uv0:RefreshData()
		uv0:ChangeMultiple()
	end)

	slot0.stageID_ = slot0.params_.stageID
	slot0.cost_ = BattleEnchantmentStageCfg[slot0.stageID_].cost
	slot0.multiple_ = 1

	slot0:RefreshData()
	slot0:ChangeMultiple()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot0.GetUnlockChallengeCnt(slot0)
	slot2 = PlayerData:GetPlayerInfo().userLevel

	for slot6, slot7 in ipairs(GameSetting.challenge_multiple_count_unlock_level.value) do
		if slot2 < slot7 then
			return slot6 - 1
		end
	end

	return #slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
