slot0 = class("EquipSkillView", EquipBaseView)

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipExclusiveSkillMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
	uv0.super.Init(slot0, 1)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.isOpen_ = {}
	slot0.skillLv_ = {}
	slot0.skillBtn_ = {}
	slot0.skillCon_ = {}
	slot0.skillName_ = {}
	slot0.skillDesc_ = {}
	slot0.skillIcon_ = {}
	slot0.skillLockLv_ = {}
	slot0.skillContent_ = {}

	for slot4 = 1, 2 do
		slot0.skillLv_[slot4] = slot0["skillLv_" .. slot4]
		slot0.skillBtn_[slot4] = slot0["skillBtn_" .. slot4]
		slot0.skillCon_[slot4] = ControllerUtil.GetController(slot0.gameObject_.transform, "skill_" .. slot4)
		slot0.skillName_[slot4] = slot0["skillName_" .. slot4]
		slot0.skillDesc_[slot4] = slot0["skillDesc_" .. slot4]
		slot0.skillIcon_[slot4] = slot0["skillIcon_" .. slot4]
		slot0.skillLockLv_[slot4] = slot0["skillLockLv_" .. slot4]
		slot0.skillContent_[slot4] = slot0["skillContent_" .. slot4]
	end
end

function slot0.AddUIListeners(slot0)
	for slot4 = 1, #slot0.skillBtn_ do
		slot0:AddBtnListener(slot0.skillBtn_[slot4], nil, function ()
			if uv0.isOpen_[uv1] then
				JumpTools.OpenPageByJump("/equipHeroSkillUI", {
					equipID = uv0.equipID_,
					skillID = uv0.skillData_[uv1] or 0
				})
			else
				ShowTips(string.format(GetTips("EQUIP_ENCHANT_OEPN_LEVEL"), uv0.skillOpenLevel_[uv1]))
			end
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0.equipID_ = slot0.params_.equipId
	slot0.equipData_ = EquipData:GetEquipData(slot0.equipID_)

	if not slot0.equipData_ then
		slot0:Go("/home")

		return
	end

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.skillData_ = slot0.equipData_.useList
	slot0.equipLv_ = slot0.equipData_:GetLevel()
	slot0.equipCfg_ = EquipCfg[slot0.equipData_.prefab_id]
	slot0.skillNum_ = slot0.equipCfg_.hero_slot_num
	slot0.skillOpenLevel_ = slot0.equipCfg_.hero_slot_open_level or {}

	table.sort(slot0.skillData_, function (slot0, slot1)
		return slot0 < slot1
	end)

	for slot4 = 1, slot0.skillNum_ do
		if slot0.equipLv_ < (slot0.skillOpenLevel_[slot4] or 0) then
			slot0.isOpen_[slot4] = false
			slot0.skillLockLv_[slot4].text = string.format(GetTips("EQUIP_SKILL_LOCK_LEVEL"), slot5)

			slot0.skillCon_[slot4]:SetSelectedState("lock")
		else
			slot0.isOpen_[slot4] = true

			slot0.skillCon_[slot4]:SetSelectedState("open")

			if slot0.skillData_[slot4] then
				slot6 = slot0.skillData_[slot4]
				slot7 = EquipData:GetEquipSkillLv(slot0.equipID_, slot6)
				slot0.skillLv_[slot4].text = GetTips("LEVEL") .. slot7
				slot0.skillName_[slot4].text = EquipSkillCfg[slot6].name
				slot0.skillDesc_[slot4].text = EquipTools.GetSkillDesc(slot6, slot7, slot0.equipData_.race)
				slot0.skillContent_[slot4].localPosition = Vector3(slot0.skillContent_[slot4].localPosition.x, 0, 0)
				slot0.skillIcon_[slot4].sprite = getEquipSkillSprite(slot6)
			else
				slot0.skillCon_[slot4]:SetSelectedState("empty")
			end
		end
	end
end

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.OnEquipHeroSkillUp(slot0)
	slot0.equipData_ = EquipData:GetEquipData(slot0.equipID_)

	slot0:RefreshUI()
end

function slot0.OnArmHeroEquipSkill(slot0)
	slot0.equipData_ = EquipData:GetEquipData(slot0.equipID_)

	slot0:RefreshUI()
end

function slot0.OnEquipChange(slot0, slot1)
	slot0.equipID_ = slot1
	slot0.params_.equipId = slot1
	slot0.equipData_ = EquipData:GetEquipData(slot0.equipID_)

	if not slot0.equipData_ then
		slot0:Go("/home")

		return
	end

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0:HideMaskMessage()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
