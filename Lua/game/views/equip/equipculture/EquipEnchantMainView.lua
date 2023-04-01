slot0 = class("EquipEnchantMainView", EquipBaseView)

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipEnchantMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skillFixedItems_ = {}
	slot0.enchantItems = {}
end

function slot0.OnEnter(slot0)
	slot0.equipId = slot0.params_.equipId
	slot0.equip = EquipData:GetEquipData(slot0.equipId)
	slot0.slotNum = EquipCfg[slot0.equip.prefab_id].slot_num or 0
	slot0.slotOpenLevel = slot1.slot_open_level or {}

	slot0:RefreshUI()
end

function slot0.OnEquipChange(slot0, slot1)
	slot0.equipId = slot1
	slot0.params_.equipId = slot1
	slot0.equip = EquipData:GetEquipData(slot0.equipId)
	slot0.slotNum = EquipCfg[slot0.equip.prefab_id].slot_num or 0
	slot0.slotOpenLevel = slot2.slot_open_level or {}

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0:HideMaskMessage()
end

function slot0.RefreshUI(slot0)
	if not slot0.equip then
		return
	end

	slot7 = slot0.skillItem_

	slot0:RefreshSkill(slot7, slot1:GetBaseSkill(), slot1:GetLevel(), slot0.skillFixedItems_, slot0.skillFixedTrs_)

	for slot7 = 1, slot0.slotNum do
		if slot0.enchantItems[slot7] == nil then
			slot8 = Object.Instantiate(slot0.skillEnchantItem, slot0.skillEnchantParent)
			slot0.enchantItems[slot7] = {
				gameObject = slot8,
				skillEnchantTrs = slot0:FindTrs("ScrollView/Viewport/Grid", slot8.transform),
				skillEnchantNull = slot0:FindGo("skillnull", slot8.transform),
				skillLockGo = slot0:FindGo("lock", slot8.transform),
				skillLockText = slot0:FindCom(typeof(Text), "lock/text", slot8.transform),
				skillItemList = {}
			}

			slot0:AddBtnListener(slot8:GetComponent(typeof(Button)), nil, function ()
				uv0:OnEnchantClick(uv1)
			end)
		end

		SetActive(slot0.enchantItems[slot7].gameObject, true)
		slot0:RefreshSkill(slot0.skillEnchant_, slot1.enchant[slot7] or {}, slot2, slot0.enchantItems[slot7].skillItemList, slot0.enchantItems[slot7].skillEnchantTrs)

		if slot0.equip:GetLevel() < (slot0.slotOpenLevel[slot7] or 0) then
			SetActive(slot0.enchantItems[slot7].skillLockGo, true)
			SetActive(slot0.enchantItems[slot7].skillEnchantNull, false)

			slot0.enchantItems[slot7].skillLockText.text = string.format(GetTips("EQUIP_SKILL_LOCK_LEVEL"), slot8)
		elseif not slot1.enchant[slot7] or #slot1.enchant[slot7] == 0 then
			SetActive(slot0.enchantItems[slot7].skillLockGo, false)
			SetActive(slot0.enchantItems[slot7].skillEnchantNull, true)
		else
			SetActive(slot0.enchantItems[slot7].skillLockGo, false)
			SetActive(slot0.enchantItems[slot7].skillEnchantNull, false)
		end
	end

	for slot7 = slot0.slotNum + 1, #slot0.enchantItems do
		SetActive(slot0.enchantItems[slot7].gameObject, false)
	end
end

function slot0.RefreshSkill(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	for slot11 = 1, #slot2 do
		if slot11 > #slot4 then
			slot4[slot11] = EquipNewSkillItem.New(slot0, Object.Instantiate(slot1, slot5), slot2[slot11])
			slot13 = slot4[slot11]

			slot13:RegistCallBack(function (slot0)
				uv0:SkillClick(uv1[uv2], slot0)
			end)
		end

		slot2[slot11].level = slot3
		slot2[slot11].hideMaxLevel = true

		slot4[slot11]:RefreshData(slot0, slot2[slot11])
	end

	if slot6 then
		SetActive(slot6, slot7 == 0)
	end

	for slot11, slot12 in ipairs(slot4) do
		slot12:Show(slot11 <= slot7)
	end
end

function slot0.OnEnchantClick(slot0, slot1)
	if slot0.equip:GetLevel() < (slot0.slotOpenLevel[slot1] or 0) then
		ShowTips(string.format(GetTips("EQUIP_ENCHANT_OEPN_LEVEL"), slot2))

		return
	end

	slot0:Go("/equipEnchantView", {
		equipId = slot0.equipId,
		enchatPos = slot1
	})
end

function slot0.Dispose(slot0)
	if slot0.skillFixedItems_ then
		for slot4, slot5 in ipairs(slot0.skillFixedItems_) do
			slot5:Dispose()
		end

		slot0.skillFixedItems_ = {}
	end

	if slot0.skillEnchantOneItems_ then
		for slot4, slot5 in ipairs(slot0.skillEnchantOneItems_) do
			slot5:Dispose()
		end

		slot0.skillEnchantOneItems_ = {}
	end

	for slot4, slot5 in ipairs(slot0.enchantItems) do
		for slot9, slot10 in ipairs(slot5.skillItemList) do
			slot10:Dispose()
		end
	end

	slot0.enchantItems = {}

	uv0.super.Dispose(slot0)
end

return slot0
