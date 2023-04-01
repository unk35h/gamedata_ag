slot0 = class("SectionSelectHeroActivityMatrixView", SectionSelectHeroBaseView)

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.matrix_activity_id = slot0.params_.matrix_activity_id
end

function slot0.GetChipView(slot0)
	return SectionSelectHeroMatrixChip
end

function slot0.GetComboSkillView(slot0)
	return SectionComboSkillMatrixView
end

function slot0.ChangeHeroTeam(slot0, slot1)
	ActivityMatrixData:SetMatrixBattleHeroTeam(slot0.matrix_activity_id, slot1)
end

function slot0.GetHeroCfg(slot0, slot1)
	return SkinCfg[ActivityMatrixData:GetHeroSkin(slot0.matrix_activity_id, slot1)]
end

function slot0.GetSkinCfg(slot0, slot1, slot2)
	if slot0.heroTrialList_[slot1] ~= 0 then
		return SkinCfg[HeroStandardSystemCfg[slot0.heroTrialList_[slot1]].skin_id]
	else
		return slot0:GetHeroCfg(slot2)
	end
end

function slot0.StartBattle(slot0)
	if ActivityMatrixData:GetGameState(slot0.matrix_activity_id) == MatrixConst.STATE_TYPE.NOTSTARTED then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_REFRESH_DATA"),
			OkCallback = function ()
				JumpTools.GoToSystem("/matrixBlank/activityMatrix", {
					main_matrix_activity_id = ActivityMatrixData:GetMainActivityId(uv0.matrix_activity_id),
					matrix_activity_id = uv0.matrix_activity_id
				})
			end
		})
	else
		slot4 = slot0.params_.eventId

		if ActivityMatrixData:GetMatrixPhaseData(slot0.matrix_activity_id):GetPhase() == 2 then
			ActivityMatrixAction.DoEvent(slot0.matrix_activity_id)
		else
			ActivityMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
				slot4
			})
		end
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

		ShowTips("CAN_NOT_CHANGE_HERO")
	end
end

function slot0.GetTotalPower(slot0)
	return 0
end

function slot0.RefreshPower(slot0)
end

function slot0.RefreshAddBtn(slot0)
	for slot4 = 1, 3 do
		SetActive(slot0.addBtnGo_[slot4], false)
		SetActive(slot0.heroPowerPanel_[slot4].gameObject, false)
	end
end

function slot0.RefreshChip(slot0)
	SetActive(slot0.chipPanel_, false)
end

function slot0.RefreshRace(slot0)
	slot1, slot2 = slot0:GetRaceEffect()

	SetActive(slot0.effectTitlePanel_, slot1 ~= 0)

	if slot2 then
		slot0.effectText_.text = RaceEffectCfg[slot1].battle_desc
		slot0.titleCanvasGroup2_.alpha = 1
	else
		if ActivityMatrixData:GetRaceEffect(slot0.matrix_activity_id) then
			slot0.effectText_.text = GetTips("MATRIX_NO_BATTLE_BUFF")
		else
			slot0.effectText_.text = GetTips("NO_BATTLE_BUFF")
		end

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
	slot3 = RaceEffectCfg[slot1]
	slot0.effectName_.text = slot3.name
	slot0.effectHeroText_.text = slot3.desc
	slot0.effectImage_.sprite = getSprite("Atlas/CampItem", slot3.icon)
end

function slot0.GetRaceEffect(slot0)
	slot1 = {}
	slot2 = 0
	slot3 = false

	for slot8, slot9 in pairs(slot0.cacheHeroTeam_) do
		if slot9 ~= 0 then
			slot1[slot10] = (slot1[HeroCfg[slot9].race] or 0) + 1

			if slot1[slot10] == 2 then
				slot2 = slot10

				if ActivityMatrixData:GetRaceEffect(slot0.matrix_activity_id) then
					slot3 = true
				end
			elseif slot1[slot10] == 3 then
				slot3 = true
			end
		end
	end

	return slot2, slot3, slot1[slot2] or 1
end

return slot0
