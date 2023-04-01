slot0 = class("EquipInfoView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.transform_ = slot1.transform
	slot0.gameObject_ = slot1
	slot0.info_ = slot2
	slot0.lockHandler_ = slot3

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.RefreshData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.data_ = slot1
	slot0.info_ = slot2
	slot0.lockHandler_ = slot3
	slot0.heroId_ = slot4
	slot0.extra_ = slot5

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.star_ = {}

	for slot4 = 1, 5 do
		slot0.star_[slot4] = slot0["star_" .. slot4]
	end

	slot0.slot_ = {}

	for slot4 = 1, 2 do
		slot0.slot_[slot4] = slot0["slot_" .. slot4]
	end

	slot0.slotHave_ = {}

	for slot4 = 1, 2 do
		slot0.slotHave_[slot4] = slot0["slotHave_" .. slot4]
	end

	slot0.attrItem_ = {}

	for slot4 = 1, 2 do
		slot0.attrItem_[slot4] = AttributeItem.New(slot0, slot0["attrItem_" .. slot4])
	end

	slot0.skillIndex_ = 0
	slot0.skillItems_ = {}
	slot0.heroSkillIndex_ = 0
	slot0.heroSkillItems_ = {}
	slot0.suitItem_ = EquipNewSuitItem.New(slot0, slot0.suitItemGo_)
	slot0.lockController = ControllerUtil.GetController(slot0.lockGo_.transform, "lockBtn")
	slot0.raceController = ControllerUtil.GetController(slot0.m_raceController, "race")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.skillBtn_, nil, function ()
		if uv0.selectType_ ~= "skill" then
			uv0:ChangeShowView("skill")

			if uv0.data_.ChildToggleSelect then
				uv0.data_:ChildToggleSelect("skill", uv0.message_)
			end
		end
	end)
	slot0:AddBtnListener(slot0.suitBtn_, nil, function ()
		if uv0.selectType_ ~= "suit" then
			uv0:ChangeShowView("suit")

			if uv0.data_.ChildToggleSelect then
				uv0.data_:ChildToggleSelect("suit", uv0.message_)
			end
		end
	end)
	slot0:AddToggleListener(slot0.lockToggle_, function (slot0)
		EquipAction.ApplyLockEquip(uv0.info_.equip_id, slot0)

		if uv0.lockHandler_ then
			uv0.lockHandler_(slot0, uv0.info_.equip_id)
		end

		uv0.lockController:SetSelectedState(slot0 and "close" or "open")
	end)
end

function slot0.ChangeShowView(slot0, slot1)
	slot0.selectType_ = slot1

	SetActive(slot0.skillPanel_, slot0.selectType_ == "skill")
	SetActive(slot0.suitPanel_, slot0.selectType_ == "suit")
	SetActive(slot0.skillToggle_select, slot0.selectType_ == "skill")
	SetActive(slot0.skillToggle_unselect, slot0.selectType_ ~= "skill")
	SetActive(slot0.suitPanel_select, slot0.selectType_ == "suit")
	SetActive(slot0.suitPanel_unselect, slot0.selectType_ ~= "suit")
	slot0:RefreshLayout()

	if slot0.data_.HideSkillMask then
		slot0.data_:HideSkillMask()
	end
end

function slot0.ChangeSelect(slot0, slot1)
	if not slot0.info_ then
		return
	end

	if slot1 == "skill" then
		if #slot0.info_:GetTotalSkill() > 0 then
			slot0:ChangeShowView("skill")
		end
	elseif slot1 == "suit" then
		slot0:ChangeShowView("suit")
	end
end

function slot0.RefreshUI(slot0)
	if slot0.info_ then
		slot0:RefreshTitle()
		slot0:RefreshAttr()
		slot0:RreshRace()
		slot0:RefreshSkill()

		if slot1.isKeep then
			slot0.selectType_ = slot0.selectType_ or "suit"
		else
			slot0.selectType_ = "suit"
		end

		slot0:RefreshState()
		slot0:RefreshSuitInfo()
		slot0:RefreshLayout()
	end
end

function slot0.RefreshState(slot0)
	if #slot0.info_:GetTotalSkill() > 0 then
		SetActive(slot0.switchGo_, true)
		SetActive(slot0.suitTipGo_, false)
		slot0:ChangeShowView(slot0.selectType_)
	else
		SetActive(slot0.switchGo_, false)
		SetActive(slot0.suitTipGo_, true)
		slot0:ChangeShowView("suit")
	end
end

