slot0 = class("SectionSelectHeroBaseView", ReduxView)
slot1 = {
	{
		position = Vector3(500, 0, 0),
		rotation = Vector3(0, 0, 0),
		scale = Vector3(1, 1, 1)
	},
	{
		position = Vector3(502, 0, -2.5),
		rotation = Vector3(0, -16.419, 0),
		scale = Vector3(1, 1, 1)
	},
	{
		position = Vector3(498, 0, -2.5),
		rotation = Vector3(0, 9.932, 0),
		scale = Vector3(1, 1, 1)
	}
}
slot2 = 462.5
slot3 = Vector3.Distance(slot1[1].position, slot1[2].position)
slot4 = slot1[2].position.z - slot1[1].position.z
slot5 = slot1[2].position.x - slot1[1].position.x

function slot0.UIName(slot0)
	return "UI/StagePrepare/BattleSelectHeroUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.comboSkillView_ = slot0:GetComboSkillView().New(slot0.goComboSkill_)
	slot0.chipView_ = slot0:GetChipView().New(slot0.chipPanel_)
end

function slot0.GetChipView(slot0)
	return SectionSelectHeroChip
end

function slot0.GetComboSkillView(slot0)
	return SectionComboSkillView
end

function slot0.HeroPosAdaptUI(slot0)
	for slot4 = 1, 3 do
		uv0[slot4].position.x, uv0[slot4].position.z = manager.ui:ScreenToWorldPoint(slot0.heroRect_[slot4].anchoredPosition.x * UnityEngine.Screen.width / slot0.panel.rect.width + 0.5 * UnityEngine.Screen.width, 0, 7.6 - offset[slot4])
	end
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("battleHeroSelect")
	manager.ui:AdaptUIByFOV()

	if slot0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS or slot0.params_.stageType == BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			NAVI_BAR
		})
	end

	slot0.multiple_ = slot0.params_.multiple or 1
	slot0.stageID_ = slot0.params_.section
	slot0.stageType_ = slot0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	slot0.contID_ = slot0.params_.cont_id

	if slot0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		slot0.teamID_ = slot0.params_.team_id or 0
		slot0.params_.team_id = slot0.teamID_
	else
		slot0.teamID_ = slot0.params_.team_id
	end

	slot0.heroModel_ = {}
	slot0.loadAsyncIndex_ = {}
	slot0.loadingList_ = {}
	slot0.cacheHeroNumber_ = {
		1,
		2,
		3
	}
	slot0.cacheHeroTeam_ = {}
	slot0.heroTrialList_ = {}

	slot0:RefreshEffectActive()
	slot0:RefreshChip()
	slot0:RefreshHeroTeam()
	slot0:LoadHeroModels()
	slot0:RefreshText()
	slot0:HidePanel()
	slot0:RefreshRace()
	slot0:RefreshReservesBtn()
	slot0:RefreshSortType()

	slot0.params_.isReserves = nil
end

function slot0.OnExit(slot0)
	if slot0.talkTimer_ then
		slot0.talkTimer_:Stop()

		slot0.talkTimer_ = nil
	end

	if slot0.talkCDTimer_ then
		slot0.talkCDTimer_:Stop()

		slot0.talkCDTimer_ = nil
	end

	slot0.params_.isSorted = false
	slot0.params_.cont_id = nil
	slot0.params_.team_id = nil
	slot0.contID_ = nil
	slot0.teamID_ = nil

	HeroTools.StopTalk()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	slot0:DestroyHeroModels()
end

