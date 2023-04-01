slot0 = class("EquipNewHeroSkillItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.emptyCon_ = ControllerUtil.GetController(slot0.transform_, "empty")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_({
				equipID = uv0.equipID_,
				skillID = uv0.skillID_,
				index = uv0.index_,
				lv = uv0.lv_,
				extra = uv0.extra_,
				race = uv0.equipData_.race
			})
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshData(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.data_ = slot1
	slot0.index_ = slot4
	slot0.skillID_ = slot2
	slot0.equipID_ = slot3
	slot0.pos_ = slot5
	slot0.extra_ = slot6
	slot0.heroID_ = slot7

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if not slot0.equipID_ or slot0.equipID_ == 0 then
		slot0.stateCon_:SetSelectedState("off")

		return
	end

	if slot0.extra_ then
		if slot0.extra_.isForeign then
			slot0.equipData_ = ForeignInfoData:GetEquipInfo(slot0.heroID_, slot0.pos_)
		elseif slot0.extra_.isTemp then
			return
		end
	else
		slot0.equipData_ = EquipData:GetEquipData(slot0.equipID_)
	end

	slot1 = slot0.equipData_:GetLevel()

	if not EquipCfg[slot0.equipData_.prefab_id].hero_slot_open_level[slot0.index_] or slot1 < slot2 then
		if slot2 then
			slot0.lock_.text = string.format(GetTips("EQUIP_SKILL_LOCK_LEVEL"), slot2)
		end

		slot0.stateCon_:SetSelectedState("off")

		return
	end

	slot0.stateCon_:SetSelectedState("on")

	if slot0.skillID_ then
		slot0.lv_ = slot0.equipData_.skillList[slot0.skillID_].level
		slot0.skillLv_.text = GetTips("LEVEL") .. slot0.lv_
		slot0.skillName_.text = EquipSkillCfg[slot0.skillID_].name
		slot0.skillDesc_.text = EquipTools.GetSkillDesc(slot0.skillID_, slot0.lv_, slot0.equipData_.race)
		slot0.skillIcon_.sprite = getEquipSkillSprite(slot0.skillID_)

		slot0.emptyCon_:SetSelectedState("false")
	else
		slot0.emptyCon_:SetSelectedState("true")
	end
end

function slot0.Calculate(slot0, slot1, slot2)
	if slot2 <= 0 then
		return string.format("%.1f%%", slot1)
	else
		return slot1
	end
end

function slot0.ShowSelect(slot0, slot1)
	SetActive(slot0.select_, slot1)
end

function slot0.OnClick(slot0, slot1)
	if slot0.clickFunc_ then
		slot0.clickFunc_(slot0.info_)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.GetItemInfo(slot0)
	return {
		equipID = slot0.equipID_,
		skillID = slot0.skillID_,
		index = slot0.index_
	}
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.clickFunc_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
