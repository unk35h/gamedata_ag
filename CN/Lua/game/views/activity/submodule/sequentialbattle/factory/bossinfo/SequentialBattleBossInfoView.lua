slot0 = class("SequentialBattleBossInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/continuousBattle/MardukBossDetailsPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.bossUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, SequentialBattleBossInfoItem)

	slot0.bossUIList_:SetPageChangeHandler(handler(slot0, slot0.OnPageChange))
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.bossIndex_ = slot0.params_.bossIndex
	slot0.pageIndex_ = slot0.bossIndex_
	slot0.bossList_ = {}

	for slot5, slot6 in ipairs(SequentialBattleChapterCfg[slot0.activityID_].boss_list) do
		if slot6 ~= 0 then
			table.insert(slot0.bossList_, slot6)
		end
	end

	slot0.bossUIList_:StartScroll(#slot0.bossList_, slot0.pageIndex_, true, false)
	slot0:RefreshBtn()
end

function slot0.OnExti(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.bossUIList_:Dispose()

	slot0.bossUIList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.leftBtn_, nil, function ()
		if uv0.pageIndex_ > 1 then
			uv0.pageIndex_ = uv0.pageIndex_ - 1

			uv0.bossUIList_:SwitchToPage(uv0.pageIndex_)
		end
	end)
	slot0:AddBtnListener(slot0.rightBtn_, nil, function ()
		if uv0.pageIndex_ < #uv0.bossList_ then
			uv0.pageIndex_ = uv0.pageIndex_ + 1

			uv0.bossUIList_:SwitchToPage(uv0.pageIndex_)
		end
	end)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot3 = slot0.bossList_[slot1]

	slot2:SetBossID(slot3, table.keyof(SequentialBattleChapterCfg[slot0.activityID_].boss_list, slot3))
end

function slot0.OnPageChange(slot0, slot1)
	slot0.pageIndex_ = slot1

	slot0:RefreshBtn()
end

function slot0.RefreshBtn(slot0)
	SetActive(slot0.leftBtn_.gameObject, slot0.pageIndex_ > 1)
	SetActive(slot0.rightBtn_.gameObject, slot0.pageIndex_ < #slot0.bossList_)
end

return slot0
