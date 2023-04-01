slot0 = class("SummerCooperationCreatRoomView", ReduxView)

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/Cooperation/SummerCooperationCreatRoomUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_createRoomBtn, nil, function ()
		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			CooperationAction.CreateRoom(uv0.activity_id, BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO, 2, {
				CooperationData:GetCooperationHero(uv0.dest)
			})
		end
	end)
	slot0:AddBtnListener(slot0.m_joinRoomBtn, nil, function ()
		CooperationAction.JoinRoom(tonumber(uv0.m_roomIdInput.text), {
			{
				hero_id = 108401,
				owner_id = 0,
				hero_type = 2
			}
		})
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.activity_id = ActivityConst.COOPERATION_DEMO
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
