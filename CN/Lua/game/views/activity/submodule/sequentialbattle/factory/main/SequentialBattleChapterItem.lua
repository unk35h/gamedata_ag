slot0 = class("SequentialBattleChapterItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.activityID_ = slot3

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.finishController_ = ControllerUtil.GetController(slot0.transform_, "finish")

	if SequentialBattleData:GetChapterData(slot0.activityID_) == nil then
		SequentialBattleData:InitChapterData(slot0.activityID_)
	end
end

function slot0.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE, slot0.activityID_))
	slot0:AddTimer()

	slot0.nameText1_.text = SequentialBattleChapterCfg[slot0.activityID_].stage_name
	slot0.nameText2_.text = SequentialBattleChapterCfg[slot0.activityID_].stage_name

	slot0:RefreshFinishStatus()
	SetActive(slot0.gameObject_, true)
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE, slot0.activityID_))
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.lock_ then
			if manager.time:GetServerTime() < ActivityData:GetActivityData(uv0.activityID_).startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot0.startTime)))
			else
				ShowTips("TIME_OVER")
			end

			return
		else
			SequentialBattleData:SetSelectChapterID(SequentialBattleChapterCfg[uv0.activityID_].main_id, uv0.activityID_)
			manager.notify:Invoke(SEQUENTIAL_BATTLE_SELECT_CHAPTER)
		end
	end)
end

function slot0.RefreshSelect(slot0, slot1)
	if slot0.activityID_ == slot1 then
		slot0.selectController_:SetSelectedState("Select")
	else
		slot0.selectController_:SetSelectedState("no")
	end
end

function slot0.RefreshLock(slot0)
	if slot0.lock_ then
		slot0.lockController_:SetSelectedState("on")
	else
		slot0.lockController_:SetSelectedState("off")
	end
end

function slot0.RefreshFinishStatus(slot0)
	slot1 = slot0.activityID_

	if table.length(SequentialBattleData:GetChapterData(slot1).historyFinishStage) < #SequentialBattleChapterCfg[slot1].stage_id then
		slot0.finishController_:SetSelectedState("false")
	else
		slot0.finishController_:SetSelectedState("true")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0.activityID_).startTime or slot1.stopTime < manager.time:GetServerTime() then
		slot0.lock_ = true
	else
		slot0.lock_ = false
	end

	slot0:RefreshLock()

	slot2 = GetTips("OPEN_TIME")

	if slot1.stopTime < manager.time:GetServerTime() then
		slot0.unlockText_.text = GetTips("TIME_OVER")
	else
		slot0.unlockText_.text = string.format(slot2, manager.time:GetLostTimeStr(slot1.startTime))
	end

	slot0.timer_ = Timer.New(function ()
		if uv0.startTime <= manager.time:GetServerTime() and slot0 < uv0.stopTime then
			if uv1.lock_ == true then
				uv1.lock_ = false

				uv1:RefreshLock()
			else
				uv1.lock_ = false
			end
		elseif uv0.stopTime < slot0 then
			uv1:StopTimer()

			uv1.lock_ = true

			uv1:RefreshLock()

			uv1.unlockText_.text = GetTips("TIME_OVER")
		elseif slot0 < uv0.startTime then
			uv1.unlockText_.text = string.format(uv2, manager.time:GetLostTimeStr(uv0.startTime))
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

return slot0
