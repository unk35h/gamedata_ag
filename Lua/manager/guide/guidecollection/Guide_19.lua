slot0 = class("Guide_19", BaseGuide)

function slot0.InitSteps(slot0)
	slot1 = {}

	slot0:OnGuideStart()
	table.insert(slot1, 1901)
	table.insert(slot1, 1902)
	table.insert(slot1, 1903)
	table.insert(slot1, 1904)
	table.insert(slot1, 1905)

	if not table.keyof(ChipData:GetUnlockChipManagerIDList(), 6) then
		table.insert(slot1, 1906)
	end

	table.insert(slot1, 1907)
	table.insert(slot1, 1908)
	table.insert(slot1, 1909)

	if not table.keyof(ChipData:GetUnlockChipIDList(), 105) then
		table.insert(slot1, 1910)
	end

	if not ChipData:GetChipManagerList() or not slot2[6] or not table.indexof(slot2[6], 105) then
		table.insert(slot1, 1911)
	end

	table.insert(slot1, 1912)

	if ChipData:GetEnabledChipManagerID() ~= 6 then
		table.insert(slot1, 1913)
	end

	table.insert(slot1, 1914)
	table.insert(slot1, 1915)

	slot0._steps = {}

	for slot7 = 1, #slot1 do
		if slot0:ProduceStep(slot1[slot7]) then
			table.insert(slot0._steps, slot9)
		end
	end
end

return slot0
