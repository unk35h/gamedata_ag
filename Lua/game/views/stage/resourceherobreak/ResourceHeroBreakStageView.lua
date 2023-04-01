slot0 = class("ResourceHeroBreakStageView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/RoleSurmountUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
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
	slot4 = ChapterClientCfg[ChapterClientCfg.get_id_list_by_toggle[ChapterClientCfg[ChapterClientCfg[slot0.chapterClientID_].chapter_list[1]].toggle][1]].chapter_list[1]
	slot8 = getChapterToggle(slot0.chapterClientID_)
	slot9 = slot0.chapterClientID_

	BattleFieldData:SetCacheChapterClient(slot8, slot9)
	slot0:RefreshItems()

	for slot8, slot9 in ipairs(slot0.itemList_) do
		slot9:OnEnter()
	end

	slot0:Display()
end

function slot0.Display(slot0)
	slot0:BreakDisplay()

	slot0.scrollView_.horizontalNormalizedPosition = 0
	slot0.scrollView_.enabled = false
	slot1 = 1
	slot0.timer_ = Timer.New(function ()
		uv0.itemList_[uv1]:Show(true)

		if uv1 == #uv0.itemList_ then
			uv0.scrollView_.enabled = true
		end

		uv1 = uv1 + 1
	end, 0.03, #slot0.itemList_)

	slot0.timer_:Start()
end

function slot0.BreakDisplay(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:BreakDisplay()
	slot0:StopTimer()

	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:OnExit()
	end
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
	for slot5 = #slot0.itemList_ + 1, #ChapterClientCfg[slot0.chapterClientID_].chapter_list do
		table.insert(slot0.itemList_, slot0:CreateItem(slot1[slot5]))
	end
end

function slot0.CreateItem(slot0, slot1)
	slot3 = ChapterCfg[ChapterClientCfg[slot1].chapter_list[1]]

	return ResourceHeroBreakStageItem.New(slot0.item_, slot0.itemParent_, slot1)
end

function slot0.InitPosition(slot0)
	slot2 = ChapterClientCfg[ChapterClientCfg[slot0.chapterClientID_].chapter_list[1]].toggle
	slot4 = BattleFieldData:GetSecondCacheChapter(slot2)
	slot5 = 1

	for slot9, slot10 in ipairs(ChapterClientCfg.get_id_list_by_toggle[slot2]) do
		if slot10 == slot4 then
			slot5 = slot9

			break
		end
	end

	slot0:StopTimer()

	slot0.scrollTimer_ = Timer.New(function ()
		uv0.scrollView_.horizontalNormalizedPosition = uv1 / #uv2
	end, 0.013, 1)

	slot0.scrollTimer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.scrollTimer_ then
		slot0.scrollTimer_:Stop()

		slot0.scrollTimer_ = nil
	end
end

return slot0
