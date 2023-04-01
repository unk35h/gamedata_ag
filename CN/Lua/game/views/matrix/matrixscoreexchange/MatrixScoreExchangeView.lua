slot0 = class("MatrixScoreExchangeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/ScoreExchange/MatrixScoreExchangeUI"
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

	slot0.exchangeList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.scoreListGo_, MatrixScoreExchangeItem)
	slot0.passController = ControllerUtil.GetController(slot0.transform_, "pass")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.oneKeyGetBtn_, nil, function ()
		slot0 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_MATRIX_PT)
		slot1 = false
		slot4 = MatrixData
		slot6 = slot4

		for slot5, slot6 in pairs(slot4.GetPointRewardList(slot6)) do
			if MatrixPointRankCfg[slot6.rank].point <= slot0 and slot6.is_got_reward == 0 then
				slot1 = true

				break
			end
		end

		if slot1 then
			MatrixAction.OneKeyGetBonus()
		end
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		if slot0 == CurrencyConst.CURRENCY_TYPE_MATRIX_PT then
			uv0:UpdateView()

			slot3 = uv0.exchangeList_
			slot5 = slot3

			for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
				slot5:UpdateView()
			end
		end
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = MatrixData:GetPointRewardList()

	slot2:SetData(slot1, slot3[slot1].rank, slot3[slot1].item_list, slot3[slot1].is_got_reward, slot3[slot1].need_level)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnMatrixSystemUpdate(slot0)
	slot0:UpdateView()
end

function slot0.OnMatrixUserUpdate(slot0)
	slot0:UpdateView()
end

function slot0.OnGetMatrixExchangeBonus(slot0)
	slot0:UpdateView()
	slot0.exchangeList_:StartScrollWithoutAnimator(#MatrixData:GetPointRewardList())
end

function slot0.UpdateView(slot0)
	slot0.myScoreText_.text = string.format("%d", CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_MATRIX_PT))
	slot2 = false
	slot3 = MatrixData:GetTerminalLevel()
	slot6 = MatrixData
	slot8 = slot6

	for slot7, slot8 in pairs(slot6.GetPointRewardList(slot8)) do
		if MatrixPointRankCfg[slot8.rank].point <= slot1 and slot8.is_got_reward == 0 and slot8.need_level <= slot3 then
			slot2 = true

			break
		end
	end

	if slot1 == 0 then
		slot0.passController:SetSelectedIndex(0)
	elseif slot2 then
		slot0.passController:SetSelectedIndex(1)
	else
		slot0.passController:SetSelectedIndex(2)
	end
end

function slot0.OnTop(slot0)
	slot0:UpdateView()

	slot3 = slot0.exchangeList_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:UpdateView()
	end
end

function slot0.OnEnter(slot0)
	slot0:UpdateBar()
	slot0.exchangeList_:StartScroll(#MatrixData:GetPointRewardList())

	slot0.timer_ = Timer.New(function ()
		uv0.countdownText_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(MatrixData:GetNextRefreshTime()))
	end, 0.2, -1)

	slot0.timer_:Start()
	slot0:UpdateView()

	slot0.terminalLv = MatrixData:GetTerminalLevel()

	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnTerminalExpChange))
end

function slot0.OnTerminalExpChange(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_MATRIX_TERMINAL_EXP then
		MatrixData:UpdateTerminalLevel()

		if slot0.terminalLv ~= MatrixData:GetTerminalLevel() then
			slot0.terminalLv = slot2

			JumpTools.OpenPageByJump("matrixTerminalLevelUpgrade", {
				newLv = slot2
			})
		end
	end
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	if slot0.exchangeList_ then
		slot0.exchangeList_:Dispose()

		slot0.exchangeList_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnMatrixSystemOverdue(slot0)
	slot0:Back()
end

return slot0
