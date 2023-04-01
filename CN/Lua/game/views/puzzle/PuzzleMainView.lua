slot0 = class("PuzzleMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/Puzzle/VolumePuzzleMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.onSenceLoadedHandler_ = handler(slot0, slot0.OnPuzzleSceneLoaded)
	slot0.puzzleGameEnterHandler_ = handler(slot0, slot0.OnPuzzleGameEnter)
	slot0.puzzleGameExitHandler_ = handler(slot0, slot0.OnPuzzleGameExit)
	slot0.puzzleAnimStartHandler_ = handler(slot0, slot0.OnAnimStart)
	slot0.puzzleAnimEndHandler_ = handler(slot0, slot0.OnAnimEnd)
	slot0.clickSwitchItemHandler_ = handler(slot0, slot0.OnClickSwitchItem)

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.gameStartController_ = ControllerUtil.GetController(slot0.transform_, "gameStart")
	slot0.switchItemList_ = {}
	slot2 = nil

	for slot6 = 1, slot0.contentTrans_.childCount do
		slot0.switchItemList_[slot6] = PuzzleSelectItem.New(slot0.contentTrans_:GetChild(slot6 - 1).gameObject)
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_PUZZLE_DESCRIPE")
	manager.notify:RegistListener(PUZZLE_GAME_ENTER, slot0.puzzleGameEnterHandler_)
	manager.notify:RegistListener(PUZZLE_GAME_EXIT, slot0.puzzleGameExitHandler_)
	manager.notify:RegistListener(PUZZLE_GAME_ANIM_START, slot0.puzzleAnimStartHandler_)
	manager.notify:RegistListener(PUZZLE_GAME_ANIM_END, slot0.puzzleAnimEndHandler_)
	slot0.gameStartController_:SetSelectedState("false")
	slot0:LoadPuzzleScene()

	slot0.activityID_ = slot0.params_.activityID
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime
	slot2 = slot0.contentTrans_.localPosition
	slot2.x = PuzzleData:GetLastContentPosX(slot0.activityID_) or slot2.x
	slot0.contentTrans_.localPosition = slot2
end

function slot0.OnTop(slot0)
	slot0.playingAnimCount_ = 0

	slot0:RefreshUI()
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(PUZZLE_GAME_ENTER, slot0.puzzleGameEnterHandler_)
	manager.notify:RemoveListener(PUZZLE_GAME_EXIT, slot0.puzzleGameExitHandler_)
	manager.notify:RemoveListener(PUZZLE_GAME_ANIM_START, slot0.puzzleAnimStartHandler_)

	slot4 = PUZZLE_GAME_ANIM_END
	slot5 = slot0.puzzleAnimEndHandler_

	manager.notify:RemoveListener(slot4, slot5)

	for slot4, slot5 in ipairs(slot0.switchItemList_) do
		slot5:OnExit()
	end

	slot0:UnLoadPuzzleScene()
	slot0:StopTimer()
	PuzzleData:SetLastContentPosX(slot0.activityID_, slot0.contentTrans_.localPosition.x)
end

function slot0.Dispose(slot0)
	slot0.onSenceLoadedHandler_ = nil
	slot0.puzzleGameEnterHandler_ = nil
	slot0.puzzleGameExitHandler_ = nil
	slot0.puzzleAnimStartHandler_ = nil
	slot0.puzzleAnimEndHandler_ = nil
	slot0.clickSwitchItemHandler_ = nil

	for slot4, slot5 in ipairs(slot0.switchItemList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnPuzzleGameEnter(slot0)
	slot0.startAnim_:Play("VolumePuzzleMain_exit", -1, 0)
	slot0:StopTimer()
end

function slot0.OnPuzzleGameExit(slot0)
	for slot4, slot5 in ipairs(slot0.switchItemList_) do
		slot5:Reset()
	end

	slot0.gameStartController_:SetSelectedState("false")
	slot0.startAnim_:Play("VolumePuzzleMain_recover", -1, 0)
	PuzzleTool:RecoverBg()
end

function slot0.OnAnimStart(slot0)
	slot0.playingAnimCount_ = slot0.playingAnimCount_ + 1

	SetActive(slot0.fullMask_, true)
end

function slot0.OnAnimEnd(slot0)
	PuzzleTool:SetPuzzleGo(true)
	PuzzleTool:RefreshPuzzlePanel(PuzzleData:IsCompleted(slot0.selectActivityID_))

	slot0.playingAnimCount_ = slot0.playingAnimCount_ - 1

	if slot0.playingAnimCount_ == 0 then
		slot0.gameStartController_:SetSelectedState("true")
		SetActive(slot0.fullMask_, false)
	end
end

function slot0.LoadPuzzleScene(slot0)
	manager.ui:SetMainCamera("puzzle")

	manager.ui.mainCameraCom_.orthographic = true

	PuzzleTool:LoadPuzzleLevel(slot0.onSenceLoadedHandler_)
end

function slot0.UnLoadPuzzleScene(slot0)
	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	PuzzleTool:UnLoadPuzzleLevel()
end

function slot0.RefreshUI(slot0)
	slot0.subActivityList_ = ActivityCfg[slot0.activityID_].sub_activity_list

	for slot4, slot5 in ipairs(slot0.switchItemList_) do
		slot5:SetData(slot0.activityID_, slot0.subActivityList_[slot4], slot4)
		slot5:SetClickCallBack(slot0.clickSwitchItemHandler_)
		slot5:Reset()
	end

	slot0:RefreshDesc()
	SetActive(slot0.fullMask_, false)
end

function slot0.RefreshDesc(slot0)
	slot0.descText_.text = GetTips("ACTIVITY_PUZZLE_CONTENT")
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	slot0.remainTimeText_.text = manager.time:GetLostTimeStr(slot0.stopTime_)

	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		for slot3, slot4 in ipairs(uv0.switchItemList_) do
			slot4:RefreshLock()
		end

		uv0.remainTimeText_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnPuzzleSceneLoaded(slot0)
end

function slot0.OnClickSwitchItem(slot0, slot1, slot2)
	slot0.selectActivityID_ = slot2

	for slot6, slot7 in ipairs(slot0.switchItemList_) do
		slot7:OnClickItem(slot1)
	end
end

return slot0
