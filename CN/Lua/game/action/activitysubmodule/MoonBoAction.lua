slot1 = manager.net

slot1:Bind(61005, function (slot0)
	MoonBoData:SetData(slot0)
end)

return {
	GetMoonBo = function (slot0)
		manager.net:SendWithLoadingNew(61006, {
			activity_id = ActivityConst.MOONBO
		}, 61007, handler(slot0, slot0.OnMoonBoReward))
	end,
	OnMoonBoReward = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			MoonBoData:GetRewards(slot1)
			manager.notify:Invoke(MOONBO_SUCCESS, {})
		else
			ShowTips(GetTips(slot1.result))
		end
	end
}
