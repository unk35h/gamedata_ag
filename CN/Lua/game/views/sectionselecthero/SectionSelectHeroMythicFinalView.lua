slot0 = class("SectionSelectHeroMythicFinalView", SectionSelectHeroBaseView)

function slot0.StartBattle(slot0)
	if MythicData:GetIsNew() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_REFRESH_DATA"),
			OkCallback = function ()
				JumpTools.OpenPageByJump("/mythicUltimateView/mythicDifficulty", nil)
			end
		})

		return
	end

	slot0.super.StartBattle(slot0)
end

return slot0
