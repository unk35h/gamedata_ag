slot1 = class("FactorySoloChallengeSelectItem", import("game.views.soloChallenge.SoloChallengeSelectItem"))

function slot1.Init(slot0)
	slot0.affixList_ = {}

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.heroSelectController = ControllerUtil.GetController(slot0.transform_, "heroSelect")
	slot0.lockStateController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.indexController_ = ControllerUtil.GetController(slot0.transform_, "index")
end

function slot1.RefreshTitle(slot0)
	slot0.indexController_:SetSelectedState(tostring(slot0.selectHeroPos_))
end

function slot1.RefreshEnemyUI(slot0)
	slot0.bossIcon_.sprite = getSpriteWithoutAtlas("Textures/MardukUI/boss/solo384x172/" .. ActivitySoloChallengeCfg[slot0.activityID_].boss_id_list[slot0.selectHeroPos_])
end

return slot1
