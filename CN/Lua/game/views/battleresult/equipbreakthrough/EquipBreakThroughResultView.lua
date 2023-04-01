slot0 = class("EquipBreakThroughResultView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapSettlementUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.heroView_ = EquipBreakThroughResultHeroView.New(slot0.heroPanel_)
	slot0.resultInfoView_ = EquipBreakThroughResultInfoView.New(slot0.infoPanel_)

	LeanTween.alphaCanvas(slot0.maskCanvas_, 0, 0.1)
	slot0:AddTimer()
end

function slot0.OnEnter(slot0)
	slot0.stageData_ = slot0.params_.stageData

	BattleInstance.hideBattlePanel()

	if slot0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function ()
				uv0:CloseFunc()
			end
		})
	end

	slot0.heroView_:SetData(slot0.stageData_)
	slot0.resultInfoView_:SetData(slot0.stageData_)
end

function slot0.OnExit(slot0)
	slot0.heroView_:OnExit()
	slot0.resultInfoView_:OnExit()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.heroView_:Dispose()

	slot0.heroView_ = nil

	slot0.resultInfoView_:Dispose()

	slot0.resultInfoView_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:CloseFunc()
	end)
	slot0:AddBtnListener(slot0.stasticsBtn_, nil, function ()
		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = uv0.stageData,
			battleTime = uv0:GetBattleTime()
		})
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:EndAnimator()
	end)
end

function slot0.CloseFunc(slot0)
	BattleInstance.QuitBattle(slot0.stageData_)
end

function slot0.GetBattleTime(slot0)
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function slot0.EndAnimator(slot0)
	slot0:StopTimer()

	slot0.maskCanvas_.blocksRaycasts = false
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		uv0:EndAnimator()
	end, 1, 1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()
	end
end

return slot0
