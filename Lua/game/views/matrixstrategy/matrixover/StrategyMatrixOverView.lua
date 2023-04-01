slot1 = class("StrategyMatrixOverView", import("game.views.matrixOver.MatrixOverView"))

function slot1.UIName(slot0)
	return "UI/StrategyMatrix/StrategyBattleMatrixOverUI"
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroItemList_ = {}

	for slot4 = 1, 3 do
		slot0.heroItemList_[slot4] = StrategyMatrixOverHeroItem.New(slot0[string.format("heroItem%s_", slot4)])
	end

	slot0.affixList_ = LuaList.New(handler(slot0, slot0.AffixIndexItem), slot0.m_affixList, MatrixOverAffixItem)
	slot0.treasureList_ = LuaList.New(handler(slot0, slot0.ArtifactIndexItem), slot0.m_treasureList, MatrixOverArtifactItem)
	slot0.beaconList_ = LuaList.New(handler(slot0, slot0.BeaconIndexItem), slot0.m_beaconList, MatrixOverBeaconItem)
	slot0.resultController_ = ControllerUtil.GetController(slot0.transform_, "result")
	slot0.difficultyController_ = ControllerUtil.GetController(slot0.transform_, "difficulty")
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		if uv0:GetGameState() == MatrixConst.STATE_TYPE.NOTSTARTED then
			StrategyMatrixAction.GotoStrategyMatrixPrepare(uv0.matrix_activity_id)
		else
			StrategyMatrixAction.QueryMatrixOver(uv0.matrix_activity_id)
		end
	end)
	slot0:AddBtnListener(slot0.statisticsBtn_, nil, function ()
		JumpTools.OpenPageByJump("battleStatisticsStrategyMatrixOver", {
			matrix_activity_id = uv0.matrix_activity_id
		})
	end)
end

function slot1.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	for slot4 = 1, 3 do
		slot0.heroItemList_[slot4]:SetMatrixActivityId(slot0.matrix_activity_id)
	end

	slot0:Refresh()
end

function slot1.Refresh(slot0)
	uv0.super.Refresh(slot0)
end

function slot1.OnMatrixUserUpdate(slot0)
	if MatrixConst.STATE_TYPE.NOTSTARTED == MatrixData:GetGameState() then
		-- Nothing
	elseif MatrixConst.STATE_TYPE.SUCCESS ~= slot1 and MatrixConst.STATE_TYPE.FAIL == slot1 then
		-- Nothing
	end
end

function slot1.GetGameState(slot0)
	return StrategyMatrixData:GetGameState(slot0.matrix_activity_id)
end

function slot1.GetCurrentClearTime(slot0)
	return StrategyMatrixData:GetCurrentClearTime(slot0.matrix_activity_id)
end

function slot1.GetMinClearTime(slot0)
	return StrategyMatrixData:GetMinClearTime(slot0.matrix_activity_id)
end

function slot1.GetEvaluateList(slot0)
	return {}
end

function slot1.GetTierDes(slot0)
	slot2 = StrategyMatrixTierTemplateCfg[StrategyMatrixData:GetTierID(slot0.matrix_activity_id)]

	return string.format("%s-%s", slot2.tier, slot2.level)
end

function slot1.GetAffixList(slot0)
	return {}
end

function slot1.GetArtifactList(slot0)
	return StrategyMatrixData:GetArtifactList(slot0.matrix_activity_id)
end

function slot1.GetUseBeaconList(slot0)
	return {}
end

function slot1.GetMatrixCurrencyList(slot0)
	return StrategyMatrixData:GetMatrixCurrencyList(slot0.matrix_activity_id)
end

function slot1.GetMatrixHeroTeam(slot0)
	return StrategyMatrixData:GetMatrixHeroTeam(slot0.matrix_activity_id)
end

function slot1.GetMatrixOverScore(slot0)
	return StrategyMatrixData:GetMatrixOverPoint(slot0.matrix_activity_id)
end

function slot1.GetDifficulty(slot0)
	return 1
end

function slot1.GetRegularAffix(slot0)
	return {}
end

function slot1.GetCustomAffix(slot0)
	return {}
end

return slot1
