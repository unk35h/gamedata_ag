slot0 = class("TeachStageBaseView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.switchType_ = slot2

	slot0:InitUI()
	slot0:AddListeners()

	slot0.missionItem_ = {}
	slot0.lineList_ = {}
end

function slot0.OnEnter(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnUpdate(slot0)
	slot0:RefreshUI()
end

function slot0.OnClickTeachViewBtn(slot0)
end

function slot0.OnExit(slot0)
	BattleTeachData:SetBaseScrollViewHorizontal(slot0.scrollMoveView_:GetHorizontalNormalizedPosition())

	slot0.isFirst_ = false

	slot0.scrollMoveView_:OnExit()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.missionItem_) do
		slot5:Dispose()
	end

	slot0.missionItem_ = nil

	for slot4, slot5 in pairs(slot0.lineList_) do
		slot5:Dispose()
	end

	slot0.lineList_ = nil

	slot0.scrollMoveView_:Dispose()

	slot0.scrollMoveView_ = nil

	slot0:RemoveListeners()

	slot0.scrollViewEvent_ = nil
	slot0.scrollViewGo_ = nil
	slot0.scrollView_ = nil
	slot0.viewportRect_ = nil
	slot0.content_ = nil
	slot0.contentRect_ = nil
	slot0.sectionItem_ = nil
	slot0.lineGo_ = nil
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollMoveView_ = ScrollMoveView.New(slot0, slot0.basiScrollView_)
end

function slot0.AddListeners(slot0)
end

function slot0.RemoveListeners(slot0)
end

function slot0.RefreshData(slot0)
	slot0.stageList_ = ChapterCfg[ChapterCfg.get_id_list_by_type[slot0.switchType_][1]].section_id_list

	slot0:GetScrollWidth()
end

function slot0.GetScrollWidth(slot0)
	slot0.scrollWidth_ = BattleBaseTeachStageCfg[slot0.stageList_[#slot0.stageList_]].position[1]
end

function slot0.SwitchPageUI(slot0, slot1, slot2, slot3)
	slot4 = slot0.switchType_ == slot1

	SetActive(slot0.gameObject_, slot4)

	if slot4 then
		BattleTeachAction.CancelBaseTeachRedPoint()
	end

	if slot3 then
		slot5 = ChapterCfg.get_id_list_by_type[slot0.switchType_][1]

		BattleFieldData:SetCacheStage(slot5, ChapterCfg[slot5].section_id_list[1])
		BattleTeachData:SetBaseScrollViewHorizontal(0)
	end
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("teachSectionInfo")
end

function slot0.RefreshUI(slot0)
	slot0:RefreshMissionList()

	slot3 = table.keyof(slot0.stageList_, BattleFieldData:GetCacheStage(ChapterCfg.get_id_list_by_type[slot0.switchType_][1]) or slot0.stageList_[1])
	slot4 = BattleBaseTeachStageCfg[slot0.stageList_[slot3]].position[1]
	slot0.lastSelect_ = slot3

	if not slot0.isFirst_ then
		slot0.scrollMoveView_:SetHorizontalNormalizedPosition(BattleTeachData:GetBaseScrollViewHorizontal(), slot0.scrollWidth_)

		slot0.isFirst_ = true
	else
		slot0.scrollMoveView_:RefreshUI(slot4, slot0.scrollWidth_, not slot0:IsOpenSectionInfo())
	end
end

function slot0.GetSectionItemClass(slot0)
	return TeachStageBaseItem
end

function slot0.RefreshMissionList(slot0)
	for slot4 = 1, #slot0.missionItem_ do
		slot0.missionItem_[slot4]:Show(false)
	end

	for slot4 = 1, #slot0.stageList_ do
		if slot0.missionItem_[slot4] then
			slot0.missionItem_[slot4]:SetData(slot0.stageList_[slot4])
		else
			slot0.missionItem_[slot4] = slot0:GetSectionItemClass().New(slot0.sectionItem_, slot0.content_, slot0.stageList_[slot4])
		end
	end

	slot0:CreateLineItemList()
end

function slot0.CreateLineItemList(slot0)
	for slot4, slot5 in pairs(slot0.lineList_) do
		slot5:Show(false)
	end

	for slot4, slot5 in ipairs(slot0.stageList_) do
		if slot4 > 1 then
			slot0.lineList_[slot4] = slot0.lineList_[slot4] or SectionLineItem.New(slot0.lineGo_, slot0.content_, slot0.pointGo_)

			slot0.lineList_[slot4]:RefreshUI(slot0.missionItem_[slot4 - 1]:GetLocalPosition() + Vector3(150, 6.2, 0), slot0.missionItem_[slot4]:GetLocalPosition() + Vector3(-157, 6.2, 0))
			slot0.lineList_[slot4]:Show(true)
		end
	end
end

return slot0
