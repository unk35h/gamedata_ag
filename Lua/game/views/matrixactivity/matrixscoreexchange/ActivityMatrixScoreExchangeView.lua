slot0 = class("ActivityMatrixScoreExchangeMiniView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeRewardshow"
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

	slot0.exchangeList = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scoreListGo_, ActivityMatrixScoreExchangeItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.oneKeyGetBtn_, nil, function ()
		slot0 = {}
		slot1 = ActivityMatrixData:GetMatrixScore(uv0.matrix_activity_id)

		for slot5, slot6 in ipairs(uv0.rewards) do
			if ActivityPointRewardCfg[slot6].need <= slot1 and not ActivityMatrixData:GetMatrixPointRewardState(uv0.matrix_activity_id, slot6) then
				table.insert(slot0, slot6)
			end
		end

		ActivityAction.ReceivePointReward(slot0)
	end)
	slot0:AddBtnListener(slot0.bgMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id
	slot0.rewards = ActivityPointRewardCfg.get_id_list_by_activity_id[slot0.matrix_activity_id] or {}

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

	slot0.m_name.text = ActivityMatrixCfg[slot0.matrix_activity_id].name
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

function slot0.OnReceivePointReward(slot0)
	slot0:Refresh()
	slot0.exchangeList:Refresh()
end

return slot0
