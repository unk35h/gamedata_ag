slot1 = class("OsirisRecallRemasterdView", import("game.views.osiris.recall.OsirisRecallView"))

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, OsirisRecallRemasteredItem)
	slot0.playExtraStoryStartHandler_ = handler(slot0, slot0.PlayExtraStoryStart)
	slot0.playExtraStoryOverHander_ = handler(slot0, slot0.PlayExtraStoryOver)
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
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

function slot1.PlayExtraStoryStart(slot0)
	slot0.cachePosition_ = slot0.list:GetScrolledPosition()
end

function slot1.PlayExtraStoryOver(slot0)
	slot0.list:StartScrollByPosition(#slot0.data, slot0.cachePosition_ or Vector3.one)
end

return slot1
