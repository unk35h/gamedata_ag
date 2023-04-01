slot0 = class("MatrixPrepareView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/Prepare/MatrixPrepareUI"
end

function slot0.UIBackCount(slot0)
	return 2
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
	slot0:AddBtnListener(slot0.m_startButton, nil, function ()
		if MatrixConst.STATE_TYPE.STARTED == MatrixData:GetGameState() then
			JumpTools.GoToSystem("/matrixBlank/matrixOrigin")
		elseif MatrixAction.CheckTerminalGiftRedPoint(MatrixData:GetTerminalGift()) then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("MATRIX_PREPARE_ADJUST_TERMINAL"),
				BtnText = {
					GetTips("MATRIX_PREPARE_GO_ADJUST"),
					GetTips("MATRIX_PREPARE_START_CHALLENGE"),
					GetTips("MATRIX_PREPARE_GO_ADJUST")
				},
				OkCallback = function ()
					JumpTools.GoToSystem("/matrixTerminalTalent")
				end,
				CancelCallback = function ()
					JumpTools.OpenPageByJump("matrixSelect")
				end
			})
		else
			JumpTools.OpenPageByJump("matrixSelect")
		end
	end)
	slot0:AddBtnListener(slot0.m_beaconButton, nil, function ()
		JumpTools.GoToSystem("/matrixTreasureAtlas")
	end)
	slot0:AddBtnListener(slot0.m_shopButton, nil, function ()
		JumpTools.GoToSystem("/shop", {
			shopId = 13,
			showShops = {
				13
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.m_scoreButton, nil, function ()
		JumpTools.OpenPageByJump("matrixScoreExchange", nil, ViewConst.SYSTEM_ID.BAG)
	end)
	slot0:AddBtnListener(slot0.m_roleButton, nil, function ()
		JumpTools.OpenPageByJump("/matrixHero", nil, ViewConst.SYSTEM_ID.BAG)
	end)
	slot0:AddBtnListener(slot0.m_terminalBtn, nil, function ()
		JumpTools.GoToSystem("/matrixTerminalTalent")
	end)
	slot0:AddBtnListener(slot0.m_artifactlBtn, nil, function ()
		JumpTools.GoToSystem("/matrixBeaconOperate")
	end)
	slot0:AddBtnListener(slot0.m_rankBtn, nil, function ()
		MatrixAction.QueryOpenRankView()
	end)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnEnter(slot0)
	slot0:Refresh()
	manager.redPoint:bindUIandKey(slot0.m_scoreButton.gameObject.transform, RedPointConst.MATRIX_EXCHANGE_BONUS, {
		x = 125.9,
		y = 31.3
	})
	manager.redPoint:bindUIandKey(slot0.m_artifactlBtn.gameObject.transform, RedPointConst.MATRIX_BEACON_UNLOCK, {
		x = 166,
		y = 41.3
	})
	manager.redPoint:bindUIandKey(slot0.m_terminalBtn.gameObject.transform, RedPointConst.MATRIX_TERMINAL_GIFT, {
		x = 166,
		y = 41.3
	})

	if slot0.params_.isTimeOut == true then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MATRIX_TIME_LIMIT_EXCEEDED"),
			OkCallback = function ()
				uv0:CheckMail()
			end
		})

		slot0.params_.isTimeOut = false
	else
		slot0:CheckMail()
	end

	if not MatrixData:GetCurRank(MatrixConst.MatirxRankSubType.COMMON) then
		MatrixAction.QueryCurRank(MatrixConst.MatirxRankSubType.COMMON)
	end
end

function slot0.CheckMail(slot0)
	if PlayerData:GetUnclaimed(1) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function ()
				PlayerAction.ReadUnclaimedMessage(1)
			end
		})
	end
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.m_scoreButton.gameObject.transform, RedPointConst.MATRIX_EXCHANGE_BONUS)
	manager.redPoint:unbindUIandKey(slot0.m_artifactlBtn.gameObject.transform, RedPointConst.MATRIX_BEACON_UNLOCK)
	manager.redPoint:unbindUIandKey(slot0.m_terminalBtn.gameObject.transform, RedPointConst.MATRIX_TERMINAL_GIFT)
	manager.windowBar:HideBar()

	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end
end

function slot0.Refresh(slot0)
	slot0:RefreshTimer()

	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end

	slot0.countdownTimer_ = Timer.New(function ()
		uv0:RefreshTimer()
	end, 1, -1)

	slot0.countdownTimer_:Start()
	slot0:RefreshRank()
end

function slot0.OnMatrixSystemUpdate(slot0)
	slot0:Refresh()
end

function slot0.OnMatrixSystemOverdue(slot0)
	ShowMessageBox({
		ButtonType = "SingleBtn",
		title = GetTips("PROMPT"),
		content = GetTips("MATRIX_TIME_LIMIT_EXCEEDED")
	})
end

function slot0.RefreshTimer(slot0)
	slot0.m_timer.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStr(MatrixData:GetNextRefreshTime()))
end

function slot0.RefreshRank(slot0)
	if MatrixData:GetCurRank(MatrixConst.MatirxRankSubType.COMMON) and slot1.rank ~= 0 then
		slot0.m_score.text = slot1.score
	else
		slot0.m_score.text = GetTips("MATRIX_RANK_NO_INFO")
	end
end

function slot0.OnMatrixCurRankUpdate(slot0)
	slot0:RefreshRank()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
