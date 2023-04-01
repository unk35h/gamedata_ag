slot0 = class("PuzzleSelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/Puzzle/VolumePuzzleGamePlayUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.rewardItemList_ = {}
	slot0.onItemSelectHandler_ = handler(slot0, slot0.OnItemSelected)
	slot0.onCompleteHandler_ = handler(slot0, slot0.CompletedPuzzle)
	slot0.onMoveHandler_ = handler(slot0, slot0.OnMovePuzzle)
	slot0.operationType_ = PuzzleAction.OPERATION_TYPE

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.completedController_ = ControllerUtil.GetController(slot0.transform_, "complete")
	slot0.resetBtnController_ = ControllerUtil.GetController(slot0.transform_, "resetBtn")
	slot0.stepCountController_ = ControllerUtil.GetController(slot0.transform_, "stepCount")
	slot0.lastRecordController_ = ControllerUtil.GetController(slot0.transform_, "lastRecord")
	slot0.retryController_ = ControllerUtil.GetController(slot0.transform_, "retry")
	slot0.rewardState_ = ControllerUtil.GetController(slot0.transform_, "reward")
	slot0.previewController_ = ControllerUtil.GetController(slot0.transform_, "preview")
end

function slot0.OnEnter(slot0)
	manager.notify:Invoke(PUZZLE_GAME_ENTER)

	slot0.canMove_ = true
	slot0.retry_ = false
	slot0.activityID_ = slot0.params_.activityID
	slot0.isCompleted_ = PuzzleData:IsCompleted(slot0.activityID_)

	slot0:InitializePuzzle()
	slot0:RefreshUI()

	slot0.videoRedPointStr_ = string.format("%s_%s_%s_video", RedPointConst.ACTIVITY_PUZZLE, slot0.params_.mainActivityID, slot0.params_.activityID)

	manager.redPoint:bindUIandKey(slot0.watchBtnTrans_, slot0.videoRedPointStr_)
end

function slot0.OnExit(slot0)
	manager.notify:Invoke(PUZZLE_GAME_EXIT)

	if slot0.timer_ ~= nil then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	PuzzleTool:SetPuzzleGo(false)
	PuzzleTool:SetPuzzleAnswerPanel(false)
	SetActive(slot0.previewPanel_, false)
	manager.redPoint:unbindUIandKey(slot0.watchBtnTrans_, slot0.videoRedPointStr_)
end

function slot0.OnEnterReTry(slot0)
	slot0.retryController_:SetSelectedState("uncompleted")
	slot0.completedController_:SetSelectedState("retry")
	slot0.resetBtnController_:SetSelectedState("reset")
	slot0.previewController_:SetSelectedState("true")

	slot0.retry_ = true

	manager.windowBar:HideBar()
	slot0:ResetLevel()
	slot0:RefreshUI()
	PuzzleTool:RefreshPuzzlePanel(false)
	slot0:RefreshRecord(false, PuzzleData:GetMinStepCount(slot0.activityID_))
end

function slot0.OnExitRetry(slot0)
	slot0.retryController_:SetSelectedState("none")

	slot0.retry_ = false

	SetActive(slot0.newRecordFlag_, false)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_PUZZLE_DESCRIPE")
	slot0:RefreshUI()
	PuzzleTool:RefreshPuzzlePanel(slot0.isCompleted_)
end

function slot0.InitializePuzzle(slot0)
	slot0.curStateList_ = PuzzleData:GetStateList(slot0.activityID_)
	slot0.puzzleSize_ = ActivityPuzzleCfg[slot0.activityID_].type
	slot0.answerList_ = ActivityPuzzleCfg[slot0.activityID_].correct_array
	slot0.maxStep_ = ActivityPuzzleCfg[slot0.activityID_].max_step
	slot0.emptyFlag_ = ActivityPuzzleCfg[slot0.activityID_].block
	slot0.pieceList_ = PuzzleTool:InitPuzzlePiece(slot0.activityID_, slot0.curStateList_, slot0.onItemSelectHandler_)

	slot0:RefreshPreviewImg()
end

function slot0.RefreshPreviewImg(slot0)
	slot1 = ActivityPuzzleCfg[slot0.activityID_].picture_id
	slot2 = ActivityPuzzleCfg[slot0.activityID_].path
	slot0.previewBigImg_.sprite = getSprite(slot2, slot1)
	slot0.previewSmallImg_.sprite = getSprite(slot2, slot1)
	slot3 = PuzzleTool:GetPuzzlePanelWidth()
	slot0.previewBigTrans_.sizeDelta = Vector2(slot3, slot3)
	slot9, slot0.previewBigTrans_.localPosition = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot0.previewPanel_.transform, manager.ui.mainCameraCom_:WorldToScreenPoint(PuzzleTool:GetPanelTrans().position), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, Vector2(1, 1))