function slot0.Dispose(slot0)
	slot0.chipView_:Dispose()

	slot0.chipView_ = nil

	slot0.comboSkillView_:Dispose()

	slot0.comboSkillView_ = nil

	if slot0.ani_ then
		Object.Destroy(slot0.ani_)
	end

	slot0:RemoveTriggerListeners()
	slot0:RemoveListeners()

	slot0.stageName_ = nil
	slot0.warningImage_ = nil
	slot0.recommendGo_ = nil
	slot0.powerGo_ = nil
	slot0.recommendImage_ = nil
	slot0.recommendPowerText_ = nil
	slot0.recommendPowerNumText_ = nil
	slot0.powerNumText_ = nil
	slot0.powerText_ = nil
	slot0.powerImg_ = nil
	slot0.effectPanel_ = nil
	slot0.effectImage_ = nil
	slot0.effectName_ = nil
	slot0.effectText_ = nil
	slot0.effectHeroText_ = nil
	slot0.addBtnGo_ = nil
	slot0.addBtnImg_ = nil
	slot0.heroPowerPanel_ = nil
	slot0.heroPowerIcon_ = nil
	slot0.heroPowerText_ = nil
	slot0.drag_ = nil
	slot0.dragPosition_ = nil
	slot0.startBtn_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.addBtnGo_ = {}
	slot0.addBtnImg_ = {}
	slot0.heroPowerPanel_ = {}
	slot0.heroPowerIcon_ = {}
	slot0.heroPowerText_ = {}
	slot0.hpImg_ = {}
	slot0.hpText_ = {}
	slot0.energyGo_ = {}
	slot0.energyText_ = {}
	slot0.drag_ = {}
	slot0.dragImg_ = {}
	slot0.dragPosition_ = {}
	slot0.heroRect_ = {}

	for slot4 = 1, 3 do
		slot0.heroPowerPanel_[slot4] = slot0[string.format("heroPowerPanel%s_", slot4)]
		slot0.heroPowerIcon_[slot4] = slot0[string.format("heroPowerIcon%s_", slot4)]
		slot0.heroPowerText_[slot4] = slot0[string.format("heroPowerText%s_", slot4)]
		slot0.addBtnGo_[slot4] = slot0[string.format("addBtnGo%s_", slot4)]
		slot0.addBtnImg_[slot4] = slot0[string.format("addBtnImg%s_", slot4)]
		slot0.energyGo_[slot4] = slot0[string.format("energyGo%s_", slot4)]
		slot0.energyText_[slot4] = slot0[string.format("energyLabel%s_", slot4)]
		slot0.drag_[slot4] = slot0[string.format("drag%s_", slot4)]
		slot0.dragImg_[slot4] = slot0["dragImg_" .. slot4]
		slot0.hpImg_[slot4] = slot0[string.format("blood%sImg_", slot4)]
		slot0.hpText_[slot4] = slot0[string.format("hptext%sText_", slot4)]

		slot0:CreateDragListeners(slot4)

		slot0.dragPosition_[slot4] = slot0.drag_[slot4].transform.localPosition
		slot0.heroRect_[slot4] = slot0[string.format("heroRect_%s", slot4)]
	end
end

function slot0.CreateDragListeners(slot0, slot1)
	slot0.drag_[slot1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0.selectIndex_ then
			return
		end

		if #uv0.loadingList_ > 0 then
			return
		end

		if uv0.lockStateList_[uv1] or uv0.params_.canChangeTeam ~= nil and uv0.params_.canChangeTeam == false then
			ShowTips("CAN_NOT_CHANGE_HERO")

			return
		end

		uv0.selectIndex_ = uv1
		uv0.cacheSelectIndex_ = uv1
		uv0.cacheHeroNumber_ = {
			1,
			2,
			3
		}
	end))
	slot0.drag_[slot1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0.selectIndex_ ~= uv1 then
			return
		end

		if #uv0.loadingList_ > 0 then
			return
		end

		slot2 = Vector3((slot1.position.x - Screen.width / 2) * manager.ui.canvasRate, 0, 0)

		if slot0.transform.localPosition.x > 237 or slot2.x > 237 then
			slot0.transform.localPosition = Vector3(237, slot2.y, slot2.z)
		elseif slot0.transform.localPosition.x < -688 or slot2.x < -688 then
			slot0.transform.localPosition = Vector3(-688, slot2.y, slot2.z)
		else
			slot0.transform.localPosition = slot2
		end

		slot3 = uv0:GetModelOffesetPosition(slot0.transform.localPosition)

		if uv0.heroModel_[uv1] then
			uv0.heroModel_[uv1].transform.localPosition = uv2[1].position + slot3

			if not uv0.lockStateList_[uv1] or uv0.params_.canChangeTeam ~= nil and uv0.params_.canChangeTeam == true then
				uv0:TryModifyHeroPos()
			end
		end
	end))
	slot0.drag_[slot1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0.selectIndex_ ~= uv1 then
			return
		end

		if #uv0.loadingList_ > 0 then
			return
		end

		slot0.transform.localPosition = uv0.dragPosition_[uv1]

		if not uv0.lockStateList_[uv1] or uv0.params_.canChangeTeam ~= nil and uv0.params_.canChangeTeam == true then
			uv0:EndDrag(uv1)
		end

		uv0.selectIndex_ = nil
	end))
	slot0.drag_[slot1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(handlerArg1(slot0, slot0.ClickHero, slot1)))
