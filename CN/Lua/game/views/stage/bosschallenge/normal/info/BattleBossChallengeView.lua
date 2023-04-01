slot1 = class("BattleBossChallengeView", import("game.views.stage.bossChallenge.BattleBossInfoBaseView"))

function slot1.UIName(slot0)
	return "UI/BossChallenge/BossInformationUI"
end

function slot1.Init(slot0)
	uv0.super.Init(slot0)

	slot0.difficultItemList_ = {}
	slot0.targetItemList_ = {}
	slot0.affixItemList_ = {}
	slot0.switchDifficultHandler_ = handler(slot0, slot0.SwitchDifficult)
	slot0.controller_ = ControllerUtil.GetController(slot0.startBattleBtn_.transform, "name")
end

function slot1.OnEnterExtend(slot0)
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_DESC")

	slot0.bossIndex_ = slot0.params_.bossIndex or BattleBossChallengeData:GetCacheSelectBossIndex()

	BattleBossChallengeData:SaveCacheSelectBossIndex(slot0.bossIndex_)
	manager.notify:RegistListener(BOSS_CHALLENGE_SWITCH_DIFFICULT, slot0.switchDifficultHandler_)
	manager.redPoint:bindUIandKey(slot0.transformStar_, RedPointConst.BOSS_CHALLENGE_NORMAL)
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_SWITCH_DIFFICULT, slot0.switchDifficultHandler_)
	manager.redPoint:unbindUIandKey(slot0.transformStar_, RedPointConst.BOSS_CHALLENGE_NORMAL)
end

function slot1.OnUpdate(slot0)
	uv0.super.OnUpdate(slot0)
	slot0:RefreshResetBtn()
	slot0:RefreshStar()
end

function slot1.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.switchDifficultHandler_ = nil

	for slot4, slot5 in pairs(slot0.affixItemList_) do
		slot5:Dispose()
	end

	slot0.affixItemList_ = nil

	for slot4, slot5 in ipairs(slot0.difficultItemList_) do
		slot5:Dispose()
	end

	slot0.difficultItemList_ = nil

	for slot4, slot5 in ipairs(slot0.targetItemList_) do
		slot5:Dispose()
	end

	slot0.targetItemList_ = nil
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.startBattleBtn_, nil, function ()
		if uv0.isLock_ then
			ShowTips("NEED_UNLOCK_FRONT_DIFFICULT")

			return
		end

		BattleBossChallengeNormalData:SetSelectDifficult(uv0.bossIndex_, uv0.difficult_)
		uv0:Go("/sectionSelectHeroBoss", {
			section = uv0.curStageID_,
			bossIndex = uv0.bossIndex_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE
		})
	end)
	slot0:AddBtnListener(slot0.buttonExchange_, nil, function ()
		JumpTools.OpenPageByJump("bossStarExchange")
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_CHALLENGE_NORMAL_RESET"),
			OkCallback = function ()
				BattleBossChallengeAction.ResetNormalModeBoss(uv0.bossIndex_, function (slot0)
					if isSuccess(slot0.result) then
						uv0:RefreshData()
						uv0:RefreshUI()
					else
						ShowTips(slot0.result)
					end
				end)
			end
		})
	end)
end

function slot1.RefreshData(slot0)
	slot0.templateID_ = StageGroupCfg[BattleBossChallengeNormalData:GetBossList()[slot0.bossIndex_]].boss_id
	slot0.difficult_ = BattleBossChallengeNormalData:GetSelectDifficult(slot0.bossIndex_)
	slot0.curStageID_ = slot0:GetStageID()
	slot0.lockHeroGroup_ = BattleBossChallengeNormalData:GetLockHero()
	slot0.isLock_ = BattleBossChallengeNormalData:GetFinishIndex(slot0.bossIndex_) < slot0.difficult_
end

function slot1.GetBossID(slot0)
end

function slot1.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)
	slot0:RefreshStar()
	slot0:RefreshDifficultItem()
	slot0:RefreshTargetItem()
	slot0:RefreshAffix()
	slot0:RefreshResetBtn()
	slot0:RefreshStartBtn()
