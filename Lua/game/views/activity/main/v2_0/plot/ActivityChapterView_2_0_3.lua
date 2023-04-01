ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ActivityChapterView_2_0_3", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return "UI/VersionUI/XuHeng1stUI/XH1stPlotUI/XH1stPlot2UI"
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.chapterBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		if ChapterTools.IsFinishPreChapter(11113) then
			uv0:Go("/chapterSection", {
				chapterID = ChapterClientCfg[11113].chapter_list[1]
			})

			return
		end

		ShowTips("TIME_OVER")
	end)
end

return slot0
