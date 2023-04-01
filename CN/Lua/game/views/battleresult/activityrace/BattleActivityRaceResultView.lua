slot1 = class("BattleActivityRaceResultView", import("game.views.battleResult.multiple.BattleMultipleResultView"))

function slot1.UIName(slot0)
	return "UI/BattleResult/ActivityRaceMultipletUI"
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddListener()

	slot0.heroItemView_ = {}
	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.RewardRenderer), slot0.rewardUIList_, CommonItem)
	slot0.affixList_ = LuaList.New(handler(slot0, slot0.AffixRenderer), slot0.affixUIList_, ActivityRaceAffixResultItem)
end

function slot1.OnEnter(slot0)
	slot0.stageData = slot0.params_.stageData
	slot0.stageId = slot0.stageData:GetStageId()
	slot0.stageType = slot0.stageData:GetType()

	BattleInstance.hideBattlePanel()
	slot0:RefreshUI()

	slot1 = {}

	for slot5, slot6 in ipairs(slot0.params_.rewardList) do
		for slot10, slot11 in ipairs(slot6) do
			slot1[slot11[1]] = slot1[slot11[1]] or {}
			slot1[slot11[1]][1] = slot11[1]

			if slot1[slot11[1]][2] == nil then
				slot1[slot11[1]][2] = 0
			end

			slot1[slot11[1]][2] = slot1[slot11[1]][2] + slot11[2]
		end
	end

	slot0.rewardDataList_ = {}
	slot2 = 1

	for slot6, slot7 in pairs(slot1) do
		slot0.rewardDataList_[slot2] = slot7
		slot2 = slot2 + 1
	end

	slot0.rewardList_:StartScroll(#slot0.rewardDataList_, 1)
	slot0.affixList_:StartScroll(#slot0.params_.affixList, 1)

	if slot0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
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

function slot1.Dispose(slot0)
	slot0.affixList_:Dispose()

	slot0.affixList_ = nil

	slot0.rewardList_:Dispose()

	slot0.rewardList_ = nil

	uv0.super.Dispose(slot0)
end

function slot1.RewardRenderer(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.rewardDataList_[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_OTHER_ITEM, uv0.rewardDataList_[uv1])
	end)
end

function slot1.AffixRenderer(slot0, slot1, slot2)
	slot2:SetData(slot0.params_.affixList[slot1])
end

return slot1
