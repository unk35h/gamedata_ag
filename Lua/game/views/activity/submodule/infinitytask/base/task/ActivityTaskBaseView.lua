slot0 = class("ActivityTaskBaseView", ReduxView)

function slot0.GetAssetName(slot0)
	return "UI/VersionUI/OsirisUI/OsirisTaskContent"
end

function slot0.GetTaskClass(slot0)
	return ActivityTaskBaseItem
end

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:GetAssetName()), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.activityID_ = slot2
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, slot0:GetTaskClass())
	slot0.osirisTaskUpdateHandler_ = handler(slot0, slot0.OsirisTaskUpdate)

	slot0:OnEnter()
end

function slot0.OnEnter(slot0)
	slot0.scrollHelper_:StartScroll(#TaskData:GetActivityTaskSortList(slot0.activityID_))
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, slot0.osirisTaskUpdateHandler_)

	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.notify:RemoveListener(OSIRIS_TASK_UPDATE, slot0.osirisTaskUpdateHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.osirisTaskUpdateHandler_ = nil

	slot0.scrollHelper_:Dispose()
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(TaskData:GetActivityTaskSortList(slot0.activityID_)[slot1].id)
end

function slot0.Show(slot0, slot1)
	if slot0.gameObject_.activeSelf == slot1 then
		return
	end

	SetActive(slot0.gameObject_, slot1)
end

function slot0.OsirisTaskUpdate(slot0)
	slot0.scrollHelper_:StartScroll(#TaskData:GetActivityTaskSortList(slot0.activityID_))
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.textTime_.text = GetTips("TIME_OVER")

		ShowTips("TIME_OVER")
		slot0:Back()

		return
	end

	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.textTime_.text = GetTips("TIME_OVER")

			ShowTips("TIME_OVER")
			uv0:Back()

			return
		end

		uv0.textTime_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
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
