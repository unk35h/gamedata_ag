slot1 = class("SectionSelectHeroActivityWorldBossView", import("game.views.sectionSelectHero.SectionSelectHeroBaseView"))

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.activity_id = slot0.params_.activityID
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot1.StartBattle(slot0)
	if not ActivityData:GetActivityIsOpen(slot0.activity_id) then
		ShowTips("TIME_OVER")

		return
	end

	BattleController.GetInstance():LaunchBattle(BattleActivityWorldBossTemplate.New(ActivityWorldBossData:GetStageId(slot0.activity_id), slot0.activity_id))
end

return slot1