end

function slot1.GetAffix(slot0)
	if type(BattleBossStageCfg[slot0.curStageID_].affix_type) ~= "table" then
		return {}
	end

	return getMosterAffix(slot1)
end

function slot1.GetStageID(slot0)
	return BattleBossChallengeNormalData:GetStageList(slot0.bossIndex_, slot0.difficult_)
end

function slot1.SwitchDifficult(slot0, slot1)
	slot0.difficult_ = slot1
	slot0.curStageID_ = slot0:GetStageID()
	slot0.isLock_ = BattleBossChallengeNormalData:GetFinishIndex(slot0.bossIndex_) < slot0.difficult_

	slot0:RefreshTargetItem()
	slot0:RefreshAffix()

	for slot5, slot6 in ipairs(slot0.difficultItemList_) do
		slot6:SwitchDifficult(slot1)
	end

	slot0:RefreshStartBtn()
end

function slot1.RefreshAffix(slot0)
	for slot5, slot6 in ipairs(slot0:GetAffix()) do
		if slot0.affixItemList_[slot5] then
			slot0.affixItemList_[slot5]:SetData(slot6)
		else
			slot0.affixItemList_[slot5] = AffixItemView.New(slot0.affixItem_, slot0.affixPanel_, slot6)
		end
	end

	for slot5 = #slot0.affixItemList_, #slot1 + 1, -1 do
		slot0.affixItemList_[slot5]:Show(false)
	end
end

function slot1.RefreshStar(slot0)
	slot1 = BattleBossChallengeNormalData:GetBossChallengeCfg()
	slot2 = slot1.reward[#slot1.reward][1]
	slot3 = BattleBossChallengeNormalData:GetReceiveStarList()

	for slot7 = 1, #slot1.reward do
		if not table.keyof(slot3, slot1.reward[slot7][1]) then
			slot2 = slot1.reward[slot7][1]

			break
		end
	end

	slot0.textCurStar_.text = StageTools.CalcBossChallengeStar()
	slot0.textTotalStar_.text = string.format("/%s", slot2)
end

function slot1.RefreshDifficultItem(slot0)
	slot2 = BattleBossChallengeNormalData:GetSelectDifficult(slot0.bossIndex_)

	for slot6 = 1, BattleBossChallengeNormalData:GetBossChallengeCfg().level_amount do
		if slot0.difficultItemList_[slot6] == nil then
			slot0.difficultItemList_[slot6] = BattleBossChallengeDifficultItem.New(slot0.goDifficultItem_, slot0.goDifficultParent_, slot0.goLight_, slot0.goLightParent_, slot6)
		end

		slot0.difficultItemList_[slot6]:SetData(slot0.bossIndex_)
		slot0.difficultItemList_[slot6]:SwitchDifficult(slot2)
	end
end

function slot1.RefreshTargetItem(slot0)
	slot1 = BattleBossChallengeNormalData:GetStarList(slot0.curStageID_)

	for slot5 = 1, 3 do
		if slot0.targetItemList_[slot5] == nil then
			slot0.targetItemList_[slot5] = BattleBossTargetItem.New(slot0[string.format("goTargetItem%s_", slot5)], slot5)
		end

		slot0.targetItemList_[slot5]:Refresh(slot1[slot5] == 1, BattleBossStageCfg[slot0.curStageID_].three_star_need[slot5])
	end
end

function slot1.RefreshResetBtn(slot0)
	if table.length(BattleBossChallengeNormalData:GetReceiveStarList()) > 0 then
		SetActive(slot0.resetGo_, false)

		return
	end

	if table.length(BattleBossChallengeNormalData:GetLockHero()[slot0.bossIndex_]) > 0 then
		SetActive(slot0.resetGo_, true)
	else
		SetActive(slot0.resetGo_, false)
	end
end

function slot1.RefreshStartBtn(slot0)
	if slot0.isLock_ then
		slot0.controller_:SetSelectedState("false")
	else
		slot0.controller_:SetSelectedState("true")
	end
end

return slot1
