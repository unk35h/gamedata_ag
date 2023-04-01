return {
	StartAfterSeconds = function (slot0, slot1, slot2)
		function slot4()
			if uv0 ~= nil then
				uv1(unpack(uv2))
				uv0:Stop()

				uv0 = nil
			end
		end

		if nil ~= nil then
			slot3.Reset(slot3)
		else
			Timer.New(slot4, slot0, 1):Start()
		end

		return slot3
	end
}
