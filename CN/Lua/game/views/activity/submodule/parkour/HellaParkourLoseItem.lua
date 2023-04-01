slot0 = class("HellaParkourLoseItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.index, true)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index = slot1
	slot0.parkour_activity_id = slot2
	slot0.itemid = slot3
	slot0.m_icon.sprite = ItemTools.getItemSprite(slot3)

	slot0:UpdateState()
end

function slot0.UpdateState(slot0)
	slot2 = ParkourData:GetCollectRedList(slot0.parkour_activity_id)

	if not table.indexof(ParkourData:GetParkCollect(slot0.parkour_activity_id), slot0.itemid) then
		slot0.stateController:SetSelectedIndex(2)
	elseif table.indexof(slot2, slot0.itemid) then
		slot0.stateController:SetSelectedIndex(1)
	else
		slot0.stateController:SetSelectedIndex(0)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.SetSelectedIndex(slot0, slot1)
	slot0.selectController:SetSelectedIndex(slot1 == slot0.index and 1 or 0)
end

return slot0
