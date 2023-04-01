slot0 = class("ActivityMatrixClueView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeCluesToCollectUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, ActivityMatrixClueItem)
	slot0.pageIndex_ = 1
	slot0.clues = {}
end

function slot0.AddUIListeners(slot0)
	slot1 = slot0.list_

	slot1:SetPageChangeHandler(handler(slot0, slot0.OnPageChange))
	slot0:AddBtnListener(slot0.m_preBtn, nil, function ()
		uv0.list_:SwitchToPage(uv0.pageIndex_ - 1)
	end)
	slot0:AddBtnListener(slot0.m_nextBtn, nil, function ()
		uv0.list_:SwitchToPage(uv0.pageIndex_ + 1)
	end)
end

function slot0.OnPageChange(slot0, slot1)
	slot0.pageIndex_ = slot1

	ActivityMatrixAction.SetSelectClue(slot1)

	if slot0.clues[slot1] then
		ActivityMatrixAction.SetClueRead(slot0.main_matrix_activity_id, slot2.clue_id)
	end

	slot3 = false

	for slot7, slot8 in ipairs(slot0.clues) do
		if not ActivityMatrixData:GetClueRead(slot0.main_matrix_activity_id, slot8.clue_id) then
			slot3 = true

			break
		end
	end

	manager.redPoint:SetRedPointIndependent(slot0.m_nextBtn.transform, slot3)
	SetActive(slot0.m_preBtn.gameObject, slot1 > 1)
	SetActive(slot0.m_nextBtn.gameObject, slot1 < #slot0.clues)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
end

function slot0.OnEnter(slot0)
	slot0.main_matrix_activity_id = slot0.params_.main_matrix_activity_id
	slot0.clues = ActivityMatrixData:GetMatrixClue(slot0.main_matrix_activity_id)

	slot0.list_:StartScroll(#slot0.clues, 1, true, false)

	slot1 = math.min(ActivityMatrixAction:GetSelectClue(), #slot0.clues)

	slot0.list_:SwitchToPage(slot1)
	slot0:OnPageChange(slot1)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.clues[slot1].clue_id)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
