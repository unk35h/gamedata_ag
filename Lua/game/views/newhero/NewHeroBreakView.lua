slot0 = class("NewHeroBreakView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroPromotion/HeroBreakUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.moneyEnoughController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "moneyEnough")
	slot0.items_ = {}
	slot0.needIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.breakBtn_, nil, function ()
		slot1 = HeroTools.CaculateHeroAttribute(uv0.heroInfo_, EquipTools.CalHeroEquipAttribute(uv0.heroInfo_.equip, uv0.heroInfo_.id))

		HeroTools.CalFinalAttribute(slot1)

		uv0.oldAttr_ = slot1

		HeroAction.HeroBreak(uv0.heroInfo_.id)
	end)
end

function slot0.OnHeroBreak(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		for slot6, slot7 in ipairs(slot0.breakCfg_.cost) do
			MaterialAction.MaterialModify(slot7[1], -1 * slot7[2])
		end

		CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_GOLD, -slot0.breakCfg_.cost_gold)
		HeroAction.BreakSuccess(slot0.heroInfo_.id, (slot0.heroInfo_.break_level or 0) + 1)
		slot0:Back()
		JumpTools.OpenPageByJump("newBreakSuccess", {
			heroId = slot0.heroInfo_.id,
			breakLevel = slot0.heroInfo_.break_level or 0,
			oldCrit = slot0.oldAttr_[HeroConst.HERO_ATTRIBUTE.CRITICAL]
		})
	end
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0.heroInfo_ = slot0.params_.heroInfo
	slot0.heroCfg_ = HeroCfg[slot0.heroInfo_.id]
	slot0.breakCfg_ = HeroTools.GetHeroBreakConfig(slot0.heroCfg_.race, slot0.heroInfo_.break_level or 0)
	slot0.nextBreakCfg_ = HeroTools.GetHeroBreakConfig(slot0.heroCfg_.race, slot0.heroInfo_.break_level + 1 or 0)

	slot0:RegistEventListener(MATERIAL_MODIFY, function (slot0)
		uv0:UpdateView()
	end)
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.titleText_.text = string.format(GetTips("HERO_LEVEL_LIMIT_UP"), slot0.nextBreakCfg_.max_level)
	slot1 = true
	slot2 = nil

	if slot0.breakCfg_.user_level <= PlayerData:GetPlayerInfo().userLevel then
		slot2 = string.format(GetTips("UPGRADE_LIMIT_LEVEL"), slot0.breakCfg_.user_level)
		slot0.conditionToggle_.isOn = true
	else
		slot2 = string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), slot0.breakCfg_.user_level)
		slot0.conditionToggle_.isOn = false
		slot1 = false
	end

	slot0.conditionText_.text = slot2
	slot3 = #slot0.breakCfg_.cost

	for slot7 = 1, 3 do
		slot8 = slot0["itemPrefab" .. slot7]

		if slot7 <= slot3 then
			if not slot0.items_[slot7] then
				SetActive(slot8, true)
				table.insert(slot0.items_, NewHeroBreakMaterialItem.New(slot0, slot8))
			end

			slot0.items_[slot7]:SetInfo(slot0.breakCfg_.cost[slot7][1], slot0.breakCfg_.cost[slot7][2])

			if not slot0.items_[slot7]:IsEnough() then
				slot1 = false
			end
		else
			SetActive(slot8, false)
		end
	end

	while slot3 < #slot0.items_ do
		slot0.items_[#slot0.items_]:Dispose()
		table.remove(slot0.items_, #slot0.items_)
	end

	slot0.needNumText_.text = string.format("x%d", slot0.breakCfg_.cost_gold)

	if slot0.breakCfg_.cost_gold <= CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD) then
		slot0.moneyEnoughController_:SetSelectedState("true")
	else
		slot0.moneyEnoughController_:SetSelectedState("false")

		slot1 = false
	end

	ButtonTools.SetButtonEnable(slot0.breakBtn_, slot1)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.items_ then
		for slot4, slot5 in ipairs(slot0.items_) do
			slot5:Dispose()
		end

		slot0.items_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
