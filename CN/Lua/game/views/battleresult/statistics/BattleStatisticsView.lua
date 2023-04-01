slot0 = class("BattleStatisticsView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BattleResult/BattleStatisticsUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
	SetActive(slot0.goShare_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
end

function slot0.OnEnter(slot0)
	slot0.stageData = slot0.params_.stageData
	slot0.statisticsHeroItem_ = {}
	slot1, slot2, slot3 = BattleTools.GetBattleStatisticsData()
	slot5 = LuaExchangeHelper.GetBattleStatisticsData() and slot4.dataForLua.currentHPHero or {}
	slot7 = 0

	for slot11, slot12 in ipairs(slot0.stageData:GetHeroTeam()) do
		if slot12 ~= 0 then
			slot7 = slot7 + 1
		end
	end

	if (slot5.Count or 0) ~= slot7 then
		print("special handling Battle Statistics")

		for slot12 = 1, 3 do
			if slot12 <= slot8 then
				slot0.statisticsHeroItem_[slot12] = slot0:GetStatisticsItem().New(slot0.heroItem_[slot12], slot0.stageData:GetHeroDataByPos(table.indexof(slot6, slot5[slot12 - 1])), slot2, slot3, slot1[slot12])
			else
				slot0.statisticsHeroItem_[slot12] = slot0:GetStatisticsItem().New(slot0.heroItem_[slot12], nil, slot2, slot3, slot1[slot12])
			end
		end
	else
		for slot12 = 1, 3 do
			slot0.statisticsHeroItem_[slot12] = slot0:GetStatisticsItem().New(slot0.heroItem_[slot12], slot0.stageData:GetHeroDataByPos(slot12), slot2, slot3, slot1[slot12])
		end
	end

	slot0:SetLevelTitle()
	slot0:RefreshTimeText()

	if slot0.params_.battleResult ~= nil and slot0.params_.battleResult.errorCode ~= nil and slot0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function ()
				uv0:CloseFunc()
			end
		})
	end
end

function slot0.OnExit(slot0)
	for slot4, slot5 in pairs(slot0.statisticsHeroItem_) do
		slot5:Dispose()
	end

	slot0.statisticsHeroItem_ = nil
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroItem_ = {}

	for slot4 = 1, 3 do
		slot0.heroItem_[slot4] = slot0["hero" .. slot4]
	end
end

function slot0.GetStatisticsItem(slot0)
	return BattleStatisticsHeroItem
end

function slot0.SetLevelTitle(slot0, slot1)
	slot2 = slot0.stageData:GetStageId()
	slot3 = slot0.stageData:GetType()
	slot0.lvText_.text = BattleStageTools.GetStageName(slot3, slot2)
	slot4, slot5 = BattleStageTools.GetChapterSectionIndex(slot3, slot2)

	if slot4 ~= "" then
		slot0.stareText_.text = string.format("%s-%s", GetI18NText(slot4), slot5)
	else
		slot0.stareText_.text = ""
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.titleTransform_)
end

function slot0.RefreshTimeText(slot0)
	SetActive(slot0.battleTimeGo_, slot0.params_.battleTime ~= nil)

	if not slot0.params_.battleTime then
		return
	end

	slot0.battleTimeText_.text = slot0.params_.battleTime
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonShare_, nil, function ()
		slot0 = manager.share

		slot0:Share(function ()
			SetActive(uv0.goShare_, false)
			SetActive(uv0.goBack_, false)
		end, function ()
			SetActive(uv0.goShare_, true)
			SetActive(uv0.goBack_, true)
		end)
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.backBtn_.onClick:RemoveAllListeners()
end

return slot0
