slot0 = class("Guide_19", BaseGuide)

function slot0.InitSteps(slot0)
	slot1 = {}

	slot0:OnGuideStart()

	if SkuldTravelData:GetSkuldStatu() == 2 then
		table.insert(slot1, 2801)
		table.insert(slot1, 2802)
		table.insert(slot1, 2803)
	end

	table.insert(slot1, 2804)
	table.insert(slot1, 2805)
	table.insert(slot1, 2806)
	table.insert(slot1, 2807)
	table.insert(slot1, 2808)
	table.insert(slot1, 2809)
	table.insert(slot1, 2810)

	slot0._steps = {}

	for slot6 = 1, #slot1 do
		if slot0:ProduceStep(slot1[slot6]) then
			table.insert(slot0._steps, slot8)
		end
	end
end

function slot0.CheckGuide(slot0)
	if not GuideTool.SatisfyCondition(slot0.open_condition) then
		return false
	end

	if SkuldTravelData:GetSkuldStatu() == 2 then
		return gameContext:GetOpenPageHandler("skuldTravelResultView") ~= nil
	else
		return gameContext:GetOpenPageHandler("skuldTravelView") ~= nil
	end
end

return slot0
