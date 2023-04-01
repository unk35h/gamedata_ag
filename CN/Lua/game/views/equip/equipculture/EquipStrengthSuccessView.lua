slot0 = class("EquipStrengthSuccessView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipStrengthSuccessUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.attrIcon_ = {}
	slot0.attrName_ = {}
	slot0.attrOld_ = {}
	slot0.attrNew_ = {}

	for slot4 = 1, 2 do
		slot5 = slot0["attritem" .. slot4]
		slot0.attrIcon_[slot4] = slot0:FindCom(typeof(Image), "icon", slot5)
		slot0.attrName_[slot4] = slot0:FindCom(typeof(Text), "text", slot5)
		slot0.attrOld_[slot4] = slot0:FindCom(typeof(Text), "ori", slot5)
		slot0.attrNew_[slot4] = slot0:FindCom(typeof(Text), "after", slot5)
	end

	slot0.skillItems_ = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, , function ()
		uv0:Back()
		uv0.params_.callback()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot2 = slot0.params_.newEquip

	if not slot0.params_.oldEquip or not slot2 then
		return
	end

	slot3 = slot1:GetLevel()
	slot0.titleText_.text = "" .. slot2:GetLevel()
	slot6 = EquipTools.CountEquipAttribute(slot2)
	slot7 = 1

	for slot11, slot12 in pairs(EquipTools.CountEquipAttribute(slot1)) do
		slot14 = math.floor(slot12)
		slot15 = math.floor(slot6[slot11])

		if PublicAttrCfg[slot11].percent and slot13.percent == 1 then
			slot14 = slot12 / 10 .. "%"
			slot15 = slot6[slot11] / 10 .. "%"
		end

		slot0.attrName_[slot7].text = slot13.name
		slot0.attrIcon_[slot7].sprite = getSprite("Atlas/Common", slot13.icon)
		slot0.attrOld_[slot7].text = slot14
		slot0.attrNew_[slot7].text = slot15
		slot7 = slot7 + 1
	end

	slot9 = {}

	for slot13, slot14 in pairs(EquipCfg[slot2.prefab_id].effect_unlock_level) do
		if slot14 <= slot4 and slot3 < slot14 then
			slot15 = slot8.effect[slot13]

			table.insert(slot9, {
				id = slot15[1],
				num = slot15[2],
				unlockLevel = slot14
			})
		end
	end

	if #slot9 > 0 then
		SetActive(slot0.skillPanel_, true)
		slot0:RefreshSkill(slot9, slot4)
	else
		SetActive(slot0.skillPanel_, false)
	end
end

function slot0.RefreshSkill(slot0, slot1, slot2)
	for slot7 = 1, #slot1 do
		if slot7 > #slot0.skillItems_ then
			slot8 = Object.Instantiate(slot0.skillItem_, slot0.skillParent_.transform)
			slot9 = slot8.transform
			slot0.skillItems_[slot7] = {
				gameObject = slot8,
				icon_ = slot0:FindCom(typeof(Image), "icon", slot9),
				name_ = slot0:FindCom(typeof(Text), "lv", slot9),
				lv_ = slot0:FindCom(typeof(Text), "name", slot9)
			}
		end

		slot8 = slot1[slot7]
		slot9 = EquipSkillCfg[slot8.id]
		slot0.skillItems_[slot7].icon_.sprite = getSprite("Atlas/EquipSkillIconAtlas", slot9.icon)
		slot0.skillItems_[slot7].name_.text = slot9.name
		slot0.skillItems_[slot7].lv_.text = GetTips("LEVEL") .. slot8.num
	end

	for slot7, slot8 in ipairs(slot0.skillItems_) do
		SetActive(slot8.gameObject, slot7 <= slot3)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
