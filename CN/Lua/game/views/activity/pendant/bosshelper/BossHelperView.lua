slot1 = class("BossHelperView", import("game.views.prompt.GameHelpProView"))

function slot1.UIName(slot0)
	return "UI/VolumeIIIUI/VolumeGameHelpPro"
end

function slot1.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot1.AddUIListeners(slot0)
	uv0.super.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		BattleBossChallengeAction.EnterBossChallenge()
	end)
end

return slot1
