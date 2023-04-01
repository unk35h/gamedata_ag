slot0 = class("ActivityMainBasePanel", ReduxView)

function slot0.GetUIName(slot0)
end

function slot0.Ctor(slot0, slot1, slot2)
	slot0.activityID_ = slot2
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:GetUIName()), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot1 = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot1.startTime
	slot0.stopTime_ = slot1.stopTime

	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.OnTop(slot0)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()
	slot0:RefreshTimeText()

	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ < manager.time:GetServerTime() then
			return
		end

		uv0:RefreshTimeText()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshTimeText(slot0)
	if slot0.timeText_ then
		slot0.timeText_.text = manager.time:GetLostTimeStr2(slot0.stopTime_, nil, true)
	end
end

function slot0.IsActivityTime(slot0)
	if manager.time:GetServerTime() < slot0.startTime_ then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(slot0.startTime_, nil, true)))

		return false
	end

	if slot0.stopTime_ <= manager.time:GetServerTime() then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

return slot0
