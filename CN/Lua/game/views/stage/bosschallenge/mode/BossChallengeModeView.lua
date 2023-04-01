slot0 = class("BossChallengeModeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BossChallenge/BossSelectModeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = ControllerUtil.GetController(slot0.btnTransform_, "conName")
	slot0.chooseHandler_ = handler(slot0, slot0.ChooseMode)
	slot0.modeUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, BossChallengeModeItem)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_MODE_DESC")
	manager.notify:RegistListener(CHALLENGE_CHOOSE_MODE, slot0.chooseHandler_)
	slot0.modeUIList_:StartScroll(#BossChallengeAdvanceCfg.all, 1)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0.chooseIndex_ = nil

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CHALLENGE_CHOOSE_MODE, slot0.chooseHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.chooseHandler_ = nil

	if slot0.modeUIList_ then
		slot0.modeUIList_:Dispose()

		slot0.modeUIList_ = nil
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.chooseBtn_, nil, function ()
		if uv0.chooseIndex_ == nil then
			return
		end

		uv0:ClickBtn()
	end)
end

function slot0.ClickBtn(slot0)
	if BossChallengeAdvanceCfg[BossChallengeAdvanceCfg.all[slot0.chooseIndex_]].type == 1 then
		BattleBossChallengeAction.RequireBossChallengeData(slot1, function ()
			uv0:Go("/bossSwitch", nil, true)
		end)
	else
		BattleBossChallengeAction.RequireBossChallengeData(slot1, function ()
			uv0:Go("/bossAdvanceSwitch", nil, true)
		end)
	end
end

function slot0.RefreshUI(slot0)
	slot0:ChooseMode(slot0.chooseIndex_)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.chooseIndex_)
end

function slot0.ChooseMode(slot0, slot1)
	slot0.chooseIndex_ = slot1

	if slot1 then
		slot0.selectController_:SetSelectedState("yellow")
	else
		slot0.selectController_:SetSelectedState("black")
	end
end

return slot0
