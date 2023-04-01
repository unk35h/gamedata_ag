slot0 = class("RaceTrailBattleItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.raceCon_ = ControllerUtil.GetController(slot0.transform_, "race")
	slot0.viewCon_ = ControllerUtil.GetController(slot0.transform_, "view")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if manager.time:GetServerTime() < uv0.openTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), uv0:GetTimeText(uv0.openTime_ - manager.time:GetServerTime())))

			return
		end

		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("/raceTrailReady", {
			activityID = uv0.activityID_,
			mainActivityID = uv0.mainActivityID_
		})
		RaceTrailData:SetBattleRedPointOn(false, uv0.activityID_)
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.cfg_ = ActivityRaceTrialCfg[slot0.activityID_]
	slot0.data_ = RaceTrailData:GetBattleData(slot0.activityID_) or {}
	slot0.mainActivityID_ = slot2
	slot3 = ActivityData:GetActivityData(slot0.activityID_)
	slot0.openTime_ = slot3.startTime
	slot0.endTime_ = slot3.stopTime

	slot0.raceCon_:SetSelectedState(tostring(slot0.cfg_.race))

	if slot0.nameText_ then
		slot0.nameText_.text = ActivityRaceTrialCfg[slot0.activityID_].name
	end

	if slot0.openTime_ <= manager.time:GetServerTime() and slot4 < slot0.endTime_ then
		slot0:RefreshOpen()
	else
		slot0:RefreshClose()
	end

	if manager.redPoint:getTipValue(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, slot0.mainActivityID_, slot0.activityID_)) > 0 then
		SetActive(slot0.redGo_, true)
	else
		SetActive(slot0.redGo_, false)
	end
end

function slot0.RefreshOpen(slot0)
	if slot0.data_.point > 0 then
		slot0.viewCon_:SetSelectedState("open")

		slot0.scoreText_.text = slot0.data_.point
	else
		slot0.viewCon_:SetSelectedState("none")
	end
end

function slot0.RefreshClose(slot0)
	slot0.viewCon_:SetSelectedState("close")

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.endTime_ <= manager.time:GetServerTime() then
		slot0.timeCntText_.text = GetTips("TIME_OVER")

		return
	end

	slot0.timeCntText_.text = string.format(GetTips("OPEN_TIME"), slot0:GetTimeText(slot0.openTime_ - manager.time:GetServerTime()))
	slot0.timer_ = Timer.New(function ()
		uv0 = uv1.openTime_ - manager.time:GetServerTime()

		if uv0 <= 0 then
			uv1.timer_:Stop()

			uv1.timer_ = nil

			uv1:RefreshUI(uv1.activityID_, uv1.mainActivityID_)
		end

		uv1.timeCntText_.text = string.format(GetTips("OPEN_TIME"), uv1:GetTimeText(uv0))
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.GetTimeText(slot0, slot1)
	slot2 = ""

	return slot1 / 86400 >= 1 and math.ceil(slot1 / 86400) .. GetTips("DAY") or slot1 / 3600 >= 1 and math.ceil(slot1 / 3600) .. GetTips("HOUR") or slot1 / 60 >= 1 and math.ceil(slot1 / 60) .. GetTips("MINUTE") or 1 .. GetTips("MINUTE")
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
