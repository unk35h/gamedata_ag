slot0 = class("BossAdvanceTargetMultiple", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "Item")
	slot0.switchMultipleHandler_ = handler(slot0, slot0.SwitchMultiple)

	manager.notify:RegistListener(BOSS_CHALLENGE_CHOOSE_MULTIPLE, slot0.switchMultipleHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_CHOOSE_MULTIPLE, slot0.switchMultipleHandler_)

	slot0.switchMultipleHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		BattleBossChallengeAdvanceData:SetBossMultipleIndex(uv0.bossIndex_, uv0.index_)
		manager.notify:Invoke(BOSS_CHALLENGE_CHOOSE_MULTIPLE, uv0.index_)
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.bossIndex_ = slot1
	slot0.index_ = slot2

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:SwitchMultiple(BattleBossChallengeAdvanceData:GetBossList()[slot0.bossIndex_].multipleIndex)

	slot0.nameText_.text = string.format("%s%s", GetTips("HARDLEVEL"), GetTips(string.format("NUM_%s", slot0.index_)))
	slot0.pointText_.text = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].difficult_point[slot0.index_]
end

function slot0.SwitchMultiple(slot0, slot1)
	if slot0.index_ == slot1 then
		slot0.controller_:SetSelectedState("on")
	else
		slot0.controller_:SetSelectedState("off")
	end
end

return slot0
