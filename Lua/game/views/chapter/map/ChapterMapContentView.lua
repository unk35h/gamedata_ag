slot0 = class("ChapterMapContentView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.chapterToggle_ = slot2
	slot0.itemList_ = {}

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.viewportTransform_ = slot0.mapViewPort_.transform
	slot0.itemParentTransform_ = slot0.itemParent_.transform
	slot0.hardLevelView_ = HardLevelChapterView.New(slot0.selectDifficultBtn_, slot0.difficultPanel_)
end

function slot0.OnEnter(slot0)
	slot0.hardLevelView_:OnEnter()
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0.hardLevelView_:OnExit()
	slot0:StopTimer()
	slot0:StopNaviagteTimer()

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:OnExit()
	end

	slot0.isFirstEnter_ = false
end

function slot0.Dispose(slot0)
	slot0.hardLevelView_:Dispose()

	slot0.hardLevelView_ = nil
	slot0.leanTween_ = nil

	LeanTween.cancel(slot0.itemParent_)
	slot0:RemoveListeners()

	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = {}

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.BeginDragFun)))
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.EndDragFun)))
end

function slot0.BeginDragFun(slot0, slot1, slot2)
	slot0.beginPositionX_ = slot2.position.x
end

function slot0.EndDragFun(slot0, slot1, slot2)
	slot3 = slot2.position.x - slot0.beginPositionX_

	if slot0.selectChapterClientID_ == slot0:SearchNearItem():GetChapterClientID() and math.abs(slot3) > 30 then
		slot5 = ChapterTools.GetNeighborClientID(slot0.selectChapterClientID_, slot3 < 0)
	end

	slot0.selectChapterClientID_ = slot5

	slot0:ChangeSelectID(slot5)
	slot0:NavigateItem(slot5, true, 0.25)
	manager.audio:PlayUIAudioByVoice("stage_slide")
end

function slot0.RemoveListeners(slot0)
	slot0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	slot0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
end

function slot0.RefreshData(slot0)
	slot0.selectChapterClientID_ = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)
	slot0.hardLevel_ = ChapterClientCfg[slot0.selectChapterClientID_].difficulty
	slot0.chapterList_ = getChapterClientList()[slot0.hardLevel_]
	slot0.maxChapterLevel_ = #slot0.chapterList_
end

function slot0.RefreshUI(slot0)
	slot0:RefreshMapItems()
	slot0:RefreshSelectDifficult()
end

function slot0.ChangeHardLevel(slot0)
	slot0:RefreshData()
	slot0:RefreshMapItems()
	slot0:RefreshSelectDifficult()

	slot0.changeLevel_ = true
end

function slot0.RefreshMapItems(slot0)
	for slot5 = #slot0.itemList_ + 1, slot0.maxChapterLevel_ do
		slot6 = nil

		if slot0.itemList_[slot5] == nil then
			slot0.itemList_[slot5] = ChapterMapItemView.New(slot0.mapItem_, slot0.itemParent_, slot0.chapterList_[slot5])
		else
			slot6 = slot0.itemList_[slot5]
		end

		slot6:OnEnter()
	end

	for slot5 = 1, slot1 do
		slot0.itemList_[slot5]:SetChapterClientID(slot0.chapterList_[slot5])
		slot0.itemList_[slot5]:Show(ChapterTools.HasChapterStage(slot0.chapterList_[slot5]))
	end

	for slot5 = slot1 + 1, #slot0.itemList_ do
		slot0.itemList_[slot5]:Show(false)
	end

	for slot5 = #slot0.itemList_, slot1 + 1, -1 do
		slot0.itemList_[slot5]:OnExit()
	end

	slot0:RefreshScrollRect()
end

function slot0.Display(slot0)
	slot1 = slot0.maxChapterLevel_
	slot3 = table.keyof(slot0.chapterList_, slot0.selectChapterClientID_) - 1 < 1 and 1 or slot2 - 1

	for slot7 = slot3, slot1 do
		if slot0.itemList_[slot7] then
			slot0.itemList_[slot7]:Hide(false)
		end
	end

	slot4 = slot3

	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		if uv0.itemList_[uv1] == nil then
			return
		end

		uv0.itemList_[uv1]:Hide(true)

		if uv1 == uv2 then
			uv0:NavigateItem(uv0.selectChapterClientID_)
		end

		uv1 = uv1 + 1
	end, 0.03, slot1 - slot3 + 1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_.func = nil
		slot0.timer_ = nil
	end
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0:RefreshData()
		slot0:Display()
	end
end

function slot0.RefreshSelectDifficult(slot0)
	slot0.hardLevelView_:SetData(slot0.hardLevel_, 0)
end

function slot0.ChangePlotSelectChapter(slot0)
	slot0:RefreshData()

	if slot0.changeLevel_ then
		slot0:NavigateItem(slot0.selectChapterClientID_)
		slot0:Display()

		slot0.changeLevel_ = false
	else
		slot0:NavigateItem(slot0.selectChapterClientID_, true)
	end
end

function slot0.ChangeSelectID(slot0, slot1)
	if not slot1 then
		return
	end

	BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, slot1)
end

function slot0.SearchNearItem(slot0)
	slot1 = nil
	slot2 = 200000
	slot3 = slot0.viewportTransform_.localPosition.x + slot0.viewportTransform_.rect.width / 2

	for slot8 = 1, slot0.maxChapterLevel_ do
		slot9 = slot0.itemList_[slot8]
		slot12 = slot9:GetChapterClientID()

		if math.abs(slot9:GetLocalPosition().x - slot0.viewportTransform_.rect.width / 2 - slot3) <= slot2 and ChapterTools.HasChapterStage(slot12) then
			slot2 = slot11
			slot1 = slot9
		end
	end

	return slot1
end

function slot0.GetSelectItem(slot0, slot1)
	for slot5, slot6 in pairs(slot0.itemList_) do
		if slot6:GetChapterClientID() == slot1 then
			return slot6
		end
	end
end

function slot0.NavigateItem(slot0, slot1, slot2, slot3)
	if slot0:GetSelectItem(slot1) then
		slot0:StopNaviagteTimer()

		slot0.navigateTimer_ = FrameTimer.New(function ()
			if uv0 == nil then
				return
			end

			if not uv1.isFirst_ then
				uv1.isFirst_ = true

				uv1:RefreshScrollRect()
			end

			slot0 = uv0:GetLocalPosition().x - (uv1.viewportTransform_.localPosition.x + uv1.viewportTransform_.rect.width / 2) - uv1.viewportTransform_.rect.width / 2

			if uv2 then
				uv1.leanTween_ = LeanTween.moveLocalX(uv1.itemParent_, uv1.itemParentTransform_.localPosition.x - slot0, uv3 or 0.4)
			else
				slot1 = uv1.itemParentTransform_.localPosition
				uv1.itemParentTransform_.localPosition = Vector3(slot1.x - slot0, slot1.y, slot1.z)
			end

			uv1:StopNaviagteTimer()
		end, 1, 1)

		slot0.navigateTimer_:Start()
	end
end

function slot0.StopNaviagteTimer(slot0)
	if slot0.navigateTimer_ then
		slot0.navigateTimer_:Stop()

		slot0.navigateTimer_ = nil
	end
end

function slot0.RefreshScrollRect(slot0)
	slot0.scrollRect_.horizontalNormalizedPosition = (table.keyof(slot0.chapterList_, slot0.selectChapterClientID_) - 1) / slot0.maxChapterLevel_
end

return slot0
