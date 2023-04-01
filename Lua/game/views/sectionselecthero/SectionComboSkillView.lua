slot0 = class("SectionComboSkillView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.comboSkillController_ = ControllerUtil.GetController(slot0.transform_, "teamwork")

	slot0:AddBtnListener(slot0.buttonComboSkill_, nil, function ()
		if uv0.isCustom_ then
			ShowTips("CANNOT_CHANGE_COMBO_SKILL")

			return
		end

		uv0:ClickComboSkillBtn()
	end)

	slot0.handler_ = handler(slot0, slot0.OnComboSkillSelect)

	manager.notify:RegistListener(COMBO_SKILL_SELECT, slot0.handler_)
end

function slot0.ClickComboSkillBtn(slot0)
	JumpTools.OpenPageByJump("comboSkillSelect", {
		stageType = slot0.stageType_,
		stageID = slot0.stageID_,
		activityID = slot0.activityID_,
		heroList = slot0.heroList_,
		trialList = slot0.trialList_,
		comboSkillID = slot0.comboSkillID_,
		cont_id = slot0.cont_id_,
		team_id = slot0.team_id_
	})
end

function slot0.RefreshUI(slot0)
	if slot0.comboSkillID_ == 0 then
		slot0.comboSkillController_:SetSelectedState("off")
	else
		slot0.comboSkillController_:SetSelectedState("on")

		slot1 = ComboSkillCfg[slot0.comboSkillID_]
		slot5 = "ComboSkill"
		slot6 = slot1.skill_id
		slot0.imageSkillIcon_.sprite = getSpriteViaConfig(slot5, slot6)

		for slot5, slot6 in ipairs(slot1.cooperate_role_ids) do
			SetActive(slot0[string.format("goHeroItem%s_", slot5)], true)

			slot0[string.format("imageHeroIcon%s_", slot5)].sprite = getSpriteViaConfig("HeroLittleIcon", slot6)
		end

		for slot5 = #slot1.cooperate_role_ids + 1, 3 do
			SetActive(slot0[string.format("goHeroItem%s_", slot5)], false)
		end
	end
end

function slot0.SetHeroList(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
	slot0.isCustom_ = false
	slot0.stageType_ = slot1
	slot0.stageID_ = slot2
	slot0.activityID_ = slot3
	slot0.cont_id_ = slot8
	slot0.team_id_ = slot9

	if BattleStageTools.GetStageCfg(slot1, slot2) and slot10.combo_skill_id and slot10.combo_skill_id ~= 0 then
		slot0.comboSkillID_ = slot10.combo_skill_id

		SetActive(slot0.gameObject_, true)
		slot0:RefreshUI()

		slot0.isCustom_ = true

		return
	end

	if type(BattleStageTools.GetRestrictHeroList(slot1, slot2)) == "table" then
		SetActive(slot0.gameObject_, false)

		slot0.isCustom_ = true

		return
	end

	slot12 = 0

	for slot16, slot17 in ipairs(slot4) do
		if slot17 ~= 0 then
			slot12 = slot12 + 1
		end
	end

	if slot12 < 2 then
		SetActive(slot0.gameObject_, false)
		slot0:SetComboSkillID(0)

		slot0.comboSkillID_ = 0

		slot0:RefreshUI()

		return
	end

	SetActive(slot0.gameObject_, true)

	slot0.heroList_ = slot4
	slot0.trialList_ = slot5
	slot13 = slot0:GetComboSkillID()

	if slot6 then
		slot14 = BattleTeamData:GetReservesTeamList()[slot7]

		slot0:SetComboSkillID(slot14.comboSkill)
		slot0:SetNeedRefresh(false)

		slot0.comboSkillID_ = slot14.comboSkill

		slot0:RefreshUI()

		return
	end

	if ComboSkillTools.CheckError(slot13, slot4, true) ~= slot13 or slot0:GetNeedRefresh() == true then
		slot0:SetComboSkillID(ComboSkillTools.GetRecommendSkillID(slot4, true))
		slot0:SetNeedRefresh(false)
	end

	slot0.comboSkillID_ = slot14

	slot0:RefreshUI()
end

function slot0.GetComboSkillID(slot0)
	return BattleTeamData:GetComboInfo(slot0.stageType_, slot0.activityID_, slot0.cont_id_, slot0.team_id_)
end

function slot0.SetComboSkillID(slot0, slot1)
	BattleFieldAction.SetComboInfo(slot0.stageType_, slot0.activityID_, slot1, slot0.cont_id_, slot0.team_id_)
end

function slot0.GetNeedRefresh(slot0)
	return ComboSkillData:GetNeedRefresh(slot0.stageType_, slot0.activityID_)
end

function slot0.SetNeedRefresh(slot0, slot1)
	ComboSkillData:SetNeedRefresh(slot1)
end

function slot0.OnComboSkillSelect(slot0, slot1)
	slot0.comboSkillID_ = slot1

	slot0:RefreshUI()
end

function slot0.GetCurComboSkill(slot0)
	return slot0.comboSkillID_ or 0
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(COMBO_SKILL_SELECT, slot0.handler_)

	slot0.handler_ = nil
end

return slot0
