slot1 = class("BattleStatisticsPolyhedronOverItem", import("game.views.battleResult.statistics.BattleStatisticsHeroItem"))

function slot1.RefreshUI(slot0)
	if slot0.heroData_ then
		slot0.haveHeroController_:SetSelectedState("true")

		slot1 = slot0.heroData_
		slot2 = HeroCfg[slot0.heroData_.id]
		slot3 = slot0.data_
		slot5 = slot0.totalData_
		slot0.battleCountIcon_.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[slot1.skin_id].picture_id)

		SetActive(slot0.battleCountIcon_.gameObject, true)

		slot0.battleCountLv_.text = slot1.level
		slot0.battleCountDamageNum_.text = slot3.damage
		slot0.battleCountHurtNum_.text = slot3.hurt
		slot0.battleCountCureNum_.text = slot3.cure
		slot0.battleCountDamageImg_.enabled = slot0.maxData_.damage == slot3.damage and slot4.damage > 0
		slot0.battleCountHurtNumImg_.enabled = slot4.hurt == slot3.hurt and slot4.hurt > 0
		slot0.battleCountCureNumImg_.enabled = slot4.cure == slot3.cure and slot4.cure > 0

		if slot3.damage == 0 then
			slot0.controllers_[1]:SetSelectedState("true")

			slot0.battleCountDamageNum_.text = "--"
		else
			slot0.controllers_[1]:SetSelectedState("false")
		end

		if slot3.hurt == 0 then
			slot0.controllers_[2]:SetSelectedState("true")

			slot0.battleCountHurtNum_.text = "--"
		else
			slot0.controllers_[2]:SetSelectedState("false")
		end

		if slot3.cure == 0 then
			slot0.controllers_[3]:SetSelectedState("true")

			slot0.battleCountCureNum_.text = "--"
		else
			slot0.controllers_[3]:SetSelectedState("false")
		end
	else
		slot0.haveHeroController_:SetSelectedState("false")
	end
end

return slot1
