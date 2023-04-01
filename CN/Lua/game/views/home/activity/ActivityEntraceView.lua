slot0 = class("ActivityEntraceView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.itemList_ = {}
	slot5 = slot0.ActivityOpen
	slot0.activityOpenHandler_ = handler(slot0, slot5)

	for slot5, slot6 in ipairs(ActivityEntraceCfg.all) do
		if ActivityData:GetActivityIsOpen(slot6) then
			slot0.itemList_[slot6] = ActivityEntraceItem.New(slot0.itemGo_, slot0.itemParent_, slot6)
		end
	end
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(ACTIVITY_UPDATE, slot0.activityOpenHandler_)

	slot4 = ACTIVITY_ENTRACE_OPEN
	slot5 = slot0.activityOpenHandler_

	manager.notify:RegistListener(slot4, slot5)

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:OnEnter()
	end

	slot0:RefreshScrollView()
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(ACTIVITY_UPDATE, slot0.activityOpenHandler_)

	slot4 = ACTIVITY_ENTRACE_OPEN
	slot5 = slot0.activityOpenHandler_

	manager.notify:RemoveListener(slot4, slot5)

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.activityOpenHandler_ = nil

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil
end

function slot0.ActivityOpen(slot0, slot1)
	if ActivityTemplateConst.MAIN_ACTIVITY ~= ActivityTools.GetActivityType(slot1) then
		return
	end

	if not slot0.itemList_[slot1] then
		slot0.itemList_[slot1] = ActivityEntraceItem.New(slot0.itemGo_, slot0.itemParent_, slot1)

		slot0.itemList_[slot1]:OnEnter()
	end

	slot0:RefreshScrollView()
end

function slot0.RefreshScrollView(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.itemList_) do
		if slot6:IsOpen() then
			slot1 = slot1 + 1
		end
	end

	if slot1 > 1 then
		slot0.scrollView_.enabled = true
	else
		slot0.scrollView_.verticalNormalizedPosition = 0
		slot0.scrollView_.enabled = false
	end
end

return slot0
