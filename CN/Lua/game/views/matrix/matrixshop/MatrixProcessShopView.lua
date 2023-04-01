slot0 = class("MatrixProcessShopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/Process/MatrixProcessShopUI"
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

	slot0.matrixShopList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, MatrixProcessShopItem)
	slot0.emptyController = ControllerUtil.GetController(slot0.transform_, "empty")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_sellerBtn, nil, function ()
		uv0:RandomDialog(1)
	end)
	slot0:AddBtnListener(slot0.m_refreshBtn, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = {
				GetTips("WHETHER_TO_CONSUME"),
				{
					CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
					uv0.refreshCost
				},
				GetTips("MATRIX_SHOP_REFRESH")
			},
			OkCallback = function ()
				MatrixAction.QueryRefreshShopItem()
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.shops[slot1])
end

function slot0.UpdateView(slot0, slot1)
	slot0.refreshCount, slot0.shops = slot0:GetMatrixPhaseData():GetData()

	slot0.matrixShopList_:StartScroll(#slot0.shops)

	if slot1 then
		slot0.matrixShopList_:StartScrollByPosition(#slot0.shops, slot1)
	else
		slot0.matrixShopList_:StartScroll(#slot0.shops)
	end

	if #slot0.shops == 0 then
		slot0.emptyController:SetSelectedIndex(1)
	else
		slot0.emptyController:SetSelectedIndex(0)
	end

	slot4 = slot0:GetShopFressRefreshTimes()

	if slot0.refreshCount < slot0:GetShoRefreshTimes() then
		SetActive(slot0.m_refreshContent, true)

		slot0.refreshCost = 0
		slot0.m_refreshTimes.text = string.format("%d/%d", slot0.refreshCount, slot3)
		slot5 = GameSetting.matrix_shop_refresh_cost_item_list.value

		if slot4 <= slot0.refreshCount then
			slot8 = slot5[math.min(slot0.refreshCount - slot4 + 1, #slot5)]
			slot0.refreshCost = slot8[2]
			slot0.m_refreshIcon.sprite = ItemTools.getItemLittleSprite(slot0:GetSwitchItemIcon(slot8[1]))
		else
			slot0.m_refreshIcon.sprite = ItemTools.getItemLittleSprite(slot0:GetSwitchItemIcon(slot5[1][1]))
			slot0.refreshCost = 0
		end

		slot0.m_refreshCost.text = "x" .. slot0.refreshCost
	else
		SetActive(slot0.m_refreshContent, false)
	end
end

function slot0.RandomDialog(slot0, slot1)
	if not MatrixShopDialogCfg.get_id_list_by_type[slot1] then
		return
	end

	SetActive(slot0.m_bubbleGo, true)

	slot3 = #slot2

	if #slot2 == 1 then
		slot0.curRandomIndex_ = 1
	else
		slot0.curRandomIndex_ = math.random(2, slot3) == slot0.curRandomIndex_ and 1 or slot4
	end

	slot5 = MatrixShopDialogCfg[slot2[slot0.curRandomIndex_]]
	slot0.m_dialogText.text = slot5.content
	slot7 = slot5.voice_name

	if slot5.voice_sheet ~= nil and slot6 ~= "" and slot7 ~= nil and slot7 ~= "" then
		manager.audio:PlayVoice(slot6, slot7, "")
	end

	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:RemoveDialog()
		end, 3, 1)

		slot0.timer_:Start()
	else
		slot0.timer_:Reset()
	end
end

function slot0.RemoveDialog(slot0)
	SetActive(slot0.m_bubbleGo, false)

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
	slot0:RandomDialog(2)
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN
	})

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, false)

	slot1 = manager.windowBar

	slot1:SetGameHelpKey("MATRIX_DESCRIPE")

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("MATRIX_SURE_GET_OUT_SHOP"),
			OkCallback = function ()
				if uv0:GetGameState() == MatrixConst.STATE_TYPE.STARTED then
					MatrixAction.QueryNextProgress()
				end

				JumpTools.OpenPageByJump("/matrixBlank/matrixOrigin")
			end
		})
	end)
end

function slot0.OnExit(slot0)
	slot0:RemoveDialog()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	if slot0.matrixShopList_ then
		slot0.matrixShopList_:Dispose()

		slot0.matrixShopList_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnMatrixUserUpdate(slot0)
	if MatrixConst.STATE_TYPE.STARTED == slot0:GetGameState() then
		slot0:UpdateView()
	elseif MatrixConst.STATE_TYPE.NOTSTARTED == slot1 then
		JumpTools.OpenPageByJump("/matrixBlank/matrixPrepare", {
			isTimeOut = true
		})
	end
end

function slot0.OnMatrixShopBuySuccess(slot0)
	slot0:RandomDialog(3)
end

function slot0.OnMatrixSystemUpdate(slot0)
	slot0:UpdateView(slot0.matrixShopList_:GetScrolledPosition())
end

function slot0.OnMatrixUserUpdate(slot0)
	slot0:UpdateView(slot0.matrixShopList_:GetScrolledPosition())
end

function slot0.GetGameState(slot0)
	return MatrixData:GetGameState()
end

function slot0.GetMatrixPhaseData(slot0)
	return MatrixData:GetMatrixPhaseData()
end

function slot0.GetShoRefreshTimes(slot0)
	return MatrixData:GetShoRefreshTimes()
end

function slot0.GetShopFressRefreshTimes(slot0)
	return MatrixData:GetShopFressRefreshTimes()
end

function slot0.GetSwitchItemIcon(slot0, slot1)
	return slot1
end

return slot0
