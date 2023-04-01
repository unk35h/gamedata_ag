slot0 = class("ActivityNoobPhaseItem", ReduxView)
slot1 = {
	"normal",
	"lock",
	"finish"
}

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.Dispose(slot0)
	slot0.clickHandler_ = nil

	slot0:UnbindRedPoint()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.isLock_ == true then
			ShowTips(string.format(GetTips("ACTIVITY_FIRST_UNLOCK_PROMPT"), uv0.unLockDay_))
		end

		if uv0.clickHandler_ then
			uv0.clickHandler_(uv0.phase_)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0:BindRedPoint(slot1)

	slot0.phase_ = slot1
	slot0.titleText_.text = "0" .. slot1
	slot0.titleText2_.text = string.format(GetTips("ACTIVITY_GREENHORN_TASK_STAGE"), slot1)

	slot0:RefreshState()
end

function slot0.BindRedPoint(slot0, slot1)
	if slot0.phase_ == nil then
		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%d", RedPointConst.NEWBIE_TASK, slot1))
	elseif slot0.phase_ ~= slot1 then
		manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%d", RedPointConst.NEWBIE_TASK, slot0.phase_))
		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%d", RedPointConst.NEWBIE_TASK, slot1))
	end
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%d", RedPointConst.NEWBIE_TASK, slot0.phase_))
end

function slot0.RefreshState(slot0)
	slot0.stateCon_:SetSelectedState(slot0:GetItemState())
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectController_:SetSelectedIndex(slot0.phase_ == slot1 and 1 or 0)
end

function slot0.GetItemState(slot0)
	slot1 = TaskData:GetNoobTaskSortList(slot0.phase_)
	slot0.isLock_ = false

	if ActivityNoobData:GetUnlockPhase() < slot0.phase_ then
		slot0.unLockDay_ = slot0.phase_ - slot2
		slot0.isLock_ = true

		return uv0[2]
	else
		for slot6, slot7 in ipairs(slot1) do
			slot8 = AssignmentCfg[slot7.id]

			if slot7.complete_flag < 1 then
				return uv0[1]
			end
		end
	end

	return uv0[3]
end

function slot0.SetClickHandler(slot0, slot1)
	slot0.clickHandler_ = slot1
end

return slot0
