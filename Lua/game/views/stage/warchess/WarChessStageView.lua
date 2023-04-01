slot0 = class("WarChessStageView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/WarChessStageUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.chapterList_ = {}
	slot0.itemList_ = {}

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})

	slot0.chapterClientID_ = slot0.params_.chapterClientID
	slot0.chapterList = ChapterClientCfg.get_id_list_by_toggle[ChapterClientCfg[ChapterClientCfg[slot0.chapterClientID_].chapter_list[1]].toggle]
	slot3 = ChapterClientCfg[slot0.chapterList[1]].chapter_list[1]
	slot8 = slot0.chapterClientID_

	BattleFieldData:SetCacheChapterClient(getChapterToggle(slot0.chapterClientID_), slot8)

	slot7 = slot0.chapterClientID_

	WarChessData:SetChapterClientID(slot7)
	slot0:RefreshItems()

	for slot7, slot8 in ipairs(slot0.itemList_) do
		slot8:OnEnter()
	end

	if slot0.params_.firstChapter then
		slot0.scrollView_.horizontalNormalizedPosition = 0.95
	elseif table.indexof(slot0.chapterList_, WarChessData:GetCurrentChapter(0)) then
		slot0.scrollView_.horizontalNormalizedPosition = (slot5 - 1) / #slot0.chapterList_
	else
		slot0.scrollView_.horizontalNormalizedPosition = WarChessData:GetViewPos()
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	WarChessData:CacheViewPos(slot0.scrollView_.horizontalNormalizedPosition)
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil

	uv0.super.Dispose(slot0)

	slot0.scrollView_ = nil
	slot0.item_ = nil
	slot0.itemParent_ = nil
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
end

function slot0.RemoveListeners(slot0)
end

function slot0.RefreshItems(slot0)
	slot0:UpdateChapterList()

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = {}

	for slot4 = #slot0.itemList_ + 1, #slot0.chapterList_ do
		slot6 = slot0:CreateItem(slot0.chapterList_[slot4])

		slot6:Show(true)
		table.insert(slot0.itemList_, slot6)
	end
end

function slot0.CreateItem(slot0, slot1)
	slot3 = ChapterCfg[ChapterClientCfg[slot1].chapter_list[1]]

	return WarChessStageItemView.New(slot0.item_, slot0.itemParent_, slot1)
end

function slot0.UpdateChapterList(slot0)
	slot0.chapterList_ = {}
	slot4 = slot0.chapterClientID_

	for slot4, slot5 in pairs(ChapterClientCfg[slot4].chapter_list) do
		if WarchessLevelCfg[slot5].switch_id == 0 then
			table.insert(slot0.chapterList_, slot5)
		elseif not SystemSwitchData:GetSwitchIDIsOpen(slot6) then
			table.insert(slot0.chapterList_, slot5)
		end
	end
end

function slot0.OnSystemSwitchUpdate(slot0)
	slot0:RefreshItems()
end

return slot0
