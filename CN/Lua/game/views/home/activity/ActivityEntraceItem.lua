slot0 = class("ActivityEntraceItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.isOpen_ = false
	slot0.activityID_ = slot3
end

function slot0.OnEnter(slot0)
	slot0:AddTimer()

	if JumpTools.GetLinkIsLocked(ActivityEntraceCfg[slot0.activityID_].jump_system) then
		SetActive(slot0.redPointGo_, false)
	else
		SetActive(slot0.redPointGo_, true)
	end

	manager.redPoint:bindUIandKey(slot0.redPointGo_.transform, string.format("%s%s", RedPointConst.MAIN_ACTIVITY, slot0.activityID_))
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.redPoint:unbindUIandKey(slot0.redPointGo_.transform, string.format("%s%s", RedPointConst.MAIN_ACTIVITY, slot0.activityID_))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		JumpTools.JumpToPage2(ActivityEntraceCfg[uv0.activityID_].jump_system)
	end)
end

function slot0.IsOpen(slot0)
	return slot0.isOpen_
end

function slot0.RefreshUI(slot0)
	slot2 = ActivityEntraceCfg[slot0.activityID_]
	slot3 = slot2.icon

	if ActivityData:GetActivityData(slot0.activityID_).startTime + slot2.delay_day * 24 * 3600 < manager.time:GetServerTime() then
		slot3 = slot2.icon2
	end

	slot0.image_.sprite = getSpriteViaConfig("ActivityBannerTextures", slot3 .. SettingData:GetCurrentLanguageKey())
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.isOpen_ = ActivityData:GetActivityIsOpen(slot0.activityID_)

	SetActive(slot0.gameObject_, slot0.isOpen_)

	slot0.activiteTime_ = Timer.New(function ()
		if uv0.isOpen_ ~= ActivityData:GetActivityIsOpen(uv0.activityID_) then
			uv0.isOpen_ = slot0

			SetActive(uv0.gameObject_, slot0)

			if slot0 == false then
				uv0:StopTimer()
				manager.notify:Invoke(ACTIVITY_ENTRACE_OPEN, uv0.activityID_)
			end
		end
	end, 1, -1)

	slot0.activiteTime_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.activiteTime_ then
		slot0.activiteTime_:Stop()

		slot0.activiteTime_ = nil
	end
end

return slot0