end

function slot0.RemoveTriggerListeners(slot0)
	for slot4 = 1, 3 do
		slot0.drag_[slot4]:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
		slot0.drag_[slot4]:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
		slot0.drag_[slot4]:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
		slot0.drag_[slot4]:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	end
end

function slot0.ClickHero(slot0, slot1, slot2, slot3)
	if not slot3.dragging then
		if slot0.selectIndex_ then
			return
		end

		if #slot0.loadingList_ > 0 then
			return
		end

		BattleFieldData:SetCurrentSelectHeroData(slot0.cacheHeroTeam_[slot1], slot0.heroTrialList_[slot1])
		OperationRecorder.Record(slot0.class.__cname, "click_add")
		slot0:GoHeroInfoUI(slot1)
	end
end

function slot0.TryModifyHeroPos(slot0)
	slot2 = slot0.heroModel_[slot0.selectIndex_].transform.localPosition

	for slot6 = 1, 3 do
		if math.abs(uv0[slot6].position.x - slot2.x) <= 0.6 and slot6 ~= slot0.cacheSelectIndex_ then
			if slot0.cacheHeroTeam_[slot0.cacheHeroNumber_[slot6]] == 0 then
				break
			end

			if slot0.lockStateList_[slot0.selectIndex_] or slot0.lockStateList_[slot6] then
				return
			end

			if slot0.heroModel_[slot0.cacheHeroNumber_[slot6]] then
				slot0.heroModel_[slot0.cacheHeroNumber_[slot6]].transform.localPosition = uv0[slot0.cacheSelectIndex_].position
				slot0.heroModel_[slot0.cacheHeroNumber_[slot6]].transform.localEulerAngles = uv0[slot0.cacheSelectIndex_].rotation
			end

			slot0.cacheHeroNumber_[slot6] = slot0.cacheHeroNumber_[slot0.cacheSelectIndex_]
			slot0.cacheHeroNumber_[slot0.cacheSelectIndex_] = slot0.cacheHeroNumber_[slot6]
			slot0.cacheSelectIndex_ = slot6

			break
		end
	end
end

function slot0.EndDrag(slot0, slot1)
	slot2 = {}

	for slot6 = 1, 3 do
		slot2[slot6] = slot0.cacheHeroTeam_[slot0.cacheHeroNumber_[slot6]]
	end

	slot3 = {}

	for slot7, slot8 in pairs(slot2) do
		slot9 = 1

		for slot13 = 1, 3 do
			if slot0.cacheHeroTeam_[slot13] == slot8 then
				slot9 = slot13

				break
			end
		end

		slot3[slot7] = slot0.heroModel_[slot9]

		if slot3[slot7] then
			slot3[slot7].transform.localPosition = uv0[slot7].position
			slot3[slot7].transform.localEulerAngles = uv0[slot7].rotation
		end
	end

	slot0.heroModel_ = slot3

	slot0:SwapIndex(slot0.selectIndex_, slot0.cacheSelectIndex_)
	slot0:ChangeHeroTeam(slot2)
	slot0:RefreshHeroTeam()
	OperationRecorder.Record(slot0.class.__cname, "endDrag")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if uv0.params_.sectionType == BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL then
			MythicAction.SaveAllTeam(function ()
				if #uv0.loadingList_ > 0 then
					return
				end

				if uv0.cacheHeroTeam_[1] ~= 0 then
					uv0:StartBattle()
				else
					ShowTips("ERROR_HERO_ONE_NOT_IN")
				end
			end)
		else
			uv0:OnClickStartBattle()
		end
	end)
	slot0:AddBtnListener(slot0.reservesBtn_, nil, function ()
		uv0:GotoReservesUI()
	end)
