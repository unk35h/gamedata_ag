slot0 = class("SkadiLittleGameItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.chapterID_ = slot2
	slot0.activityID_ = slot3

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.starController_ = ControllerUtil.GetController(slot0.starsGo_.transform, "name")
end

function slot0.OnEnter(slot0)
	slot0.name1Text_.text = ActivityCrossWaveCfg[slot0.chapterID_].name
	slot0.name2Text_.text = ActivityCrossWaveCfg[slot0.chapterID_].name

	slot0:AddTimer()
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s_%s", RedPointConst.LEVIATHAN_GAME, ActivityConst.LEVIATHAN_GAME, slot0.activityID_))
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s_%s", RedPointConst.LEVIATHAN_GAME, ActivityConst.LEVIATHAN_GAME, slot0.activityID_))
end

function slot0.Dispose(slot0)
	slot0.transform_ = nil
	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnBtn_, nil, function ()
		if manager.time:GetServerTime() < uv0:GetOpenTimestamp() then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0:GetOpenTimestamp())))

			return
		end

		uv0:Go("skadiSectionInfo", {
			activityID = uv0.activityID_,
			chapterID = uv0.chapterID_,
			section = ActivityCrossWaveCfg[uv0.chapterID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKADI_GAME
		})
	end)
end

function slot0.GetOpenTimestamp(slot0)
	return ActivityData:GetActivityData(slot0.chapterID_).startTime or 0
end

function slot0.GetStopTimestamp(slot0)
	return ActivityData:GetActivityData(slot0.chapterID_).stop_time
end

function slot0.AddTimer(slot0)
	slot0:RefreshState()

	if manager.time:GetServerTime() - slot0:GetOpenTimestamp() >= 0 then
		return
	end

	slot0.countdownText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot0:GetOpenTimestamp()))

	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		uv0 = manager.time:GetServerTime() - uv1:GetOpenTimestamp()

		uv1:RefreshState()

		uv1.countdownText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv1:GetOpenTimestamp()))

		if uv0 >= 0 then
			uv1:StopTimer()
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshState(slot0)
	if manager.time:GetServerTime() < slot0:GetOpenTimestamp() then
		slot0.controller_:SetSelectedState("close")

		return
	end

	slot0.starController_:SetSelectedState(table.length(SummerLittleGameData:GetSkadiStars(slot0.chapterID_)))

	if slot0:GetOpenTimestamp() <= manager.time:GetServerTime() then
		slot0.controller_:SetSelectedState("normal")

		return
	end
end

function slot0.IsOpen(slot0)
	if slot0:GetOpenTimestamp() <= manager.time:GetServerTime() then
		return true
	end

	return false
end

return slot0
