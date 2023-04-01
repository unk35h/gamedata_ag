slot0 = class("EquipNewSkillItem2", EquipNewSkillItem)

function slot0.RefreshData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.data_ = slot1
	slot0.info_ = slot2
	slot0.lvmax_ = slot3
	slot0.lvsum_ = slot4
	slot0.equipData_ = slot5

	slot0:Render()
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot2 = EquipSkillCfg[slot1.id]
		slot0.icon_.sprite = getSprite("Atlas/EquipSkillIconAtlas", slot2.icon)
		slot0.name_.text = slot2.name

		if slot1.level < (slot1.unlockLevel or 0) then
			slot0.unlockLv_.text = string.format(GetTips("EQUIP_SKILL_LOCK_LEVEL"), slot1.unlockLevel)

			SetActive(slot0.unlockGo_, true)
		else
			SetActive(slot0.unlockGo_, false)
		end

		if slot0.canvasGroup_ then
			slot0.canvasGroup_.alpha = slot1.level < slot3 and 0.7 or 1
		end

		slot4 = slot0.lvmax_ and "/" .. slot2.lvmax or ""
		slot5 = 0
		slot6 = 0

		if slot0.equipData_ then
			if EquipTools.GetEquipedHeroId(slot0.equipData_.equip_id) ~= 0 then
				slot5 = HeroTools.GetHeroEquipSkillAddLevel(HeroData:GetHeroData(slot7))

				for slot13, slot14 in ipairs(HeroTools.GetHeroEquipS(slot7)) do
					if EquipData:GetEquipData(slot14.equip_id) then
						slot6 = slot6 + slot15:GetSkillLevel(slot1.id)
					end
				end
			else
				slot6 = slot0.equipData_:GetSkillLevel(slot1.id)
			end
		end

		slot7 = nil
		slot7 = slot0.lvsum_ and slot6 or slot1.num
		slot7 = (slot2.lvmax >= slot7 + slot5 or slot2.lvmax) and slot7 + slot5

		if slot5 ~= 0 then
			slot0.lv_.text = GetTips("LEVEL") .. "<color=#E57725>" .. slot7 .. "</color>" .. slot4
		else
			slot0.lv_.text = GetTips("LEVEL") .. slot7 .. slot4
		end

		slot9 = string.format(GetI18NText(slot2.desc), tostring(slot2.upgrade / slot2.percent * slot7))

		if slot2.desc_spec_value ~= nil and slot2.desc_spec_value ~= "" then
			slot9 = string.gsub(slot9, tostring(slot8), slot2.desc_spec_value[slot1.num])
		end

		slot0.des_.text = slot9

		if slot0.content_ then
			slot0.content_.localPosition = Vector3(slot0.content_.localPosition.x, 0, 0)
		end
	end
end

return slot0
