slot0 = class("PolyhedronTaskTipsItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot2, slot1)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.startTime_ = ActivityData:GetActivityData(slot1).startTime
	slot0.tipsText_.text = string.format(GetTips("ERROR_MATRIX_SEASON_MISSIONS_TIME"), manager.time:GetLostTimeStr(slot0.startTime_), #AssignmentCfg.get_id_list_by_activity_id[slot1])

	slot0:Show(true)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
