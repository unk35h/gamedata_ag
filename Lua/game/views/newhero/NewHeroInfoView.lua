slot0 = class("NewHeroInfoView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.oldAtt_ = {}
	slot0.tweens_ = {}
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.isUnlockController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isUnlock")
	slot0.pieceEnoughController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "pieceEnough")
	slot0.campController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "camp")
	slot0.isSelfController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isSelf")
	slot4 = "attackType"
	slot0.attackTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, slot4)
	slot0.propNames_ = {
		slot0.propName1_,
		slot0.propName2_,
		slot0.propName3_,
		slot0.propName4_
	}
	slot0.propItems_ = {
		slot0.propNum1_,
		slot0.propNum2_,
		slot0.propNum3_,
		slot0.propNum4_
	}
	slot0.propIcon_ = {
		slot0.propIcon1_,
		slot0.propIcon2_,
		slot0.propIcon3_,
		slot0.propIcon4_
	}
	slot0.propIndexes_ = {
		HeroConst.HERO_ATTRIBUTE.ATK,
		HeroConst.HERO_ATTRIBUTE.ARM,
		HeroConst.HERO_ATTRIBUTE.STA,
		HeroConst.HERO_ATTRIBUTE.CRITICAL
	}
	slot0.endfixes_ = {}

	for slot4 = 1, 4 do
		slot0.propNames_[slot4].text, slot6, slot0.propIcon_[slot4].sprite = SkillTools.GetAttr({
			slot0.propIndexes_[slot4],
			0
		})
		slot0.endfixes_[slot4] = PublicAttrCfg[slot0.propIndexes_[slot4]].percent == 1 and "%" or ""
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.getPieceBtn_, nil, function ()
		ShowPopItem(POP_SOURCE_ITEM, {
			ItemCfg[uv0.heroCfg_.id].fragment
		})
	end)
	slot0:AddBtnListener(slot0.getHeroBtn_, nil, function ()
		manager.net:SendWithLoadingNew(14016, {
			id = uv0.heroCfg_.id
		}, 14017, handler(uv0, uv0.OnUnlockHero))
	end)
	slot0:AddBtnListener(slot0.campBgBtn_, nil, function ()
		JumpTools.OpenPageByJump("heroRaceDetails")
	end)

	if slot0.buttonHeroAttribute_ then
		slot0:AddBtnListener(slot0.buttonHeroAttribute_, nil, function ()
			JumpTools.OpenPageByJump("heroAttribute", {
				heroID = uv0.heroInfo_.id,
				extra = uv0.extra_
			})
		end)
	end
end

function slot0.OnUnlockHero(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		HeroAction.UnlockHeroSuccess(slot0.heroCfg_.id)
		HeroAction.HeroPieceModify(slot0.heroCfg_.id, slot0.pieceCost_)
		PolyhedronAction:RefreshHeroesRedPoint()
		gameContext:Go("obtainView", {
			itemList = {
				slot0.heroCfg_
			}
		})
	end
end

function slot0.SetHeroInfo(slot0, slot1)
	slot0.oldBattlePower_ = slot0.battlePower_ or 0
	slot0.oldAtt_ = slot0.att_ or {}
	slot0.heroInfo_ = slot1
	slot0.heroCfg_ = HeroCfg[slot1.id]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.nameText_.text = slot0.heroCfg_.name
	slot0.subNameText_.text = slot0.heroCfg_.suffix

	slot0.isUnlockController_:SetSelectedState(tostring(slot0.heroInfo_.unlock ~= 0 or slot0.isPreview_ == true))
	slot0.campController_:SetSelectedState(tostring(slot0.heroCfg_.race))

	if slot0.heroInfo_.unlock == 0 then
		slot0:UpdateLockedView()
	else
		slot0:UpdateUnlockedView()
	end
end

function slot0.UpdateLockedView(slot0)
	slot1 = slot0.heroInfo_.piece
	slot3 = GameSetting.unlock_hero_need.value[slot0.heroCfg_.rare]
	slot4 = math.min(slot1, slot3)
	slot0.pieceCost_ = -slot3
	slot0.curPieceText_.text = tostring(slot1)
	slot0.needPieceText_.text = "/" .. tostring(slot3)

	if slot0.tweenValue_ then
		LeanTween.cancel(slot0.tweenValue_.id)

		slot0.tweenValue_ = nil
	end

	slot0.tweenValue_ = LeanTween.value(0, 0.7, 0.7):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		slot1 = 0

		if slot0 >= 0.2 then
			slot1 = (slot0 - 0.2) / 0.5
		end

		uv0.scheduleImage_.fillAmount = uv1 * slot1 / uv2
	end)):setOnComplete(LuaHelper.VoidAction(function ()
		if uv0.tweenValue_ then
			uv0.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			uv0.tweenValue_ = nil
		end

		uv0.scheduleImage_.fillAmount = uv1 / uv2
	end)):setEase(LeanTweenType.easeOutQuad)

	if slot3 <= slot1 then
		slot0.pieceEnoughController_:SetSelectedState("true")
	else
		slot0.pieceEnoughController_:SetSelectedState("false")
	end
