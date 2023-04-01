SectionInfoBaseView = import("game.views.sectionInfo.SectionInfoBaseView")
slot0 = class("SotryStageInfoActivityView", SectionInfoBaseView)

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)
	SetActive(slot0.tipsPanel_, true)

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")

	slot0.controller_:SetSelectedState("activity")
end

function slot0.OnClickBtn(slot0)
	slot1 = slot0.stageID_
	slot3 = ActivityStoryChapterCfg[slot0.params_.chapterID].activity_id

	if BattleConst.BATTLE_TAG.STORY == BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).tag then
		BattleController.GetInstance():LaunchStoryBattle(slot0.stageType_, slot0.stageID_, slot3)
	else
		slot0:Go("/sectionSelectHero", {
			section = slot1,
			sectionType = slot0.stageType_,
			activityID = slot3
		})
	end
end

function slot0.RefreshData(slot0)
	uv0.super.RefreshData(slot0)

	slot0.lock_ = PlayerData:GetPlayerInfo().userLevel < BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).level
	slot0.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot1.level)
	slot0.drop_lib_id = slot1.drop_lib_id_list[1]
	slot0.isFirstClear_ = StoryStageActivityData:GetStageData(slot0.params_.chapterID)[slot0.stageID_].clear_times <= 0

	if slot0.isFirstClear_ then
		slot0.cost = slot1.cost or 0
	else
		slot0.cost = 0
	end
end

function slot0.RefreshStageInfo(slot0)
	if slot0.oldCfgID_ ~= BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).id then
		slot0.sectionName_.text = slot1.name
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
		slot0.textStory_.text = slot1.tips
		slot0.oldCfgID_ = slot1.id
	end
end

return slot0
