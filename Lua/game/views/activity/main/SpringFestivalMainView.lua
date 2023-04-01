ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")
slot0 = class("SpringFestivalMainView", ActivityMainBaseView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/NewyearMainUI"
end

function slot0.InitSubmoduleButton(slot0)
	slot0.submoduleBtnList_ = {
		SpringFestivalGreetingSubmoduleItem.New(slot0.springFestivalGreetingGo_, ActivityConst.SPRING_FESTIVAL_GREETING),
		ActivitySubmoduleWithSpineItem.New(slot0.paperCutGo_, ActivityConst.PAPER_CUT_GAME),
		ActivitySubmoduleWithSpineItem.New(slot0.btn2_, ActivityConst.SPRING_ANTITHETICAL_COUPLET),
		ActivitySubmoduleWithSpineItem.New(slot0.riddleGo_, ActivityConst.SPRING_FESTIVAL_RIDDLE),
		ActivitySubmoduleWithSpineItem.New(slot0.canteenGo_, ActivityConst.SPRING_CANTEEN, function ()
			if GameSetting.activity_festival_canteen_plot.value[1] and not manager.story:IsStoryPlayed(slot0) then
				slot1 = manager.story

				slot1:StartStoryById(slot0, function (slot0)
					CanteenData:ConsumeNotification(RedPointConst.CANTEEN_BUSINESS_STOPPED)
					ActivityTools.JumpToSubmodulePage(ActivityConst.SPRING_CANTEEN)
				end)
			else
				CanteenData:ConsumeNotification(RedPointConst.CANTEEN_BUSINESS_STOPPED)
				ActivityTools.JumpToSubmodulePage(ActivityConst.SPRING_CANTEEN)
			end
		end),
		ActivitySubmoduleWithSpineItem.New(slot0.btn5_, ActivityConst.FIRE_WORK, function ()
			if not manager.story:IsStoryPlayed(GameSetting.activity_firework_unlock_pre_story.value[1]) then
				ShowTips(string.format(GetTips("FIRE_WORK_LOCK_STORY"), StoryCfg[slot0].name))

				return
			end

			ActivityTools.JumpToSubmodulePage(ActivityConst.FIRE_WORK)
		end),
		ActivitySubmoduleWithSpineItem.New(slot0.btn4_, ActivityConst.NIEN_WORLD_BOSS, function ()
			if not manager.story:IsStoryPlayed(GameSetting.activity_firework_story.value[1]) then
				ShowTips(string.format(GetTips("ACTIVITY_WORLD_BOSS_LOCK_STORY"), StoryCfg[slot0].name))

				return
			end

			ActivityTools.JumpToSubmodulePage(ActivityConst.NIEN_WORLD_BOSS)
		end)
	}
end

function slot0.GetActivityID(slot0)
	return ActivityConst.SPRING_FESTIVAL_ACTIVITY
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.canteenGo_.transform, RedPointConst.CANTEEN_DISPATCH)
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.canteenGo_.transform, RedPointConst.CANTEEN_DISPATCH)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:BindRedPoint()
	slot0:AddTimer()
	TimeTools.StartAfterSeconds(0.033, function ()
		if manager.guide:IsPlaying() then
			slot0 = uv0.scrollContent_.localPosition
			slot0.x = -400
			uv0.scrollContent_.localPosition = slot0
		end
	end, {})
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:UnbindRedPoint()
	slot0:StopTimer()
end

function slot0.RefreshUI(slot0)
end

function slot0.AddListeners(slot0)
end

function slot0.AddTimer(slot0)
	slot0.stopTime_ = ActivityData:GetActivityData(slot0:GetActivityID()).stopTime

	slot0:StopTimer()

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
