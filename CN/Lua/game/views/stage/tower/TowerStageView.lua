slot0 = class("TowerStageView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Tower/TowerStageUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, TowerStageItem)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.chapterClientID_ = 401
	slot0.data = ChapterClientCfg.get_id_list_by_toggle[slot0.chapterClientID_]

	if TowerData:GetTowerStageViewScrollPos() then
		slot0.list:StartScrollByPosition(#slot0.data, TowerData:GetTowerStageViewScrollPos())
	else
		slot0.list:StartScroll(#slot0.data)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.data[slot1], slot1)
	slot2:RegistCallBack(handler(slot0, slot0.OnItemClick))
end

function slot0.OnItemClick(slot0)
	TowerData:CacheTowerStageViewScrollPos(slot0.list:GetScrolledPosition())
end

function slot0.Dispose(slot0)
	TowerData:CacheTowerStageViewScrollPos(nil)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
