slot0 = class("GMActivityItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
	slot0:Show(true)
end

function slot0.SetData(slot0, slot1)
	if slot0.activityID_ ~= slot1 then
		slot0.toggle_.isOn = false
	end

	slot0.activityID_ = slot1
	slot2 = ActivityData:GetActivityData(slot1)
	slot4 = slot2.stopTime
	slot5 = nil
	slot5 = slot2.startTime == 0 and "" or string.format("(<color=%s>%s</color>)", slot4 < manager.time:GetServerTime() and "#000000" or slot3 < manager.time:GetServerTime() and "blue" or "red", string.format("<size=25>%s-%s</size>", manager.time:STimeDescS(slot3, "!%m/%d %H:%M"), manager.time:STimeDescS(slot4, "!%m/%d %H:%M")))

	if #ActivityCfg[slot1].sub_activity_list <= 0 then
		slot0.text_.text = string.format("<b>Φ</b>%s-%s%s", slot1, ActivityCfg[slot1].remark, slot5)
	else
		slot0.text_.text = string.format("%s-%s%s", slot1, ActivityCfg[slot1].remark, slot5)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddToggleListener(slot0.toggle_, function (slot0)
		GMData:EnabledActivity(uv0.activityID_, slot0)
	end)
end

function slot0.Show(slot0, slot1)
	slot0.gameObject_:SetActive(slot1)
end

function slot0.SelectItem(slot0, slot1)
	slot0.toggle_.isOn = slot1
end

return slot0