end

function slot0.GotoReservesUI(slot0)
	slot5 = slot0.comboSkillView_

	JumpTools.OpenPageByJump("/reservesUI", {
		isInit = true,
		stage_type = slot0.stageType_,
		activityID = slot0.params_.activityID,
		hero_list = slot0.cacheHeroTeam_,
		hero_trial_list = slot0.heroTrialList_,
		lockList = slot0.lockList_,
		comboSkill = slot5:GetCurComboSkill(),
		chipInfo = {
			enabledID = slot0.chipView_:GetCurEnabledID(),
			chipList = slot0.chipView_:GetCurChipList()
		},
		cont_id = slot0.contID_,
		team_id = slot0.teamID_
	})
end

function slot0.RemoveListeners(slot0)
	slot0.startBtn_.onClick:RemoveAllListeners()
end

function slot0.OnClickStartBattle(slot0)
	if #slot0.loadingList_ > 0 then
		return
	end

	if slot0.cacheHeroTeam_[1] ~= 0 then
		slot0:SaveTeamInfo()
		slot0:StartBattle()
	else
		ShowTips("ERROR_HERO_ONE_NOT_IN")
	end
end

function slot0.StartBattle(slot0)
	slot1 = BattleStageFactory.Produce(slot0.stageType_, slot0.stageID_, slot0.params_.activityID)

	slot1:SetMultiple(slot0.multiple_)
	BattleController.GetInstance():LaunchBattle(slot1)
end

function slot0.RefreshHeroTeam(slot0)
	slot0:GetSelectHero()
	slot0:RefreshAddBtn()
	slot0:RefreshCombo()
end

function slot0.LoadHeroModels(slot0)
	for slot4, slot5 in ipairs(slot0.cacheHeroTeam_) do
		if slot5 ~= 0 and slot5 then
			table.insert(slot0.loadingList_, slot5)

			slot8 = manager.resourcePool
			slot0.loadAsyncIndex_[slot4] = slot8:AsyncLoad("Char/" .. slot0:GetSkinCfg(slot4, slot5).ui_modelId, ASSET_TYPE.TPOSE, function (slot0)
				uv0.heroModel_[uv1] = slot0
				uv0.heroModel_[uv1].transform.localEulerAngles = uv2[uv1].rotation
				uv0.heroModel_[uv1].transform.localPosition = uv2[uv1].position
				uv0.heroModel_[uv1].transform.localScale = uv2[uv1].scale

				if table.keyof(uv0.loadingList_, uv3) then
					table.remove(uv0.loadingList_, slot1)
				end
			end)
		end
	end
end

function slot0.GetSkinCfg(slot0, slot1, slot2)
	if slot0.heroTrialList_[slot1] ~= 0 then
		return SkinCfg[HeroStandardSystemCfg[slot0.heroTrialList_[slot1]].skin_id]
	elseif slot0.lockStateList_[slot1] then
		return SkinCfg[slot2]
	else
		return slot0:GetHeroCfg(slot2)
	end
end

function slot0.GetHeroCfg(slot0, slot1)
	return HeroTools.HeroUsingSkinInfo(slot1)
end

function slot0.DestroyHeroModels(slot0)
	for slot4, slot5 in pairs(slot0.heroModel_) do
		manager.resourcePool:DestroyOrReturn(slot5, ASSET_TYPE.TPOSE)

		if dl then
			SetActive(dl, true)
		end
	end

	for slot4, slot5 in pairs(slot0.loadAsyncIndex_) do
		manager.resourcePool:StopAsyncQuest(slot0.loadAsyncIndex_[slot4])
	end

	slot0.loadAsyncIndex_ = nil
	slot0.heroModel_ = nil
