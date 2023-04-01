slot0 = setmetatable
slot1 = UpdateBeat
slot2 = CoUpdateBeat
slot3 = Time
Timer = {}
slot4 = Timer
slot5 = {
	__index = slot4
}

function slot6(slot0, slot1)
	return function ()
		uv0.running = false
		uv0.timeout = true

		if uv1 then
			uv1()
		end
	end
end

function slot4.New(slot0, slot1, slot2, slot3)
	slot2 = slot2 or 1
	slot4 = {
		func = slot0,
		duration = slot1,
		loop = slot2,
		unscaled = slot3,
		id = FuncTimerManager.inst:CreateFuncTimer(uv0(slot4, slot0), slot1, slot2, false)
	}

	return uv1(slot4, uv2)
end

function slot4.Start(slot0)
	slot0.running = true

	FuncTimerManager.inst:StartFuncTimer(slot0.id)
end

function slot4.Reset(slot0)
	FuncTimerManager.inst:ResetFuncTimer(slot0.id)
end

function slot4.Stop(slot0)
	if slot0.running then
		slot0.running = false
		slot0.timeout = false
	end

	FuncTimerManager.inst:RemoveFuncTimer(slot0.id)
end

function slot4.QueryTime(slot0)
	return FuncTimerManager.inst:QueryTotalTime(slot0.id)
end

function slot4.Update(slot0)
	if not slot0.running then
		return
	end

	slot0.time = slot0.time - (slot0.unscaled and uv0.unscaledDeltaTime or uv0.deltaTime)

	if slot0.time <= 0 then
		slot0.func()

		if slot0.loop > 0 then
			slot0.loop = slot0.loop - 1
			slot0.time = slot0.time + slot0.duration
		end

		if slot0.loop == 0 then
			slot0:Stop()
		elseif slot0.loop < 0 then
			slot0.time = slot0.time + slot0.duration
		end
	end
end

function slot4.IsRunning(slot0)
	return slot0.running
end

function slot4.HasStarted(slot0)
	return slot0.running ~= nil
end

FrameTimer = {}
slot7 = FrameTimer
slot8 = {
	__index = slot7
}

function slot7.New(slot0, slot1, slot2)
	return uv1({
		running = false,
		func = slot0,
		loop = slot2 or 1,
		duration = slot1,
		count = uv0.frameCount + slot1
	}, uv2)
end

function slot7.Reset(slot0, slot1, slot2, slot3)
	slot0.func = slot1
	slot0.duration = slot2
	slot0.loop = slot3
	slot0.count = uv0.frameCount + slot2
end

function slot7.Start(slot0)
	if not slot0.handle then
		slot0.handle = uv0:CreateListener(slot0.Update, slot0)
	end

	uv0:AddListener(slot0.handle)

	slot0.running = true
end

function slot7.Stop(slot0)
	slot0.running = false

	if slot0.handle then
		uv0:RemoveListener(slot0.handle)
	end
end

function slot7.Update(slot0)
	if not slot0.running then
		return
	end

	if slot0.count <= uv0.frameCount then
		slot0.func()

		if slot0.loop > 0 then
			slot0.loop = slot0.loop - 1
		end

		if slot0.loop == 0 then
			slot0:Stop()
		else
			slot0.count = uv0.frameCount + slot0.duration
		end
	end
end

CoTimer = {}
slot9 = CoTimer
slot10 = {
	__index = slot9
}

function slot9.New(slot0, slot1, slot2)
	return uv0({
		running = false,
		duration = slot1,
		loop = slot2 or 1,
		func = slot0,
		time = slot1
	}, uv1)
end

function slot9.Start(slot0)
	if not slot0.handle then
		slot0.handle = uv0:CreateListener(slot0.Update, slot0)
	end

	slot0.running = true

	uv0:AddListener(slot0.handle)
end

function slot9.Reset(slot0, slot1, slot2, slot3)
	slot0.duration = slot2
	slot0.loop = slot3 or 1
	slot0.func = slot1
	slot0.time = slot2
end

function slot9.Stop(slot0)
	slot0.running = false

	if slot0.handle then
		uv0:RemoveListener(slot0.handle)
	end
end

function slot9.Update(slot0)
	if not slot0.running then
		return
	end

	if slot0.time <= 0 then
		slot0.func()

		if slot0.loop > 0 then
			slot0.loop = slot0.loop - 1
			slot0.time = slot0.time + slot0.duration
		end

		if slot0.loop == 0 then
			slot0:Stop()
		elseif slot0.loop < 0 then
			slot0.time = slot0.time + slot0.duration
		end
	end

	slot0.time = slot0.time - uv0.deltaTime
end
