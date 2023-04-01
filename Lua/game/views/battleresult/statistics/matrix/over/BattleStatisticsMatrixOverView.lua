slot1 = class("BattleStatisticsMatrixOverView", import("..BattleStatisticsMatrixView"))

function slot1.OnEnter(slot0)
	slot1 = slot0:GetMatrixHeroTeam()
	slot0.statisticsHeroItem_ = {}
	slot2 = {
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
	slot3 = {
		hurt = 0,
		damage = 0,
		cure = 0
	}
	slot4 = {
		hurt = 0,
		damage = 0,
		cure = 0
	}
	slot5 = {}

	for slot9 = 1, 3 do
		if slot1[slot9] and slot1[slot9] ~= 0 then
			slot10 = slot0:GetHeroData(slot1[slot9])
			slot5[slot9] = {
				level = 1,
				id = slot1[slot9],
				skin_id = slot0:GetHeroSkin(slot1[slot9])
			}
			slot2[slot9].damage = slot10.totalDamage_
			slot2[slot9].hurt = slot10.totalHurt_
			slot2[slot9].cure = slot10.totalHeal_
			slot4.damage = slot2[slot9].damage <= slot4.damage and slot4.damage or slot2[slot9].damage
			slot4.hurt = slot2[slot9].hurt <= slot4.hurt and slot4.hurt or slot2[slot9].hurt
			slot4.cure = slot2[slot9].cure <= slot4.cure and slot4.cure or slot2[slot9].cure
			slot3.damage = slot3.damage + slot2[slot9].damage
			slot3.hurt = slot3.hurt + slot2[slot9].hurt
			slot3.cure = slot3.cure + slot2[slot9].cure
		end
	end

	for slot9 = 1, 3 do
		slot0.statisticsHeroItem_[slot9] = slot0:GetStatisticsItem().New(slot0.heroItem_[slot9], slot5[slot9], slot3, slot4, slot2[slot9])
	end

	slot0:SetLevelTitle()

	if slot0:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS then
		slot0.battleTimeText_.text = slot0:ParseTime(slot0:GetCurrentClearTime())

		SetActive(slot0.battleTimeGo_, true)
	else
		SetActive(slot0.battleTimeGo_, false)
	end
end

function slot1.GetStatisticsItem(slot0)
	return BattleStatisticsMatrixOverItem
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

function slot1.GetGameState(slot0)
	return MatrixData:GetGameState()
end

function slot1.GetCurrentClearTime(slot0)
	return MatrixData:GetCurrentClearTime()
end

function slot1.GetMatrixHeroTeam(slot0)
	return MatrixData:GetMatrixHeroTeam()
end

function slot1.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

function slot1.GetHeroSkin(slot0, slot1)
	return MatrixData:GetHeroSkin(slot1)
end

return slot1
