slot0 = class("DemoCooperationEntryView", ReduxView)

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/Cooperation/Demo/DemoCooperationUI"
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
	slot0:AddBtnListener(nil, slot0.m_createRoomBtn, function ()
		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			CooperationAction.CreateRoom(uv0.activity_id, BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO, 2, {
				CooperationData:GetCooperationHero(uv0.dest)
			})
		end
	end)
	slot0:AddBtnListener(nil, slot0.m_quickJoinBtn, function ()
		CooperationAction.QuickJoinRoom(uv0.activity_id, BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO, {
			CooperationData:GetCooperationHero(uv0.dest)
		})
	end)
	slot0:AddBtnListener(nil, slot0.m_inviteBtn, function ()
		JumpTools.OpenPageByJump("cooperationApply", {
			room_type = BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO
		})
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	slot0:CheckCooperationInviteEntry()
end

function slot0.OnEnter(slot0)
	slot0.activity_id = ActivityConst.COOPERATION_DEMO
	slot1 = ActivityCooperationDemoCfg[slot0.activity_id]
	slot0.m_stageName.text = slot1.stage_name
	slot0.m_stageDes.text = slot1.stage_des

	manager.redPoint:bindUIandKey(slot0.m_inviteBtn.transform, string.format("%s_%s", RedPointConst.COOPERATION_INVIT, BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO))
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.m_inviteBtn.transform, string.format("%s_%s", RedPointConst.COOPERATION_INVIT, BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO))
end

function slot0.GetCooperationInviteEntryGo(slot0)
	return slot0.m_inviteBtn.gameObject
end

return slot0
