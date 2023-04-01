ActivityChessView = import("game.views.activity.Submodule.Chess.ActivityChessView")
slot0 = class("SummerChessView", ActivityChessView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerWarChessUI"
end

function slot0.AddUIListener(slot0)
end

function slot0.GetChessItemView(slot0)
	return SummerChessItemView
end

return slot0
