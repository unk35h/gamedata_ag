slot0 = class("SkinTrialSelectItem_2_0", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.SKIN_TRIAL, ActivitySkinTrialCfg[slot0.skinTrialID_].activity_id))

	slot0.outOfDataHandler_ = nil
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
		SkinTrialTools.GoToSelectView(uv0.activityID_, uv0.skinTrialID_)
	end)
end

function slot0.SetSkinTrialID(slot0, slot1)
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.SKIN_TRIAL, ActivitySkinTrialCfg[slot1].activity_id))

	slot0.skinTrialID_ = slot1
	slot0.activityID_ = ActivitySkinTrialCfg[slot0.skinTrialID_].activity_id
	slot0.startTime_ = ActivityData:GetActivityData(slot0.activityID_).startTime
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:RefreshUI()
	slot0:RefreshTime()
end

function slot0.RefreshUI(slot0)
	slot2 = ActivitySkinTrialCfg[slot0.skinTrialID_].trial_id
	slot3 = HeroStandardSystemCfg[slot2].skin_id
	slot4 = HeroStandardSystemCfg[slot2].hero_id
	slot0.heroNameText_.text = string.format("%s·%s", HeroCfg[slot4].name, HeroCfg[slot4].suffix)
	slot0.nameText_.text = string.format("- %s -", SkinCfg[slot3].name)

	if getSpriteWithoutAtlas("Textures/Character/Portrait/" .. SkinCfg[slot3].picture_id) ~= nil then
		slot0.skinImage_.sprite = slot5
	end
end

function slot0.RefreshTime(slot0)
	if manager.time:GetServerTime() < slot0.startTime_ or slot0.stopTime_ <= manager.time:GetServerTime() then
		SetActive(slot0.gameObject_, false)
		slot0.outOfDataHandler_()

		return
	end

	SetActive(slot0.gameObject_, true)

	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
end

function slot0.SetOutOfDataHandler(slot0, slot1)
	slot0.outOfDataHandler_ = slot1
end

return slot0
