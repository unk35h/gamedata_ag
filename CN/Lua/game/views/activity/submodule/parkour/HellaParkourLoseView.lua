slot0 = class("HellaParkourLoseView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/HellaUI/Parkour/HellaParkourLoseUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.collectController = ControllerUtil.GetController(slot0.transform_, "collect")
	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, HellaParkourLoseItem)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.parkour_activity_id = slot0.params_.parkour_activity_id or 0
	slot2 = ActivityCfg[slot0.parkour_activity_id] and slot1.sub_activity_list or {}
	slot0.loseList = {}

	for slot6, slot7 in ipairs(slot2) do
		table.insert(slot0.loseList, ActivityParkourCfg[slot7].specail_item)
	end

	slot3 = ParkourData:GetParkCollect(slot0.parkour_activity_id)

	table.sort(slot0.loseList, function (slot0, slot1)
		if not not table.indexof(uv0, slot0) ~= not not table.indexof(uv0, slot1) then
			return slot2
		else
			return slot0 < slot1
		end
	end)
	slot0.list:StartScroll(#slot0.loseList)
	slot0:SetSelectIndex(1)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	slot0.selectIndex = -1
end

function slot0.Refresh(slot0)
	if table.indexof(ParkourData:GetParkCollect(slot0.parkour_activity_id), slot0.loseList[slot0.selectIndex]) then
		slot0.collectController:SetSelectedIndex(1)
	else
		slot0.collectController:SetSelectedIndex(0)
	end

	if ItemCfg[slot1] then
		slot0.m_name.text = slot3.name
		slot0.m_des.text = slot3.desc
	end

	slot0.m_icon.sprite = ItemTools.getItemSprite(slot1)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.parkour_activity_id, slot0.loseList[slot1])
	slot2:SetSelectedIndex(slot0.selectIndex)
	slot2:RegistCallBack(handler(slot0, slot0.SetSelectIndex))
end

function slot0.SetSelectIndex(slot0, slot1, slot2)
	if slot1 == slot0.selectIndex then
		return
	end

	slot8 = slot0.loseList[slot1]

	ParkourData:SetParkourCollectRedPoint(slot0.parkour_activity_id, slot8)

	slot0.selectIndex = slot1

	for slot8, slot9 in pairs(slot0.list:GetItemList()) do
		slot9:SetSelectedIndex(slot0.selectIndex)
		slot9:UpdateState()
	end

	slot0:Refresh()
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
