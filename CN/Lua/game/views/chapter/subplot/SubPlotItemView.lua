slot0 = class("SubPlotItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.parent_ = slot2
	slot0.viewportTransform_ = slot2.transform.parent
	slot0.width_ = slot0.viewportTransform_.rect.width / 2
	slot4 = slot0:FindCom("HorizontalLayoutGroup", "Content", slot0.viewportTransform_)
	slot0.scale_ = 5540
	slot0.alphaScale_ = 0.0007692307692307692

	SetActive(slot0.gameObject_, true)

	slot0.chapterClientID_ = slot3
	slot0.transform_.name = slot3

	slot0:InitUI()
	slot0:AddListeners()
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.itemRect_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, slot0.chapterClientID_), {
		x = 617,
		y = 290
	})
	slot0:PlayAnimate()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.itemRect_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, slot0.chapterClientID_))
	slot0:StopTimer()
	slot0:StopTween()
	slot0:RemoveActivityTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.chapterPaint_.sprite = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
	slot0.btn_ = nil
	slot0.itemRect_ = nil
	slot0.chapterPaint_ = nil
	slot0.chapterName_ = nil
	slot0.chapterDesc_ = nil
	slot0.collectText_ = nil
	slot0.collectProgress_ = nil
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.activityController_ = ControllerUtil.GetController(slot0.transform_, "activityFlag")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if ChapterClientCfg[BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT)].id ~= uv0.chapterClientID_ then
			manager.audio:PlayUIAudioByVoice("stage_slide")
			BattleFieldAction.ChangeSelectChapterID(ChapterClientCfg[slot0].chapter_list[1])

			return
		end

		if uv0.isLock_ and manager.time:GetServerTime() < ActivityData:GetActivityRefreshTime(uv0:GetActivityID()) then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot4)))

			return
		end

		JumpTools.Jump2SubPlot(uv0.chapterClientID_)
	end)
end

function slot0.RefreshData(slot0)
	slot0.collectRate_ = StageTools.GetSubPlotFinishRate(slot0.chapterClientID_)

	if ActivityData:GetActivityRefreshTime(slot0:GetActivityID()) ~= 0 then
		slot0.isLock_ = manager.time:GetServerTime() < slot2
	else
		slot0.isLock_ = false
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshItem()
	slot0:RefreshLock()
	slot0:RefreshCollect()
end

function slot0.RefreshItem(slot0)
	if slot0.oldChapterClientID_ ~= slot0.chapterClientID_ then
		slot2 = ChapterClientCfg[slot1]
		slot0.chapterName_.text = slot2.name
		slot0.chapterDesc_.text = slot2.desc

		getSpriteWithoutAtlasAsync(SpritePathCfg.ChapterPaint.path .. slot2.chapter_paint, function (slot0)
			if uv0.chapterPaint_ then
				uv0.chapterPaint_.sprite = slot0
			end
		end)

		slot0.oldChapterClientID_ = slot1
	end
end

function slot0.RefreshLock(slot0)
	slot0.lockController_:SetSelectedState(tostring(slot0.isLock_))
end

function slot0.RefreshActivity(slot0)
	slot0.activityController_:SetSelectedState(tostring(ActivityData:GetActivityIsOpen(ChapterCfg[ChapterClientCfg[slot0.chapterClientID_].chapter_list[1]].activity_id)))
end

function slot0.RefreshCollect(slot0)
	slot0.collectText_.text = string.format("<size=60>%s</size>%%", slot0.collectRate_)
end

function slot0.PlayAnimate(slot0)
	slot0:StopTween()

	slot0.collectProgress_.fillAmount = 0
	slot0.tweenValue_ = LeanTween.value(slot0.gameObject_, 0, slot0.collectRate_ / 100, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.collectProgress_.fillAmount = slot0
	end)):setOnComplete(LuaHelper.VoidAction(function ()
		uv0.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

		uv0.tweenValue_ = nil
	end)):setEase(LeanTweenType.easeOutQuad):setDelay(0.2)
end

function slot0.StopTween(slot0)
	if slot0.tweenValue_ then
		slot0.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.gameObject_)

		slot0.tweenValue_ = nil
	end
end

function slot0.SetChapterClientID(slot0, slot1)
	manager.redPoint:unbindUIandKey(slot0.itemRect_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, slot1))

	slot0.chapterClientID_ = slot1

	manager.redPoint:bindUIandKey(slot0.itemRect_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, slot0.chapterClientID_), {
		x = 617,
		y = 290
	})
	slot0:RefreshData()
	slot0:RefreshUI()
	slot0:PlayAnimate()
	slot0:AddActivityTimer()
end

function slot0.GetLocalPosition(slot0)
	return slot0.transform_.localPosition + slot0.parent_.transform.localPosition
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1 and BattleStageData:GetStageData()[ChapterCfg[ChapterClientCfg[slot0.chapterClientID_].chapter_list[1]].section_id_list[1]] ~= nil)

	if slot1 == false then
		slot0.collectProgress_.fillAmount = 0
	end
end

function slot0.Hide(slot0, slot1)
	SetActive(slot0.mapItemGo_, slot1)

	if slot1 then
		slot0:PlayAnimate()
	end
end

function slot0.Scale(slot0, slot1)
	slot0.transform_.localScale = Vector3(slot1, slot1, 1)
end

function slot0.SetAlpha(slot0, slot1)
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.AddUpdate(slot0)
	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		if uv0.dist_ == math.abs(uv0:GetLocalPosition().x - uv0.width_) then
			return
		end

		uv0.dist_ = slot1

		if slot1 < uv0.width_ * 2 then
			uv0:Scale(1 - slot1 / uv0.scale_)
			uv0:SetAlpha(1 - slot1 * uv0.alphaScale_)
		end
	end, 0.03, -1)

	slot0.timer_:Start()
end

function slot0.GetActivityID(slot0)
	return ChapterCfg[ChapterClientCfg[slot0.chapterClientID_].chapter_list[1]].activity_id or 0
end

function slot0.GetChapterClientID(slot0)
	return slot0.chapterClientID_
end

function slot0.IsLock(slot0)
	return slot0.isLock_
end

function slot0.AddActivityTimer(slot0)
	slot0:RemoveActivityTimer()

	if ActivityData:GetActivityRefreshTime(slot0:GetActivityID()) == 0 or slot2 < manager.time:GetServerTime() then
		slot0.isLock_ = false

		slot0:RefreshLock()

		return
	end

	slot0.activityTimer_ = Timer.New(function ()
		if uv0 == 0 or uv0 < manager.time:GetServerTime() then
			uv1.isLock_ = false

			uv1:RefreshLock()
			uv1:RemoveActivityTimer()
		end
	end, 1, -1)

	slot0.activityTimer_:Start()
end

function slot0.RemoveActivityTimer(slot0)
	if slot0.activityTimer_ then
		slot0.activityTimer_:Stop()

		slot0.activityTimer_ = nil
	end
end

return slot0
