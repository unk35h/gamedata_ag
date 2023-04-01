slot0 = class("EquipNewHeroSkillInfoView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot0.name_.text = EquipSkillCfg[slot1.skillID].name
		slot0.desc_.text = EquipTools.GetSkillDesc(slot1.skillID, slot1.lv + slot1.isAdd, slot1.race)
		slot0.icon_.sprite = getEquipSkillSprite(slot1.skillID)

		if slot1.isAdd == 1 then
			slot0.lv_.text = "<color=#E57725>" .. GetTips("LEVEL") .. slot1.lv + slot1.isAdd .. "</color>"
		else
			slot0.lv_.text = GetTips("LEVEL") .. slot1.lv
		end
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
