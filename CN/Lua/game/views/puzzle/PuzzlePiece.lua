slot0 = class("PuzzlePiece", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0.onClickHandler_ = handler(slot0, slot0.OnClick)

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0.clickListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(slot0.onClickHandler_))
end

function slot0.OnClick(slot0)
	if slot0.ID_ ~= slot0.emptyFlag_ and slot0.selectCallBack_ ~= nil then
		slot0.selectCallBack_(slot0.index_)
	end
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.activityID_ = slot3
	slot0.ID_ = slot1
	slot0.index_ = slot2
	slot0.emptyFlag_ = ActivityPuzzleCfg[slot0.activityID_].block
	slot0.size_ = slot4

	slot0:RefreshUI()
	SetActive(slot0.gameObject_, true)
end

function slot0.SetID(slot0, slot1)
	slot0.ID_ = slot1

	slot0:RefreshUI()
end

function slot0.SetSelectCallBack(slot0, slot1)
	slot0.selectCallBack_ = slot1
end

function slot0.RefreshUI(slot0)
	if slot0.ID_ ~= slot0.emptyFlag_ then
		slot0.renderer_.sprite = getSprite(ActivityPuzzleCfg[slot0.activityID_].path, tostring(ActivityPuzzleCfg[slot0.activityID_].picture_array[slot0.ID_]))
	else
		slot0.renderer_.sprite = nil
	end

	slot0.renderer_.size = slot0.size_
end

function slot0.Dispose(slot0)
	slot0.clickListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerClick)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
	slot0.selectCallBack_ = nil
	slot0.onClickHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
