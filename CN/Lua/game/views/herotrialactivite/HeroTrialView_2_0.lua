slot1 = class("HeroTrialView_2_0", import("game.views.heroTrialActivite.TYR.HeroTrialView_1_7"))

function slot1.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:UIName()), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.activiteID_ = slot2

	slot0:Init()
end

function slot1.Init(slot0)
	uv0.super.Init(slot0)

	slot0.attackTypeController_ = ControllerUtil.GetController(slot0.transform_, "attackType")
end

function slot1.UIName(slot0)
	return "UI/VersionUI/XuHeng1stUI/XH1stHeroTrialUI/XH1stHeroTrialUI"
end

function slot1.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot1.OnEnter(slot0)
	if not ActivityData:GetActivityIsOpen(slot0.activiteID_) then
		return
	end

	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activiteID_).stopTime
end

function slot1.OnExit(slot0)
	slot0:StopTimer()
end

function slot1.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_HERO_TRIAL_DESCRIPE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_HERO_TRIAL_DESCRIPE")
		})
	end)
end

function slot1.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot1.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)
	slot0:RefreshRangeType()
	slot0:RefreshChargeType()
	slot0:RefreshAttackType()
end

function slot1.RefreshRangeType(slot0)
	slot0.rangeTypeText_.text = CharactorParamCfg[slot0.heroID_].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
end

function slot1.RefreshChargeType(slot0)
	if slot0.heroCfg_.mechanism_type[1] == HeroConst.HERO_CHARGE_TYPE.RAGE then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_1")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.ENERGY then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_2")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.TRACES then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_3")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.DIVINE_GRACE then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_4")
	end
end

function slot1.RefreshAttackType(slot0)
	if #slot0.heroCfg_.ATK_attribute > 1 then
		slot0.attackTypeController_:SetSelectedState(-1)
	else
		slot0.attackTypeController_:SetSelectedState(slot0.heroCfg_.ATK_attribute[1])
	end
end

function slot1.RefreshTextName(slot0, slot1)
	slot2 = string.split(slot1, "·")
	slot0.textName_.text = slot2[1]
	slot0.textSubName_.text = slot2[2]
end

function slot1.GetRewardItem(slot0, slot1)
	return HeroTrialRewardItem_2_0.New(slot0.goRewardPanel_, slot0.rewardItemGo_, slot1, true)
end

function slot1.RefreshHeroItem(slot0)
	slot1 = slot0.selectActiviteHeroID_

	for slot6, slot7 in ipairs(slot0.activiteHeroIDList_) do
		if slot0.heroItemList_[slot6] then
			slot0.heroItemList_[slot6]:SetActiviteHeroID(slot0.activiteID_, slot7)
		else
			slot0.heroItemList_[slot6] = slot0:GetHeroTrialSelectItemClass().New(slot0.goItem_, slot0.goItemParent_, slot7, slot0.activiteID_)
		end
	end

	for slot6 = #slot0.heroItemList_, #slot2 + 1, -1 do
		slot0.heroItemList_[slot6]:Dispose()

		slot0.heroItemList_[slot6] = nil
	end

	for slot6, slot7 in pairs(slot2) do
		if slot7 == slot1 then
			slot0:RefreshSelectActiviteHero(slot1)

			return
		end
	end

	slot0:RefreshSelectActiviteHero(slot2[1])
end

function slot1.GetHeroTrialSelectItemClass(slot0)
	return HeroTrialSelectItem_2_0
end

function slot1.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 == true then
		slot0:AddTimer()
		slot0:RefreshUI()
		manager.notify:RegistListener(HERO_TRIAL_CLICK, slot0.onClickTrialHandler_)
	else
		slot0:StopTimer()
		manager.notify:RemoveListener(HERO_TRIAL_CLICK, slot0.onClickTrialHandler_)
	end
end

function slot1.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		uv0.textTime_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

return slot1
