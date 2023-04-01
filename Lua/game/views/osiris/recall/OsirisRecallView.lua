slot0 = class("OsirisRecallView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BranchlineUI/OsirisRecallUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, OsirisRecallItem)
end

function slot0.AddUIListener(slot0)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.data = ActivityStoryCollect[ActivityConst.OSIRIS_ACTIVITY] and ActivityStoryCollect[ActivityConst.OSIRIS_ACTIVITY].story_id or {}

	slot0.list:StartScroll(#slot0.data)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.data[slot1])
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
