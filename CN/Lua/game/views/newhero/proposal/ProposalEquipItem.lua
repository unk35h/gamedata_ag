slot0 = class("ProposalEquipItem", EquipBaseView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	uv0.super.Init(slot0, 1)
end

function slot0.InitUI(slot0)
	slot0.equipInfoGo_ = slot0:FindGo("EquipInfoUI")
	slot0.equipSkillGo_ = slot0:FindGo("EquipSkillInfoUI")
	slot0.maskGo_ = slot0:FindGo("mask")
end

function slot0.ShowEquipInfo(slot0, slot1)
	SetActive(slot0.equipInfoGo_, true)
	SetActive(slot0.maskGo_, true)
	slot0:RefreshEquipInfo(EquipData:GetEquipData(slot1))
end

return slot0
