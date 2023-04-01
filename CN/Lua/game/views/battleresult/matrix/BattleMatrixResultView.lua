slot0 = class("BattleMatrixResultView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BattleResult/BattleVariableUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListener()

	slot0.affixList = LuaList.New(handler(slot0, slot0.IndexAffixItem), slot0.affixListGo_, BattleMatrixAffixItem)
end

function slot0.OnEnter(slot0)
	BattleInstance.hideBattlePanel()

	slot0.stageData = slot0.params_.stageData

	slot0:RefreshUI()

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

function slot0.NeedOnceMore(slot0)
	return false
end

function slot0.OnTop(slot0)
	SetActive(slot0.gameObject_, true)

	slot0.toStat_ = false
end

function slot0.OnBehind(slot0)
	if slot0.toStat_ then
		SetActive(slot0.gameObject_, false)
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = nil

	slot0.affixList:Dispose()

	for slot4, slot5 in ipairs(slot0.rewardItemGos_) do
		Object.Destroy(slot5)
	end

	slot0.rewardItemGos_ = nil
	slot0.heroGo_ = nil
	slot0.heroImg_ = nil
	slot0.hpText_ = nil
	slot0.rewardList_ = nil
	slot0.stareText_ = nil
	slot0.lvText_ = nil
	slot0.mask_ = nil
	slot0.btnBack_ = nil
	slot0.btnBattleCount_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemPrefeb = Asset.Load("UI/Common/CommonItem")
	slot0.rewardItems_ = {}
	slot0.rewardItemGos_ = {}
	slot0.heroGo_ = {}
	slot0.heroImg_ = {}
	slot0.hpText_ = {}

	for slot4 = 1, 3 do
		slot0.heroGo_[slot4] = slot0["hero" .. slot4]
		slot0.heroImg_[slot4] = slot0["heroMaskIcon" .. slot4]
		slot0.hpText_[slot4] = slot0[string.format("hpText%s_", slot4)]
	end

	slot1 = LeanTween.alphaCanvas(slot0.mask_, 0, 0.1)

	slot1:setOnComplete(LuaHelper.VoidAction(function ()
		uv0.mask_.blocksRaycasts = false
	end))
end

function slot0.GetRewardData(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.params_.rewardList) do
		table.insert(slot1, slot6)
	end

	return slot1
end

function slot0.ShowVitalityBox(slot0, slot1)
	if needShowVitalityFullBox(slot0:GetRewardData()) then
		showVitalitySendMail(slot1)
	else
		slot1()
	end
end

function slot0.ShowEquipBox(slot0, slot1)
	if needShowBagFullBox(slot0:GetRewardData()) then
		showEquipSendMail(slot1)
	else
		slot1()
	end
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.btnBack_, nil, function ()
		uv0:CloseFunc()
	end)
	slot0:AddBtnListener(slot0.btnBattleCount_, nil, function ()
		uv0.toStat_ = true

		JumpTools.OpenPageByJump("battleStatisticsMatrix", {
			stageData = uv0.stageData,
			battleTime = uv0:GetBattleTime()
		})
	end)
end

function slot0.CloseFunc(slot0)
	slot0:ShowVitalityBox(function ()
		slot0 = uv0

		slot0:ShowEquipBox(function ()
			BattleInstance.QuitBattle(uv0.stageData)
		end)
	end)
end

function slot0.RemoveListener(slot0)
	slot0.btnBack_.onClick:RemoveAllListeners()
	slot0.btnBattleCount_.onClick:RemoveAllListeners()
end

function slot0.RefreshUI(slot0)
	slot0:SetLevelTitle()
	slot0:RefreshRewardItemS()
	slot0:RefreshHeroS()
	slot0:RefreshBattleTime()
end

function slot0.SetLevelTitle(slot0)
	slot2 = MatrixTierCfg[MatrixData:GetTierID()]
	slot0.stareText_.text = string.format("%s-%s", slot2.tier, slot2.level)
	slot0.lvText_.text = BattleMatrixStageCfg[slot0.stageData:GetStageId()].name
	slot5 = MatrixData:GetDifficulty()
	slot0.difficultText_.text = string.format("<color=#%s>(%s)</color>", MatrixConst.DIFFICULTY_COLOR[slot5], GetTips(BattleConst.HARD_LANGUAGE[slot5]))
	slot0.timeText_.text = manager.time:DescCTime(BattleFieldData:GetBattleResultData().useSecond, "%M:%S")
	slot0.affixData = MatrixData:GetAffixList()

	slot0.affixList:StartScroll(math.max(#slot0.affixData, 3))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.titleTransform_)
end

function slot0.RefreshRewardItemS(slot0)
	slot1 = {}

	if slot0.params_.rewardList then
		for slot5, slot6 in pairs(slot0.params_.rewardList) do
			table.insert(slot1, slot6)
		end

		slot1 = sortReward(mergeReward(slot1))
	end

	for slot5 = 1, #slot1 do
		if not slot0.rewardItems_[slot5] then
			slot6 = Object.Instantiate(slot0.itemPrefeb, slot0.rewardList_)
			slot0.rewardItems_[slot5] = CommonItem.New(slot6)

			slot0.rewardItems_[slot5]:RegistCallBack(function (slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end)

			slot0.rewardItemGos_[slot5] = slot6

			slot0.rewardItems_[slot5]:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
		end

		slot0.rewardItems_[slot5]:RefreshData(formatReward(slot1[slot5]))
		slot0.rewardItems_[slot5]:SetBottomText("<color=#%s>" .. formatReward(slot1[slot5]).number .. "</color>")
	end
end

function slot0.RefreshHeroS(slot0)
	slot1 = slot0.stageData:GetHeroTeam()

	for slot5 = 1, 3 do
		if not slot1[slot5] or slot1[slot5] == 0 then
			SetActive(slot0.heroGo_[slot5], false)
		else
			SetActive(slot0.heroGo_[slot5], true)

			slot0.heroImg_[slot5].sprite = getSpriteViaConfig("HeroIcon", SkinCfg[MatrixData:GetHeroSkin(slot1[slot5])].picture_id)
			slot7 = MatrixData:GetHeroData(slot1[slot5])
			slot8 = slot7:GetHeroHP()
			slot9 = slot7:GetHeroMaxHP()
			slot0.hpText_[slot5].text = string.format("<color=#FF9500>%s</color>/%s", slot8, slot9)
			slot0[string.format("hpSlider%s_", slot5)].value = slot8 / slot9
		end
	end
end

function slot0.RefreshBattleTime(slot0)
	slot0.battleTimeText_.text = slot0:GetBattleTime()
end

function slot0.GetBattleTime(slot0)
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function slot0.IndexAffixItem(slot0, slot1, slot2)
	slot2:SetData(slot0.affixData[slot1])
end

return slot0
