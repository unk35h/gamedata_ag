slot0 = class("ActivityMatrixProcessShopView", MatrixProcessShopView)

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.matrixShopList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, ActivityMatrixProcessShopItem)
	slot0.emptyController = ControllerUtil.GetController(slot0.transform_, "empty")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_sellerBtn, nil, function ()
		uv0:RandomDialog(1)
	end)
	slot0:AddBtnListener(slot0.m_refreshBtn, nil, function ()
		slot5 = uv0

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = {
				GetTips("WHETHER_TO_CONSUME"),
				{
					slot5:GetSwitchItemIcon(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN),
					uv0.refreshCost
				},
				GetTips("MATRIX_SHOP_REFRESH")
			},
			OkCallback = function ()
				ActivityMatrixAction.QueryRefreshShopItem(uv0.matrix_activity_id)
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetMatrixActivityId(slot0.matrix_activity_id)
	uv0.super.indexItem(slot0, slot1, slot2)
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})

	slot1 = manager.windowBar

	slot1:SetActivityId(ACTIVITY_MATRIX_COIN, slot0.matrix_activity_id)

	slot1 = manager.windowBar

	slot1:SetGameHelpKey("ACTIVITY_MATRIX_DESC")

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("MATRIX_SURE_GET_OUT_SHOP"),
			OkCallback = function ()
				if ActivityMatrixData:GetGameState(uv0.matrix_activity_id) == MatrixConst.STATE_TYPE.STARTED then
					ActivityMatrixAction.QueryNextProgress(uv0.matrix_activity_id)
				end

				JumpTools.OpenPageByJump("/matrixBlank/activityMatrixOrigin", {
					matrix_activity_id = uv0.matrix_activity_id
				})
			end
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	uv0.super.OnEnter(slot0)
end

function slot0.GetGameState(slot0)
	return ActivityMatrixData:GetGameState(slot0.matrix_activity_id)
end

function slot0.GetMatrixPhaseData(slot0)
	return ActivityMatrixData:GetMatrixPhaseData(slot0.matrix_activity_id)
end

function slot0.GetShoRefreshTimes(slot0)
	return ActivityMatrixData:GetShoRefreshTimes(slot0.matrix_activity_id)
end

function slot0.GetShopFressRefreshTimes(slot0)
	return ActivityMatrixData:GetShopFressRefreshTimes(slot0.matrix_activity_id)
end

function slot0.GetSwitchItemIcon(slot0, slot1)
	if slot1 == 26 then
		return ActivityMatrixTools.GetCoinItem(slot0.matrix_activity_id)
	end

	return slot1
end

return slot0
