slot0 = class("Guide_14", BaseGuide)

function slot0.InitSteps(slot0)
	slot1 = {}

	slot0:OnGuideStart()
	table.insert(slot1, 1101)
	table.insert(slot1, 1102)
	table.insert(slot1, 1103)

	if MythicData:IsShowDifficultySelectView_Guide() then
		table.insert(slot1, 1104)
	end

	table.insert(slot1, 1105)

	slot2 = 1

	for slot7, slot8 in ipairs(slot0._cfg.leaps) do
		slot10 = slot8[2]

		if GuideTool.SatisfyCondition({
			{
				"uiName",
				slot8[1]
			}
		}) then
			slot2 = slot10
		end
	end

	slot0._steps = {}

	for slot8 = slot2, #slot1 do
		if slot0:ProduceStep(slot1[slot8]) then
			table.insert(slot0._steps, slot10)
		end
	end
end

return slot0
