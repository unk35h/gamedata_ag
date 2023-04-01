ActivityChessItem = import("game.views.activity.Submodule.Chess.ActivityChessItem")
slot0 = class("SummerChessItemView", ActivityChessItem)

function slot0.RefreshUI(slot0)
	slot1 = ChessTools.GetChapterProgress(slot0.chapterID_)
	slot0.imageProgress_.fillAmount = slot1 / 100
	slot0.textProress_.text = string.format("%s%%", slot1)
	slot0.textName_.text = WarchessLevelCfg[slot0.chapterID_].name_level
end

return slot0
