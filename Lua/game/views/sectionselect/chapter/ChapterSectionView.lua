slot0 = class("ChapterSectionView", import("..SectionBaseView"))

function slot0.Init(slot0)
	slot0.hardLevelItems_ = {}

	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.hardLevelView_ = HardLevelBaseView.New(slot0.selectDifficultBtn_, slot0.difficultPanel_)
	slot0.skuldBtnController_ = ControllerUtil.GetController(slot0.skuldbtn_.transform, "isbreach")
	slot0.chapterPartBtnView_ = ChapterPartBtnView.New(slot0.chapterBranchGo_)
	slot0.stopMoveHandler_ = handler(slot0, slot0.StopMove)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshText()
	uv0.super.RefreshUI(slot0)
	slot0:RefreshHardLevelUI()
	slot0:RefreshCollectProgress()
	slot0:SwitchRewardShow()
	slot0:RefreshTogglePanel()
	slot0:SwitchBG()
	slot0:CheckSkuldBtn()
	slot0:RefreshPartBtn()
end

function slot0.ShowPanel(slot0)
	SetActive(slot0.collectBtnGo_, true)
	SetActive(slot0.selectDifficultGo_, true)
end

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
	slot0:AddBtnListener(slot0.collectBtn_, nil, function ()
		if uv0:IsOpenSectionInfo() then
			JumpTools.Back()

			return
		end

		uv0.stopMove_ = true

		uv0:Go("chapterSectionReward", {
			chapterID = uv0.chapterID_,
			level = uv0.hardLevel_
		})
	end)
	slot0:AddBtnListener(slot0.skuldbtn_, nil, function ()
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			JumpTools.GoToSystem("/skuldTravelView")
		else
			slot0 = GameSetting.travel_skuld_unlock.value[1]
			slot2, slot3 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot0)

			ShowTips(string.format(GetTips("MISSION_PROGRESS_UNLOCK_EX"), getChapterDifficulty(slot0), slot2 .. "-" .. slot3))
		end
	end)
end

function slot0.RemoveListeners(slot0)
	uv0.super.RemoveListeners(slot0)
	slot0.collectBtn_.onClick:RemoveAllListeners()
end

function slot0.RefreshCustomData(slot0)
	slot0.hardLevel_ = ChapterCfg[slot0.chapterID_].difficulty
	slot0.curStar_ = BattleStageData:GetChapterStarCnt(slot0.chapterID_)
	slot0.totalStar_ = BattleInstance.CaculateChapterStar(slot0.chapterID_)

	slot0.hardLevelView_:SetData(slot0.hardLevel_, slot0.curStar_ / slot0.totalStar_)
	BattleFieldAction.ChangePlotHardLevel(slot0.hardLevel_)
end

function slot0.SwitchRewardShow(slot0)
	if slot0:IsOpenRoute("chapterSectionReward") then
		SetActive(slot0.difficultPanel_, false)
		SetActive(slot0.collectBtnGo_, false)

		slot0.viewportRect_.localScale = Vector3.zero
	else
		SetActive(slot0.collectBtnGo_, true)

		slot0.viewportRect_.localScale = Vector3(1, 1, 1)
	end
end

function slot0.GetSectionItemClass(slot0)
	return ChapterSectionItem
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("chapterSectionInfo")
end

function slot0.GetCfgName(slot0)
	return BattleChapterStageCfg
end

function slot0.RefreshHardLevelUI(slot0)
	slot0:RefreshSelectDifficult()
end

function slot0.RefreshTogglePanel(slot0)
	if not getChapterNumList(ChapterCfg[slot0.params_.chapterID].sub_type)[2] then
		SetActive(slot0.selectDifficultGo_, false)

		return
	end

	if #ChapterCfg[getChapterNumList(slot1)[2][1]].section_id_list < 1 then
		SetActive(slot0.selectDifficultGo_, false)

		return
	end

	if slot0:IsOpenSectionInfo() or slot0:IsOpenRoute("chapterSectionReward") then
		SetActive(slot0.selectDifficultGo_, false)
	else
		SetActive(slot0.selectDifficultGo_, true)
	end
end

function slot0.RefreshCollectProgress(slot0)
	slot0.collectTotalText_.text = string.format("/%s", slot0.totalStar_)
	slot0.collectCurText_.text = slot0.curStar_
end

function slot0.RefreshSelectDifficult(slot0)
	slot0.collectProgress_.fillAmount = slot0.curStar_ / slot0.totalStar_
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0.hardLevelView_:OnEnter()
	slot0.chapterPartBtnView_:OnEnter()
	slot0:SwitchRewardShow()
	manager.notify:RegistListener(CHAPTER_SCROLL_STOP, slot0.stopMoveHandler_)
	manager.redPoint:bindUIandKey(slot0.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot0.chapterID_), {
		scaleY = 1.5,
		scaleX = 1.5,
		x = 25,
		y = 45
	})
	manager.redPoint:bindUIandKey(slot0.skuldbtn_.transform, RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	slot0:AddMoveFollowTimer()
end

function slot0.CheckSkuldBtn(slot0)
	if not slot0:IsOpenSectionInfo() and not slot0:IsOpenRoute("chapterSectionReward") and ChapterCfg[slot0.params_.chapterID].sub_type == 13 then
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			SetActive(slot0.skuldbtn_.gameObject, true)
		else
			SetActive(slot0.skuldbtn_.gameObject, false)
		end

		slot0.skuldBtnController_:SetSelectedState(SkuldTravelData:GetSkuldBtnIsBreach() and "true" or "false")
	else
		SetActive(slot0.skuldbtn_.gameObject, false)
	end
end

function slot0.RefreshPartBtn(slot0)
	if not slot0:IsOpenSectionInfo() and not slot0:IsOpenRoute("chapterSectionReward") then
		slot0.chapterPartBtnView_:RefreshUI(slot0.chapterID_)
	else
		SetActive(slot0.chapterBranchGo_, false)
	end
end

function slot0.OnUpdate(slot0)
	if slot0.chapterID_ ~= slot0.params_.chapterID then
		manager.redPoint:unbindUIandKey(slot0.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot0.chapterID_))
		manager.redPoint:bindUIandKey(slot0.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot0.params_.chapterID), {
			scaleY = 1.5,
			scaleX = 1.5,
			x = 25,
			y = 45
		})
	end

	uv0.super.OnUpdate(slot0)