end

function slot0.ResetLevel(slot0)
	PuzzleData:ResetData(slot0.activityID_)

	slot4 = slot0.activityID_
	slot0.curStateList_ = PuzzleData:GetStateList(slot4)

	for slot4, slot5 in ipairs(slot0.curStateList_) do
		if slot0.pieceList_[slot4] then
			slot0.pieceList_[slot4]:SetID(slot5)
		end
	end
end

function slot0.RefreshUI(slot0)
	if slot0.retry_ == false then
		slot0:RefreshReward()
		slot0.completedController_:SetSelectedState(tostring(slot0.isCompleted_))

		if not slot0.isCompleted_ then
			slot0.stepCountController_:SetSelectedState("cur")
			slot0.resetBtnController_:SetSelectedState("reset")
			slot0.previewController_:SetSelectedState("true")
		else
			slot0.resetBtnController_:SetSelectedState("retry")
			slot0.previewController_:SetSelectedState("false")

			if PuzzleData:GetMinStepCount(slot0.activityID_) == 0 then
				slot0.stepCountController_:SetSelectedState("none")
			else
				slot0.stepCountController_:SetSelectedState("min")
			end

			PuzzleTool:RefreshAnswer(slot0.activityID_)
			SetActive(slot0.playStoryBtnGo_, ActivityPuzzleCfg[slot0.activityID_].story_id ~= 0)
		end

		slot0:RefreshHelpBtn()
	else
		slot0.stepCountController_:SetSelectedState("cur")
	end

	slot0:RefreshStepCount()
end

function slot0.RefreshStepCount(slot0)
	slot1 = 0

	if not slot0.isCompleted_ or slot0.retry_ == true then
		slot0.curStepCountText_.text = PuzzleData:GetStepCount(slot0.activityID_)
	else
		slot0.minStepCountText_.text = PuzzleData:GetMinStepCount(slot0.activityID_)
	end
end

function slot0.RefreshRecord(slot0, slot1, slot2)
	SetActive(slot0.newRecordFlag_, slot1)

	if slot2 ~= 0 then
		slot0.lastRecordController_:SetSelectedState("true")

		slot0.lastRecordText_.text = slot2
	else
		slot0.lastRecordController_:SetSelectedState("false")
	end
end

function slot0.RefreshHelpBtn(slot0)
	if PuzzleData:GetStepCount(slot0.activityID_) < slot0.maxStep_ then
		slot0.helpText_.text = string.format(GetTips("PUZZLE_HELP_REMAIN"), slot0.maxStep_ - slot1)
		slot0.helpBtn_.interactable = false
	else
		slot0.helpText_.text = GetTips("PUZZLE_HELP")
		slot0.helpBtn_.interactable = true
	end

	if slot1 == slot0.maxStep_ and (getData(string.format("Puzzle_%d", slot0.activityID_), "canPlayHelpAnim") == nil or slot2 == true) then
		slot0.helpAnim_:Play("VolumePuzzleGamePlayUI_help", -1, 0)
		saveData(string.format("Puzzle_%d", slot0.activityID_), "canPlayHelpAnim", false)
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_puzzlehelp", "")
	end
end

