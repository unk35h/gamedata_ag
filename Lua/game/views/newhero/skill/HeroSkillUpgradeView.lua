slot0 = class("HeroSkillUpgradeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/HeroSkillUpgradeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.btnStateController_ = ControllerUtil.GetController(slot0.upgradeGo_.transform, "btnState")
	slot0.isSelfController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isSelf")
	slot0.descBtnController_ = ControllerUtil.GetController(slot0.descBtnPanelGo_.transform, "btnState")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.costIconBtn_, nil, function ()
		if uv0.costCfg_ then
			ShowPopItem(POP_SOURCE_ITEM, uv0.costCfg_)
		end
	end)
	slot0:AddPressingByTimeListener(slot0.upgradeBtn_.gameObject, 2, 0.4, 0.2, function ()
		if SkillTools.GetIsDodgeSkill(uv0.params_.skillId) or uv0.level_ == HeroConst.MAX_SKILL_LEVEL then
			uv0:SendSkillUpgrade()

			return false
		end

		if HeroData:GetHeroData(uv0.params_.heroId).break_level < SkillCfg[uv0.level_]["skill_limit" .. SkillTools.GetSkillIdIndex(uv0.params_.skillId)] then
			uv0:SendSkillUpgrade()

			return false
		end

		if not uv0.costEnough_ then
			uv0:SendSkillUpgrade()
			ShowTips("ERROR_HERO_NO_SKILL_UP_MAT")

			return false
		end

		uv0.tempAddLevel_ = (uv0.tempAddLevel_ or 0) + 1

		uv0:RefreshMessage()

		return true
	end, handler(slot0, slot0.SendSkillUpgrade))
	slot0:AddBtnListener(slot0.simpleDescBtn_, nil, function ()
		uv0:RefreshDesc(1)
	end)
	slot0:AddBtnListener(slot0.detailDescBtn_, nil, function ()
		uv0:RefreshDesc(2)
	end)
end

function slot0.SendSkillUpgrade(slot0)
	if slot0.tempAddLevel_ and slot0.tempAddLevel_ > 0 then
		HeroAction.HeroSkillUpgrade(slot0.params_.heroId, slot0.params_.skillId, slot0.tempAddLevel_)
	end
end

function slot0.GetRealSkillId(slot0)
	if slot0.extra_ and slot0.isPreview_ then
		return slot0.params_.skillId
	else
		return SkillTools.GetRealSkillId(slot0.params_.heroId, slot0.params_.skillId, slot0.extra_)
	end
end

function slot0.RefreshSkill(slot0)
	slot0.realSkillId_ = slot0:GetRealSkillId()
	slot1 = HeroSkillCfg[slot0.realSkillId_]
	slot0.iconImg_.sprite = getSprite("Atlas/" .. slot0.params_.heroId, slot0.realSkillId_)
	slot0.nameText_.text = slot1.name

	if slot1.cd == 0 then
		slot0.cdText_.text = " - "
	else
		slot0.cdText_.text = slot1.cd / 1000 .. "s"
	end

	slot2 = HeroCfg[slot0.params_.heroId]
	slot0.subnameText_.text = slot2.skill_subhead[table.indexof(slot2.skills, slot0.params_.skillId)]
	slot0.typeText_.text = SkillElementCfg[slot1.element_type].name
	slot0.listSrex_.verticalNormalizedPosition = 1

	SetActive(slot0.skillCostGo_, slot1.EnergyChange < 0)

	if slot1.EnergyChange < 0 then
		slot0.skillCostText_.text = math.abs(slot1.EnergyChange) .. " " .. GetTips("NOTE_ENERGYTYPE_" .. CharactorParamCfg[slot0.params_.heroId].EnergyType)
	end

	SetActive(slot0.rcpPanel_, HeroConst.SKILL_SHOW_ICON[slot0.realSkillId_] ~= nil)

	if slot5 then
		slot0.rcpIcon1_.sprite = getSprite("Atlas/" .. slot0.params_.heroId, slot5[1])
		slot0.rcpIcon2_.sprite = getSprite("Atlas/" .. slot0.params_.heroId, slot5[2])
	end

	if PublicSkillCfg[slot0.params_.skillId].skill_sub_type == nil then
		slot6 = 0
	end

	SetActive(slot0.goSkillType_, slot6 ~= 0)

	slot0.textSkillType_.text = SkillSubTypeCfg[SkillSubTypeCfg.get_id_list_by_value[slot6][1]].annotation