end

function slot0.UpdateUnlockedView(slot0)
	if slot0.isPreview_ == nil or slot0.isPreview_ == false then
		if not slot0.extra_ then
			slot0.proficiencyText_.text = HeroTools.GetHeroProficiency(slot0.heroInfo_.id) .. "/" .. GameSetting.mastery_level_max.value[1]
		end

		slot1 = slot0.heroInfo_.level
		slot2 = slot0.heroInfo_.exp

		if slot0.isForeign_ then
			slot0.battlePower_ = ForeignInfoData:GetBattlePower(slot0.heroInfo_.id)
		elseif slot0.isTemp_ then
			slot0.battlePower_ = TempHeroData:GetBattlePower(TempHeroData:GetHeroDataByHeroID(slot0.extra_.tempHeroList, slot0.heroInfo_.id), slot0.extra_)
		elseif slot0.isPolyhedron_ then
			slot0.battlePower_ = getBattlePower(PolyhedronData:GetPolyhedronHeroData(slot0.heroInfo_.id))
		else
			slot4 = {}

			for slot8, slot9 in ipairs(HeroData:GetHeroData(slot0.heroInfo_.id).equip) do
				id = slot9.equip_id

				if id ~= 0 then
					table.insert(slot4, EquipData:GetEquipData(id))
				end
			end

			slot0.battlePower_ = getBattlePower(slot3)
		end

		if slot0.battlePowerTween_ then
			LeanTween.cancel(slot0.battlePowerTween_.id)

			slot0.battlePowerTween_ = nil
		end

		slot0.battlePowerTween_ = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
			slot1 = uv0.oldBattlePower_ or 0
			uv0.fightPowerText_.text = math.floor(slot1 + (uv0.battlePower_ - slot1) * slot0)
		end)):setOnComplete(LuaHelper.VoidAction(function ()
			if uv0.battlePowerTween_ then
				uv0.battlePowerTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

				uv0.battlePowerTween_ = nil
			end

			uv0.fightPowerText_.text = uv0.battlePower_
		end)):setEase(LeanTweenType.easeOutQuad)
		slot3 = HeroTools.GetHeroCurrentMaxLevel(slot0.heroInfo_)
		slot4 = slot2 - LvTools.LevelToExp(slot1, "hero_level_exp1")
		slot8 = slot0.extra_
		slot0.att_ = HeroTools.GetHeroAllAttribute(slot0.heroInfo_.id, slot8)

		for slot8, slot9 in pairs(slot0.propItems_) do
			slot10 = PublicAttrCfg[slot0.propIndexes_[slot8]].percent == 1

			if slot0.tweens_[slot8] then
				LeanTween.cancel(slot0.tweens_[slot8].id)

				slot0.tweens_[slot8] = nil
			end

			slot0.tweens_[slot8] = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
				slot1 = uv0.oldAtt_[uv0.propIndexes_[uv1]] or 0
				slot3 = math.floor(slot1 + (uv0.att_[uv0.propIndexes_[uv1]] - slot1) * slot0)

				if uv2 then
					uv3.text = string.format("%.2f", slot3 / 10) .. uv0.endfixes_[uv1]
				else
					uv3.text = math.floor(slot3)
				end
			end)):setOnComplete(LuaHelper.VoidAction(function ()
				if uv0.tweens_[uv1] then
					uv0.tweens_[uv1]:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

					uv0.tweens_[uv1] = nil
				end

				if uv2 then
					uv3.text = string.format("%.2f", uv0.att_[uv0.propIndexes_[uv1]] / 10) .. uv0.endfixes_[uv1]
				else
					uv3.text = math.floor(uv0.att_[uv0.propIndexes_[uv1]])
				end
			end)):setEase(LeanTweenType.easeOutQuad)
		end

		slot0.nowLevelText_.text = tostring(slot1)
		slot0.topLevelText_.text = "/" .. slot3

		if slot1 < slot3 then
			slot5 = GameLevelSetting[slot1].hero_level_exp1
			slot0.expProgressBar_.value = math.floor(slot4 / slot5 * 1000) / 1000
			slot0.expText_.text = string.format("%d/%d", slot4, slot5)
		elseif LvTools.GetIsMaxLv(slot1, "hero") then
			slot0.expProgressBar_.value = 1
			slot0.expText_.text = "-/-"
		else
			slot5 = GameLevelSetting[slot1].hero_level_exp1
			slot0.expProgressBar_.value = math.floor(slot4 / slot5 * 1000) / 1000
			slot0.expText_.text = string.format("%d/%d", slot4, slot5)
		end

		slot0.descScroll_.verticalNormalizedPosition = 1
	end

	slot0.friendlyDescText_.text = slot0.heroCfg_.hero_desc
	slot0.starImg_.sprite = getSprite("Atlas/Common", "star_" .. HeroStarCfg[slot0.heroInfo_.star].star)
	slot0.rangeTypeText_.text = CharactorParamCfg[slot0.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")

	slot0:RefreshChargeType()
	slot0:RefreshAttackType()
end

function slot0.RefreshChargeType(slot0)
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

function slot0.RefreshAttackType(slot0)
	if #slot0.heroCfg_.ATK_attribute > 1 then
		slot0.attackTypeController_:SetSelectedState(-1)
	else
		slot0.attackTypeController_:SetSelectedState(slot0.heroCfg_.ATK_attribute[1])
	end
end

function slot0.OnEnter(slot0, slot1)
	slot0.extra_ = slot1
	slot0.isForeign_ = slot1 and slot1.isForeign
	slot0.isTemp_ = slot1 and slot1.isTemp
	slot0.isPreview_ = slot1 and slot1.isPreview
	slot0.isPolyhedron_ = slot1 and slot1.isPolyhedron

	slot0.isSelfController_:SetSelectedState(not slot0.extra_ and "true" or "false")
	slot0:RegistEventListener(HERO_DATA_MODIFY, handler(slot0, slot0.OnHeroModify))
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnHeroModify(slot0, slot1)
	if slot1 == slot0.heroInfo_.id then
		slot0:UpdateView()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.tweenValue_ then
		slot0.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tweenValue_.id)

		slot0.tweenValue_ = nil
	end

	if slot0.battlePowerTween_ then
		slot0.battlePowerTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.battlePowerTween_.id)

		slot0.battlePowerTween_ = nil
	end

	if slot0.tweens_ then
		for slot4, slot5 in pairs(slot0.tweens_) do
			slot5:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
			LeanTween.cancel(slot5.id)
		end

		slot0.tweens_ = nil
	end

	slot0.handler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
