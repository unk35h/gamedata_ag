slot0 = class("BackHomeEnterView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/BackHouseUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.canteenBtn_, nil, function ()
		JumpTools.GoToCanteen()
	end)
	slot0:AddBtnListenerScale(slot0.dormBtn_, nil, function ()
		JumpTools.GoToDorm()
	end)
	slot0:AddBtnListenerScale(slot0.lockBtn_, nil, function ()
		ShowTips(GetTips("DORM_AREA_NOT_OPEN"))
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.OpenPageByJump("/home")
	end)
	manager.redPoint:bindUIandKey(slot0.dormBtn_.transform, RedPointConst.DORM)
	manager.redPoint:bindUIandKey(slot0.canteenBtn_.transform, RedPointConst.CANTEEN)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.dormBtn_.transform, RedPointConst.DORM)
	manager.redPoint:unbindUIandKey(slot0.canteenBtn_.transform, RedPointConst.CANTEEN)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
