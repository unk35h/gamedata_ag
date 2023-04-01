slot1 = 0.4

return {
	PlayAnimationWithCallback = function (slot0, slot1, slot2)
		slot3 = false

		if not slot0:GetCurrentAnimatorStateInfo(0):IsName("ui_stand") then
			slot3 = (slot1 ~= "ui_stand" or false) and true
		end

		uv0.PlayAnimatorWithCallback(slot0, slot1, slot2, slot3)
	end,
	PlayAnimatorWithCallback = function (slot0, slot1, slot2, slot3)
		slot0.speed = 1

		if slot3 then
			uv0.CrossFade(slot0, slot1)
		else
			slot0.Play(slot0, slot1)
		end

		if uv0.timer_ ~= nil then
			uv0.timer_:Stop()
		end

		uv0.timer_ = Timer.New(function ()
			slot2 = (uv1 and uv2 or 0) / uv0:GetCurrentAnimatorStateInfo(0).length

			if slot0:IsName(uv3) and slot0.normalizedTime >= 1 - slot2 then
				if uv4.timer_ ~= nil then
					uv4.timer_:Stop()

					uv4.timer_ = nil
				end

				if uv5 ~= nil then
					uv5()
				end
			end
		end, 0.033, -1)

		uv0.timer_:Start()
	end,
	Stop = function ()
		if uv0.timer_ ~= nil then
			uv0.timer_:Stop()

			uv0.timer_ = nil
		end
	end,
	CrossFade = function (slot0, slot1)
		slot0.CrossFade(slot0, slot1, uv0 / slot0.GetCurrentAnimatorStateInfo(slot0, 0).length, 0)
	end
}
