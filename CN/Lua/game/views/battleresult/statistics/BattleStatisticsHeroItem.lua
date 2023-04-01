slot0 = class("BattleStatisticsHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.heroData_ = slot2
	slot0.totalData_ = slot3
	slot0.maxData_ = slot4
	slot0.data_ = slot5

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.haveHeroController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "haveHero")
	slot0.highGo1_ = slot0:FindGo("line1/high")
	slot0.highGo2_ = slot0:FindGo("line2/high")
	slot0.highGo3_ = slot0:FindGo("line3/high")
	slot0.controllers_ = {
		ControllerUtil.GetController(slot0.highGo1_.transform, "zero"),
		ControllerUtil.GetController(slot0.highGo2_.transform, "zero"),
		ControllerUtil.GetController(slot0.highGo3_.transform, "zero")
	}
end

function slot0.AddListeners(slot0)
end

function slot0.RemoveListeners(slot0)
end

function slot0.RefreshUI(slot0)
	if slot0.heroData_ then
		slot0.haveHeroController_:SetSelectedState("true")

		slot1 = slot0.heroData_
		slot2 = HeroCfg[slot0.heroData_.id]
		slot3 = slot0.data_
		slot5 = slot0.totalData_
		slot0.battleCountIcon_.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[slot1.skin_id].picture_id)

		SetActive(slot0.battleCountIcon_.gameObject, true)

		slot0.battleCountLv_.text = slot1.level
		slot0.battleCountDamageNum_.text = tostring(slot3.damage)
		slot0.battleCountHurtNum_.text = tostring(slot3.hurt)
		slot0.battleCountCureNum_.text = tostring(slot3.cure)
		slot0.battleCountDamageImg_.enabled = int64.equals(slot0.maxData_.damage, slot3.damage) and int64.zero < slot4.damage
		slot0.battleCountHurtNumImg_.enabled = int64.equals(slot4.hurt, slot3.hurt) and int64.zero < slot4.hurt
		slot0.battleCountCureNumImg_.enabled = int64.equals(slot4.cure, slot3.cure) and int64.zero < slot4.cure

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

return slot0