function slot0.OnItemSelected(slot0, slot1)
	if not slot0.canMove_ then
		return
	end

	slot2 = slot1
	slot3 = slot2 - 1
	slot4 = slot2 + 1
	slot5 = slot2 - slot0.puzzleSize_
	slot6 = slot2 + slot0.puzzleSize_

	if slot2 % slot0.puzzleSize_ ~= 1 and slot0.curStateList_[slot3] == slot0.emptyFlag_ then
		slot0:ExChangeItem(slot2, slot3, slot1)
	elseif slot2 % slot0.puzzleSize_ ~= 0 and slot0.curStateList_[slot4] == slot0.emptyFlag_ then
		slot0:ExChangeItem(slot2, slot4, slot1)
	elseif slot5 > 0 and slot0.curStateList_[slot5] == slot0.emptyFlag_ then
		slot0:ExChangeItem(slot2, slot5, slot1)
	elseif slot6 <= #slot0.curStateList_ and slot0.curStateList_[slot6] == slot0.emptyFlag_ then
		slot0:ExChangeItem(slot2, slot6, slot1)
	end
end

function slot0.ExChangeItem(slot0, slot1, slot2, slot3)
	slot4 = slot0.pieceList_[slot1].ID_

	slot0.pieceList_[slot1]:SetID(slot0.pieceList_[slot2].ID_)

	slot0.curStateList_[slot1] = slot0.pieceList_[slot2].ID_

	slot0.pieceList_[slot2]:SetID(slot4)

	slot0.curStateList_[slot2] = slot4

	PuzzleData:SetPuzzleState(slot0.activityID_, slot1, slot0.curStateList_[slot1], slot2, slot0.curStateList_[slot2])
	slot0:RefreshHelpBtn()

	slot5 = slot0:CheckAnswer()

	slot0:RefreshStepCount(slot5)

	if not slot5 then
		slot0.canMove_ = false

		PuzzleAction.Operate(slot0.activityID_, slot0.operationType_.move, slot0.onMoveHandler_, slot3)
	else
		slot0.canMove_ = false

		PuzzleAction.Operate(slot0.activityID_, slot0.operationType_.complete, slot0.onCompleteHandler_, slot3)
	end

	manager.audio:PlayEffect("minigame_activity_1_3", "minigame_slide", "")
end

function slot0.OnMovePuzzle(slot0)
	slot0.canMove_ = true
end

function slot0.CheckAnswer(slot0)
	slot1 = true

	for slot5, slot6 in ipairs(slot0.answerList_) do
		if slot0.answerList_[slot5] ~= slot0.curStateList_[slot5] then
			slot1 = false

			break
		end
	end

	return slot1
end

function slot0.CompletedPuzzle(slot0, slot1)
	slot0.canMove_ = true

	PuzzleData:SetCompletedActivityList(slot0.activityID_)

	slot0.isCompleted_ = true

	PuzzleTool:RefreshPuzzlePanel(slot0.isCompleted_)
	PuzzleTool:RefreshAnswer(slot0.activityID_)

	if not slot1 then
		slot2, slot3 = PuzzleData:SetMinStepCount(slot0.activityID_)

		if slot0.retry_ == true then
			slot0.retryController_:SetSelectedState("completed")
			slot0.resetBtnController_:SetSelectedState("none")
			slot0:RefreshRecord(slot2, slot3)
		end
	end

	slot0.previewController_:SetSelectedState("false")
	slot0:RefreshUI()
	slot0:PlaySuccessAnim()
end

function slot0.PlaySuccessAnim(slot0)
	SetActive(slot0.fullMask_, true)
	PuzzleTool:SetPuzzleAnswerPanel(true)
	PuzzleTool:GetAnswerAnim():Play("VolumePuzzleGamePlayUI_success", -1, 0)

	slot0.timer_ = Timer.New(function ()
		if uv0:GetCurrentAnimatorStateInfo(0):IsName(uv1) and slot0.normalizedTime >= 1 then
			if uv2.timer_ ~= nil then
				uv2.timer_:Stop()

				uv2.timer_ = nil
			end

			SetActive(uv2.fullMask_, false)
			PuzzleTool:SetPuzzleAnswerPanel(false)
		end
	end, 0.033, -1)

	slot0.timer_:Start()
	manager.audio:PlayEffect("minigame_activity_1_3", "minigame_puzzlecomplete", "")
