slot0 = class("EquipSectionView", import("..SectionBaseView"))

function slot0.GetSectionItemClass(slot0)
	return EquipSectionItemView
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("equipSectionInfo")
end

function slot0.InitCustom(slot0)
	SetActive(slot0.equipPanel_, true)
	slot0:AddBtnListener(slot0.switchBtn_, nil, function ()
		if uv0.isUnChoose_ then
			RedPointAction.HandleRedPoint(RED_POINT_ID.BATTLE_EQUIP)
			manager.redPoint:SetRedPointIndependent(uv0.switchBtn_.transform, false)
		end

		JumpTools.OpenPageByJump("suitSelect", {
			suitId = uv0.upSuitId_,
			currentSuitId = uv0.upSuitId_
		})
	end)
end

function slot0.RefreshData(slot0)
	slot0.battleEquipData_ = BattleEquipData:GetBattleEquipData()
	slot1 = slot0.battleEquipData_.baseStageId

	if slot0:IsOpenSectionInfo() and slot0.lastBaseStageId_ and slot0.lastBaseStageId_ ~= slot1 then
		slot0.isOpenInfoView_ = false

		JumpTools.Back()
	end

	slot0.lastBaseStageId_ = slot1
	slot0.stageList_ = StageGroupCfg[slot1].stage_list
	slot0.stageData_ = {}

	for slot6, slot7 in ipairs(slot0.stageList_) do
		slot0.stageData_[slot7] = {
			id = slot0.stageList_[slot6]
		}
	end

	slot0:RefreshCustomData()

	slot0.oepnStageList_ = slot0.stageList_
end

function slot0.RefreshUI(slot0)
	slot0:RefreshMissionList()

	slot1 = slot0.params_.section or BattleFieldData:GetCacheStage(slot0.chapterID_) or slot0.stageList_[1]
	slot0.selectSection_ = slot1

	if table.keyof(slot0.stageList_, slot1) == nil then
		slot0.selectSection_ = slot0.stageList_[1]
		slot2 = 1
	end

	slot0.scrollMoveView_:RefreshUI(slot0:GetScrollPos(), slot0:GetScrollWidth())
	slot0:RefreshSelectItem()
	slot0:RefreshRemainTime()
	slot0:RefreshUpSuit()

	if slot0.params_.equipId then
		JumpTools.OpenPageByJump("suitSelect", {
			suitId = EquipCfg[slot0.params_.equipId].suit,
			currentSuitId = slot0.upSuitId_
		})

		slot0.params_.equipId = nil
	end

	slot0:SwitchBG()
end

function slot0.GetCfgName(slot0)
	return BattleEquipStageCfg
end

function slot0.RefreshUpSuit(slot0)
	slot0.upSuitId_ = slot0.battleEquipData_.upSuitId
	slot0.equipName_.text = EquipSuitCfg[slot0.upSuitId_].name

	SetSpriteWithoutAtlasAsync(slot0.equipIcon_, SpritePathCfg.EquipIcon.path .. slot0.upSuitId_)
end

function slot0.RefreshRemainTime(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	slot1 = slot0.battleEquipData_.next_refresh_time - manager.time:GetServerTime()
	slot0.timeText_.text = string.format(GetTips("TIME_DISPLAY_15"), manager.time:DescCDTime(slot1))
	slot0.updateTimer_ = Timer.New(function ()
		uv0 = uv0 - 1
		uv1.timeText_.text = string.format(GetTips("TIME_DISPLAY_15"), manager.time:DescCDTime(uv0))

		if uv0 <= 0 then
			BattleEquipAction.RequestBattleEquipInfo()
		end
	end, 1, slot1, 1)

	slot0.updateTimer_:Start()
end

function slot0.RefreshMissionList(slot0)
	for slot4 = 1, #slot0.stageList_ do
		if slot0.missionItem_[slot4] then
			slot0.missionItem_[slot4]:SetData(slot0.chapterID_, slot0.stageList_[slot4])
		else
			slot0.missionItem_[slot4] = slot0:GetSectionItemClass().New(slot0.sectionItem_, slot0.content_, slot0.stageList_[slot4], slot0.chapterID_)
		end
	end

	slot0:CreateLineItemList()
end

function slot0.RefreshRedPoint(slot0)
	slot0.isUnChoose_ = not RedPointData:GetIsRedPointOpen(RED_POINT_ID.BATTLE_EQUIP)

	if slot0.isUnChoose_ then
		manager.redPoint:SetRedPointIndependent(slot0.switchBtn_.transform, true)
	end
end

function slot0.OnBattleEquipUpdate(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		INFO_BAR
	})

	slot1 = manager.windowBar

	slot1:SetGameHelpKey("EQUIP_STAGE_DESCRIPE")

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0:IsOpenSectionInfo() then
			uv0.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("null")
	slot0:ShowPanel()
	BattleEquipAction.RequestBattleEquipInfo()

	slot0.chapterID_ = ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP][1]

	slot0:RefreshBGM()
	slot0:RefreshRedPoint()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)

	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end
end

function slot0.CreateLineItemList(slot0)
	for slot4, slot5 in pairs(slot0.lineList_) do
		slot5:Show(false)
	end

	slot1 = 1

	for slot5, slot6 in ipairs(slot0.stageList_) do
		if slot5 > 1 then
			slot0.lineList_[slot1] = slot0.lineList_[slot1] or slot0:GetLineClass().New(slot0.lineGo_, slot0.content_, slot0.pointGo_)

			slot0.lineList_[slot1]:Show(true)
			slot0.lineList_[slot1]:RefreshUI(slot0.missionItem_[slot5 - 1]:GetLocalPosition() + Vector3(173, -13.8, 0), slot0.missionItem_[slot5]:GetLocalPosition() + Vector3(-137, -13.8, 0))

			slot1 = slot1 + 1
		end
	end
end

return slot0
