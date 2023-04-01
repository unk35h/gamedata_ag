slot0 = class("FireWorkResultView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/Firework/FireworkMakingUI"
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

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		slot0 = uv0.params_.fire_activity_id

		if uv0.isWin then
			JumpTools.OpenPageByJump("/fireWorkShow", {
				fire_activity_id = slot0
			})
		else
			JumpTools.OpenPageByJump("fireWorkMake", {
				start = true,
				fire_activity_id = slot0
			})
		end
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.isWin = slot0.params_.isWin

	if slot0.isWin then
		slot0.stateController:SetSelectedIndex(1)
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_good", "")
	else
		slot0.stateController:SetSelectedIndex(0)
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_no", "")
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
