slot0 = class("ActivityRaceRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.taskItemList_ = {}
end

function slot0.SetData(slot0, slot1)
	slot0.activityID_ = slot1
	slot0.accumulateTaskIDList_ = ActivityRaceCfg[slot1].task_list_id
	slot0.taskIDList_ = ActivityRaceCfg[slot1].task_list
	slot0.title_.text = ActivityRaceCfg[slot1].map_name
	slot2 = 1

	for slot6, slot7 in ipairs(slot0.accumulateTaskIDList_) do
		if slot0.taskItemList_[slot2] == nil then
			slot0.taskItemList_[slot2] = ActivityRaceTaskItem.New(slot0.taskItemTemplate_, slot0.taskPanel_)
		end

		slot0.taskItemList_[slot2]:SetData(slot7, slot0.activityID_, true)

		slot2 = slot2 + 1
	end

	for slot6, slot7 in ipairs(slot0.taskIDList_) do
		if slot0.taskItemList_[slot2] == nil then
			slot0.taskItemList_[slot2] = ActivityRaceTaskItem.New(slot0.taskItemTemplate_, slot0.taskPanel_)
		end

		slot0.taskItemList_[slot2]:SetData(slot7, slot0.activityID_, false)

		slot2 = slot2 + 1
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.taskItemList_) do
		slot5:Dispose()
	end

	slot0.taskItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
