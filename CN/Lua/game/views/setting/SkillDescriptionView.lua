slot0 = class("SkillDescriptionView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.transform_ = slot2.transform
	slot0.gameObject_ = slot2
	slot0.stageData = slot3

	slot0:Init()
end

function slot0.IsInTable(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		if slot7 == slot1 then
			return true, slot6
		end
	end

	return false
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:OnEnter()
end

function slot0.GetSkills(slot0, slot1, slot2, slot3)
	slot5 = slot2.weaponEffectID
	slot6 = slot2.astrolabe
	slot7 = {}

	for slot11, slot12 in ipairs(HeroCfg[slot1].equip_orange_skill) do
		if slot0:IsInTable(slot5, WeaponServantCfg[slot12[2]].effect) then
			slot7[slot12[1]] = slot12[3]
		end
	end

	for slot11, slot12 in ipairs(slot4.astrolabe_skill) do
		for slot16 = 0, slot6.Length - 1 do
			if slot12[2] == slot6[slot16] then
				slot7[slot12[1]] = slot12[3]

				break
			end
		end
	end

	slot8 = {}

	for slot12, slot13 in ipairs(slot4.skills) do
		slot14 = {
			id = slot13
		}

		if slot7[slot13] then
			slot14.id = slot7[slot13]
		end

		slot16 = 1

		if not SkillTools.GetIsDodgeSkill(slot14.id) then
			slot16 = slot2.skillLevel[slot12 - 1]
		end

		slot14.desc = SkillTools.GetSkillDesc(slot14.id, slot16, slot16 == HeroConst.MAX_SKILL_LEVEL or slot15, slot3)
		slot14.desc = string.gsub(slot14.desc, "\n\n", "\n")
		slot14.name = HeroSkillCfg[slot14.id].name
		slot14.ele = SkillElementCfg[HeroSkillCfg[slot14.id].element_type].name
		slot14.sprite = getSprite("Atlas/" .. slot1, slot14.id)
		slot14.subType = PublicSkillCfg[slot14.id].skill_sub_type

		if slot14.subType == nil then
			slot14.subType = 0
		end

		slot14.subType = SkillSubTypeCfg[SkillSubTypeCfg.get_id_list_by_value[slot14.subType][1]].annotation
		slot14.type = slot4.skill_subhead[slot12]

		table.insert(slot8, slot14)
	end

	return slot8
end

function slot0.RefreshSkills(slot0)
	for slot4, slot5 in ipairs(slot0.skills) do
		slot6 = Object.Instantiate(slot0.explainSkillTplGo_, slot0.suitcontentSkillTrs_)
		slot6.transform:Find("skill/bg/icon"):GetComponent("Image").sprite = slot5.sprite
		slot6.transform:Find("skill/name/text"):GetComponent("Text").text = slot5.type
		slot6.transform:Find("Adaptation/nametext"):GetComponent("Text").text = slot5.name
		slot6.transform:Find("Adaptation/describetext"):GetComponent("Text").text = slot5.desc
		slot6.transform:Find("Adaptation/attribute"):GetComponent("Text").text = slot5.ele
		slot6.transform:Find("Adaptation/attribute/text"):GetComponent("Text").text = slot5.subType

		SetActive(slot6, true)
	end

	slot0.timerSkill_ = FrameTimer.New(function ()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.suitcontentSkillTrs_)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.suitcontentSkillTrs_)
	end, 1, 1)

	slot0.timerSkill_:Start()
end

function slot0.GetRecommendCombo(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(HeroCfg[slot1].recommend_combo) do
		table.insert(slot3, SkillComboRecommenderCfg[slot8])
	end

	return slot3
end

function slot0.RefreshCombos(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.combos) do
		slot7 = Object.Instantiate(slot0.explainComboTplGo_, slot0.suitcontentComboTrs_)
		slot8 = slot7.transform:Find("nametext"):GetComponent("Text")
		slot9 = slot7.transform:Find("describetext"):GetComponent("Text")
		slot10 = slot7.transform:Find("panel")
		slot11 = slot7.transform:Find("panel/skill").gameObject

		if slot6.desc and slot6.desc ~= "" then
			slot9.text = slot6.desc
		else
			slot9.gameObject:SetActive(false)
		end

		slot8.text = slot6.name

		if slot6.list_icon[1] then
			slot12 = #slot6.list_icon

			for slot16, slot17 in ipairs(slot6.list_icon) do
				slot18 = Object.Instantiate(slot11, slot10)
				slot18.transform:Find("bg/icon"):GetComponent("Image").sprite = getSprite("Atlas/" .. slot1, slot6.list_icon[slot16])
				slot18.transform:Find("name/text"):GetComponent("Text").text = slot6.list_name[slot16]

				SetActive(slot18, true)

				slot21 = slot18.transform:Find("sign"):GetComponent("Image")
				slot22 = slot18.transform:Find("text"):GetComponent("Text")

				if slot12 ~= slot16 then
					if slot6.combine_char[slot16] == "或" then
						slot21.enabled = false
						slot22.text = GetTips("TIP_OR")
					else
						slot21.enabled = true
						slot21.sprite = getSprite("Atlas/Setting", slot6.combine_char[slot16])
						slot22.text = ""
					end
				else
					slot21.enabled = false
					slot22.text = ""
				end
			end
		else
			slot10.gameObject:SetActive(false)
		end

		SetActive(slot7, true)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.suitcontentSkillTrs_)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot3 = SkinCfg[GetSceneDataForExcehange().roleDataInLua[0].ID].hero

	if slot0.stageData and slot0.stageData:GetIsCooperation() then
		slot4 = PlayerData:GetPlayerInfo().userID

		for slot9, slot10 in ipairs(slot0.stageData:GetRoleDatas()) do
			if tostring(slot10.UID) == tostring(slot4) then
				slot3 = SkinCfg[slot10.ID].hero
			end
		end
	end

	slot4, slot5 = slot0.stageData:GetHeroTeam()
	slot6 = nil

	if slot5[1] ~= nil and slot5[1] > 0 then
		slot6 = {
			isTemp = true
		}
	end

	slot0.skills = slot0:GetSkills(slot3, slot2, slot6)

	slot0:RefreshSkills()

	slot0.combos = slot0:GetRecommendCombo(slot3)

	slot0:RefreshCombos(slot3)

	slot0.nType = 1
end

function slot0.AddUIListener(slot0)
	slot0:AddToggleListener(slot0.explainTgl_, function (slot0)
		SetActive(uv0.skillpanelGo_, slot0)

		if slot0 then
			OperationRecorder.Record("battle", "skillExplain")

			if uv0.hander_.RecordStaySkill then
				uv0.hander_:RecordStaySkill(2)
			end

			uv0.nType = 1
		end
	end)
	slot0:AddToggleListener(slot0.technicTgl_, function (slot0)
		SetActive(uv0.recommendpanelGo_, slot0)

		if slot0 then
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.suitcontentComboTrs_)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.suitcontentComboTrs_)
			OperationRecorder.Record("battle", "recommend")

			if uv0.hander_.RecordStaySkill then
				uv0.hander_:RecordStaySkill(1)
			end

			uv0.nType = 2
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.timerSkill_ then
		slot0.timerSkill_:Stop()
	end

	slot0.hander_ = nil
	slot0.data = nil
end

return slot0
