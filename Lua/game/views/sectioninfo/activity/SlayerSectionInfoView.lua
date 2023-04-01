SectionInfoBaseView = import("game.views.sectionInfo.SectionInfoBaseView")
slot0 = class("SlayerSectionInfoView", SectionInfoBaseView)

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)
	SetActive(slot0.tipsPanel_, true)

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")

	slot0.controller_:SetSelectedState("slayer")

	slot0.slayerComs = {}

	ComponentBinder.GetInstance():BindCfgUI(slot0.slayerComs, slot0.slayerPanel_)

	slot0.slayerBuffList = {}

	SetActive(slot0.resourcePanel_, false)
end

function slot0.OnClickBtn(slot0)
	slot0:Go("/sectionSelectHeroSlayer", {
		section = slot0.stageID_,
		sectionType = slot0.stageType_,
		region_activity_id = slot0.params_.region_activity_id,
		activityID = slot0.params_.slayer_activity_id
	})
end

function slot0.RefreshData(slot0)
	uv0.super.RefreshData(slot0)

	slot0.lock_ = PlayerData:GetPlayerInfo().userLevel < BattleSlayerStageCfg[slot0.stageID_].level
	slot0.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot1.level)
	slot0.cost = 0
	slot0.drop_lib_id = 0
	slot0.isFirstClear_ = false
end

function slot0.RefreshStageInfo(slot0)
	if slot0.oldCfgID_ ~= BattleSlayerStageCfg[slot0.stageID_].id then
		slot0.sectionName_.text = slot1.name
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
		slot0.slayerComs.m_tips.text = slot1.tips
		slot0.oldCfgID_ = slot1.id
	end

	slot3 = slot0.params_.slayer_activity_id
	slot0.buffData = ActivitySlayerCfg[slot0.params_.region_activity_id] and slot4.buff_desc or {}

	for slot9 = 1, #slot0.buffData do
		if not slot0.slayerBuffList[slot9] then
			slot0.slayerBuffList[slot9] = SlayerSectionItem.New(Object.Instantiate(slot0.slayerComs.m_buffItem, slot0.slayerComs.m_buffParent))
		end

		slot0.slayerBuffList[slot9]:SetData(slot0.buffData[slot9])
		slot0.slayerBuffList[slot9]:SetActive(true)
	end

	for slot9 = slot5 + 1, #slot0.slayerBuffList do
		slot0.slayerBuffList[slot9]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.slayerComs.m_buffParent)

	slot0.slayerComs.m_maxScore.text = SlayerData:GetPoint(slot3, slot2)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.slayerBuffList) do
		slot5:Dispose()
	end

	slot0.slayerBuffList = {}

	uv0.super.Dispose(slot0)
end

return slot0
