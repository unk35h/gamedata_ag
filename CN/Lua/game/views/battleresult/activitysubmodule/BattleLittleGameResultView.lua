slot1 = class("BattleLittleGameResultView", import("game.views.battleResult.BattleResultBaseView"))

function slot1.UIName(slot0)
	return "UI/BattleResult/SummerBattleSettlementUI"
end

function slot1.RefreshUI(slot0)
	slot0:SetLevelTitle()
	slot0:RefreshMyExpS()
	slot0:RefreshHeroS()
	slot0:RefreshCommonUI()
	slot0:RefreshSummer()
	slot0:RefreshBattleTime()
end

function slot1.RefreshSummer(slot0)
	slot2 = 0
	slot3 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas:GetEnumerator()

	while slot3:MoveNext() do
		slot2 = slot2 + slot3.Current.Value
	end

	slot0.missionText1.text = slot2
	slot0.missionText2.text = slot1.items:TryGetValue(60010, nil) and slot1.items[60010] or 0
end

return slot1
