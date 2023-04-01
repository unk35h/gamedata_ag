slot1 = class("SummerPlotRemasteredView", import("game.views.activity.Submodule.storyStage.plot.SummerPlotView"))

function slot1.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "active")

	slot0.controller_:SetSelectedState("off")

	slot0.plotUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, SummerPlotRemasteredItem)
	slot0.playExtraStoryStartHandler_ = handler(slot0, slot0.PlayExtraStoryStart)
	slot0.playExtraStoryOverHander_ = handler(slot0, slot0.PlayExtraStoryOver)
end

function slot1.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.plotList_ = ActivityStoryCollect[slot0.params_.theme].story_id

	slot0.plotUIList_:StartScroll(#slot0.plotList_, 1)
	manager.notify:RegistListener(PLAY_EXTRA_STORY_START, slot0.playExtraStoryStartHandler_)
	manager.notify:RegistListener(PLAY_EXTRA_STORY_OVER, slot0.playExtraStoryOverHander_)
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.notify:RemoveListener(PLAY_EXTRA_STORY_START, slot0.playExtraStoryStartHandler_)
	manager.notify:RemoveListener(PLAY_EXTRA_STORY_OVER, slot0.playExtraStoryOverHander_)
end

function slot1.Dispose(slot0)
	slot0.playExtraStoryStartHandler_ = nil
	slot0.playExtraStoryOverHander_ = nil

	uv0.super.Dispose(slot0)
end

function slot1.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot0.plotList_[slot1])
end

function slot1.PlayExtraStoryStart(slot0)
	slot0.cachePosition_ = slot0.plotUIList_:GetScrolledPosition()
end

function slot1.PlayExtraStoryOver(slot0)
	slot0.plotUIList_:StartScrollByPosition(#slot0.plotList_, slot0.cachePosition_ or Vector3.one)
end

return slot1
