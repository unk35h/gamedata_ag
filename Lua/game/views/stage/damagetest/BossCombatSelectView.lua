slot0 = class("BossCombatSelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/DamageTest/BossCombatSelectUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.affixList_ = LuaList.New(handler(slot0, slot0.RefreshAffixItem), slot0.affixUIList_, DamageTestConditionItem)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.damageTestId_ = slot0.params_.damageTestId

	slot0:RefreshUI()

	slot1 = DamageTestCfg[slot0.damageTestId_]

	slot0.affixList_:StartScroll(#slot1.time_pool + #slot1.boss_ai_pool + #slot1.affix_pool, 1)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.chooseConditionHandler_ = nil

	if slot0.affixList_ then
		slot0.affixList_:Dispose()

		slot0.affixList_ = nil
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		uv0:Go("/sectionSelectHero", {
			section = DamageTestCfg[uv0.damageTestId_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST,
			activityID = uv0.damageTestId_
		})
	end)
end

function slot0.RefreshUI(slot0)
	slot0.bossImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossLittlePaint.path, BossChallengeUICfg[DamageTestCfg[slot0.damageTestId_].boss_id].icon))
end

function slot0.RefreshAffixItem(slot0, slot1, slot2)
	slot4, slot5 = nil

	if slot1 <= #DamageTestCfg[slot0.damageTestId_].time_pool then
		slot4 = BossConst.TYPE_STAGE
		slot5 = slot3.time_pool[slot1]
	elseif slot1 <= #slot3.time_pool + #slot3.boss_ai_pool then
		slot4 = BossConst.TYPE_BISS_AI
		slot5 = slot3.boss_ai_pool[slot1 - #slot3.time_pool]
	else
		slot4 = BossConst.TYPE_AFFIX
		slot5 = slot3.affix_pool[slot1 - #slot3.time_pool - #slot3.boss_ai_pool]
	end

	slot2:SetData(slot0.damageTestId_, slot4, slot5)
end

return slot0
