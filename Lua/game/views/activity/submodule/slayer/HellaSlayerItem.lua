slot0 = class("HellaSlayerItem", ReduxView)

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

	slot0.lineController = ControllerUtil.GetController(slot0.transform_, "line")
	slot0.stateController = ControllerUtil.GetController(slot0.m_regionTrans, "state")
	slot0.selectController = ControllerUtil.GetController(slot0.m_regionTrans, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_regionBtn, nil, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.index)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.slayer_activity_id = slot2
	slot0.region_activity_id = slot3
	slot0.index = slot1

	if slot1 == 1 then
		slot0.lineController:SetSelectedIndex(1)

		slot0.m_region.anchoredPosition = Vector3.New(0, -80, 0)
	elseif slot1 % 2 == 0 then
		slot0.lineController:SetSelectedIndex(2)

		slot0.m_region.anchoredPosition = Vector3.New(0, 140, 0)
	elseif slot1 % 2 == 1 then
		slot0.lineController:SetSelectedIndex(3)

		slot0.m_region.anchoredPosition = Vector3.New(0, -240, 0)
	else
		slot0.lineController:SetSelectedIndex(0)
	end

	if slot4 then
		slot0.lineController:SetSelectedIndex(0)
	end

	slot0.m_name.text = ActivitySlayerCfg[slot3].name
	slot0.m_maxPointLab.text = SlayerData:GetPoint(slot0.slayer_activity_id, slot0.region_activity_id)

	slot0:RefreshTime()
end

function slot0.RefreshTime(slot0)
	if ActivityData:GetActivityData(slot0.region_activity_id) and slot1:IsActivitying() then
		slot0.stateController:SetSelectedIndex(1)
	else
		slot0.stateController:SetSelectedIndex(0)

		if slot1.stopTime <= manager.time:GetServerTime() then
			slot0.m_countDownLab.text = GetTips("TIME_OVER")
		else
			slot0.m_countDownLab.text = string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(slot1.startTime))
		end
	end
end

function slot0.SetSelectedIndex(slot0, slot1)
	slot0.selectController:SetSelectedIndex(slot1 == slot0.index and 1 or 0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
