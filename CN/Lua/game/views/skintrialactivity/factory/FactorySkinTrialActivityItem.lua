SkinTrialActivityItem = import("game.views.skinTrialActivity.SkinTrialActivityItem")
slot0 = class("FactorySkinTrialActivityItem", SkinTrialActivityItem)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")

	slot0:SetSkinTrialID(slot2)
	SetActive(slot0.gameObject_, true)
end

function slot0.RefreshUI(slot0)
	if SkinTrialData:IsCompleted(slot0.skinTrialID_) then
		slot0.stateController_:SetSelectedState("true")
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if manager.time:GetServerTime() < uv0.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0.startTime_)))

			return
		end

		if uv0.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		SkinTrialData:SetSelectSkinTrialID(uv0.activityID_, uv0.skinTrialID_)

		if uv0.path_ == nil then
			uv0.path_ = string.format("/skinTrialSelect%d", uv0.skinTrialID_)
		end

		uv0:Go(uv0.path_, {
			canPlayAnim = true,
			activityID = uv0.activityID_,
			skinTrialID = uv0.skinTrialID_
		})
	end)
end

return slot0
