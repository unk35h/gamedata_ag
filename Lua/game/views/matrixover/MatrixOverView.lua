slot0 = class("matrixOverNewView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BattleResult/BattleMatrixOverUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroItemList_ = {}

	for slot4 = 1, 3 do
		slot0.heroItemList_[slot4] = MatrixOverHeroItem.New(slot0[string.format("heroItem%s_", slot4)])
	end

	slot0.affixList_ = LuaList.New(handler(slot0, slot0.AffixIndexItem), slot0.m_affixList, MatrixOverAffixItem)
	slot0.treasureList_ = LuaList.New(handler(slot0, slot0.ArtifactIndexItem), slot0.m_treasureList, MatrixOverArtifactItem)
	slot0.beaconList_ = LuaList.New(handler(slot0, slot0.BeaconIndexItem), slot0.m_beaconList, MatrixOverBeaconItem)
	slot0.resultController_ = ControllerUtil.GetController(slot0.transform_, "result")
	slot0.difficultyController_ = ControllerUtil.GetController(slot0.transform_, "difficulty")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		if uv0:GetGameState() == MatrixConst.STATE_TYPE.NOTSTARTED then
			uv0:Go("/matrixBlank/matrixPrepare")
		else
			MatrixAction.QueryMatrixOver(function (slot0)
				if isSuccess(slot0.result) then
					uv0:Go("/matrixBlank/matrixPrepare")
				end
			end)
		end
	end)
	slot0:AddBtnListener(slot0.m_evaluateBtn, nil, function ()
		if uv0:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS then
			uv0:Go("matrixOverEvaluate")
		end
	end)
	slot0:AddBtnListener(slot0.statisticsBtn_, nil, function ()
		JumpTools.OpenPageByJump("battleStatisticsMatrixOver")
	end)
end

function slot0.OnEnter(slot0)
	slot0:Refresh()
end

function slot0.OnExit(slot0)
end

function slot0.ParseTime(slot0, slot1)
	slot3 = math.floor(slot1 % 3600 / 60)
	slot4 = slot1 % 60

	if math.floor(slot1 / 3600) < 10 then
		slot2 = "0" .. slot2 or slot2
	end

	if slot3 < 10 then
		slot3 = "0" .. slot3 or slot3
	end

	if slot4 < 10 then
		slot4 = "0" .. slot4 or slot4
	end

	return slot2 .. ":" .. slot3 .. ":" .. slot4
end

function slot0.Refresh(slot0)
	if slot0:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS then
		slot0.resultController_:SetSelectedIndex(0)

		slot0.currentTimeText_.text = slot0:ParseTime(slot0:GetCurrentClearTime())
		slot0.bestTimeText_.text = slot0:ParseTime(slot0:GetMinClearTime())

		if #slot0:GetEvaluateList() > 0 and MatrixEvaluateCfg[slot2[1]] then
			slot0.stageName_.text = MatrixEvaluateCfg[slot2[1]].title
		else
			slot0.stageName_.text = slot0:GetTierDes()
		end
	else
		slot0.resultController_:SetSelectedIndex(1)

		slot0.stageName_.text = slot0:GetTierDes()
	end

	slot0.m_rankScoreText.text = slot0:GetMatrixOverScore()

	if slot0:GetDifficulty() == 1 then
		slot0.difficultyController_:SetSelectedIndex(0)
	else
		slot0.difficultyController_:SetSelectedIndex(1)

		slot0.regularData = slot0:GetRegularAffix()
		slot0.customData = slot0:GetCustomAffix()
		slot3 = 0
		slot4 = 0

		for slot8, slot9 in ipairs(slot0.regularData) do
			slot3 = slot3 + MatrixAffixCfg[slot9].point
		end

		for slot8, slot9 in ipairs(slot0.customData) do
			slot3 = slot3 + MatrixAffixCfg[slot9].point
		end

		slot0.m_difficultyScore.text = "" .. slot3
	end

	slot3 = slot0:GetMatrixHeroTeam()

	for slot7 = 1, 3 do
		if slot3[slot7] and slot8 ~= 0 then
			slot0.heroItemList_[slot7]:Refresh(slot8)
			slot0.heroItemList_[slot7]:SetActive(true)
		else
			slot0.heroItemList_[slot7]:SetActive(false)
		end
	end

	slot0.affixData = slot0:GetAffixList()

	slot0.affixList_:StartScroll(#slot0.affixData)

	slot0.artifactData = slot0:GetArtifactList()

	table.sort(slot0.artifactData, function (slot0, slot1)
		if MatrixItemCfg[slot0.id].rare ~= MatrixItemCfg[slot1.id].rare then
			return slot3.rare < slot2.rare
		end

		return slot0.id < slot1.id
	end)
	slot0.treasureList_:StartScroll(#slot0.artifactData)

	slot0.beaconData = slot0:GetUseBeaconList()

	slot0.beaconList_:StartScroll(#slot0.beaconData)

	slot0.scoreText_.text = slot0:GetMatrixCurrencyList()[CurrencyConst.CURRENCY_TYPE_MATRIX_PT] or 0
end

function slot0.AffixIndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.affixData[slot1])
end

function slot0.ArtifactIndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.artifactData[slot1])
end

function slot0.BeaconIndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.beaconData[slot1])
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.heroItemList_) do
		slot5:Dispose()
	end

	slot0.heroItemList_ = nil

	slot0.affixList_:Dispose()
	slot0.treasureList_:Dispose()
	slot0.beaconList_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnMatrixOverUpdate(slot0)
	slot0:Refresh()
end

function slot0.GetGameState(slot0)
	return MatrixData:GetGameState()
end

function slot0.GetCurrentClearTime(slot0)
	return MatrixData:GetCurrentClearTime()
end

function slot0.GetMinClearTime(slot0)
	return MatrixData:GetMinClearTime()
end

function slot0.GetEvaluateList(slot0)
	return MatrixData:GetEvaluateList()
end

function slot0.GetTierDes(slot0)
	slot2 = MatrixTierCfg[MatrixData:GetTierID()]

	return string.format("%s-%s", slot2.tier, slot2.level)
end

function slot0.GetAffixList(slot0)
	return MatrixData:GetAffixList()
end

function slot0.GetArtifactList(slot0)
	return MatrixData:GetArtifactList()
end

function slot0.GetUseBeaconList(slot0)
	return MatrixData:GetUseBeaconList()
end

function slot0.GetMatrixCurrencyList(slot0)
	return MatrixData:GetMatrixCurrencyList()
end

function slot0.GetMatrixHeroTeam(slot0)
	return MatrixData:GetMatrixHeroTeam()
end

function slot0.GetMatrixOverScore(slot0)
	return MatrixData:GetMatrixOverScore()
end

function slot0.GetDifficulty(slot0)
	return MatrixData:GetDifficulty()
end

function slot0.GetRegularAffix(slot0)
	return MatrixData:GetDifficultyData():GetRegularAffix()
end

function slot0.GetCustomAffix(slot0)
	return MatrixData:GetCustomAffix()
end

return slot0