end

function slot0.RefreshReward(slot0)
	for slot5, slot6 in ipairs(ActivityPuzzleCfg[slot0.activityID_].reward_item_list) do
		if slot0.rewardItemList_[slot5] then
			slot0.rewardItemList_[slot5]:SetData(slot6, false)
		else
			slot0.rewardItemList_[slot5] = RewardPoolItem.New(slot0.goRewardPanel_, slot6)
		end
	end

	for slot5 = #slot1 + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot5]:Show(false)
	end

	slot3 = PuzzleData:IsReceived(slot0.activityID_)

	if not PuzzleData:IsCompleted(slot0.activityID_) then
		slot0.rewardState_:SetSelectedState("uncompleted")
	elseif not slot3 then
		slot0.rewardState_:SetSelectedState("unreceived")
	else
		slot0.rewardState_:SetSelectedState("received")
	end
end

function slot0.Dispose(slot0)
	slot0.onItemSelectHandler_ = nil
	slot0.onCompleteHandler_ = nil
	slot0.operationType_ = nil

	for slot4, slot5 in pairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil
	slot0.pieceList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(uv0.activityID_, uv0.operationType_.reset, function ()
			uv0:ResetLevel()
			uv0:RefreshUI()
			saveData(string.format("Puzzle_%d", uv0.activityID_), "canPlayHelpAnim", true)
		end)
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(uv0.activityID_, uv0.operationType_.receive, function ()
			getReward(ActivityPuzzleCfg[uv0.activityID_].reward_item_list)
			PuzzleData:SetReceivedActivityList(uv0.activityID_)
			uv0:RefreshReward()
		end)
	end)
	slot0:AddBtnListener(slot0.helpBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(uv0.activityID_, uv0.operationType_.help, uv0.onCompleteHandler_)
	end)
	slot0:AddBtnListener(slot0.reTryBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(uv0.activityID_, uv0.operationType_.reset, function ()
			uv0:OnEnterReTry()
		end)
	end)
	slot0:AddBtnListener(slot0.playStoryBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleData:SetWatchedVideo(uv0.activityID_)

		manager.ui.mainCameraCom_.orthographic = false

		manager.ui:ResetMainCamera()

		if StoryCfg[ActivityPuzzleCfg[uv0.activityID_].story_id].trigger[4] == 1 then
			slot3 = gameContext

			slot3:Go("blank")

			slot3 = manager.audio

			slot3:Pause("music", true)

			slot3 = manager.video

			slot3:Play(slot1.videoPath, function ()
				gameContext:Back(nil, {
					isEnter = false
				})
				PlayerAction.ChangeStoryList(uv0)
				manager.audio:Pause("music", false)
				manager.ui:SetMainCamera("puzzle")

				manager.ui.mainCameraCom_.orthographic = true
			end)

			return
		end
	end)
	slot0:AddBtnListener(slot0.tryAgainBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleAction.Operate(uv0.activityID_, uv0.operationType_.reset, function ()
			uv0:OnEnterReTry()
		end)
	end)
	slot0:AddBtnListener(slot0.retrunBtn_, nil, function ()
		uv0:OnExitRetry()
	end)
	slot0:AddBtnListener(slot0.giveUpBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_PUZZLE"),
			OkCallback = function ()
				PuzzleAction.Operate(uv0.activityID_, uv0.operationType_.reset, function ()
					uv0:OnExitRetry()
				end)
			end
		})
	end)
	slot0:AddBtnListener(slot0.previewBtn_, nil, function ()
		SetActive(uv0.previewPanel_, true)
	end)
	slot0:AddBtnListener(slot0.previewReturnBtn_, nil, function ()
		SetActive(uv0.previewPanel_, false)
	end)
end

return slot0
