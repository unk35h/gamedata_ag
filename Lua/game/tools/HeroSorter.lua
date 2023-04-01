slot0 = class("HeroSorter")
slot1 = {}
slot2 = false

function slot0.Reset(slot0)
	uv0 = false
	uv1 = {}
end

function slot0.SetUnlockFirst(slot0, slot1)
	uv0 = slot1

	return uv1
end

function slot0.SortWithId(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, slot7)
	end

	table.sort(slot2, handler(slot0, slot0.SortRule))
	slot0:Reset()

	return slot2
end

function slot0.SortRule(slot0, slot1, slot2)
	slot3 = HeroData:GetHeroList()[slot1]
	slot4 = HeroData:GetHeroList()[slot2]

	if uv0 and (slot3.unlock == 1 and 1 or 0) ~= (slot4.unlock == 1 and 1 or 0) then
		return slot6 < slot5
	end

	slot5 = HeroCfg[slot1]
	slot6 = HeroCfg[slot2]
	slot9 = slot0:GetHeroPower(slot3)
	slot10 = slot0:GetHeroPower(slot4)

	if slot0:GetSortWeight(slot3) ~= slot0:GetSortWeight(slot4) then
		return slot8 < slot7
	elseif slot9 ~= slot10 then
		return slot10 < slot9
	elseif slot5.rare ~= slot6.rare then
		return slot6.rare < slot5.rare
	else
		return slot2 < slot1
	end
end

function slot0.GetHeroPower(slot0, slot1)
	if uv0[slot1.id] then
		return uv0[slot1.id]
	end

	slot2 = getBattlePower(slot1)
	uv0[slot1.id] = slot2

	return slot2
end

function slot0.GetSortWeight(slot0, slot1)
	slot2 = 0
	slot3 = HeroCfg[slot1.id]

	if slot1.hero_unlock == 1 or slot1.unlock == 1 then
		slot2 = slot2 + 100
	end

	if (slot1.hero_unlock == 0 or slot1.unlock == 0) and slot1.piece and GameSetting.unlock_hero_need.value[slot3.rare] <= slot1.piece then
		slot2 = slot2 + 10
	end

	return slot2
end

return slot0