end

function slot0.GetModelOffesetPosition(slot0, slot1)
	slot2 = Vector3(0, 0, 0)

	if slot1.x - slot0.dragPosition_[1].x > 0 then
		slot2.x = -slot3 * uv0 / uv1
		slot2.z = slot3 * uv2 / uv1
	else
		slot2.x = -slot3 * uv0 / uv1
		slot2.z = -slot3 * uv2 / uv1
	end

	return slot2
end

function slot0.RefreshAddBtn(slot0)
	for slot4 = 1, 3 do
		if slot0.lockStateList_[slot4] == true and slot0.cacheHeroTeam_[slot4] == 0 then
			slot0.addBtnImg_[slot4].sprite = getSprite("Atlas/BattleSelectHero", "icon_no")
		else
			slot0.addBtnImg_[slot4].sprite = getSprite("Atlas/BattleSelectHero", "btn_add")
		end

		slot0.addBtnImg_[slot4]:SetNativeSize()
	end

	for slot4, slot5 in ipairs(slot0.cacheHeroTeam_) do
		SetActive(slot0.addBtnGo_[slot4], slot5 == 0)

		if slot4 == 2 or slot4 == 3 then
			SetActive(slot0.addBtnGo_[slot4], slot5 == 0 and slot0.params_.sectionType ~= BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO)
		end

		if slot5 and slot5 == 0 then
			SetActive(slot0.heroPowerPanel_[slot4].gameObject, false)
		else
			slot0.heroPowerText_[slot4].text = slot0:GetHeroPower(slot4)
			slot0.heroPowerIcon_[slot4].sprite = getSprite("Atlas/CampItem", RaceEffectCfg[HeroCfg[slot5].race].icon)

			SetActive(slot0.heroPowerPanel_[slot4].gameObject, true)
		end
	end

	slot0.dragImg_[2].raycastTarget = slot0.params_.sectionType ~= BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO
	slot0.dragImg_[3].raycastTarget = slot0.params_.sectionType ~= BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO
end

function slot0.RefreshReservesBtn(slot0)
	slot1 = true

	for slot5 = 1, 3 do
		if slot0.lockStateList_[slot5] then
			slot1 = false
		end
	end

	if slot0.params_.canChangeTeam ~= nil and slot0.params_.canChangeTeam == false then
		slot1 = false
	end

	SetActive(slot0.reservesBtn_.gameObject, slot1)
end

function slot0.HidePanel(slot0)
	if slot0:GetRecommendLevel() == 0 then
		SetActive(slot0.recommendGo_, false)
	else
		SetActive(slot0.recommendGo_, true)
	end
end

function slot0.RefreshHp(slot0)
	for slot4, slot5 in pairs(slot0.cacheHeroTeam_) do
		if slot5 and slot5 == 0 then
			-- Nothing
		elseif not WarChessData:GetHeroHp(slot5) then
			print("英雄血量不存在")
		else
			slot0.hpImg_[slot4].fillAmount = slot6 / 10000
			slot0.hpText_[slot4].text = math.ceil(slot6 / 100) .. "%"
		end
	end
end

