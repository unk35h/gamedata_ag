slot0 = class("OsirisMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/OsirisUI/OsirisUIHomeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.mainStageBtnList_ = {
		OsirisMainStageView.New(slot0.goStory_, BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY),
		OsirisMainStageView.New(slot0.goChess_, BattleConst.STAGE_TYPE_NEW.OSIRIS_CHESS),
		OsirisMainStageView.New(slot0.goChallenge_, BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON),
		OsirisMainStageView.New(slot0.goSimulator_, BattleConst.STAGE_TYPE_NEW.RACE_TRAIL)
	}
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.redPoint:bindUIandKey(slot0.transformTask_, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.OSIRIS_TASK_DAILY))
	manager.redPoint:bindUIandKey(slot0.transformTrial_, string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.OSIRIS_HERO_TRIAL_STAGE))

	slot1 = ActivityData:GetActivityData(ActivityConst.OSIRIS_ACTIVITY)
	slot7 = "%s-%s"
	slot8 = manager.time:STimeDescS(slot1.startTime, "!%Y.%m.%d %H:%M")
	slot0.textTime_.text = string.format(slot7, slot8, manager.time:STimeDescS(slot1.stopTime, "!%Y.%m.%d %H:%M"))

	for slot7, slot8 in pairs(slot0.mainStageBtnList_) do
		slot8:OnEnter()
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.transformTask_, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.OSIRIS_TASK_DAILY))

	slot4 = slot0.transformTrial_
	slot5 = string.format

	manager.redPoint:unbindUIandKey(slot4, slot5("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.OSIRIS_HERO_TRIAL_STAGE))

	for slot4, slot5 in pairs(slot0.mainStageBtnList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.mainStageBtnList_) do
		slot5:Dispose()
	end

	slot0.mainStageBtnList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnStoryView_, nil, function ()
		uv0:Go("/osirisRecall")
	end)
	slot0:AddBtnListener(slot0.btnHeroTrial_, nil, function ()
		slot0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_HERO_TRIAL_STAGE)
		slot1 = slot0.startTime

		if slot0.stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		uv0:Go("/heroTrialActivite", {
			activiteID = ActivityConst.OSIRIS_HERO_TRIAL_STAGE
		})
	end)
	slot0:AddBtnListener(slot0.btnGift_, nil, function ()
		slot0 = ActivityData:GetActivityData(ActivityConst.OSIRIS_INFINITY_POOL)
		slot1 = slot0.startTime

		if slot0.stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		uv0:Go("/osirisActivity", {
			activityType = OsirisConst.ACTIVITY_TYPE.TASK,
			activityTaskID = ActivityConst.OSIRIS_TASK_DAILY,
			activityInfinityID = ActivityConst.OSIRIS_INFINITY_POOL
		})
	end)
end

return slot0
