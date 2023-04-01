slot0 = class("SortHeroTypeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Hero/HeroScreeningPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot4 = "select"
	slot0.allCon_ = ControllerUtil.GetController(slot0.allBtn_.gameObject.transform, slot4)
	slot0.toggle_ = {}

	for slot4 = 0, 1 do
		slot0.toggle_[slot4] = slot0["tgl_" .. slot4]
	end

	slot0.raceBtn_ = {}
	slot0.raceCon_ = {}

	for slot4, slot5 in ipairs(RaceEffectCfg.all) do
		slot0.raceBtn_[slot4] = slot0["raceBtn_" .. slot4]
		slot0.raceCon_[slot4] = ControllerUtil.GetController(slot0.raceBtn_[slot4].gameObject.transform, "select")
	end

	slot0.attackBtn_ = {}
	slot0.attackCon_ = {}
	slot0.attackType_ = {
		HeroConst.HERO_ATTACK_TYPE.PYISICS,
		HeroConst.HERO_ATTACK_TYPE.WIND,
		HeroConst.HERO_ATTACK_TYPE.FLAME,
		HeroConst.HERO_ATTACK_TYPE.THUNDER,
		HeroConst.HERO_ATTACK_TYPE.DARK,
		HeroConst.HERO_ATTACK_TYPE.LIGHT,
		HeroConst.HERO_ATTACK_TYPE.FREEZE,
		HeroConst.HERO_ATTACK_TYPE.WATER,
		HeroConst.HERO_ATTACK_TYPE.MIX
	}

	for slot4, slot5 in ipairs(slot0.attackType_) do
		slot0.attackBtn_[slot4] = slot0["attackBtn_" .. slot4]
		slot0.attackCon_[slot4] = ControllerUtil.GetController(slot0.attackBtn_[slot4].gameObject.transform, "select")
	end

	slot0.energyBtn_ = {}
	slot0.energyCon_ = {}
	slot0.energyType_ = {
		HeroConst.HERO_CHARGE_TYPE.RAGE,
		HeroConst.HERO_CHARGE_TYPE.ENERGY,
		HeroConst.HERO_CHARGE_TYPE.TRACES,
		HeroConst.HERO_CHARGE_TYPE.DIVINE_GRACE
	}

	for slot4, slot5 in ipairs(slot0.energyType_) do
		slot0.energyBtn_[slot4] = slot0["energyBtn_" .. slot4]
		slot0.energyCon_[slot4] = ControllerUtil.GetController(slot0.energyBtn_[slot4].gameObject.transform, "select")
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.canelBtn_, nil, function ()
		HeroData:ResetSortValue()
		manager.notify:CallUpdateFunc(HERO_SORT, true, 0, {}, {}, {})
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		manager.notify:CallUpdateFunc(HERO_SORT, uv0.isAll_, uv0.curSortType_, uv0.curSortRace_, uv0.curAttackType_, uv0.curEnergyType_)
		uv0:Back()
	end)

	slot4 = slot0.allBtn_

	slot0:AddBtnListener(slot4, nil, function ()
		uv0.isAll_ = true
		uv0.curSortRace_ = {}
		uv0.curAttackType_ = {}
		uv0.curEnergyType_ = {}

		uv0:RefreshBtnState()
	end)

	for slot4 = 0, 1 do
		slot0:AddToggleListener(slot0.toggle_[slot4], function (slot0)
			if slot0 then
				uv0.curSortType_ = uv1
			end
		end)
	end

	for slot4, slot5 in ipairs(RaceEffectCfg.all) do
		slot0:AddBtnListener(slot0.raceBtn_[slot4], nil, function ()
			if table.indexof(uv0.curSortRace_, uv1) then
				table.remove(uv0.curSortRace_, slot0)
				uv0.raceCon_[uv2]:SetSelectedState("off")
				uv0:IsNeedAll()
			else
				table.insert(uv0.curSortRace_, uv1)
				uv0.raceCon_[uv2]:SetSelectedState("on")
				uv0:SetAllOff()
			end
		end)
	end

	for slot4, slot5 in ipairs(slot0.attackType_) do
		slot0:AddBtnListener(slot0.attackBtn_[slot4], nil, function ()
			if table.indexof(uv0.curAttackType_, uv0.attackType_[uv1]) then
				table.remove(uv0.curAttackType_, slot1)
				uv0.attackCon_[uv1]:SetSelectedState("off")
				uv0:IsNeedAll()
			else
				table.insert(uv0.curAttackType_, slot0)
				uv0.attackCon_[uv1]:SetSelectedState("on")
				uv0:SetAllOff()
			end
		end)
	end

	for slot4, slot5 in ipairs(slot0.energyType_) do
		slot0:AddBtnListener(slot0.energyBtn_[slot4], nil, function ()
			if table.indexof(uv0.curEnergyType_, uv0.energyType_[uv1]) then
				table.remove(uv0.curEnergyType_, slot1)
				uv0.energyCon_[uv1]:SetSelectedState("off")
				uv0:IsNeedAll()
			else
				table.insert(uv0.curEnergyType_, slot0)
				uv0.energyCon_[uv1]:SetSelectedState("on")
				uv0:SetAllOff()
			end
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0.isAll_ = slot0.params_.isAll
	slot0.curSortType_ = slot0.params_.sortType or 0
	slot0.curSortRace_ = slot0.params_.sortRace and deepClone(slot0.params_.sortRace) or {}
	slot0.curAttackType_ = slot0.params_.attackType and deepClone(slot0.params_.attackType) or {}
	slot0.curEnergyType_ = slot0.params_.energyType and deepClone(slot0.params_.energyType) or {}

	slot0:RefreshBtnState()
end

function slot0.RefreshBtnState(slot0)
	slot0.allCon_:SetSelectedState(slot0.isAll_ and "on" or "off")

	slot0.toggle_[slot0.curSortType_].isOn = true

	for slot4, slot5 in ipairs(RaceEffectCfg.all) do
		slot0.raceCon_[slot4]:SetSelectedState(table.indexof(slot0.curSortRace_, slot5) and "on" or "off")
	end

	for slot4, slot5 in ipairs(slot0.attackType_) do
		slot0.attackCon_[slot4]:SetSelectedState(table.indexof(slot0.curAttackType_, slot5) and "on" or "off")
	end

	for slot4, slot5 in ipairs(slot0.energyType_) do
		slot0.energyCon_[slot4]:SetSelectedState(table.indexof(slot0.curEnergyType_, slot5) and "on" or "off")
	end
end

function slot0.SetAllOff(slot0)
	slot0.isAll_ = false

	slot0.allCon_:SetSelectedState("off")
end

function slot0.IsNeedAll(slot0)
	if #slot0.curSortRace_ <= 0 and #slot0.curAttackType_ <= 0 and #slot0.curEnergyType_ <= 0 then
		slot0.isAll_ = true

		slot0.allCon_:SetSelectedState("on")
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
