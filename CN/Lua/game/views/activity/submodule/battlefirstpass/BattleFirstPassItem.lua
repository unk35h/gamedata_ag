slot0 = class("BattleFirstPassItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	uv0.gameObject_ = slot1
	uv0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.Btn_, nil, function ()
		if manager.time:GetServerTime() < uv0.startTime_ then
			slot1 = uv0.startTime_ - slot0

			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0.startTime_, true)))
		elseif slot0 < uv0.stopTime_ then
			if uv0.clickFunc_ then
				uv0.clickFunc_(uv0.id_)
			end
		else
			ShowTips("TIP_EXPIRED")
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.id_ = slot2
	slot0.cfg_ = ActivityFirstClearCfg[slot0.id_]
	slot0.startTime_ = slot0:GetStarTime()
	slot0.stopTime_ = slot0:GetStopTime()

	slot0:RefreshTitle()
	slot0:RefreshTime()
	slot0:RefreshRedPoint()
	slot0:RefreshClear()
end

function slot0.GetStarTime(slot0)
	return ActivityData:GetActivityData(slot0.id_).startTime
end

function slot0.GetStopTime(slot0)
	return ActivityData:GetActivityData(slot0.id_).stopTime
end

function slot0.RefreshTitle(slot0)
	slot0.title_.text = "「" .. slot0.cfg_.name .. "」"
end

function slot0.RefreshTime(slot0)
	slot1 = nil

	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ then
		slot0.timeCntText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot0.startTime_, true))
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.startTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:SetSelected(uv1.select_)
				uv1:RefreshTime()

				return
			end

			uv1.timeCntText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv1.startTime_, true))
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot2 < slot0.stopTime_ then
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.stopTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:SetSelected(uv1.select_)
				uv1:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeCntText_.text = GetTips("TIME_OVER")
	end
end

function slot0.RefreshRedPoint(slot0)
	SetActive(slot0.redGo_, manager.redPoint:getTipValue(RedPointConst.BATTLE_FIRST_PASS .. slot0.id_) > 0)
end

function slot0.RefreshClear(slot0)
	if BattleFirstPassData:GetBattleData(slot0.activityID_, slot0.id_) then
		SetActive(slot0.clearGo_, slot1.battleState ~= ActivityConst.BATTLE_FIRST_PASS_STATE.UNFINISHED)
	end
end

function slot0.GetID(slot0)
	return slot0.id_
end

function slot0.GetTitle(slot0)
	return slot0.cfg_.name
end

function slot0.SetSelected(slot0, slot1)
	slot0.select_ = slot1

	if manager.time:GetServerTime() < slot0.startTime_ or slot0.stopTime_ <= slot2 then
		slot0.typeCon_:SetSelectedState("close")

		return
	elseif slot1 then
		slot0.typeCon_:SetSelectedState("selected")
		BattleFirstPassAction:SetOnceRedPointOff(slot0.activityID_, slot0.id_)
		slot0:RefreshRedPoint()
	else
		slot0.typeCon_:SetSelectedState("open")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.OnExit(slot0)
	slot0:StopTimer()

	slot0.clickFunc_ = nil
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
