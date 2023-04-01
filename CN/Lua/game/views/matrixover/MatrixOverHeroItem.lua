slot0 = class("MatrixOverHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.servantView_ = MatrixOverHeroServantItem.New(slot0.servantItem_)
	slot0.equipItemView_ = {}

	for slot4 = 1, 5 do
		table.insert(slot0.equipItemView_, MatrixOverHeroEquipItem.New(slot0[string.format("equipGo%s_", slot4)]))
	end

	slot0.astrolabeItemView_ = {}

	for slot4 = 1, 6 do
		table.insert(slot0.astrolabeItemView_, MatrixOverHeroAstrolabeItem.New(slot0[string.format("astrolabeGo%s_", slot4)]))
	end
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Refresh(slot0, slot1)
	slot0.heroID_ = slot1
	slot2 = slot0:GetHeroData(slot0.heroID_)
	slot0.icon_.sprite = HeroTools.GetHeadSprite(slot0:GetHeroSkin(slot2.hero_id))
	slot8 = slot2

	slot0.servantView_:Refresh(slot2.GetWeaponServant(slot8))

	slot3 = slot2:GetEquipList()

	for slot7, slot8 in ipairs(slot0.equipItemView_) do
		slot8:Refresh(slot3[slot7])
	end

	slot4 = slot2:GetAstrolabeList()

	for slot8, slot9 in ipairs(slot0.astrolabeItemView_) do
		slot9:Refresh(slot4[slot8], slot0.heroID_)
	end
end

function slot0.Dispose(slot0)
	slot0.servantView_:Dispose()

	slot0.servantView_ = nil

	for slot4, slot5 in ipairs(slot0.equipItemView_) do
		slot5:Dispose()
	end

	slot0.equipItemView_ = nil

	for slot4, slot5 in ipairs(slot0.astrolabeItemView_) do
		slot5:Dispose()
	end

	slot0.astrolabeItemView_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

function slot0.GetHeroSkin(slot0, slot1)
	return MatrixData:GetHeroSkin(slot1)
end

return slot0
