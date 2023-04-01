slot0 = class("SectionSelectHeroMythicView", SectionSelectHeroBaseView)

function slot0.StartBattle(slot0)
	slot2 = slot0.params_.activityID

	if not ActivityData:GetActivityIsOpen(slot0.params_.region_activity_id) then
		ShowTips("TIP_EXPIRED")

		return
	end

	BattleController.GetInstance():LaunchBattle(BattleSlayerStageTemplate.New(slot1, slot2))
end

return slot0