function slot0.RefreshTitle(slot0)
	slot0.icon_.sprite = ItemTools.getItemSprite(slot0.info_.prefab_id)
	slot0.name_.text = EquipCfg[slot0.info_.prefab_id].name
	slot3 = HeroConst.RARE_COLOR[ItemCfg[slot0.info_.prefab_id].rare]

	for slot7 = 1, 5 do
		SetActive(slot0.star_[slot7], slot7 <= slot1.starlevel)
	end

	slot4 = slot0.info_:GetEnchantCount()

	for slot8 = 1, 2 do
		SetActive(slot0.slot_[slot8], slot8 <= slot4)
	end

	slot0.lv_.text = slot0.info_:GetLevel() .. "/" .. slot0.info_:GetMaxLv()

	if slot0.info_.equip_id and slot0.info_.equip_id ~= 0 then
		SetActive(slot0.lockGo_, true)

		slot0.lockToggle_.isOn = slot0.info_.is_lock

		slot0.lockController:SetSelectedState(slot0.info_.is_lock and "close" or "open")
	else
		SetActive(slot0.lockGo_, false)
	end

	slot7 = slot1.pos or 0
	slot0.posBg_.localRotation = Quaternion.Euler(0, 0, slot1.pos * 60 - 60)
end

function slot0.RefreshAttr(slot0)
	slot2 = 1

	for slot6, slot7 in pairs(EquipTools.CountEquipAttribute(slot0.info_)) do
		slot0.attrItem_[slot2]:RefreshData(slot0, {
			key = slot6,
			value = slot7,
			race = slot0.info_.race,
			heroId = slot0.heroId_
		})

		slot2 = slot2 + 1
	end
end

function slot0.ShowRaceAdd(slot0, slot1)
	for slot5, slot6 in pairs(slot0.attrItem_) do
		slot6:ShowAdd(slot1)
	end
end

function slot0.RreshRace(slot0)
	if slot0.info_.race ~= 0 then
		SetActive(slot0.racePanel_, true)

		slot2 = nil

		if table.keyof(RaceEffectCfg.all, slot0.info_.race) ~= nil then
			slot2 = RaceEffectCfg[slot0.info_.race]
			slot0.raceText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(slot2.name))
			slot0.raceImage_.sprite = getSprite("Atlas/CampItem", slot2.icon)

			slot0.raceController:SetSelectedIndex(math.min(slot0.info_.race, 5))
		else
			slot2 = HeroCfg[slot0.info_.race]
			slot0.raceText_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), string.format("%s·%s", GetI18NText(slot2.name), GetI18NText(slot2.suffix)))
			slot0.raceImage_.sprite = HeroTools.GetSmallHeadSprite(slot0.info_.race)

			slot0.raceController:SetSelectedIndex(math.min(slot2.race, 5))
		end
	else
		SetActive(slot0.racePanel_, false)
	end
end

function slot0.SetClickMessage(slot0, slot1)
	slot0.message_ = slot1
end

function slot0.RefreshSkill(slot0)
	slot1 = slot0.info_:GetLevel()

	for slot7 = 1, #slot0.info_:GetTotalSkill() do
		if slot0.skillIndex_ < slot7 then
			slot0.skillItems_[slot7] = EquipNewSkillItem.New(slot0, Object.Instantiate(slot0.skillItem_, slot0.skillTrs_), slot2[slot7])
			slot0.skillIndex_ = slot0.skillIndex_ + 1
			slot9 = slot0.skillItems_[slot7]

			slot9:RegistCallBack(function (slot0)
				if uv0.data_.SkillClick then
					uv0.data_:SkillClick(uv0.skillItems_[uv1], slot0, uv0.message_)
				end
			end)
		end

		slot2[slot7].level = slot1
		slot2[slot7].hideMaxLevel = true

		slot0.skillItems_[slot7]:RefreshData(slot0, slot2[slot7])
	end

	for slot7, slot8 in ipairs(slot0.skillItems_) do
		slot8:Show(slot7 <= slot3)
	end

	slot0.skillTrs_.anchoredPosition = Vector3(0, 0, 0)
end

function slot0.RefreshSuitInfo(slot0)
	slot2 = EquipCfg[slot0.info_.prefab_id]
	slot3 = slot2.suit
	slot4 = EquipSuitCfg[slot3]
	slot5, slot6 = EquipTools.GetHeroEquipSuitPos(_G.EQUIPING_HERO_ID, slot3, slot2.pos)

	if slot0.info_.suitNumAdd then
		slot6 = slot6 + slot0.info_.suitNumAdd
	end

	slot0.suitItem_:RefreshData(slot0, {
		id = slot3,
		num = slot6,
		pos = slot5,
		equipPos = slot2.pos
	})
end

function slot0.RefreshLayout(slot0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.skillTrs_)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.skillItems_ then
		for slot4, slot5 in ipairs(slot0.skillItems_) do
			slot5:Dispose()
		end

		slot0.skillItems_ = nil
	end

	if slot0.attrItem_ then
		for slot4, slot5 in ipairs(slot0.attrItem_) do
			slot5:Dispose()
		end

		slot0.attrItem_ = nil
	end

	if slot0.suitItem_ then
		slot0.suitItem_:Dispose()

		slot0.suitItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
