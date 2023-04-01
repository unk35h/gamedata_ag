slot0 = class("OsirisMainStageView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.type_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnEnter(slot0)
	slot1 = nil

	if slot0.type_ == BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY then
		slot1 = ActivityData:GetActivityData(ActivityConst.OSIRIS_STROY)
	elseif slot0.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_CHESS then
		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS))

		slot1 = ActivityData:GetActivityData(ActivityConst.OSIRIS_CHESS)
	elseif slot0.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.OSIRIS_DEMON)

		slot1 = ActivityData:GetActivityData(ActivityConst.OSIRIS_DEMON)
	elseif slot0.type_ == BattleConst.STAGE_TYPE_NEW.RACE_TRAIL then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.OSIRIS_RACE_TRIAL)

		slot1 = ActivityData:GetActivityData(ActivityConst.OSIRIS_TRAIL)
	end

	slot0.startTime_ = slot1.startTime
	slot0.stopTime_ = slot1.stopTime

	slot0:RefreshLock()
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	if slot0.type_ == BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY then
		-- Nothing
	elseif slot0.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_CHESS then
		manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS))
	elseif slot0.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON then
		manager.redPoint:unbindUIandKey(slot0.transform_, RedPointConst.OSIRIS_DEMON)
	elseif slot0.type_ == BattleConst.STAGE_TYPE_NEW.RACE_TRAIL then
		manager.redPoint:unbindUIandKey(slot0.transform_, RedPointConst.OSIRIS_RACE_TRIAL)
	end

	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
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

		if uv0.type_ == BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY then
			uv0:Go("/osirisStoryStage")
		elseif uv0.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_CHESS then
			uv0:Go("/osirisChess")
		elseif uv0.type_ == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON then
			ActivityTools.JumpToSubmodulePage(ActivityConst.OSIRIS_DEMON)
		elseif uv0.type_ == BattleConst.STAGE_TYPE_NEW.RACE_TRAIL then
			uv0:Go("/raceTrail", {
				activityID = ActivityConst.OSIRIS_TRAIL
			})
		end
	end)
end

function slot0.RefreshLock(slot0)
	slot0.controller_:SetSelectedState(tostring(manager.time:GetServerTime() < slot0.startTime_))
end

function slot0.AddTimer(slot0)
	slot0.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot0.startTime_))
	slot0.timer_ = Timer.New(function ()
		if manager.time:GetServerTime() < uv0.startTime_ then
			uv0.textTime_.text = string.format(uv1, manager.time:GetLostTimeStr(uv0.startTime_))
		else
			uv0:RefreshLock()
			uv0:StopTimer()
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

return slot0
