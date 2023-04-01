slot0 = class("AchievementManagerView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Achievement/AchievementManagerUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.noticeRectList_ = {
		slot0.goCultivate_,
		slot0.goCollect_,
		slot0.goMission_,
		slot0.goPlayer_,
		slot0.goBattle_,
		slot0.goOther_
	}
	slot0.achievementButtonList_ = {}

	for slot4, slot5 in pairs(AchievementConst.AchievementType) do
		slot0.achievementButtonList_[slot5] = AchievementManagerButton.New(slot0.noticeRectList_[slot5], slot5)
	end

	slot0:AddListeners()
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
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	SetActive(slot0.goRedPoint_, manager.redPoint:getTipValue(RedPointConst.ACHIEVEMENT_STORY) > 0)

	for slot4, slot5 in pairs(slot0.achievementButtonList_) do
		slot5:OnEnter()
	end

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.noticeRectList_ = nil

	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.achievementButtonList_) do
		slot5:Dispose()
	end

	slot0.achievementButtonList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonStory_, nil, function ()
		uv0:Go("/achievementStory")
	end)
end

function slot0.RefreshUI(slot0)
	slot0.textAchievement_.text = AchievementData:GetFinishAchievementCnt()
	slot0.textTotalCnt_.text = string.format("/%s", AchievementData:GetAchievementTotalCnt())

	if AchievementData:GetCurrentLevelPoint() < AchievementData:GetCurrentPoint() then
		slot1 = slot2
	end

	slot0.textPoint_.text = slot1
	slot0.textTotalPoint_.text = string.format("/%s", slot2)
	slot3 = slot1 / slot2
	slot0.imageProcess_.value = slot3
	slot0.imageSlider_.fillAmount = slot3
end

return slot0
