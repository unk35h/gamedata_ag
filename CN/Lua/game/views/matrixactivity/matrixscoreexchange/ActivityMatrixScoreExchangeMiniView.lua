slot0 = class("ActivityMatrixScoreExchangeMiniView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/ScoreExchange/MatrixScoreExchangeMiniUI"
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

	slot0.exchangeList = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scoreListGo_, ActivityMatrixScoreExchangeMiniItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.oneKeyGetBtn_, nil, function ()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id
	slot0.rewards = ActivityPointRewardCfg.get_id_list_by_activity_id[slot0.matrix_activity_id]

	slot0.exchangeList:StartScroll(#slot0.rewards)
	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot6 = ActivityMatrixData:GetMatrixScore(slot0.matrix_activity_id)
	slot0.myScoreText_.text = string.format("%d", slot6)
	slot2 = false

	for slot6, slot7 in ipairs(slot0.rewards) do
		if ActivityPointRewardCfg[slot7].need <= slot1 and not ActivityMatrixData:GetMatrixPointRewardState(slot0.matrix_activity_id, slot7) then
			slot2 = true

			break
		end
	end

	SetActive(slot0.oneKeyGetBtn_.gameObject, slot2)

	slot0.countdownText_.text = ""
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.rewards[slot1], slot0.matrix_activity_id)
end

function slot0.Dispose(slot0)
	slot0.exchangeList:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