end

function slot0.GetSkillLv(slot0)
	if not slot0.skillLevel_ or slot0.skillLevel_ == 0 then
		slot0.skillLevel_ = HeroTools.GetSkillLv(slot0.params_.heroId, slot0.params_.skillId, slot0.extra_)
	end

	return slot0.skillLevel_ + (slot0.tempAddLevel_ or 0)
end

function slot0.GetHeroData(slot0)
	if slot0.extra_ then
		if slot0.isForeign_ then
			return ForeignInfoData:GetHeroInfo(slot0.params_.heroId)
		elseif slot0.isTemp_ then
			return TempHeroData:GetHeroDataByHeroID(slot0.extra_.tempHeroList, slot0.params_.heroId)
		elseif slot0.isPreview_ then
			return HeroData:GetHeroData(slot0.params_.heroId)
		elseif slot0.isPolyhedron_ then
			return PolyhedronData:GetPolyhedronHeroData(slot0.params_.heroId)
		end
	else
		return HeroData:GetHeroData(slot0.params_.heroId)
	end
end

function slot0.RefreshMessage(slot0)
	slot1 = slot0:GetHeroData()
	slot0.level_ = slot0:GetSkillLv()
	slot0.addEquipSkillLv_ = 0

	if slot0.extra_ then
		if slot0.isForeign_ then
			slot0.addEquipSkillLv_ = ForeignInfoData:GetTransitionAddLevel(slot0.params_.heroId, slot0.params_.skillId)
		elseif slot0.isPolyhedron_ then
			slot0.addEquipSkillLv_ = HeroTools.GetTransitionAddLevel(slot1, slot0.params_.skillId)
		end
	else
		slot0.addEquipSkillLv_ = HeroTools.GetTransitionAddLevel(slot1, slot0.params_.skillId)
	end

	slot0.addSkillLv_ = HeroTools.GetHeroSkillAddLevel(slot1, slot0.params_.skillId)

	if SkillTools.GetIsDodgeSkill(slot0.params_.skillId) then
		slot0.addSkillLv_ = 0
	end

	if slot0.isPreview_ then
		slot0.level_ = 1
		slot0.addSkillLv_ = 0
		slot0.addEquipSkillLv_ = 0

		SetActive(slot0.addLvGo_, false)
	end

	if slot0.addEquipSkillLv_ > 0 then
		slot0.lvText_.text = string.format("<size=60>%d</size><color=#383838>+</color>", slot0.level_ + slot0.addSkillLv_) .. slot0.addEquipSkillLv_
	else
		slot0.lvText_.text = string.format("<size=60>%d</size>", slot0.level_ + slot0.addSkillLv_)
	end

	slot0:RefreshShowType()
	slot0:RefreshDesc(slot0.descType_ or 1)
end

function slot0.RefreshDesc(slot0, slot1)
	if slot1 == 1 then
		slot0.contentText_.text = HeroSkillCfg[slot0.realSkillId_].simpleDesc
	else
		slot2 = SkillTools.GetIsDodgeSkill(slot0.params_.skillId)
		slot3 = slot0.contentText_
		slot4 = SkillTools.GetSkillDesc
		slot6 = slot0.realSkillId_
		slot7 = slot0.level_ + slot0.addSkillLv_ + slot0.addEquipSkillLv_
		slot8 = slot0.level_ == HeroConst.MAX_SKILL_LEVEL or slot2
		slot3.text = slot4(slot6, slot7, slot8, slot0.extra_)
	end

	slot0.descType_ = slot1

	slot0.descBtnController_:SetSelectedState(tostring(slot1))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentText_.transform)
end

