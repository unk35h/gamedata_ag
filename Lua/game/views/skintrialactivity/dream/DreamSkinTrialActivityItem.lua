FactorySkinTrialActivityItem = import("game.views.skinTrialActivity.Factory.FactorySkinTrialActivityItem")
slot0 = class("DreamSkinTrialActivityItem", FactorySkinTrialActivityItem)

function slot0.RefreshTime(slot0)
	if manager.time:GetServerTime() < slot0.startTime_ then
		SetActive(slot0.gameObject_, false)

		return
	end

	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.textTime_.text = GetTips("TIME_OVER")

		SetActive(slot0.gameObject_, false)

		return
	end

	SetActive(slot0.gameObject_, true)

	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
end

return slot0
