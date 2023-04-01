slot1 = class("BattleStatisticsPolyhdronOverView", import("game.views.battleResult.statistics.BattleStatisticsView"))

function slot1.OnEnter(slot0)
	slot2 = PolyhedronData:GetPolyhedronInfo():GetFightHeroList()
	slot0.statisticsHeroItem_ = {}
	slot3 = {
		{
			hurt = 0,
			damage = 0,
			cure = 0
		},
		{
			hurt = 0,
			damage = 0,
			cure = 0
		},
		{
			hurt = 0,
			damage = 0,
			cure = 0
		}
	}
	slot4 = {
		hurt = 0,
		damage = 0,
		cure = 0
	}
	slot5 = {
		hurt = 0,
		damage = 0,
		cure = 0
	}
	slot6 = {}

	for slot10 = 1, 3 do
		if slot2[slot10] and slot2[slot10] ~= 0 then
			slot11 = slot1:GetHeroPolyData(slot2[slot10])
			slot6[slot10] = {
				id = slot2[slot10],
				skin_id = slot0:GetHeroSkin(slot2[slot10]),
				level = HeroStandardSystemCfg[PolyhedronHeroCfg[slot2[slot10]].standard_id].hero_lv
			}
			slot3[slot10].damage = slot11.damage
			slot3[slot10].hurt = slot11.injured
			slot3[slot10].cure = slot11.heal
			slot5.damage = slot3[slot10].damage <= slot5.damage and slot5.damage or slot3[slot10].damage
			slot5.hurt = slot3[slot10].hurt <= slot5.hurt and slot5.hurt or slot3[slot10].hurt
			slot5.cure = slot3[slot10].cure <= slot5.cure and slot5.cure or slot3[slot10].cure
			slot4.damage = slot4.damage + slot3[slot10].damage
			slot4.hurt = slot4.hurt + slot3[slot10].hurt
			slot4.cure = slot4.cure + slot3[slot10].cure
		end
	end

	for slot10 = 1, 3 do
		slot0.statisticsHeroItem_[slot10] = slot0:GetStatisticsItem().New(slot0.heroItem_[slot10], slot6[slot10], slot4, slot5, slot3[slot10])
	end

	slot0:SetLevelTitle()
	SetActive(slot0.battleTimeGo_, false)
end

function slot1.GetStatisticsItem(slot0)
	return BattleStatisticsPolyhedronOverItem
end

function slot1.ParseTime(slot0, slot1)
	slot3 = math.floor(slot1 % 3600 / 60)
	slot4 = slot1 % 60

	if math.floor(slot1 / 3600) < 10 then
		slot2 = "0" .. slot2 or slot2
	end

	if slot3 < 10 then
		slot3 = "0" .. slot3 or slot3
	end

	if slot4 < 10 then
		slot4 = "0" .. slot4 or slot4
	end

	return slot2 .. ":" .. slot3 .. ":" .. slot4
end

function slot1.SetLevelTitle(slot0)
	slot0.lvText_.text = ""
	slot0.stareText_.text = ""
end

function slot1.GetCurrentClearTime(slot0)
	return 0
end

function slot1.GetHeroSkin(slot0, slot1)
	return slot1
end

return slot1
