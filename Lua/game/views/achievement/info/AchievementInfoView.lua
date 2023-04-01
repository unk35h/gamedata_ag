slot0 = class("AchievementInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Achievement/AchievementInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.noticeRectList_ = {
		slot0.rectCultivate_,
		slot0.rectCollect_,
		slot0.rectMission_,
		slot0.rectPlayer_,
		slot0.rectBattle_,
		slot0.rectOther_
	}
	slot0.goButtonList_ = {
		slot0.goCultivate_,
		slot0.goCollect_,
		slot0.goMission_,
		slot0.goPlayer_,
		slot0.goBattle_,
		slot0.goOther_
	}
	slot0.scrollPositionList_ = {}
	slot4 = slot0.uiList_
	slot5 = AchievementInfoItem
	slot0.achievementUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot4, slot5)
	slot0.achievementButtonList_ = {}

	for slot4, slot5 in pairs(AchievementConst.AchievementType) do
		slot0.achievementButtonList_[slot5] = AchievementInfoButton.New(slot0.goButtonList_[slot5], slot5)
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

	slot0.selectType_ = slot0.params_.achievementType

	slot0:RefreshScroll()
	slot0:RefreshButton()

	for slot4, slot5 in ipairs(AchievementCfg.get_id_list_by_type_id) do
		manager.redPoint:bindUIandKey(slot0.noticeRectList_[slot4], string.format("%s_%s", RedPointConst.ACHIEVEMENT, slot4))
	end

	slot0:RefreshText()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in ipairs(AchievementCfg.get_id_list_by_type_id) do
		manager.redPoint:unbindUIandKey(slot0.noticeRectList_[slot4])
	end

	slot0.scrollPositionList_ = {
		[slot0.selectType_] = slot0.achievementUIList_:GetScrolledPosition()
	}
end

function slot0.OnUpdate(slot0)
	if slot0.selectType_ == slot0.params_.achievementType then
		slot0.scrollPositionList_[slot0.selectType_] = slot0.achievementUIList_:GetScrolledPosition()

		AchievementData:SetScrollRecord(true)
	end

	slot0.selectType_ = slot0.params_.achievementType

	slot0:RefreshScroll()
	slot0:RefreshButton()
	slot0:RefreshText()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.achievementButtonList_) do
		slot5:Dispose()
	end

	slot0.achievementButtonList_ = nil

	if slot0.achievementUIList_ then
		slot0.achievementUIList_:Dispose()

		slot0.achievementUIList_ = nil
	end
end

function slot0.RefreshButton(slot0)
	for slot4, slot5 in pairs(slot0.achievementButtonList_) do
		slot5:RefreshSelectType(slot0.selectType_)
	end
end

function slot0.RefreshScroll(slot0)
	slot0.achievementIDList_ = AchievementData:GetAchievementIDList(slot0.selectType_)
	slot1 = nil

	slot0.achievementUIList_:StartScrollByPosition(#slot0.achievementIDList_, AchievementData:GetScrollRecord() == true and (slot0.scrollPositionList_[slot0.selectType_] or Vector3.one) or Vector3.one)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot0.achievementIDList_[slot1])
end

function slot0.RefreshText(slot0)
	slot0.textAchievement_.text = AchievementData:GetFinishAchievementCnt()
	slot0.textCnt_.text = string.format("/%s", AchievementData:GetAchievementTotalCnt())
	slot0.textPoint_.text = AchievementData:GetAchievementPoint()
end

return slot0
