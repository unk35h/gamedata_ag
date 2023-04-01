slot0 = class("PolyhedronBeaconOperateView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Polyhedron/Beacon/PolyhedronBeaconOperateUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, PolyhedronBeaconOperateItem)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot0.data = PolyhedronBeaconCfg.all

	table.sort(slot0.data, function (slot0, slot1)
		if PolyhedronData:GetBeaconIsLock(slot0) == PolyhedronData:GetBeaconIsLock(slot1) then
			if PolyhedronTools.GetBeaconIsUnlockCondition(slot0) == PolyhedronTools.GetBeaconIsUnlockCondition(slot1) then
				return slot0 < slot1
			else
				return slot4
			end
		else
			return slot3
		end
	end)
	slot0.list_:StartScroll(#slot0.data)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.data[slot1])
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnPolyhedronBeaconUnlock(slot0)
	for slot5, slot6 in pairs(slot0.list_:GetItemList()) do
		slot6:Refresh()
	end
end

return slot0
