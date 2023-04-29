slot0 = class("CanteenHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.fatigueController = ControllerUtil.GetController(slot0.transform_, "fatigue")
	slot0.selController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.jobController = ControllerUtil.GetController(slot0.transform_, "work")
	slot0.skillController = ControllerUtil.GetController(slot0.transform_, "skill")
	slot0.onClickCom_ = slot0:FindCom("OnClickDownListener")
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.onClickCom_.onValueChanged

	slot1:AddListener(function ()
		if uv0.selFunc then
			uv0.selFunc(uv0.heroID)
		end
	end)
end

function slot0.ResetCharacterCallBack(slot0, slot1)
	if slot1 then
		slot0.selFunc = slot1
	end
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.heroID = slot1
	slot0.heroIcon_.sprite = HeroTools.GetBackHomeHeadSprite(slot1)
	slot4 = DormData:GetHeroFatigue(slot1)
	slot0.curText_.text = slot4
	slot0.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
	slot0.progressImg_.fillAmount = slot4 / GameSetting.canteen_hero_fatigue_max.value[1]

	if slot4 < GameDisplayCfg.canteen_fatigue_red_warning.value[1] then
		slot0.fatigueController:SetSelectedState("lack")
	else
		slot0.fatigueController:SetSelectedState("full")
	end

	slot0.jobController:SetSelectedState("false")

	if DormData:GetHeroTemplateInfo(slot1).jobType then
		slot0.jobController:SetSelectedState("true")

		slot0.jobText_.text = CanteenTools:GetJobName(slot6)
	elseif CanteenData:CheckHasChooseEntrustCharacter(slot1) then
		slot0.jobController:SetSelectedState("true")

		slot0.jobText_.text = GetTips("DORM_HERO_AT_TASK")
	end

	if CanteenData:CheckHasChooseEntrustCharacter(slot1) then
		slot0.selController:SetSelectedState("no")

		return
	end

	slot7 = HeroRecordCfg.get_id_list_by_hero_id[slot2][1]
	slot0.archiveID = HeroRecordCfg.get_id_list_by_hero_id[slot1][1]

	if slot2 == slot1 then
		slot0.selController:SetSelectedState("sel")
	elseif slot0.archiveID == slot7 then
		slot0.selController:SetSelectedState("no")
	else
		slot0.selController:SetSelectedState("normal")
	end

	if #slot0:CheckSkillCanOpen(slot3) > 0 then
		slot0.iconImg_.sprite = CanteenTools.GetCanteenSkillSprite(slot8[1])

		slot0.skillController:SetSelectedState("true")
	else
		slot0.skillController:SetSelectedState("false")
	end
end

function slot0.CheckSkillCanOpen(slot0, slot1)
	slot3 = GameSetting.dorm_hero_skill_unlock.value
	slot4 = {}
	slot5 = HeroData:GetHeroData(slot0.heroID).level

	for slot9 = 1, #BackHomeHeroCfg[slot0.heroID].skill_list do
		if slot3[slot9] <= slot5 then
			table.insert(slot4, slot2[slot9])
		end
	end

	slot6 = {}

	for slot10, slot11 in ipairs(slot4) do
		if BackHomeHeroSkillCfg[slot11].condition and #slot13 > 0 then
			if slot13[1] == 1 and slot1 == slot13[2] then
				table.insert(slot6, slot11)
			end
		else
			table.insert(slot6, slot11)
		end
	end

	return slot6
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.onClickCom_.onValueChanged:RemoveAllListeners()
end

return slot0
