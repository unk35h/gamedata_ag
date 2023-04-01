slot0 = {}
slot1, slot2 = nil
slot3 = handler(slot0, slot0.StopCallback)

function slot0.StopCallback()
	uv0.stopped = uv0.stopped - uv1.StopCallback
	uv0.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Loop

	if uv2 ~= nil then
		uv2()

		uv2 = nil
	end

	uv0 = nil
end

function slot0.PlayTimelineWithCallback(slot0, slot1, slot2)
	if uv0 ~= nil then
		uv0.stopped = uv0.stopped - uv1.StopCallback
	end

	uv0 = slot0
	uv2 = slot2

	slot0:Play(slot1)

	slot0.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.None
	slot0.time = 0
	slot0.stopped = slot0.stopped + uv1.StopCallback
end

return slot0
