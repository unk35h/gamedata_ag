slot0 = class("GCManager")

function slot0.Ctor(slot0)
	slot0.gctick = 0
	slot0.gccost = 0
	slot0.running = false
end

function slot0.Collect(slot0, slot1)
	slot0:InAdvance()

	if not slot1 then
		collectgarbage("collect")
	elseif not slot0.running then
		slot0.running = true

		slot0:CalcStep()

		slot0.gctick = 0
		slot0.gccost = 0

		if not slot0.handle then
			slot0.handle = UpdateBeat:CreateListener(slot0.Update, slot0)
		end

		UpdateBeat:AddListener(slot0.handle)
	end
end

function slot0.InAdvance(slot0)
end

function slot0.Afterward(slot0)
	LuaHelper.UnityGC()
end

function slot0.CollectStep(slot0)
	slot1 = os.clock()

	if collectgarbage("step", slot0.step) then
		slot0.running = false

		if slot0.handle then
			UpdateBeat:RemoveListener(slot0.handle)

			slot0.handle = nil
		end

		slot0:Afterward()
	else
		slot2 = os.clock() * 1000 - slot1 * 1000
		slot0.gccost = slot0.gccost > 0 and (slot0.gccost + slot2) * 0.5 or slot2
		slot0.gctick = slot0.gctick + 1

		if slot0.gctick > 300 and slot0.gctick % 30 == 0 then
			slot0:CalcStep()
		end
	end
end

function slot0.CalcStep(slot0)
	slot0.step = math.max(slot0.gctick - 60, 30) / 30 * 150 * math.max(1 - math.max(slot0.gccost - 3, 0) * 0.1, 0.1)
end

return slot0
