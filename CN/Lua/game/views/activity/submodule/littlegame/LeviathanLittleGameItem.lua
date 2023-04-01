slot0 = class("LeviathanLittleGameItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index_ = slot4
	slot0.chapterID_ = slot2
	slot0.activityID_ = slot3

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnEnter(slot0)
	slot0.nameText_.text = ActivityBubblesCfg[slot0.chapterID_].name

	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	slot0.transform_ = nil
	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnBtn_, nil, function ()
		if manager.time:GetServerTime() < uv0:GetOpenTimestamp() then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0:GetOpenTimestamp())))

			return
		end

		uv0:Go("leviathanSectionInfo", {
			chapterID = uv0.chapterID_,
			section = ActivityBubblesCfg[uv0.chapterID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME
		})

		if uv0.func_ then
			uv0.func_(uv0.index_)
		end
	end)
end

function slot0.GetOpenTimestamp(slot0)
	return ActivityData:GetActivityData(slot0.chapterID_).startTime or 0
end

function slot0.AddClickFunc(slot0, slot1)
	slot0.func_ = slot1
end

function slot0.AddTimer(slot0)
	slot0:RefreshState()

	if manager.time:GetServerTime() - slot0:GetOpenTimestamp() >= 0 then
		return
	end

	slot0.timetextText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot0:GetOpenTimestamp()))

	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		uv0 = manager.time:GetServerTime() - uv1:GetOpenTimestamp()

		uv1:RefreshState()

		uv1.timetextText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv1:GetOpenTimestamp()))

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
	if slot0:IsClear() then
		slot0.controller_:SetSelectedState("clear")

		return
	end

	if slot0:GetOpenTimestamp() <= manager.time:GetServerTime() then
		slot0.controller_:SetSelectedState("normal")

		return
	end

	slot0.controller_:SetSelectedState("lock")
end

function slot0.IsOpen(slot0)
	if slot0:GetOpenTimestamp() <= manager.time:GetServerTime() then
		return true
	end

	return false
end

function slot0.IsClear(slot0)
	if SummerLittleGameData:GetLeviathanState(slot0.chapterID_) == 1 or slot1 == 2 then
		return true
	end

	return false
end

return slot0
