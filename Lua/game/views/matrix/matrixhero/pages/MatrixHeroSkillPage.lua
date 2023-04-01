slot1 = class("MatrixHeroSkillPage", import("game.views.newHero.pages.NewHeroSkillPage"))

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skillItemGo_ = {}
	slot0.skillItem_ = {}

	for slot4 = 1, 6 do
		slot0.skillItemGo_[slot4] = slot0["skillItem" .. slot4 .. "Go_"]
		slot0.skillItem_[slot4] = MatrixHeroSkillItem.New(slot0, slot0.skillItemGo_[slot4])
	end

	SetActive(slot0.teachingBtn_.gameObject, false)
end

function slot1.AddUIListener(slot0)
	for slot4 = 1, 6 do
		slot5 = slot0.skillItem_[slot4]

		slot5:RegistCallBack(function (slot0)
			JumpTools.OpenPageByJump("matrixSkillUpgrade", {
				skillId = slot0.id,
				heroId = slot0.heroId,
				standardId = uv0.standardID,
				servantId = slot0.servantId,
				lv = slot0.lv
			})
		end)
	end

	slot0:AddBtnListener(slot0.buttonComboSkill_, nil, function ()
		uv0:Go("matrixOrigin/matrixComboSkillInfo", {
			heroId = uv0.heroInfo_.id
		})
	end)
end

function slot1.OnEnter(slot0, slot1)
end

function slot1.SetMatirxHeroInfo(slot0, slot1)
	slot0.heroId_ = slot1
	slot2 = slot0:GetHeroData(slot1)
	slot0.standardID = slot2:GetStandardId()
	slot4 = nil
	slot0.heroInfo_ = (not slot2:GetIsOwnerHero() or GetPracticalData(slot2:GetEntrySnapShot())) and GetVirtualData(slot3)
	slot0.heroInfo_.servantId = slot2:GetWeaponServantEffect()

	slot0:UpdateView()
end

function slot1.RefreshSkillItemS(slot0)
	slot4 = slot0.heroInfo_
	slot0.skillList_ = slot0:GetMatrixHeroSkillInfo(slot4)

	for slot4 = 1, 6 do
		slot0.skillItem_[slot4]:RefreshData(slot0, slot0.skillList_[slot4])
	end
end

function slot1.GetMatrixHeroSkillInfo(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.skill) do
		if SkillTools.GetIsDodgeSkill(slot7.skill_id) then
			slot2[slot7.skill_id] = 1
		else
			slot2[slot7.skill_id] = slot7.skill_level
		end
	end

	slot3 = {}
	slot7 = slot1.id

	for slot7, slot8 in ipairs(HeroCfg[slot7].skills) do
		slot9 = HeroTools.GetHeroSkillAddLevel(slot1, slot8)

		if SkillTools.GetIsDodgeSkill(slot8) then
			slot9 = 0
		end

		table.insert(slot3, {
			isCanUp = false,
			id = slot8,
			heroId = slot1.id,
			lv = slot2[slot8] or 0,
			addSkillLv = slot9,
			servantId = slot1.servantId
		})
	end

	return slot3
end

function slot1.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

return slot1
