slot0 = class("GuildActivitySignUpView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivityUI/GuildActivitytSignupUI"
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

	slot0.isSignedUpController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isSignedUp")
	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.signupBtn_, nil, function ()
		if GameSetting.activity_club_user_level_limit.value[1] <= PlayerData:GetPlayerInfo().userLevel then
			GuildActivityAction.Register(function ()
				if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) then
					StartGuildActivity(GuildActivityData:GetCurrentGrid())
				else
					uv0:UpdateView()
				end
			end)
		else
			ShowTips("ACTIVITY_CLUB_REGISTER_CANT_TIP")
		end
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	slot0:ShowDefaultBar()
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
	slot0:StartTimer()
	slot0:UpdateTimer()
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	slot0:StopTimer()
end

function slot0.UpdateView(slot0)
	slot0.isSignedUpController_:SetSelectedState(GuildActivityData:HaveRegister() and "true" or "false")

	slot1 = nil
	slot0.conditionLabel_.text = (GameSetting.activity_club_user_level_limit.value[1] > PlayerData:GetPlayerInfo().userLevel or string.format(GetTips("UPGRADE_LIMIT_LEVEL"), slot3)) and string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), slot3)
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.UpdateTimer(slot0)
	slot1, slot2 = nil
	slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr(ActivityData:GetActivityData(ActivityConst.GUILD_ACTIVITY).stopTime)

	if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) then
		slot0.statusController_:SetSelectedState("resignup")
	else
		slot0.statusController_:SetSelectedState("signup")
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

return slot0
