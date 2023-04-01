slot0 = class("BossAdvanceTargetAffix", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.chooseConditionHandler_ = handler(slot0, slot0.ChooseCondition)

	manager.notify:RegistListener(BOSS_CHALLENGE_CHOOSE_CONDITION, slot0.chooseConditionHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_CHOOSE_CONDITION, slot0.chooseConditionHandler_)

	slot0.chooseConditionHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		BattleBossChallengeAdvanceData:SetBossCondition(uv0.bossIndex_, uv0.itemType_, uv0.id_)
		manager.notify:Invoke(BOSS_CHALLENGE_CHOOSE_CONDITION, {
			itemType = uv0.itemType_,
			id = uv0.id_
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.bossIndex_ = slot1
	slot0.itemType_ = slot2
	slot0.id_ = slot3

	if slot0.itemType_ == BossConst.TYPE_STAGE then
		slot4 = StageChallengeConditionPoolCfg[slot3]
		slot0.descText_.text = BattleInstance.GetStarMissionText(slot4.condition[1], slot4.condition[2], slot4.condition[3])
		slot0.pointText_.text = slot4.point
	elseif slot0.itemType_ == BossConst.TYPE_BOSS_AI then
		slot0.descText_.text = BossAIPoolCfg[slot3].desc
		slot0.pointText_.text = BossAIPoolCfg[slot3].point
	else
		slot4 = ActivityAffixPoolCfg[slot3]
		slot0.descText_.text = getAffixDesc(slot4.affix)
		slot0.pointText_.text = slot4.point
	end

	slot0:ChooseCondition({
		itemType = slot2,
		id = slot3
	})
end

function slot0.ChooseCondition(slot0, slot1)
	slot0:RefreshMutex(slot1)
end

function slot0.RefreshMutex(slot0, slot1)
	if slot0.itemType_ == slot1.itemType then
		if slot0.itemType_ == BossConst.TYPE_STAGE then
			slot0:RefreshMutexStage()
		elseif slot0.itemType_ == BossConst.TYPE_BOSS_AI then
			slot0:RefreshMutexBossAI()
		else
			slot0:RefreshMutexAffix()
		end
	end
end

function slot0.RefreshMutexStage(slot0)
	slot1 = StageChallengeConditionPoolCfg[slot0.id_]
	slot6 = slot0.itemType_

	for slot6, slot7 in ipairs(BattleBossChallengeAdvanceData:GetBossAffixList(slot0.bossIndex_, slot6)) do
		if slot0.id_ ~= slot7 and slot1.condition[1] == StageChallengeConditionPoolCfg[slot7].condition[1] then
			slot0.controller_:SetSelectedState("not")

			return
		elseif slot0.id_ == slot7 then
			slot0.controller_:SetSelectedState("true")

			return
		end
	end

	slot0.controller_:SetSelectedState("false")
end

function slot0.RefreshMutexBossAI(slot0)
	slot1 = BossAIPoolCfg[slot0.id_]
	slot6 = slot0.itemType_

	for slot6, slot7 in ipairs(BattleBossChallengeAdvanceData:GetBossAffixList(slot0.bossIndex_, slot6)) do
		if slot0.id_ ~= slot7 and slot1.group == BossAIPoolCfg[slot7].group then
			slot0.controller_:SetSelectedState("not")

			return
		elseif slot0.id_ == slot7 then
			slot0.controller_:SetSelectedState("true")

			return
		end
	end

	slot0.controller_:SetSelectedState("false")
end

function slot0.RefreshMutexAffix(slot0)
	slot1 = ActivityAffixPoolCfg[slot0.id_]
	slot6 = slot0.itemType_

	for slot6, slot7 in ipairs(BattleBossChallengeAdvanceData:GetBossAffixList(slot0.bossIndex_, slot6)) do
		if slot0.id_ ~= slot7 and slot1.affix[1] == ActivityAffixPoolCfg[slot7].affix[1] then
			slot0.controller_:SetSelectedState("not")

			return
		elseif slot0.id_ == slot7 then
			slot0.controller_:SetSelectedState("true")

			return
		end
	end

	slot0.controller_:SetSelectedState("false")
end

return slot0