function slot0.RefreshRace(slot0)
	slot0.maxRaceID_, slot2, slot0.maxRacePlayerCount_ = slot0:GetRaceEffect()

	if slot0.params_.forceRace then
		slot5 = RaceEffectCfg[slot0.params_.forceRace]

		SetActive(slot0.effectTitlePanel_, true)

		slot0.effectName_.text = slot5.name
		slot0.effectImage_.sprite = getSprite("Atlas/CampItem", slot5.icon)
		slot0.effectHeroText_.text = slot5.desc
		slot0.effectText_.text = slot5.battle_desc
		slot0.titleCanvasGroup1_.alpha = 1
		slot0.titleCanvasGroup2_.alpha = 1

		SetActive(slot0.activeGo2_, false)
		SetActive(slot0.activeGo1_, false)
	else
		SetActive(slot0.effectTitlePanel_, slot1 ~= 0)

		if slot2 then
			slot0.effectText_.text = RaceEffectCfg[slot1].battle_desc
			slot0.titleCanvasGroup2_.alpha = 1
		else
			slot0.effectText_.text = GetTips("NO_BATTLE_BUFF")
			slot0.titleCanvasGroup2_.alpha = 0.8
		end

		SetActive(slot0.activeGo2_, not slot2)
		SetActive(slot0.activeGo1_, slot1 == 0)

		if slot1 == 0 then
			slot0.titleCanvasGroup1_.alpha = 0.8
			slot0.effectHeroText_.text = GetTips("NO_CORRECTOR_BUFF")

			return
		end

		slot0.titleCanvasGroup1_.alpha = 1
		slot4 = RaceEffectCfg[slot1]
		slot0.effectName_.text = slot4.name
		slot0.effectHeroText_.text = slot4.desc
		slot0.effectImage_.sprite = getSprite("Atlas/CampItem", slot4.icon)
	end
end

function slot0.RefreshText(slot0)
	slot0.stageName_.text = BattleStageTools.GetStageName(slot0.stageType_, slot0.stageID_)
	slot0.recommendPowerNumText_.text = slot0:GetRecommendLevel()
end

function slot0.RefreshEffectActive(slot0)
	SetActive(slot0.effectPanelGo_, slot0.params_.isHideEffect ~= true)
end

function slot0.RefershPower(slot0)
	SetActive(slot0.goPowerPanel_, true)

	slot1 = slot0.totalPower_
	slot0.powerNumText_.text = slot1
	slot0.recommendPowerNumText_.text = slot0:GetRecommendLevel()
	slot2 = slot0:GetRecommendLevel() < slot1
	slot3 = nil

	SetActive(slot0.selectPowerGo_, not slot2)

	slot0.powerNumText_.color = (not slot2 or Color(0.2117647, 0.227451, 0.2588235)) and Color(0.8705883, 0.3098039, 0.3098039)
end

function slot0.RefreshChip(slot0)
	slot1 = not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER)

	SetActive(slot0.chipPanel_, slot1)

	if slot1 then
		slot0.chipView_:SetData(slot0.stageType_, slot0.stageID_, slot0.params_.activityID, slot0.contID_, slot0.teamID_)
	end
end

function slot0.RefreshCombo(slot0)
	slot0.comboSkillView_:SetHeroList(slot0.stageType_, slot0.stageID_, slot0.params_.activityID, slot0.cacheHeroTeam_, slot0.heroTrialList_, slot0.params_.isReserves, slot0.params_.index, slot0.contID_, slot0.teamID_)
end

function slot0.RefreshSortType(slot0)
	if not slot0.params_.isSorted then
		HeroData:ResetSortValue()
	end
end

function slot0.PlayHeroTalk(slot0, slot1)
	if slot0.talkTimer_ then
		slot0.talkTimer_:Stop()

		slot0.talkTimer_ = nil
	end

	HeroTools.StopTalk()

	if slot0.talkCDTimer_ then
		return
	end

	slot0.talkTimer_ = Timer.New(function ()
		HeroTools.PlayTalk(uv0, "leader")

		uv1.talkTimer_ = nil
		uv1.talkCDTimer_ = Timer.New(function ()
			uv0.talkCDTimer_:Stop()

			uv0.talkCDTimer_ = nil
		end, HeroConst.SET_LEADER_VOICE_CD, 1)

		uv1.talkCDTimer_:Start()
	end, HeroConst.TALK_DELAY_TIME, 1)

	slot0.talkTimer_:Start()
end

