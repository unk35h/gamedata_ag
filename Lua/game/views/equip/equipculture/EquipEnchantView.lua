slot0 = class("EquipEnchantView", EquipBaseView)

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipEnchantUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	uv0.super.Init(slot0)

	slot0.max = GameSetting.equip_enchant_save_num.value[1] or 0
	slot0.isLockedSkill_ = false
	slot0.lockedIndex_ = nil
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skillBaseItems_ = {}
	slot0.skillPreItems_ = {}
	slot0.items_ = {}
	slot0.materialIndex = 1
	slot0.btnEnchantController_ = ControllerUtil.GetController(slot0.btnEnchant_.transform, "enabled")
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot0.enchantListGo_, EquipEnchantPreviewItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnEnchant_, nil, function ()
		uv0:OnEnchantClick()
	end)
	slot0:AddBtnListener(slot0.btnGiveUp_, nil, function ()
		if uv0.enchantList and #uv0.enchantList > 0 then
			EquipAction.QueryEquipGiveUpAllEnchant(uv0.equipId, uv0.enchatPos)
		end
	end)
	slot0:AddBtnListener(slot0.moreAttriBtn_, nil, function ()
		if uv0.heroID_ ~= 0 then
			slot0 = {}
			slot2 = HeroTools.GetHeroEquipSkillAddLevel(HeroData:GetHeroData(uv0.heroID_)) == 1

			for slot6, slot7 in ipairs(slot1.equip) do
				if slot7.equip_id ~= 0 then
					table.insert(slot0, EquipData:GetEquipList()[slot7.equip_id])
				end
			end

			JumpTools.OpenPageByJump("equipMoreAttribute", {
				heroID = uv0.heroID_,
				equipList = slot0,
				isAdd = slot2
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.equipId = slot0.params_.equipId
	slot0.enchatPos = slot0.params_.enchatPos
	slot0.materials = EquipData:GetEnchantMaterial()
	slot0.lockmaterials_, slot0.showLockMaterials_ = EquipData:GetLockEnchantMaterial()

	slot0:RefreshUI()

	slot0.materialIndex = EquipData:GetSelectEnchantMaterialIndex()

	slot0:OnMarerialChange(slot0.materialIndex)
	slot0:ShowDefaultBar()
	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnGoldChange))
	slot0:RegistEventListener(MATERIAL_MODIFY, handler(slot0, slot0.OnMaterialModify))

	slot0.isLockedSkill_ = false
	slot0.lockedIndex_ = nil

	if EquipData:GetIsSetLockView(slot0.equipId, slot0.enchatPos) then
		slot0.skillBaseItems_[slot1]:SetLockStatus(true)
		slot0:OnMarerialChange(3)

		slot0.isLockedSkill_ = true
		slot0.lockedIndex_ = slot1

		slot0:RreshMaterialUI()
		slot0:RreshMateriaMoney()
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:HideMaskMessage()
	slot0:RemoveAllEventListener()

	slot0.isLockedSkill_ = false
	slot0.lockedIndex_ = nil

	for slot4, slot5 in pairs(slot0.skillBaseItems_) do
		slot5:SetLockStatus(false)
	end
end

function slot0.RefreshUI(slot0)
	slot0:RreshMaterialUI()
	slot0:RreshSkillUI()

	slot0.newMaxText_.text = string.format(GetTips("EQUIP_ENCHANT_RESULT_NUM"), slot0.max)

	slot0.scrollHelper:StartScrollWithoutAnimator(slot0.max, Vector2(0, 0))
end

function slot0.indexItem(slot0, slot1, slot2)
	if slot0.enchantList[slot1] then
		slot2:SetState(true)
		slot2:Refresh(slot1, slot0.equipId, slot0.enchatPos, slot3, EquipData:GetEquipData(slot0.equipId) and slot4:GetLevel() or 0, slot4)
		slot2:RegistSkillClickCallBck(handler(slot0, slot0.OnSkillClick))
	else
		slot2:SetState(false)
	end

	slot2:RefreshText(slot1)
end

function slot0.OnSkillClick(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	slot0:SkillClick(slot1, slot2)

	if slot0.skillPanel_:InverseTransformPoint(slot1.transform_:TransformPoint(Vector3(405, 0, 0))).x > -slot0.equipSkillGo_.transform.rect.width then
		slot0.equipSkillGo_.transform.localPosition = Vector3(slot0.skillPanel_:InverseTransformPoint(slot1.transform_:TransformPoint(Vector3(0, 0, 0))).x - slot5, -190, 0)
	else
		slot0.equipSkillGo_.transform.localPosition = Vector3(slot4.x, -190, 0)
	end
end

function slot0.RreshMaterialUI(slot0)
	if slot0.isLockedSkill_ then
		for slot4, slot5 in pairs(slot0.lockmaterials_) do
			if slot4 > #slot0.items_ then
				slot0.items_[slot4] = CommonItem.New(Object.Instantiate(slot0.materialItem_, slot0.materialParent_.transform))

				slot0.items_[slot4]:RegistCallBack(function (slot0)
					uv0:OnMarerialChange(uv1)
					OperationRecorder.Record("equip", "enchantSelectMaterial")
				end)
				slot0.items_[slot4]:SetSelectType("equip")
			end

			slot0.items_[slot4]:RefreshData(slot5)

			slot7 = MaterialData:GetMaterial(slot5.id) and slot6.num or 0
			slot8 = tostring(slot7)

			if slot7 < slot5.number then
				slot8 = "<color='#D34015'>" .. slot8 .. "</color>"
			end

			slot0.items_[slot4]:SetBottomText(slot8 .. "/" .. slot5.number)
			slot0.items_[slot4]:Show(true)

			if slot0.showLockMaterials_[slot4] == true then
				slot0.items_[slot4]:ShowLock(false)
			else
				slot0.items_[slot4]:ShowLock(true)
			end
		end

		for slot4 = #slot0.materials + 1, #slot0.items_ do
			slot0.items_[slot4]:Show(false)
		end
	else
		for slot4, slot5 in pairs(slot0.materials) do
			if slot4 > #slot0.items_ then
				slot0.items_[slot4] = CommonItem.New(Object.Instantiate(slot0.materialItem_, slot0.materialParent_.transform))

				slot0.items_[slot4]:RegistCallBack(function (slot0)
					uv0:OnMarerialChange(uv1)
					OperationRecorder.Record("equip", "enchantSelectMaterial")
				end)
				slot0.items_[slot4]:SetSelectType("equip")
			end

			slot0.items_[slot4]:RefreshData(slot5)

			slot7 = MaterialData:GetMaterial(slot5.id) and slot6.num or 0
			slot8 = tostring(slot7)

			if slot7 < slot5.number then
				slot8 = "<color='#D34015'>" .. slot8 .. "</color>"
			end

			slot0.items_[slot4]:SetBottomText(slot8 .. "/" .. slot5.number)
			slot0.items_[slot4]:Show(true)
			slot0.items_[slot4]:ShowLock(false)
		end

		for slot4 = #slot0.materials + 1, #slot0.items_ do
			slot0.items_[slot4]:Show(false)
		end
	end
end

function slot0.OnMarerialChange(slot0, slot1)
	if slot0.isLockedSkill_ then
		return
	end

	slot0.materialIndex = slot1
	slot5 = slot1

	EquipData:SetSelectEnchantMaterialIndex(slot5)
	slot0:RreshMateriaMoney()

	for slot5 = 1, #slot0.items_ do
		if slot1 == slot5 then
			slot0.items_[slot5]:ShowSelect(1)
		else
			slot0.items_[slot5]:ShowSelect(0)
		end
	end
end

function slot0.RreshMateriaMoney(slot0)
	slot1 = {}
	slot2 = ((not slot0.isLockedSkill_ or slot0.lockmaterials_[slot0.materialIndex]) and slot0.materials[slot0.materialIndex]).money
	slot4 = tostring(slot2)

	if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot2 then
		slot4 = "<color='#FF0000'>" .. slot4 .. "</color>"
	end

	slot0.costNum_.text = slot4
	slot6 = ItemCfg[slot1.id]

	if slot0.isLockedSkill_ then
		slot0.materialText_.text = GetTips("EQUIP_SKILL_LOCK_DES")
	else
		slot0.materialText_.text = slot6 and slot6.desc or ""
	end
end

function slot0.RreshSkillUI(slot0)
	if not EquipData:GetEquipData(slot0.equipId) then
		return
	end

	slot3 = slot1.enchant[slot0.enchatPos] or {}

	slot0:RefreshSkill(slot3, slot1:GetLevel(), slot0.skillBaseItems_, slot0.skillBaseTrs_, slot0.skillBaseNull_, slot1)

	slot0.enchantList = slot1.enchant_preview[slot0.enchatPos]

	slot0.scrollHelper:StartScrollWithoutAnimator(slot0.max, slot0.scrollHelper:GetScrolledPosition())

	slot0.heroID_ = EquipTools.GetEquipedHeroId(slot0.equipId)

	SetActive(slot0.moreAttriBtn_.gameObject, slot0.heroID_ ~= 0 and #slot3 > 0)
end

function slot0.SetButtonState(slot0, slot1, slot2, slot3)
	slot1.enabled = slot3

	if slot2 then
		slot2:SetSelectedState(tostring(slot3))
	end
end

function slot0.RefreshSkill(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	for slot11 = 1, #slot1 do
		if slot11 > #slot3 then
			slot3[slot11] = EquipNewSkillItem.New(slot0, Object.Instantiate(slot0.skillItem_, slot4), slot1[slot11])
			slot13 = slot3[slot11]

			slot13:SetIsEnchant(slot11, handler(slot0, slot0.OnLockClick))

			slot13 = slot3[slot11]

			slot13:RegistCallBack(function (slot0)
				slot1 = deepClone(slot0)
				slot1.lv = EquipSkillCfg[slot1.id].lvmax < slot1.num and slot4.lvmax or slot3

				uv0:OnSkillClick(uv1[uv2], slot1)
			end)
		end

		slot1[slot11].level = slot2
		slot1[slot11].hideMaxLevel = true
		slot12 = 0
		slot13 = 0

		if EquipTools.GetEquipedHeroId(slot6.equip_id) ~= 0 then
			slot12 = HeroTools.GetHeroEquipSkillAddLevel(HeroData:GetHeroData(slot14))

			for slot20, slot21 in ipairs(HeroTools.GetHeroEquipS(slot14)) do
				if EquipData:GetEquipData(slot21.equip_id) then
					slot13 = slot13 + slot22:GetSkillLevel(slot1[slot11].id)
				end
			end
		else
			slot13 = slot6:GetSkillLevel(slot1[slot11].id)
		end

		deepClone(slot1[slot11]).num = slot13 + slot12
		slot15.isAdd = slot12 == 1

		slot3[slot11]:RefreshData(slot0, slot15, true, false)
	end

	if slot5 then
		SetActive(slot5, slot7 == 0)
	end

	for slot11, slot12 in ipairs(slot3) do
		slot12:Show(slot11 <= slot7)

		if slot7 < slot11 and slot0.lockedIndex_ == 2 then
			slot0:OnLockClick(slot0.lockedIndex_)
		end
	end
end

function slot0.OnEnchantClick(slot0)
	slot0.enchantList = EquipData:GetEquipData(slot0.equipId).enchant_preview[slot0.enchatPos]

	if slot0.max <= #slot0.enchantList then
		ShowTips("EQUIP_ENCHANT_RESULT_NUM_MAX")

		return
	end

	slot2 = slot0.equipId
	slot3 = slot0.enchatPos
	slot4 = slot0.materials[slot0.materialIndex]
	slot5 = 0

	if slot0.isLockedSkill_ then
		slot5 = slot0.lockedIndex_
		slot4 = slot0.lockmaterials_[slot0.materialIndex]
	end

	EquipAction.QueryEquipEnchant(slot2, slot3, slot4, slot5)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper:Dispose()

	if slot0.skillBaseItems_ then
		for slot4, slot5 in ipairs(slot0.skillBaseItems_) do
			slot5:Dispose()
		end

		slot0.skillBaseItems_ = {}
	end

	for slot4, slot5 in ipairs(slot0.items_) do
		slot5:Dispose()

		slot0.items_ = {}
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnEquipEnchant(slot0)
	slot0:RreshMateriaMoney()
	slot0:RreshMaterialUI()
	slot0:RreshSkillUI()
	slot0.scrollHelper:ScrollToIndex(math.max(0, (slot0.enchantList and #slot0.enchantList or 0) - 1), true, true)
end

function slot0.OnEquipEnchantConfirm(slot0, slot1)
	slot0:RreshSkillUI()
end

function slot0.OnEquipEnchantGiveUp(slot0)
	slot0:RreshSkillUI()
end

function slot0.OnEquipEnchantAnimtionEvent(slot0, slot1)
	if slot1 == "EquipEnchantSuccess" then
		slot0:RreshSkillUI()
	elseif slot1 == "EquipEnchantConfirm" then
		slot0:RreshSkillUI()
	end
end

function slot0.OnGoldChange(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		slot0:RreshMateriaMoney()
	end
end

slot1 = 606

function slot0.OnMaterialModify(slot0, slot1)
	if ItemCfg[slot1].sub_type == uv0 then
		slot0:RreshMaterialUI()
	end
end

function slot0.OnLockClick(slot0, slot1)
	if slot0.isLockedSkill_ then
		if slot0.lockedIndex_ then
			if slot0.lockedIndex_ == slot1 then
				slot0.skillBaseItems_[slot0.lockedIndex_]:SetLockStatus(false)

				slot0.isLockedSkill_ = false
				slot0.lockedIndex_ = nil
				slot0.materialIndex = 3

				EquipData:SetEnchatLockIndex(0, 0, 0)
			elseif #slot0.enchantList > 0 then
				ShowTips(GetTips("EQUIP_SKILL_LOCK_ENCHANT_EMPTY"))
			else
				slot0.skillBaseItems_[slot0.lockedIndex_]:SetLockStatus(false)
				slot0.skillBaseItems_[slot1]:SetLockStatus(true)

				slot0.lockedIndex_ = slot1

				EquipData:SetEnchatLockIndex(slot0.equipId, slot0.enchatPos, slot0.lockedIndex_)
			end
		end
	elseif #slot0.enchantList > 0 then
		ShowTips(GetTips("EQUIP_SKILL_LOCK_ENCHANT_EMPTY"))
	else
		slot0.skillBaseItems_[slot1]:SetLockStatus(true)
		slot0:OnMarerialChange(3)

		slot0.isLockedSkill_ = true
		slot0.lockedIndex_ = slot1

		EquipData:SetEnchatLockIndex(slot0.equipId, slot0.enchatPos, slot0.lockedIndex_)
	end

	slot0:RreshMaterialUI()
	slot0:RreshMateriaMoney()
end

return slot0
