slot0 = class("Guide_46", BaseGuide)

function slot0.InitSteps(slot0)
	slot1 = {}

	slot0:OnGuideStart()
	table.insert(slot1, 4601)
	table.insert(slot1, 4602)
	table.insert(slot1, 4603)

	if PolyhedronData:GetUnlockBeaconList() and #slot2 == 0 then
		table.insert(slot1, 4604)
		table.insert(slot1, 4605)
		table.insert(slot1, 4606)
		table.insert(slot1, 4607)
	end

	table.insert(slot1, 4608)
	table.insert(slot1, 4609)
	table.insert(slot1, 4610)
	table.insert(slot1, 4611)

	if PolyhedronData:GetUnlockHeroList() and #slot3 <= 1 then
		table.insert(slot1, 4612)
		table.insert(slot1, 4613)
		table.insert(slot1, 4614)
		table.insert(slot1, 4615)
		table.insert(slot1, 4616)
	end

	table.insert(slot1, 4617)
	table.insert(slot1, 4618)
	table.insert(slot1, 4619)
	table.insert(slot1, 4620)

	slot4 = 1

	for slot9, slot10 in ipairs(slot0._cfg.leaps) do
		slot12 = slot10[2]

		if GuideTool.SatisfyCondition({
			{
				"uiName",
				slot10[1]
			}
		}) then
			slot4 = slot12
		end
	end

	slot0._steps = {}

	for slot10 = slot4, #slot1 do
		if slot0:ProduceStep(slot1[slot10]) then
			table.insert(slot0._steps, slot12)
		end
	end
end

return slot0
