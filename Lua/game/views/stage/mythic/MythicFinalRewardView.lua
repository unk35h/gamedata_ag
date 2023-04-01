slot0 = class("MythicFinalRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Mythic/MythicRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.mytrans_, "ispass")
	slot0.hotrewardList_ = LuaList.New(handler(slot0, slot0.RefreashItem), slot0.list_, MythicFinalRewardItem)
end

function slot0.OnEnter(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0.timetext_.text = manager.time:GetLostTimeStr(MythicData:GetNextRefreshTime())
		end, 1, -1)

		slot0.timer_:Start()
	end

	slot0.timetext_.text = manager.time:GetLostTimeStr(MythicData:GetNextRefreshTime())
	slot0.passtext_.text = string.format(GetTips("MYTHIC_FINAL_REWARD_FOLLOW_TIPS"), MythicData:GetPassHotLevel())

	slot0:RefreashUI()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveallbtn_, nil, function ()
		if MythicData:GetFinalIsReward() == 0 then
			ShowMessageBox({
				content = GetTips("MYTHIC_REWARD_LOACK_DIFFICULTY"),
				OkCallback = function ()
					MythicAction:GetAllFinalReward()
				end
			})
		else
			MythicAction:GetAllFinalReward()
		end
	end)
end

function slot0.RefreashItem(slot0, slot1, slot2)
	slot2:SetData(slot1)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopTimer()
end

function slot0.OnMythicFinalGetReward(slot0)
	slot0:RefreashUI()
end

function slot0.RefreashUI(slot0)
	if MythicData:GetPassHotLevel() > 0 then
		if MythicData:GetIsHaveRewardNotGet() then
			slot0.controller_:SetSelectedState("true")
		else
			slot0.controller_:SetSelectedState("noreward")
		end
	else
		slot0.controller_:SetSelectedState("false")
	end

	MythicData:SortRewards()
	slot0.hotrewardList_:StartScroll(#MythicFinalCfg.all)
end

function slot0.Dispose(slot0)
	if slot0.hotrewardList_ then
		slot0.hotrewardList_:Dispose()

		slot0.hotrewardList_ = nil
	end

	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
