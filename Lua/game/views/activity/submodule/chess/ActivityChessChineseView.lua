ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ActivityChessChineseView", ActivityMainBasePanel)
slot1 = "WARCHESS_INFO"

function slot0.GetUIName(slot0)
	return "UI/VersionUI/XuHeng1stUI/XH1stWarChessUI/XH1stWarChessUI"
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.chessBtn_, nil, function ()
		JumpTools.GoToSystem("/warChessStage", {
			firstChapter = 4040501,
			chapterClientID = 404
		}, ViewConst.SYSTEM_ID.WARCHESS)
	end)
end

return slot0
