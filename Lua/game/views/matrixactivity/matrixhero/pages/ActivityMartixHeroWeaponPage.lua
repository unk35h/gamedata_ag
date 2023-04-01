slot0 = class("ActivityMartixHeroWeaponPage", MartixHeroWeaponPage)

function slot0.SetMatirxHeroInfo(slot0, slot1, slot2)
	slot0.matrix_activity_id = slot1

	uv0.super.SetMatirxHeroInfo(slot0, slot2)
end

function slot0.GetHeroData(slot0, slot1)
	return ActivityMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

return slot0
