slot0 = class("Guide_skuld", BaseGuide)

function slot0.CheckGuide(slot0)
	if not GuideTool.SatisfyCondition(slot0.open_condition) then
		return false
	end

	if not SkuldTravelData:GetSkuldTravelIsOpen() then
		return false
	end

	if gameContext:GetOpenPageHandler("skuldTravelView") then
		return true
	end

	if gameContext:GetOpenPageHandler("chapterSection") and not gameContext:IsOpenRoute("chapterSectionInfo") and slot1.chapterID_ and ChapterCfg[slot2] then
		return slot3.sub_type == 13
	end
end

return slot0
