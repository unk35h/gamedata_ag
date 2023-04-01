slot0 = class("HellaParkourEntrustItem", ReduxView)

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

	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.index)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index = slot1
	slot0.entrust_activity_id = slot2
	slot0.m_name.text = ActivityParkourCfg[slot2].name

	slot0:RefreshTime()

	slot4 = ParkourData:GetParkourEntrustData(slot2)

	for slot8 = 1, 4 do
		if slot0["m_star" .. slot8] then
			if slot4 then
				SetActive(slot9, not not table.indexof(slot4.stars, slot8))
			else
				SetActive(slot9, false)
			end
		end
	end

	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, slot2))
end

function slot0.RefreshTime(slot0)
	if ActivityData:GetActivityData(slot0.entrust_activity_id):IsActivitying() then
		slot0.lockController:SetSelectedIndex(0)
	else
		slot0.lockController:SetSelectedIndex(1)

		if slot1.stopTime <= manager.time:GetServerTime() then
			slot0.m_lockLab.text = GetTips("TIME_OVER")
		else
			slot0.m_lockLab.text = string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(slot1.startTime))
		end
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.SetSelectedIndex(slot0, slot1)
	slot0.selectController:SetSelectedIndex(slot1 == slot0.index and 1 or 0)
end

function slot0.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
	uv0.super.Dispose(slot0)
end

return slot0
