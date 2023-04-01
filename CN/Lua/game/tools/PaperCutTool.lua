return {
	LoadScene = function (slot0, slot1)
		if SceneManager.GetSceneByName("X107") and slot2.isLoaded == true then
			return
		end

		if slot0.operation_ then
			return
		end

		slot0.callback_ = slot1
		slot0.operation_ = Asset.LoadLevelAsync("Levels/X107", true)

		if slot0.timer_ then
			slot0.timer_:Stop()

			slot0.timer_ = nil
		end

		slot0.timer_ = FrameTimer.New(handler(slot0, slot0.Process), 1, -1)

		slot0.timer_:Start()
	end,
	Process = function (slot0)
		if slot0.operation_:IsDone() then
			if not gameContext:GetOpenPageHandler("paperCutMain") and SceneManager.GetSceneByName("X107") and slot1.isLoaded == true then
				SceneManager.UnloadSceneAsync("X107")
			end

			if slot0.timer_ then
				slot0.timer_:Stop()

				slot0.timer_ = nil
			end

			slot0.operation_ = nil

			slot0:BindCfgUI()
			slot0.paperCutManager_:SetCanvas(manager.ui.canvas)
			slot0.paperCutManager_:SetCanvasScale(Vector2(manager.ui.canvasSize_.x / Screen.width, manager.ui.canvasSize_.y / Screen.height))
			slot0.paperCutManager_:InitialScene()

			if slot0.callback_ then
				slot0.callback_()

				slot0.callback_ = nil
			end
		end
	end,
	UnLoadScene = function (slot0)
		if slot0.operation_ then
			return
		end

		if slot0.paperCutManager_ ~= nil then
			slot0.paperCutManager_:ResetScene()

			slot0.paperCutManager_ = nil
		end

		if SceneManager.GetSceneByName("X107") and slot1.isLoaded == true then
			SceneManager.UnloadSceneAsync("X107")
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

		if SceneManager.GetSceneByName("X107").rootCount > 0 then
			slot1 = SceneManager.GetSceneByName("X107"):GetRootGameObjects()
		end

		if slot1 ~= nil then
			for slot6 = 0, slot1.Length - 1 do
				if slot1[slot6].name == "Panel" then
					slot2 = slot1[slot6]
				end
			end
		end

		slot0.paperCutManager_ = slot2:GetComponent("PaperCutManager")

		ComponentBinder.GetInstance():BindCfgUI(slot0, slot2)
	end,
	GameStart = function (slot0, slot1)
		slot0:RefreshDrawSprite(slot1)
		slot0:SetCheckPointPanel(slot1)
		slot0.paperCutManager_:GameStart()
	end,
	GameOver = function (slot0)
		slot0.paperCutManager_:GameOver()
	end,
	GetPaperRenderer = function (slot0)
		return slot0.paperRenderer_
	end,
	RegisterCompleteHandler = function (slot0, slot1)
		slot0.paperCutManager_:SetOnComplete(slot1)
	end,
	RegisterStartDrawHandler = function (slot0, slot1)
		slot0.paperCutManager_:SetOnStartDraw(slot1)
	end,
	RefreshDrawSprite = function (slot0, slot1)
		slot0.drawSpriteRenderer_.sprite = getSpriteWithoutAtlas("Textures/EmptyDream/paperCut/" .. PaperCutCfg[slot1].cut_result_picture)
		slot0.drawOutline_.sprite = getSpriteWithoutAtlas("Textures/EmptyDream/paperCut/" .. PaperCutCfg[slot1].cut_line_picture)
	end,
	SetCheckPointPanel = function (slot0, slot1)
		slot0.paperCutManager_:LoadCheckPointPanel(slot1)
	end,
	DisplayResultImage = function (slot0, slot1)
		slot0.paperCutManager_:DisplayResultImage(slot1)
	end,
	CalculateScore = function (slot0)
		return slot0.paperCutManager_:CalculateScore()
	end,
	OnLogout = function (slot0)
		slot0.UnLoadScene(slot0)
	end
}
