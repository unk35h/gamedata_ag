slot1 = manager.net

slot1:Bind(11035, function (slot0)
	HeroTrialData:InitData(slot0)
	manager.notify:Invoke(HERO_TRIAL_UPDATE)
end)

return {
	GetTrialReward = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(11036, {
			id = slot0
		}, 11037, function (slot0)
			if isSuccess(slot0.result) then
				HeroTrialData:ReceiveReward(uv0)
			end

			uv1(slot0)
		end)
	end
}
