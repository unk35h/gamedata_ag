slot0 = class("MythicSectionInfoView", import("..SectionInfoTargetBaseView"))

function slot0.UIName(slot0)
	return "UI/Stage/PathOfTheFlamingSwordInfoUI"
end

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)
	SetActive(slot0.tipsPanel_, true)

	slot0.targetController_ = ControllerUtil.GetController(slot0.transform_, "target")
end

function slot0.RefreshData(slot0)
	slot1 = BattleMythicStageCfg[slot0.stageID_]
	slot0.lock_ = false
	slot0.lockTips_ = ""
	slot0.cost = 0
	slot0.drop_lib_id = {}
	slot0.isFirstClear_ = MythicData:GetIsFirstClear(slot0.partition_)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.partition_ = slot0.params_.partition
	slot0.stageID_ = slot0.params_.stageID

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnUpdate(slot0)
	if slot0.partition_ == slot0.params_.partition and slot0.stageID_ == slot0.params_.stageID then
		return
	end

	slot0.partition_ = slot0.params_.partition
	slot0.stageID_ = slot0.params_.stageID

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.GetThreeStar(slot0, slot1)
	return MythicData:GetStarOpen(slot1), BattleMythicStageCfg[slot0.stageID_].three_star_need[slot1]
end

function slot0.RefreshUI(slot0)
	slot0:RefreshStageInfo()
	slot0:RefreshCost()

	if slot0.params_.isMain then
		slot0.targetController_:SetSelectedIndex(1)
		slot0:RefreshTarget()
	else
		slot0.targetController_:SetSelectedIndex(0)

		if slot0.params_.affix then
			slot1 = slot0.params_.affix
			slot0.m_affixIcon.sprite = getAffixSprite(slot1)
			slot0.m_affixName.text = getAffixName(slot1)
			slot0.m_affixDes.text = getAffixDesc(slot1)
		end
	end

	slot0.rewardView_.horizontalNormalizedPosition = 0
end

function slot0.RefreshStageInfo(slot0)
	slot2 = BattleMythicStageCfg[slot0.stageID_]
	slot0.sectionName_.text = slot2.name
	slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot2.background_1))
	slot0.tipsText_.text = slot2.tips
end

function slot0.RefreshReward(slot0)
	if 0 == 0 then
		return
	end

	slot0:RefreshRewardPanel(slot1)
end

function slot0.RefreshCost(slot0)
end

function slot0.OnClickBtn(slot0)
	slot0:Go("/sectionSelectHeroMythicView", {
		section = slot0.stageID_,
		partition = slot0.partition_,
		difficulty = slot0.params_.difficulty,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC
	})
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.sectionTargets_) do
		slot5:Dispose()
	end

	slot0.sectionTargets_ = {}

	uv0.super.Dispose(slot0)
end

return slot0
