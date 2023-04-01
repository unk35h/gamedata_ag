slot0 = class("SubPlotContentView", ReduxView)

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
end

function slot0.OnEnter(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:StopNaviagteTimer()

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:OnExit()
	end

	slot0.isFirstEnter_ = false
end

function slot0.Dispose(slot0)
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

	if BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT) == slot0:SearchNearItem():GetChapterClientID() and math.abs(slot3) > 30 then
		slot8 = table.keyof(slot0.chapterClientList_, slot5)

		if slot3 > 0 and slot8 > 1 then
			slot5 = slot7[slot8 - 1]
		elseif slot3 < 0 and slot8 < #slot7 then
			slot5 = slot7[slot8 + 1]
		end
	end

	slot7 = ChapterClientCfg[slot5].chapter_list[1]
	slot0.selectChapterID_ = slot7

	slot0:ChangeSelectID(slot5)
	slot0:NavigateItem(slot7, true, 0.25)
	manager.audio:PlayUIAudioByVoice("stage_slide")
end

function slot0.RemoveListeners(slot0)
	slot0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	slot0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
end

function slot0.RefreshData(slot0)
	slot0.selectChapterID_ = BattleFieldData:GetCacheChapter(BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT))
	slot0.chapterClientList_ = ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT]
end

function slot0.RefreshUI(slot0)
	slot0:RefreshMapItems()
end

function slot0.RefreshMapItems(slot0)
	for slot4 = #slot0.itemList_ + 1, #slot0.chapterClientList_ do
		slot5 = nil

		if slot0.itemList_[slot4] == nil then
			slot0.itemList_[slot4] = SubPlotItemView.New(slot0.mapItem_, slot0.itemParent_, slot0.chapterClientList_[slot4])
		else
			slot5 = slot0.itemList_[slot4]
		end

		slot5:OnEnter()
	end

	for slot4 = 1, #slot0.chapterClientList_ do
		slot0.itemList_[slot4]:SetChapterClientID(slot0.chapterClientList_[slot4])
		slot0.itemList_[slot4]:Show(true)
	end

	for slot4 = #slot0.itemList_, #slot0.chapterClientList_ + 1, -1 do
		slot0.itemList_[slot4]:OnExit()
	end

	slot0:RefreshScrollRect()
end

function slot0.Display(slot0)
	slot1 = #slot0.chapterClientList_
	slot4 = table.keyof(slot0.chapterClientList_, getChapterClientCfgByChapterID(slot0.selectChapterID_).id) - 1 < 1 and 1 or slot3 - 1

	for slot8 = slot4, slot1 do
		if slot0.itemList_[slot8] then
			slot0.itemList_[slot8]:Hide(false)
		end
	end

	slot5 = slot4

	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		if uv0.itemList_[uv1] == nil then
			return
		end

		uv0.itemList_[uv1]:Hide(true)

		if uv1 == uv2 then
			uv0:NavigateItem(uv0.selectChapterID_)
		end

		uv1 = uv1 + 1
	end, 0.03, slot1 - slot4 + 1)

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

function slot0.ChangePlotSelectChapter(slot0)
	slot0:RefreshData()
	slot0:NavigateItem(slot0.selectChapterID_, true)
end

function slot0.ChangeSelectID(slot0, slot1)
	if not slot1 then
		return
	end

	BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT, slot1)
end

function slot0.SearchNearItem(slot0)
	slot1 = nil
	slot2 = 200000
	slot3 = slot0.viewportTransform_.localPosition.x + slot0.viewportTransform_.rect.width / 2

	for slot7, slot8 in pairs(slot0.itemList_) do
		if math.abs(slot8:GetLocalPosition().x - slot0.viewportTransform_.rect.width / 2 - slot3) <= slot2 then
			slot2 = slot10
			slot1 = slot8
		end
	end

	return slot1
end

function slot0.GetSelectItem(slot0, slot1)
	slot2 = nil
	slot3 = getChapterClientCfgByChapterID(slot1)

	for slot7, slot8 in pairs(slot0.itemList_) do
		if slot8:GetChapterClientID() == slot3.id then
			return slot8
		end
	end
end

function slot0.NavigateItem(slot0, slot1, slot2, slot3)
	if slot0:GetSelectItem(slot1) then
		slot0:StopNaviagteTimer()

		slot0.navigateTimer_ = Timer.New(function ()
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
		end, 0.033, 1)

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
	slot0.scrollRect_.horizontalNormalizedPosition = (table.keyof(slot0.chapterClientList_, getChapterClientCfgByChapterID(slot0.selectChapterID_).id) - 1) / #slot0.chapterClientList_
end

return slot0
