slot0 = class("VolumeSlayerItem", ReduxView)

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

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.scoreController = ControllerUtil.GetController(slot0.transform_, "score")
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
	slot0.m_name.text = ActivitySlayerCfg[slot3].name
	slot6 = SlayerData:GetPoint(slot0.slayer_activity_id, slot0.region_activity_id)
	slot0.m_maxPointLab.text = slot6

	if slot6 == 0 then
		slot0.scoreController:SetSelectedIndex(0)
	else
		slot0.scoreController:SetSelectedIndex(1)
	end

	slot0:RefreshTime()
end

function slot0.RefreshTime(slot0)
	if ActivityData:GetActivityData(slot0.region_activity_id) and slot1:IsActivitying() then
		slot0.stateController:SetSelectedIndex(0)
	else
		slot0.stateController:SetSelectedIndex(1)

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
