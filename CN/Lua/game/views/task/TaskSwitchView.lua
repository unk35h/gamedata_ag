slot0 = class("TaskSwitchView", ReduxView)
slot1 = import("game.tools.TaskTools")
slot2 = import("game.const.TaskConst")

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.btnType_ = slot2

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	if slot0.btnType_ == uv0.TASK_TYPE.PLOT then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.TASK_PLOT)
	elseif slot1 == uv0.TASK_TYPE.DAILY then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.TASK_DAILY)
	elseif slot1 == uv0.TASK_TYPE.WEEK then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.TASK_WEEK)
	end

	slot0.refreshLockHandler_ = handler(slot0, slot0.RefreshLock)

	manager.notify:RegistListener(PLAYER_LEVEL_UP, slot0.refreshLockHandler_)
	slot0:RefreshLock()
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(PLAYER_LEVEL_UP, slot0.refreshLockHandler_)

	slot0.refreshLockHandler_ = nil

	manager.redPoint:unbindUIandKey(slot0.transform_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not uv0:GetOpen() then
			slot1, slot2 = JumpTools.GetSystemLockedText({
				uv0:GetSystemID(uv0.btnType_)
			})

			if slot1 then
				ShowTips(slot2)
			end
		else
			uv0.BtnFunc_(uv0.btnType_)
			OperationRecorder.Record(uv0.class.__cname, uv0.btnType_)
		end
	end)
end

function slot0.SetBtnFunc(slot0, slot1)
	slot0.BtnFunc_ = slot1
end

function slot0.RemoveListeners(slot0)
	slot0.btn_.onClick:RemoveAllListeners()
end

function slot0.SwitchButton(slot0, slot1)
	if slot0.lastBtnType_ == slot1 then
		return
	end

	SetActive(slot0.selectMission_, slot0.btnType_ == slot1)
	SetActive(slot0.unselectMission_, slot0.btnType_ ~= slot1)

	slot0.lastBtnType_ = slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	uv0.super.Dispose(slot0)
end

function slot0.GetOpen(slot0)
	return not JumpTools.IsSystemLocked(slot0:GetSystemID(slot0.btnType_))
end

function slot0.GetSystemID(slot0, slot1)
	slot2 = nil

	if slot1 == uv0.TASK_TYPE.PLOT then
		slot2 = ViewConst.SYSTEM_ID.TASK_PLOT
	elseif slot1 == uv0.TASK_TYPE.DAILY then
		slot2 = ViewConst.SYSTEM_ID.TASK_DAILY
	elseif slot1 == uv0.TASK_TYPE.WEEK then
		slot2 = ViewConst.SYSTEM_ID.TASK_WEEK
	else
		print("未知的任务类型")
	end

	return slot2
end

function slot0.RefreshLock(slot0)
	SetActive(slot0.goLock_, not slot0:GetOpen())
end

return slot0
