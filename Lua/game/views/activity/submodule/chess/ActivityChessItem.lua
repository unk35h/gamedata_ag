slot0 = class("ActivityChessItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.chapterID_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnEnter(slot0)
	slot0.ACTIVITY_CONST = WarchessLevelCfg[slot0.chapterID_].activity

	slot0:RefreshUI()
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, slot0.ACTIVITY_CONST, slot0.chapterID_))
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, slot0.ACTIVITY_CONST, slot0.chapterID_))
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if manager.time:GetServerTime() < uv0:GetOpenTimestamp() then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0:GetOpenTimestamp())))

			return
		end

		if uv0:IsPrestageLock() then
			slot2 = WarchessLevelCfg[uv0.chapterID_].unlock_level

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityCfg[WarchessLevelCfg[slot2].activity].name, WarchessLevelCfg[slot2].name_level))

			return
		end

		if uv0:IsLock() then
			slot0 = WarchessLevelCfg[uv0.chapterID_].unlock_condition

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityStoryChapterCfg[slot0[1]].name, BattleActivityStoryStageCfg[slot0[2]].name))

			return
		end

		ChessTools.EnterChessMap(uv0.chapterID_, true)
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = ChessTools.GetChapterProgress(slot0.chapterID_)
	slot0.imageProgress_.fillAmount = slot1 / 100
	slot0.textProress_.text = slot1
	slot0.textName_.text = WarchessLevelCfg[slot0.chapterID_].name_level
end

function slot0.IsPrestageLock(slot0)
	if WarchessLevelCfg[slot0.chapterID_].unlock_level ~= 0 and ChessTools.GetChapterProgress(slot3) < slot2.success_progress then
		return true
	end

	return false
end

function slot0.IsLock(slot0)
	if WarchessLevelCfg[slot0.chapterID_].activity == slot0.ACTIVITY_CONST and WarchessLevelCfg[slot1].unlock_condition ~= "" then
		if not StoryStageActivityData:GetStageData(slot2[1])[slot2[2]] or slot3.clear_times < 1 then
			return true
		end
	end

	return false
end

function slot0.GetOpenTimestamp(slot0)
	return WarChessData:GetChessTime(slot0.chapterID_) or 0
end

function slot0.AddTimer(slot0)
	slot0:RefreshState()

	if manager.time:GetServerTime() - slot0:GetOpenTimestamp() >= 0 then
		return
	end

	slot0.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot0:GetOpenTimestamp()))

	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		uv0 = manager.time:GetServerTime() - uv1:GetOpenTimestamp()

		uv1:RefreshState()

		uv1.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv1:GetOpenTimestamp()))

		if uv0 >= 0 then
			uv1:StopTimer()
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

function slot0.RefreshState(slot0)
	slot2 = WarChessData:GetCurrentChapter(WarchessLevelCfg[slot0.chapterID_].activity)

	if slot0:GetOpenTimestamp() <= manager.time:GetServerTime() then
		if slot0:IsPrestageLock() or slot0:IsLock() then
			slot0.controller_:SetSelectedState("open")

			return
		end

		if slot2 == slot0.chapterID_ then
			slot0.controller_:SetSelectedState("challenge")
		else
			slot0.controller_:SetSelectedState("normal")
		end
	else
		slot0.controller_:SetSelectedState("lock")
	end
end

return slot0
