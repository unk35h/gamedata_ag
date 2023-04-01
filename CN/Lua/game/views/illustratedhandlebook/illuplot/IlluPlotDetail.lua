slot0 = class("IlluPlotDetail", ReduxView)

function slot0.UIName(slot0)
	return "UI/IllustratedHandbook/IlluPlotDetailUI"
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

	slot0.scroll_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, IlluPlotDetailItem)
end

function slot0.AddUIListener(slot0)
end

function slot0.UpdateDate(slot0)
	slot0.itemList_ = slot0.list_

	table.sort(slot0.itemList_, function (slot0, slot1)
		if CollectStoryCfg[slot0].order ~= CollectStoryCfg[slot1].order then
			return slot2.order < slot3.order
		end

		return slot0 < slot1
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.itemList_[slot1], slot0.selType_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 == 1 then
		getSpriteWithoutAtlasAsync(SpritePathCfg.CollectPlotBig.path .. ChapterClientCfg[slot0.chapterID_].chapter_paint, function (slot0)
			uv0.bgImg_.sprite = slot0
		end)
	elseif slot1 == 2 then
		getSpriteWithoutAtlasAsync(SpritePathCfg.CollectPlotBig.path .. CollectStoryCfg[CollectStoryCfg.get_id_list_by_activity[slot0.chapterID_][1]].picture, function (slot0)
			uv0.bgImg_.sprite = slot0
		end)
	elseif slot1 == 3 then
		getSpriteWithoutAtlasAsync(SpritePathCfg.CollectPlotBig.path .. BirthdayCfg[slot0.chapterID_].picture_path, function (slot0)
			uv0.bgImg_.sprite = slot0
		end)
	end

	slot0:UpdateDate()
	slot0.scroll_:StartScroll(#slot0.itemList_)
end

function slot0.OnEnter(slot0)
	slot0:ShowDefaultBar()

	if not slot0:CheckIsRefresh() then
		return
	end

	slot0.list_ = slot0.params_.storyList
	slot0.chapterID_ = slot0.params_.chapterID
	slot0.selType_ = slot0.params_.selType

	slot0:RefreshUI(slot0.selType_)
end

function slot0.CheckIsRefresh(slot0)
	if not slot0.list_ then
		return true
	end

	for slot4, slot5 in pairs(slot0.params_.storyList) do
		if slot0.list_[slot4] ~= slot5 then
			return true
		end
	end

	if slot0.chapterID_ ~= slot0.params_.chapterID or slot0.selType_ ~= slot0.params_.selType then
		return true
	end

	return false
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.scroll_:Dispose()

	slot0.scroll_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
