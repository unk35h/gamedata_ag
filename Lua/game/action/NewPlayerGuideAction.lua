slot0 = manager.net

slot0:Bind(12011, function (slot0)
	GuideData:InitGuideData(slot0)
end)

slot1 = {}

return {
	GuideUpdateID = function (slot0)
		if not GuideData:IsFinish(slot0) then
			GuideData:FinishGuideID(slot0)
			manager.net:SendWithLoadingNew(12012, {
				mod_guide_id = slot0
			}, 12013)
		end
	end,
	GuideUpdateIDEnd = function (slot0, slot1)
		uv0[slot0] = slot1

		GuideData:FinishGuideID(slot0)
		manager.net:SendWithLoadingNew(12012, {
			mod_guide_id = slot0
		}, 12013, NewPlayerGuideAction.OnGuideUpdateIDEndCallBack)
	end,
	OnGuideUpdateIDEndCallBack = function (slot0, slot1)
		SDKTools.SendMessageToSDK("guide_complete", {
			guide_id = slot1.mod_guide_id,
			use_time = uv0[slot1.mod_guide_id] or 0
		})
	end,
	GuideUpdateNode = function (slot0)
		manager.net:SendSyncNoEnqueue(38012, {
			guide_id = slot0
		}, 38013)
	end
}
