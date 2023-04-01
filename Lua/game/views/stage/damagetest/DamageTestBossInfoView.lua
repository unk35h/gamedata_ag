slot1 = class("DamageTestBossInfoView", import("game.views.stage.bossChallenge.BattleBossInfoBaseView"))

function slot1.UIName(slot0)
	return "UI/DamageTest/DamageTestBossInformationUI"
end

function slot1.OnEnterExtend(slot0)
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_ADVANCE_DESC")
end

function slot1.OnEnter(slot0)
	manager.ui:SetMainCamera("bossChallenge")
	slot0:InitBackScene()

	slot0.exitView_ = false
	slot0.currentBossTemplateID_ = nil

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	slot0:OnEnterExtend()
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
end

function slot1.OnUpdate(slot0)
	uv0.super.OnUpdate(slot0)
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.startBattleBtn_, nil, function ()
		uv0:Go("/bossCombatSelect", {
			damageTestId = uv0.damageTestId_
		})
	end)
end

function slot1.RefreshData(slot0)
	slot0.damageTestId_ = slot0.params_.damageTestId
	slot0.templateID_ = DamageTestCfg[slot0.damageTestId_].boss_id
end

function slot1.RefreshLockHero(slot0)
end

function slot1.RefreshUI(slot0)
	slot0:RefreshText()
	slot0:LoadModel()
	slot0:RefreshSkill()
end

return slot1
