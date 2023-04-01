return {
	LoadPuzzleLevel = function (slot0, slot1)
		if SceneManager.GetSceneByName("X103") and slot2.isLoaded == true then
			return
		end

		if slot0.operation_ then
			return
		end

		slot0.callback_ = slot1
		slot0.operation_ = Asset.LoadLevelAsync("Levels/X103", true)
		slot0.raycaster_ = manager.ui.mainCamera:AddComponent(typeof(Physics2DRaycaster))

		if slot0.timer_ then
			slot0.timer_:Stop()

			slot0.timer_ = nil
		end

		slot0.timer_ = FrameTimer.New(handler(slot0, slot0.Process), 1, -1)

		slot0.timer_:Start()
	end,
	Process = function (slot0)
		if slot0.operation_:IsDone() then
			if not gameContext:GetOpenPageHandler("puzzleMain") and SceneManager.GetSceneByName("X103") and slot1.isLoaded == true then
				SceneManager.UnloadSceneAsync("X103")
			end

			if slot0.timer_ then
				slot0.timer_:Stop()

				slot0.timer_ = nil
			end

			slot0.operation_ = nil

			slot0.BindCfgUI(slot0)
			slot0.AdaptScreen(slot0)

			slot0.plauAnimCount_ = 0

			if slot0.callback_ then
				slot0.callback_()
			end

			slot0.callback_ = nil
		end
	end,
	UnLoadPuzzleLevel = function (slot0)
		if slot0.operation_ then
			return
		end

		if slot0.pieceList_ then
			for slot4, slot5 in ipairs(slot0.pieceList_) do
				slot5.Dispose(slot5)
			end

			slot0.pieceList_ = nil
		end

		if slot0.bgScaleLeanTween_ then
			slot0.bgScaleLeanTween_:setOnComplete(nil)
			LeanTween.cancel(slot0.bgTrans_.gameObject)

			slot0.bgScaleLeanTween_ = nil
		end

		if SceneManager.GetSceneByName("X103") and slot1.isLoaded == true then
			SceneManager.UnloadSceneAsync("X103")
		end

		slot0.puzzleGo_ = nil
		slot0.puzzlePanelGo_ = nil
		slot0.puzzleAnswerGo_ = nil

		if slot0.raycaster_ ~= nil then
			Object.Destroy(slot0.raycaster_)
		end
	end,
	LevelIsDone = function (slot0)
		if slot0.operation_ then
			return slot0.operation_:IsDone()
		end

		return true
	end,
	BindCfgUI = function (slot0)
		slot1, slot2 = nil

		if SceneManager.GetSceneByName("X103").rootCount > 0 then
			slot1 = SceneManager.GetSceneByName("X103"):GetRootGameObjects()
		end

		if slot1 ~= nil then
			for slot6 = 0, slot1.Length - 1 do
				if slot1[slot6].name == "Bg" then
					slot2 = slot1[slot6]
				end
			end
		end

		ComponentBinder.GetInstance():BindCfgUI(slot0, slot2)
	end,
	AdaptScreen = function (slot0)
		slot0.bgTrans_.localScale = Vector3(1, 1, 1)
		slot1 = slot0.bgRenderer_.bounds.size
		slot3 = slot1.y
		slot5 = manager.ui.mainCameraCom_.orthographicSize * 2
		slot7 = slot5 / Screen.height * Screen.width / slot1.x
		slot8 = slot5 / slot3
		slot9 = Mathf.Max(slot7, slot8)
		slot0.adaptScale_ = Vector2(slot9, slot9)
		slot0.bgTrans_.localScale = slot0.adaptScale_
		slot12 = slot0.bgTrans_.localPosition
		slot12.y = slot12.y + (slot3 * slot9 - slot5) * 0.5
		slot0.bgTrans_.localPosition = slot12
		slot13 = Mathf.Min(slot7, slot8)
		slot0.panelNewScale_ = Vector2(slot13, slot13)
		slot0.panelTrans_.localScale = slot0.panelNewScale_

		UnityEngine.Physics2D.SyncTransforms()
	end,
	InitPuzzlePiece = function (slot0, slot1, slot2, slot3)
		slot0.pieceList_ = slot0.pieceList_ or {}
		slot5 = slot0.puzzlePanelTrans_.childCount
		slot6 = slot0.puzzlePanelTrans_.rect.width
		slot7 = slot6 / ActivityPuzzleCfg[slot1].type
		slot8 = Vector2(slot7, slot7)
		slot9 = slot6 * 0.5
		slot10 = slot7 * 0.5
		slot11 = Vector3(-slot9 + slot10, slot9 - slot10, 0)
		slot12 = Vector3(0, 0, 0)
		slot13 = 1

		for slot18 = 0, slot4 - 1 do
			for slot22 = 0, slot14 do
				if slot0.pieceList_[slot13] == nil then
					slot23 = nil
					slot0.pieceList_[#slot0.pieceList_ + 1] = PuzzlePiece.New((slot5 >= slot13 or Object.Instantiate(slot0.pieceTemplate_, slot0.puzzlePanelTrans_)) and slot0.puzzlePanelTrans_:GetChild(slot13 - 1).gameObject)
				end

				slot0.pieceList_[slot13]:SetSelectCallBack(slot3)
				slot0.pieceList_[slot13]:SetData(slot2[slot13], slot13, slot1, slot8)

				slot12.x = slot22 * slot7
				slot12.y = -slot18 * slot7
				slot0.pieceList_[slot13].transform_.localPosition = slot11 + slot12
				slot13 = slot13 + 1
			end
		end

		for slot19 = slot13, #slot0.pieceList_ do
			slot0.pieceList_[slot19]:SetActive(false)
		end

		UnityEngine.Physics2D.SyncTransforms()

		return slot0.pieceList_
	end,
	RefreshAnswer = function (slot0, slot1)
		slot0.answerRenderer_.sprite = getSprite(ActivityPuzzleCfg[slot1].path, ActivityPuzzleCfg[slot1].picture_id)
	end,
	GetAnswerAnim = function (slot0)
		return slot0.answerAnim_
	end,
	SetPuzzleAnswerPanel = function (slot0, slot1)
		SetActive(slot0.puzzleAnswerPanel_, slot1)
	end,
	GetPanelNewScale = function (slot0)
		return slot0.panelNewScale_
	end,
	SetPuzzleGo = function (slot0, slot1)
		SetActive(slot0.puzzleGo_, slot1)
	end,
	RefreshPuzzlePanel = function (slot0, slot1)
		SetActive(slot0.puzzlePanelGo_, not slot1)
		SetActive(slot0.puzzleAnswerGo_, slot1)
	end,
	GetPanelTrans = function (slot0)
		return slot0.panelTrans_
	end,
	GetBgTrans = function (slot0)
		return slot0.bgTrans_
	end,
	GetPuzzlePanelWidth = function (slot0)
		if slot0.corners_ == nil then
			slot0.corners_ = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
		end

		if slot0.puzzleWidth_ == nil then
			slot0.puzzlePanelTrans_:GetWorldCorners(slot0.corners_)

			slot1 = manager.ui.mainCameraCom_
			slot0.puzzleWidth_ = (slot1:WorldToScreenPoint(slot0.corners_[2]).x - slot1:WorldToScreenPoint(slot0.corners_[0]).x) * manager.ui.canvasSize_.x / Screen.width
		end

		return slot0.puzzleWidth_
	end,
	RefreshPuzzleBg = function (slot0, slot1)
		if getSpriteWithoutAtlas("Textures/VolumeIIIUI/" .. ActivityPuzzleCfg[slot1].album_id) ~= nil then
			slot0.puzzleBgRenderer_.sprite = slot2
		end

		slot3 = slot0.puzzleBgRenderer_.sprite
		slot4 = slot3.bounds.size
		slot5 = slot3.border
		slot8 = slot0.puzzlePanelTrans_.rect
		slot0.puzzleBgTrans_.localScale = Vector3(slot8.width / (slot4.x - slot5.x * 0.01 - slot5.z * 0.01), slot8.height / (slot4.y - slot5.y * 0.01 - slot5.w * 0.01), 1)
	end,
	ScaleBg = function (slot0, slot1)
		slot0.bgOriginScale_ = slot0.bgTrans_.localScale
		slot2 = slot0.bgTrans_.localScale
		slot2.x = slot2.x + slot1
		slot2.y = slot2.y + slot1
		slot3 = LeanTween.scale(slot0.bgTrans_, slot2, 0.466)
		slot3 = slot3:setEase(LeanTweenType.easeOutCubic)
		slot0.bgScaleLeanTween_ = slot3:setOnComplete(LuaHelper.VoidAction(function ()
			if uv0.bgScaleLeanTween_ then
				uv0.bgScaleLeanTween_:setOnComplete(nil)

				uv0.bgScaleLeanTween_ = nil
			end
		end))
	end,
	RecoverBg = function (slot0)
		if slot0.bgOriginScale_ ~= nil then
			slot1 = LeanTween.scale(slot0.bgTrans_, slot0.bgOriginScale_, 0.466)
			slot1 = slot1:setEase(LeanTweenType.easeOutCubic)
			slot0.bgScaleLeanTween_ = slot1:setOnComplete(LuaHelper.VoidAction(function ()
				if uv0.bgScaleLeanTween_ then
					uv0.bgScaleLeanTween_:setOnComplete(nil)

					uv0.bgScaleLeanTween_ = nil
				end
			end))
		end

		slot0.bgOriginScale_ = nil
	end
}