end

function slot0.OnExit(slot0)
	slot0:StopMoveFollowTimer()

	slot0.imageFlag_ = nil

	slot0:RemoveTween()
	uv0.super.OnExit(slot0)
	slot0.hardLevelView_:OnExit()
	slot0.chapterPartBtnView_:OnExit()
	manager.redPoint:unbindUIandKey(slot0.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot0.chapterID_))
	OperationRecorder.RecordStayView("STAY_VIEW_SECTION", slot0:GetStayTime(), slot0.chapterID_)
	manager.redPoint:unbindUIandKey(slot0.skuldbtn_.transform, RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	manager.notify:RemoveListener(CHAPTER_SCROLL_STOP, slot0.stopMoveHandler_)
end

function slot0.Dispose(slot0)
	slot0.hardLevelView_:Dispose()

	slot0.hardLevelView_ = nil

	slot0.chapterPartBtnView_:Dispose()

	slot0.chapterPartBtnView_ = nil
	slot0.stopMoveHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddMoveFollowTimer(slot0)
	slot2 = ChapterCfg[slot0.chapterID_].drag_follow == 1

	SetActive(slot0.imagePanel_, slot2)

	if not slot2 then
		return
	end

	slot0.imagePanelTf_.localPosition = Vector3(slot0.contentRect_.localPosition.x * (maoveMaxPos == 0 and (slot0.bgTf_.rect.width - slot0.viewportRect_.rect.width) / 2 or ChapterCfg[slot1].max_width - ChapterCfg[slot1].max_width / 2) / (BattleChapterStageCfg[ChapterCfg[slot1].section_id_list[#ChapterCfg[slot1].section_id_list]].position[1] - slot0.viewportRect_.rect.width / 2), 0, 0)
	slot0.moveFollowTimer_ = FrameTimer.New(function ()
		uv0.imagePanelTf_.localPosition = Vector3(uv0.contentRect_.localPosition.x * uv1 / uv2, 0, 0)

		uv0:CheckImage()
	end, 1, -1)

	slot0.moveFollowTimer_:Start()
end

function slot0.StopMoveFollowTimer(slot0)
	if slot0.moveFollowTimer_ then
		slot0.moveFollowTimer_:Stop()

		slot0.moveFollowTimer_ = nil
	end
end

function slot0.CheckImage(slot0)
	if ChapterCfg[slot0.chapterID_].switch_bg_index == 0 then
		return
	end

	slot2 = ChapterCfg[slot0.chapterID_].section_id_list[slot1]
	slot4 = ChapterCfg[slot0.chapterID_].section_id_list[slot1 + 1]

	if slot0.contentRect_.localPosition.x * -1 < BattleChapterStageCfg[ChapterCfg[slot0.chapterID_].section_id_list[slot1 - 1]].position[1] - slot0.viewportRect_.rect.width / 2 and slot0.imageFlag_ ~= 1 then
		slot0:SwitchMiddleGB(2)

		slot0.imageFlag_ = 1
	elseif slot0.contentRect_.localPosition.x * -1 > BattleChapterStageCfg[slot4].position[1] - slot0.viewportRect_.rect.width / 2 and slot0.imageFlag_ ~= 2 then
		slot0:SwitchMiddleGB(1)

		slot0.imageFlag_ = 2
	end
end

function slot0.SwitchMiddleGB(slot0, slot1)
	if slot0.imageFlag_ == nil then
		slot0.bgCanvas1_.alpha = slot1 ~= 1 and 1 or 0
		slot0.bgCanvas2_.alpha = slot1 == 1 and 1 or 0

		return
	end

	slot0:RemoveTween()

	if slot1 == 1 then
		slot0.tween_ = LeanTween.value(slot0.gameObject_, 1, 0, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.bgCanvas1_.alpha = slot0
			uv0.bgCanvas2_.alpha = 1 - slot0
		end)):setOnComplete(System.Action(function ()
			uv0.bgCanvas1_.alpha = 0

			uv0:RemoveTween()
		end)):setEase(LeanTweenType.easeOutSine)
	else
		slot0.tween_ = LeanTween.value(slot0.gameObject_, 1, 0, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.bgCanvas2_.alpha = slot0
			uv0.bgCanvas1_.alpha = 1 - slot0
		end)):setOnComplete(System.Action(function ()
			uv0.bgCanvas2_.alpha = 0

			uv0:RemoveTween()
		end)):setEase(LeanTweenType.easeOutSine)
	end
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end
end

function slot0.StopMove(slot0)
	slot0.stopMove_ = true
end

return slot0
