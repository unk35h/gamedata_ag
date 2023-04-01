slot0 = class("AchievementStoryView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Achievement/AchievementStoryUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.storyItemList_ = {}

	for slot4, slot5 in ipairs(AchievementStoryCfg.all) do
		slot0.storyItemList_[slot5] = AchievementStoryItem.New(slot0[string.format("goItem%s_", slot4)], slot5)
	end
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)

	slot4 = CurrencyConst.CURRENCY_TYPE_DIAMOND
	slot5 = true

	manager.windowBar:SetBarCanAdd(slot4, slot5)

	for slot4, slot5 in pairs(slot0.storyItemList_) do
		slot5:Refresh()
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.storyItemList_) do
		slot5:Dispose()
	end

	slot0.storyItemList_ = nil
end

return slot0
