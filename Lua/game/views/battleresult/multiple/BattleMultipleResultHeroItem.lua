slot0 = class("BattleMultipleResultHeroItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.heroData_ = slot2
	slot0.stageData = slot3
	slot0.isLock_ = slot4

	slot0:InitUI()
	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	slot0:RemoveTween()
	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0)
	slot0.icon_.sprite = getSpriteViaConfig("HeroLittleIcon", slot0.heroData_.skin_id)

	if slot0.isLock_ then
		slot0:LockHero()
	else
		slot0:RefreshHero()
	end
end

function slot0.LockHero(slot0)
	slot0.addExpText_.text = "+0"
	slot0.lvText_.text = slot0.heroData_.level
	slot0.expProgressBar_.value = 1
end

function slot0.RefreshHero(slot0)
	slot1 = slot0.heroData_
	slot3 = slot1.exp - LvTools.LevelToExp(slot1.level, "hero_level_exp1")

	if LvTools.GetMaxTotalExp("hero_level_exp1") - slot1.exp < 0 then
		slot5 = 0
	end

	slot6 = slot0.stageData
	slot9 = slot0.stageData
	slot7 = math.min(slot9:GetAddHeroExp() * slot6:GetMultiple(), slot5)
	slot9, slot10, slot11, slot12, slot13 = LvTools.CheckHeroExp(slot2, slot1.exp + slot7, HeroTools.GetHeroCurrentMaxLevel(slot1))
	slot7 = slot7 - slot13

	HeroAction.AddHeroExpSuccess(slot1.id, slot9, slot1.exp + slot7)

	slot0.addExpText_.text = string.format("+%d", slot7)
	slot15 = math.min(math.floor(slot10 / GameLevelSetting[slot9].hero_level_exp1 * 1000) / 1000, 0.9999)

	slot0:RemoveTween()

	slot0.heroExp_ = slot9 + slot15
	slot16 = LeanTween.value(slot0.expProgressBar_.gameObject, slot2 + math.min(math.floor(slot3 / GameLevelSetting[slot2].hero_level_exp1 * 1000) / 1000, 0.9999), slot9 + slot15, 6)
	slot16 = slot16:setEase(LeanTweenType.easeOutCubic)
	slot16 = slot16:setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0:UpdateHeroData(slot0)
	end))
	slot0.tweens_ = slot16:setOnComplete(LuaHelper.VoidAction(function ()
		uv0:RemoveTween()
	end))
end

function slot0.RemoveTween(slot0)
	if slot0.tweens_ then
		slot1:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot1.id)
	end
end

function slot0.UpdateHeroData(slot0, slot1)
	slot2, slot3 = math.modf(slot1)
	slot0.lvText_.text = string.format("%d", slot2)

	if LvTools.GetIsMaxLv(slot2, "hero") then
		slot0.expProgressBar_.value = 1
	else
		slot0.expProgressBar_.value = slot3
	end
end

function slot0.EndAnimator(slot0)
	slot0:RemoveTween()

	if not slot0.isLock_ then
		slot0:UpdateHeroData(slot0.heroExp_)
	end
end

return slot0
