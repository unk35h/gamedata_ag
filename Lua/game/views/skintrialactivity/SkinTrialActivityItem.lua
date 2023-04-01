slot0 = class("SkinTrialAcitivteItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.adaptImg_ = slot0:FindCom("AdaptImage", nil, slot0.transform_)

	slot0:SetSkinTrialID(slot3)
	SetActive(slot0.gameObject_, true)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.SKIN_TRIAL, ActivitySkinTrialCfg[slot0.skinTrialID_].activity_id))
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if not ActivityData:GetActivityData(uv0.activityID_):IsActivitying() then
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

function slot0.SetSkinTrialID(slot0, slot1)
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.SKIN_TRIAL, ActivitySkinTrialCfg[slot1].activity_id))

	slot0.skinTrialID_ = slot1
	slot0.activityID_ = ActivitySkinTrialCfg[slot0.skinTrialID_].activity_id
	slot0.startTime_ = ActivityData:GetActivityData(slot0.activityID_).startTime
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = ActivitySkinTrialCfg[slot0.skinTrialID_]
	slot0.nameText_.text = slot1.name

	if getSpriteViaConfig("SkinTrialTextrues", HeroStandardSystemCfg[slot1.trial_id].skin_id) ~= nil then
		slot0.skinImage_.sprite = slot4

		slot0.adaptImg_:AdaptImg()
	end

	if SkinTrialData:IsCompleted(slot0.skinTrialID_) then
		slot0.stateController_:SetSelectedState("true")
	end
end

function slot0.RefreshTime(slot0)
	if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0.activityID_).startTime then
		SetActive(slot0.gameObject_, false)

		return
	end

	if ActivityData:GetActivityData(slot0.activityID_).stopTime <= manager.time:GetServerTime() then
		SetActive(slot0.gameObject_, false)

		return
	end

	SetActive(slot0.gameObject_, true)
end

return slot0
