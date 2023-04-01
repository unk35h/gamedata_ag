slot0 = class("SectionSelectHeroMythicView", SectionSelectHeroBaseView)

function slot0.OnEnter(slot0)
	slot0.contID_ = slot0.params_.difficulty

	slot0.super.OnEnter(slot0)
end

function slot0.StartBattle(slot0)
	if MythicData:GetIsNew() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_REFRESH_DATA"),
			OkCallback = function ()
				JumpTools.OpenPageByJump("/mythic", nil)
			end
		})

		return
	end

	BattleController.GetInstance():LaunchBattle(BattleMythicStageTemplate.New(slot0.params_.partition, slot0.stageID_, slot0.params_.difficulty))
end

return slot0
