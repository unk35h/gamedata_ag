slot0 = class("MatrixStageSettingView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.stageType = slot2
	slot0.activityId = slot3

	slot0:OnEnter()
end

function slot0.OnEnter(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot1 = {}

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot0.stageType then
		slot1 = MatrixData:GetAffixList()
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == slot0.stageType then
		slot1 = ActivityMatrixData:GetAffixList(slot0.activityId)
	elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == slot0.stageType then
		slot1 = StrategyMatrixData:GetAffixList(slot0.activityId)
	end

	slot0.affixItemList_ = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.affixItemList_, MatrixStageAffixItemView.New(slot0.item_, slot0.itemParent_, slot6))
	end

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.RefreshUI(slot0)
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot0.stageType then
		slot2 = MatrixTierCfg[MatrixData:GetTierID()]
		slot0.levelText_.text = string.format("%s-%s", slot2.tier, slot2.level)
		slot0.nameText_.text = BattleMatrixStageCfg[MatrixData:GetMatrixPhaseData():GetData()].name
		slot0.difficultText_.text = GetTips(BattleConst.HARD_LANGUAGE[MatrixData:GetDifficulty()])
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == slot0.stageType then
		slot2 = ActivityMatrixTierTemplateCfg[ActivityMatrixData:GetTierID(slot0.activityId)]
		slot0.levelText_.text = string.format("%s-%s", slot2.tier, slot2.level)
		slot0.nameText_.text = BattleActivityMatrixCfg[ActivityMatrixData:GetMatrixPhaseData(slot0.activityId):GetData()].name
		slot0.difficultText_.text = ""
	elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == slot0.stageType then
		slot2 = StrategyMatrixTierTemplateCfg[StrategyMatrixData:GetTierID(slot0.activityId)]
		slot0.levelText_.text = string.format("%s-%s", slot2.tier, slot2.level)
		slot0.nameText_.text = BattleStrategyMatrixCfg[StrategyMatrixData:GetMatrixPhaseData(slot0.activityId):GetData()].name
		slot0.difficultText_.text = ""
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.itemParent_.transform)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.affixItemList_) do
		slot5:Dispose()
	end

	slot0.affixItemList_ = nil

	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
