slot1 = class("StrategyMatrixThorStoryReviewView", import("game.views.matrixActivity.matrixActivity.ActivityMatrixStoryReviewView"))

function slot1.UIName(slot0)
	return "UI/EmptyDream/ThorRoguelike/ThorStoryReviewUI"
end

function slot1.OnEnter(slot0)
	slot0.storyList = {}

	if StrategyMatrixCfg[ActivityConst.STRATEGY_MATRIX_THOR].enter_story_id and slot3 ~= 0 and manager.story:IsStoryPlayed(slot3) then
		table.insert(slot0.storyList, slot3)
	end

	slot4 = StrategyMatrixData:GetIsClearance(ActivityConst.STRATEGY_MATRIX_THOR)

	for slot8, slot9 in ipairs(slot2.tier_story_list) do
		if slot4 or manager.story:IsStoryPlayed(slot9) then
			table.insert(slot0.storyList, slot9)
		end
	end

	slot0:Refresh()
end

return slot1
