slot0 = class("EquipBreakThroughMaterialTeamInfoItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.index_ = slot3

	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.RefreshUI(slot0)
	if EquipBreakThroughMaterialData:GetHeroState()[slot0.index_] == nil then
		slot0:Show(false)

		return
	end

	slot3 = slot2.heroID
	slot0.image_.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[HeroTools.HeroUsingSkinInfo(slot3).id].picture_id)
	slot6 = HeroCfg[slot3]
	slot0.nameText_.text = string.format("%s·%s", slot6.name, slot6.suffix)
	slot0.lvText_.text = HeroData:GetHeroList()[slot3].level or 1
	slot0.hpSlider_.value = slot2.rate / 10000

	if math.ceil(slot2.rate / 100) <= 0 and slot2.rate > 0 then
		slot8 = 1
	end

	slot0.hpText_.text = string.format("%s%%", slot8)

	slot0:Show(true)
end

return slot0