function slot0.RefreshShowType(slot0)
	if SkillTools.GetIsDodgeSkill(slot0.params_.skillId) then
		SetActive(slot0.gradeGo_, false)
		SetActive(slot0.costGo_, false)

		slot0.upgradeBtn_.enabled = false

		slot0.btnStateController_:SetSelectedState("max")

		slot0.btnText_.text = GetTips("TEXT_LEVEL_MAX")

		SetActive(slot0.tipGo_, false)
	elseif HeroConst.MAX_SKILL_LEVEL <= slot0.level_ then
		SetActive(slot0.gradeGo_, false)
		SetActive(slot0.costGo_, false)

		slot0.upgradeBtn_.enabled = false

		slot0.btnStateController_:SetSelectedState("max")

		slot0.btnText_.text = GetTips("TEXT_LEVEL_MAX")

		SetActive(slot0.tipGo_, false)
	else
		if HeroData:GetHeroData(slot0.params_.heroId).break_level < SkillCfg[slot0.level_]["skill_limit" .. SkillTools.GetSkillIdIndex(slot0.params_.skillId)] then
			SetActive(slot0.gradeGo_, true)

			slot0.gradeText_.text = string.format(GetTips("NOTE_SKILL_LIMIT"), slot2)
			slot0.upgradeBtn_.enabled = false

			slot0.btnStateController_:SetSelectedState("false")

			slot0.btnText_.text = GetTips("TEXT_UPGRADE")
		else
			SetActive(slot0.gradeGo_, false)

			slot0.upgradeBtn_.enabled = true

			slot0.btnStateController_:SetSelectedState("true")

			slot0.btnText_.text = GetTips("TEXT_UPGRADE")
		end

		SetActive(slot0.costGo_, true)
		slot0:RefreshCost()
		SetActive(slot0.tipGo_, slot0.costEnough_ and slot2 <= slot3.break_level)
	end
end

function slot0.RefreshCost(slot0)
	if not slot0.isPreview_ then
		slot0.costCfg_ = SkillCfg[slot0.level_]["skill_cost" .. SkillTools.GetSkillIdIndex(slot0.params_.skillId)][1]
		slot0.costIconImg_.sprite = ItemTools.getItemLittleSprite(slot0.costCfg_[1])
		slot3 = 0

		if MaterialData:GetMaterialList()[slot0.costCfg_[1]] then
			slot3 = slot2[slot0.costCfg_[1]].num
		end

		if slot0.tempAddLevel_ and slot0.tempAddLevel_ > 0 then
			slot3 = slot3 - SkillTools.GetSkillUpCostNum(slot0.params_.skillId, slot0.skillLevel_, slot0.tempAddLevel_)[slot0.costCfg_[1]]
		end

		if slot3 < slot0.costCfg_[2] then
			slot0.costEnough_ = false
			slot0.costNumText_.text = string.format("<color=#F43950>%d</color>/%d", slot3, slot0.costCfg_[2])
		else
			slot0.costEnough_ = true
			slot0.costNumText_.text = string.format("%d/%d", slot3, slot0.costCfg_[2])
		end
	end
end

function slot0.OnHeroSkillUpgrade(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		ShowTips("SKILL_UPGRATE_SUCCESS", string.format("LEVEL\n<size=60>%s</size>", slot0.level_))
		slot0:PlayHeroTalk(slot0.params_.heroId)
	else
		ShowTips(slot1.result)
	end

	slot0.skillLevel_ = nil
	slot0.tempAddLevel_ = 0

	slot0:RefreshMessage()
end

function slot0.PlayHeroTalk(slot0, slot1)
	if slot0.isTalkCD_ then
		return
	end

	HeroTools.PlayTalk(slot1, "skillup")

	slot0.isTalkCD_ = true
	slot0.talkCDTimer_ = Timer.New(function ()
		uv0.isTalkCD_ = false
	end, HeroConst.SKILL_UPGRADE_VOICE_CD, 1)

	slot0.talkCDTimer_:Start()
end

function slot0.OnEnter(slot0)
	slot0.id_ = slot0.params_.skillId
	slot0.extra_ = slot0.params_.extra
	slot0.isForeign_ = slot0.extra_ and slot0.extra_.isForeign
	slot0.isTemp_ = slot0.extra_ and slot0.extra_.isTemp
	slot0.isPreview_ = slot0.extra_ and slot0.extra_.isPreview
	slot0.isPolyhedron_ = slot0.extra_ and slot0.extra_.isPolyhedron
	slot0.skillLevel_ = nil
	slot0.tempAddLevel_ = 0
	slot0.isNeedPlayTalk_ = true

	slot0:RefreshSkill()
	slot0:RefreshMessage()

	if slot0.params_.hide_option then
		slot0.isSelfController_:SetSelectedState("true")
	else
		slot0.isSelfController_:SetSelectedState(slot0.extra_ and "true" or "false")
	end
end

function slot0.OnExit(slot0)
	slot0.descType_ = nil

	slot0:StopLongClickTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.talkCDTimer_ then
		slot0.talkCDTimer_:Stop()

		slot0.talkCDTimer_ = nil
	end

	slot0.isTalkCD_ = nil
end

return slot0
