slot0 = class("Guide_15", BaseGuide)

function slot0.InitSteps(slot0)
	slot0:OnGuideStart()
	table.insert({}, 1501)

	if MatrixData:GetMatrixPhaseData() and slot2:GetPhase() == 1 then
		table.insert(slot1, 1502)
	end

	slot0._steps = {}

	for slot7 = 1, #slot1 do
		if slot0:ProduceStep(slot1[slot7]) then
			table.insert(slot0._steps, slot9)
		end
	end
end

return slot0
