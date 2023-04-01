slot0 = class("SkinTrialSelect110", SkinTrialActivitySelectView)

function slot0.UIName(slot0)
	return "UI/MardukUI/skinTrial/MardukSkinTrialUI_" .. slot0.params_.skinTrialID
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.startTime_ = ActivityData:GetActivityData(slot0.activityID_).startTime
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime
	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)

	slot0:AddTimer()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnBattle_, nil, function ()
		SkinTrialData:SaveStageID(uv0.skinTrialID_)

		if not ActivityData:GetActivityData(uv0.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		uv0:Go("/sectionSelectHero", {
			section = ActivitySkinTrialCfg[uv0.skinTrialID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL,
			activityID = uv0.activityID_
		})
	end)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.RefreshUI(slot0)
	slot3 = ActivitySkinTrialCfg[slot0.skinTrialID_].trial_id
	slot5 = HeroStandardSystemCfg[slot3].hero_id
	slot0.heroNameText_.text = string.format("%s·%s", HeroCfg[slot5].name, HeroCfg[slot5].suffix)
	slot0.skinDescText_.text = SkinCfg[HeroStandardSystemCfg[slot3].skin_id].desc

	slot0:RefreshReward()
end

function slot0.GetRewardItem(slot0)
	return FactorySkinTrialRewardItem
end

function slot0.GetCommonItem(slot0, slot1)
	return slot1:GetCommonItem()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.rewardCfg_[slot1], slot0.popType_, slot0.skinTrialID_)
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		uv0.textTime_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
