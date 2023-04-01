slot0 = class("EquipBrealThroughResultHeroItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index_ = slot2

	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1)
	slot0.stageData_ = slot1

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot2 = slot0.stageData_:GetSystemHeroTeam()

	if slot0.stageData_:GetHeroTeam()[slot0.index_] == nil or slot1[slot0.index_] == 0 then
		SetActive(slot0.gameObject_, false)

		return
	end

	SetActive(slot0.gameObject_, true)

	slot0.icon_.sprite = getSpriteViaConfig("HeroIcon", HeroTools.HeroUsingSkinInfo(slot1[slot0.index_]).picture_id)
	slot0.lvText_.text = HeroData:GetHeroData(slot1[slot0.index_]).level
	slot4 = EquipBreakThroughMaterialData:GetHeroState()[slot0.index_] and EquipBreakThroughMaterialData:GetHeroState()[slot0.index_].rate or 10000
	slot0.slider_.value = slot4 / 10000
	slot5 = math.ceil(slot4 / 100)

	if slot4 > 0 and slot5 < 1 then
		slot5 = 1
	end

	slot0.rateText_.text = string.format("%s%%", slot5)
end

return slot0