function slot0.GoHeroInfoUI(slot0, slot1)
	if type(BattleStageTools.GetRestrictHeroList(slot0.stageType_, slot0.stageID_)) == "table" and (slot2[slot1][1] == 0 or slot3[1] ~= 0 and HeroCfg[slot3[1]] and not table.keyof(HeroCfg.get_id_list_by_private[0], slot3[1])) then
		ShowTips("CAN_NOT_CHANGE_HERO")

		return
	end

	slot0:Go("/heroTeamInfo", {
		isEnter = true,
		selectHeroPos = slot1,
		stageID = slot0.stageID_,
		activityID = slot0.params_.activityID,
		stageType = slot0.stageType_,
		cont_id = slot0.contID_,
		team_id = slot0.teamID_
	})
end

function slot0.SwapIndex(slot0, slot1, slot2)
end

function slot0.ChangeHeroTeam(slot0, slot1)
	slot2 = slot1
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		slot3[slot7] = slot0.heroTrialList_[table.keyof(slot0.cacheHeroTeam_, slot8)]
	end

	if slot2[1] ~= slot0.cacheHeroTeam_[1] then
		slot0:PlayHeroTalk(slot2[1])
	end

	SetHeroTeam(slot0.stageType_, slot0.stageID_, slot0.params_.activityID, slot2, slot3, slot0.comboSkillView_:GetCurComboSkill(), {
		id = slot0.chipView_:GetCurEnabledID(),
		chip = slot0.chipView_:GetCurChipList()
	}, slot0.contID_, slot0.teamID_)
end

function slot0.SaveTeamInfo(slot0)
	if slot0.stageType_ == BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL then
		MythicAction.SaveAllTeam()
	else
		SetHeroTeam(slot0.stageType_, slot0.stageID_, slot0.params_.activityID, slot0.cacheHeroTeam_, slot0.heroTrialList_, slot0.comboSkillView_:GetCurComboSkill(), {
			id = slot0.chipView_:GetCurEnabledID(),
			chip = slot0.chipView_:GetCurChipList()
		}, slot0.contID_, slot0.teamID_)
	end
end

function slot0.GetSelectHero(slot0)
	slot1 = nil
	slot0.cacheHeroTeam_, slot0.lockStateList_, slot0.lockList_, slot0.heroTrialList_, slot1 = GetLocalHeroTeam(slot0.stageType_, slot0.stageID_, slot0.params_.activityID, slot0.contID_, slot0.teamID_)

	if slot0.params_.isReserves then
		slot0.cacheHeroTeam_ = BattleTeamData:GetReservesTeam(slot0.params_.index)
		slot0.heroTrialList_ = {
			0,
			0,
			0
		}
	end

	if slot1 or slot0.params_.isReserves then
		slot0:ChangeHeroTeam(slot0.cacheHeroTeam_)
		ComboSkillData:SetNeedRefresh(true)
	end
end

function slot0.GetRaceEffect(slot0)
	slot1 = {}
	slot2 = 0
	slot3 = false

	for slot8, slot9 in ipairs(slot0.cacheHeroTeam_) do
		if slot9 ~= 0 then
			slot1[slot10] = (slot1[HeroCfg[slot9].race] or 0) + 1

			if slot1[slot10] == 2 then
				slot2 = slot10
			elseif slot1[slot10] == 3 then
				slot3 = true
			end
		end
	end

	return slot2, slot3, slot1[slot2] or 1
end

function slot0.GetTotalPower(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.cacheHeroTeam_) do
		if slot6 ~= 0 then
			slot1 = slot1 + slot0:GetHeroPower(slot5)
		end
	end

	return slot1
end

function slot0.GetRecommendLevel(slot0)
	return BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).recommend_level or 0
end

function slot0.GetHeroPower(slot0, slot1)
	if type(BattleStageTools.GetRestrictHeroList(slot0.stageType_, slot0.stageID_)) == "table" and slot2[slot1][1] ~= nil then
		return getHeroPower(slot2[slot1][2], true)
	end

	if slot0.heroTrialList_[slot1] ~= 0 then
		return getHeroPower(slot0.heroTrialList_[slot1], true)
	end

	return getHeroPower(slot0.cacheHeroTeam_[slot1], false)
end

return slot0
