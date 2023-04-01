slot0 = class("BulletinTitleItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:SetViewProp("bulletinID", slot2)
	slot0:SetViewProp("contentIndex", slot3)
	slot0:InitUI()
	slot0:AddListeners()
	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	if slot0.time_ then
		slot0.timt_:Stop()

		slot0.time_ = nil
	end

	slot0:RemoveListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.titleText_ = slot0:FindCom(typeof(Text), "titleText")
	slot0.timeText_ = slot0:FindCom(typeof(Text), "time/text")
	slot0.blueImg_ = slot0:FindCom(typeof(RectTransform), "blueImg")
	slot0.titleTrs_ = slot0:FindCom(typeof(RectTransform), "titleText")
end

function slot0.AddListeners(slot0)
end

function slot0.RemoveListeners(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.titleText_.text = slot0:GetContent(slot0:GetViewProp("bulletinID"), slot0:GetViewProp("contentIndex")).text
	slot0.timeText_.text = TimeMgr.GetInstance():STimeDescS(slot0:GetTimestamp(slot0:GetViewProp("bulletinID")), "!%Y/%m/%d")
	slot0.time_ = Timer.New(function ()
		uv0.blueImg_.sizeDelta = Vector2(uv0.titleTrs_.rect.width + 10, uv0.blueImg_.sizeDelta.y)
		uv0.time_ = nil
	end, 0.05, 1)

	slot0.time_:Start()
	SetActive(slot0.gameObject_, true)
end

function slot0.GetTimestamp(slot0, slot1)
	for slot5, slot6 in pairs(BulletinData.GetBulletinPageList()) do
		if slot6.id == slot1 then
			slot7 = TimeMgr.GetInstance():GetServerTime()

			return slot6.startTime
		end
	end
end

function slot0.GetContent(slot0, slot1, slot2)
	for slot6, slot7 in pairs(BulletinData.GetBulletinPageList()) do
		if slot7.id == slot1 then
			return slot7.content[slot2]
		end
	end
end

return slot0
