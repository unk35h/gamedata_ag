slot0 = class("Guide_14", BaseGuide)

function slot0.InitSteps(slot0)
	slot1 = {}

	slot0:OnGuideStart()
	table.insert(slot1, 1401)
	table.insert(slot1, 1402)
	table.insert(slot1, 1403)

	if MatrixData:GetUnlockBeaconList() and #slot2 == 0 then
		table.insert(slot1, 1404)
		table.insert(slot1, 1405)
		table.insert(slot1, 1406)
		table.insert(slot1, 1407)
	end

	table.insert(slot1, 1408)
	table.insert(slot1, 1409)
	table.insert(slot1, 1410)
	table.insert(slot1, 1411)
	table.insert(slot1, 1412)
	table.insert(slot1, 1413)
	table.insert(slot1, 1414)
	table.insert(slot1, 1415)

	slot3 = 1

	for slot8, slot9 in ipairs(slot0._cfg.leaps) do
		slot11 = slot9[2]

		if GuideTool.SatisfyCondition({
			{
				"uiName",
				slot9[1]
			}
		}) then
			slot3 = slot11
		end
	end

	slot0._steps = {}

	for slot9 = slot3, #slot1 do
		if slot0:ProduceStep(slot1[slot9]) then
			table.insert(slot0._steps, slot11)
		end
	end
end

return slot0
