slot0 = class("ChapterVariantBaseItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "lockState")
end

function slot0.OnEnter(slot0, slot1)
	slot0.chapterID_ = slot1

	if BattleStageData:GetStageData()[ChapterCfg[slot1].section_id_list[1]] then
		slot0.isLock_ = false
	else
		slot0.isLock_ = true
	end

	SetActive(slot0.gameObject_, not slot0.isLock_)
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot1))

	if ChapterCfg[slot1].unlock_activity_id ~= 0 then
		slot0:AddTimer()
	end
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot0.chapterID_))
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.isLock_ then
			ShowTips("NEED_FINISH_PRE_NORMAL_STAGE")

			return
		end

		if uv0.timeLock_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ChapterCfg[uv0.chapterID_].unlock_activity_id).startTime)))

			return
		end

		if uv0.chapterID_ == 11112 and not SkuldTravelData:IsCollectAllPhoto() then
			ShowTips(GetTips("TRAVEL_SKULD_COLLECT_ALL_PHOTO"))

			return
		end

		uv0:Go("/chapterSection", {
			chapterID = uv0.chapterID_
		})
	end)
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.timeLock_ = false

	if ActivityData:GetActivityData(ChapterCfg[slot0.chapterID_].unlock_activity_id).startTime < manager.time:GetServerTime() then
		slot0:RefreshControllerState()

		return
	end

	slot0.controller_:SetSelectedState("timeLock")

	slot0.timerText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot2.startTime))
	slot0.timeLock_ = true
	slot0.timer_ = Timer.New(function ()
		if uv0.startTime < manager.time:GetServerTime() then
			uv1:RefreshControllerState()

			uv1.timeLock_ = false

			uv1:StopTimer()
		else
			uv1.timerText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0.startTime))
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshControllerState(slot0)
	if slot0.isLock_ or slot0.chapterID_ == 11112 and not SkuldTravelData:IsCollectAllPhoto() then
		slot0.controller_:SetSelectedState("lock")
	else
		slot0.controller_:SetSelectedState("normal")
	end
end

return slot0
