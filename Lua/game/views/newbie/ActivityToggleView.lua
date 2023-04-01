slot0 = class("ActivityToggleView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")

	if slot2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.SIGN then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.NEWBIE_SIGN)
	elseif slot2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.TASK then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.NEWBIE_TASK)
	elseif slot2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.UPGRADE then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.NEWBIE_UPGRADE)
	elseif slot2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.DAILY_TASK then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.NEWBIE_DAILY_TASK)
	elseif slot2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.RECHARGE then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.NEWBIE_RECHARGE)
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:Go("/activityNewbie", {
			activityType = uv0.index_
		})
	end)
end

function slot0.SetSelect(slot0, slot1)
	if slot0.index_ == slot1 then
		slot0.controller_:SetSelectedState("0")
	else
		slot0.controller_:SetSelectedState("1")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
end

return slot0
