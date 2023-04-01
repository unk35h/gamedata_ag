slot0 = class("ChallengeView", import("..daily.DailyView"))
slot1 = import("game.const.BattleConst")

function slot0.GetSectionItemClass(slot0)
	return ChallengeItem
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("challengeSectionInfo")
end

return slot0
