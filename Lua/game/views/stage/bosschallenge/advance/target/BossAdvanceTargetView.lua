slot0 = class("BossAdvanceTargetView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BossChallenge/BossCombatUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.hardList_ = LuaList.New(handler(slot0, slot0.RefreshMultipleItem), slot0.hardUIList_, BossAdvanceTargetMultiple)
	slot0.affixList_ = LuaList.New(handler(slot0, slot0.RefreshAffixItem), slot0.affixUIList_, BossAdvanceTargetCondition)
	slot0.chooseConditionHandler_ = handler(slot0, slot0.ChooseCondition)
	slot0.challengeUpdateHandler_ = handler(slot0, slot0.UpdateBossChallenge)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistHomeCallBack(function ()
		uv0:SaveTargerData(function ()
			uv0:Go("/home")
		end)
	end)
	manager.windowBar:RegistBackCallBack(function ()
		uv0:SaveTargerData(function ()
			uv0:Back()
		end)
	end)
	BossTools.CheckTimeout()

	slot0.bossIndex_ = slot0.params_.bossIndex

	slot0:RefreshData()
	slot0:RefreshUI()
	slot0.hardList_:StartScroll(#BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].difficult_point, 1)

	slot3 = slot0.cfg_

	slot0.affixList_:StartScroll(#slot3.time_pool + #slot3.boss_ai_pool + #slot3.affix_pool, 1)
	manager.notify:RegistListener(BOSS_CHALLENGE_CHOOSE_CONDITION, slot0.chooseConditionHandler_)
	manager.notify:RegistListener(BOSS_CHALLENGE_CHOOSE_MULTIPLE, slot0.chooseConditionHandler_)
	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, slot0.challengeUpdateHandler_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(BOSS_CHALLENGE_CHOOSE_CONDITION, slot0.chooseConditionHandler_)
	manager.notify:RemoveListener(BOSS_CHALLENGE_CHOOSE_MULTIPLE, slot0.chooseConditionHandler_)
	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, slot0.challengeUpdateHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.challengeUpdateHandler_ = nil
	slot0.chooseConditionHandler_ = nil

	if slot0.hardList_ then
		slot0.hardList_:Dispose()

		slot0.hardList_ = nil
	end

	if slot0.affixList_ then
		slot0.affixList_:Dispose()

		slot0.affixList_ = nil
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		slot0 = uv0

		slot0:SaveTargerData(function (slot0)
			if isSuccess(slot0.result) then
				uv0:Go("/sectionSelectHeroBoss", {
					section = BossChallengeAdvancePoolCfg[uv0.poolID_].stage_id,
					bossIndex = uv0.bossIndex_,
					sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE
				})
			end
		end)
	end)
end

function slot0.RefreshData(slot0)
	slot1 = BattleBossChallengeAdvanceData:GetBossList()[slot0.bossIndex_]
	slot0.bossID_ = slot1.templateID
	slot0.poolID_ = slot1.id
	slot0.cfg_ = BossChallengeAdvancePoolCfg[slot0.poolID_]
end

function slot0.RefreshUI(slot0)
	slot1 = BossChallengeUICfg[slot0.bossID_]
	slot0.bossImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossLittlePaint.path, slot1.icon))
	slot0.bossAffixText_.text = getAffixDesc(slot1.custom_affix)

	slot0:ChooseCondition()
end

function slot0.UpdateBossChallenge(slot0)
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function slot0.RefreshMultipleItem(slot0, slot1, slot2)
	slot2:SetData(slot0.bossIndex_, slot1)
end

function slot0.RefreshAffixItem(slot0, slot1, slot2)
	slot4, slot5 = nil

	if slot1 <= #slot0.cfg_.time_pool then
		slot4 = BossConst.TYPE_STAGE
		slot5 = slot3.time_pool[slot1]
	elseif slot1 <= #slot3.time_pool + #slot3.boss_ai_pool then
		slot4 = BossConst.TYPE_BISS_AI
		slot5 = slot3.boss_ai_pool[slot1 - #slot3.time_pool]
	else
		slot4 = BossConst.TYPE_AFFIX
		slot5 = slot3.affix_pool[slot1 - #slot3.time_pool - #slot3.boss_ai_pool]
	end

	slot2:SetData(slot0.bossIndex_, slot4, slot5)
end

function slot0.ChooseCondition(slot0)
	slot0.pointText_.text = BattleBossChallengeAdvanceData:GetPointValue(slot0.bossIndex_)
	slot4 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].monster_value[BattleBossChallengeAdvanceData:GetBossList()[slot0.bossIndex_].multipleIndex]
	slot0.bossAttackText_.text = string.format("+%s%%", slot4[1] / 10 - 100)
	slot0.bossHpText_.text = string.format("+%s%%", slot4[3] / 10 - 100)
end

function slot0.SaveTargerData(slot0, slot1)
	slot2 = BattleBossChallengeAdvanceData
	slot2 = slot2:GetBossList()[slot0.bossIndex_]
	slot3 = slot2.multipleIndex
	slot4 = clone(slot2.condition)

	BattleBossChallengeAction.ModifySelectAffix(slot2.id, slot2.multipleIndex, slot2.condition[BossConst.TYPE_STAGE], slot2.condition[BossConst.TYPE_BOSS_AI], slot2.condition[BossConst.TYPE_AFFIX], function (slot0)
		if isSuccess(slot0.result) then
			BattleBossChallengeAdvanceData:SetBossTarget(uv0.bossIndex_, uv1, uv2)
		else
			ShowTips(slot0.result)
		end

		uv3(slot0)
	end)
end

return slot0
