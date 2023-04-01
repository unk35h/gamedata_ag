slot0 = class("PopSourceUnlockItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.data_ = slot3

	slot0:Init()
	SetActive(slot0.gameObject_, true)
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	slot0:StopTimer()
	slot0:RemoveListeners()

	slot0.callback_ = nil
	slot0.btn_ = nil
	slot0.sourceText_ = nil
	slot0.sourceContent_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.callback_ ~= nil then
			uv0.callback_()
		end

		JumpTools.JumpToPage2(uv0.data_)
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.btn_.onClick:RemoveAllListeners()
end

function slot0.SetJumpCallback(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.RefreshUI(slot0)
	slot0.sourceContent_.text, slot0.sourceText_.text = JumpTools.GetName(slot0.data_)
	slot1 = SystemLinkCfg[slot0.data_[1]]
	slot2 = slot1.activity_id

	if type(slot1.paramName) == "table" and (table.keyof(slot1.paramName, "activityId") or table.keyof(slot1.paramName, "activityID")) then
		slot2 = slot0.data_[slot3 + 1]
	end

	if slot2 and slot2 ~= 0 then
		slot0.startTime_, slot4, slot5 = JumpTools.GetActivityTime(slot2)
		slot0.stopTime_ = slot4

		if manager.time:GetServerTime() < slot4 then
			slot0:AddTimer()
		end
	end

	slot0:RefreshLock()
end

function slot0.RefreshLock(slot0)
	if JumpTools.GetLinkIsLocked(slot0.data_) then
		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		uv0:RefreshLock()

		if uv0.stopTime_ < manager.time:GetServerTime() then
			uv0:StopTimer()
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
