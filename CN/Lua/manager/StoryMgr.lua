slot0 = class("StoryMgr", import("game.extend.BaseView"))
slot1 = 1
slot2 = {}

function slot0.Ctor(slot0)
	slot0.BEFORE = 1
	slot0.WIN = 2
	slot0.LOSE = 3
	slot0.uiShow_ = true
	slot0.cameraChanged_ = false
end

function slot0.InitPlayer(slot0, slot1)
	if not slot0.timer_ then
		slot2 = FuncTimerManager.inst
		slot0.timer_ = slot2:CreateFuncFrameTimer(function ()
			if uv0.player_ then
				uv0.player_:Update(Time.deltaTime)
			end
		end, -1, true)
	end

	slot0.stage_ = GameObject.New()
	slot0.player_ = StoryPlayer.New(slot0.stage_)
	slot0.uiShow_ = true
	slot0.cameraChanged_ = false
end

function slot0.RemovePlayer(slot0)
	manager.video:HidePlayer()

	if slot0.player_ then
		slot0:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		slot0.player_:Dispose()

		slot0.player_ = nil
	end
end

function slot0.StartStory(slot0, slot1)
	if StoryCfg[slot1].trigger[4] == 1 then
		slot4 = gameContext

		slot4:Go("/blank")

		slot4 = manager.audio

		slot4:Pause("music", true)

		slot4 = manager.video

		slot4:Play(slot2.videoPath, function (slot0)
			slot2 = nil

			SDKTools.SendMessageToSDK("story_oper", {
				oper = slot0,
				is_first = PlayerData:GetStoryList()[uv0] and 0 or 1,
				story_id = string.format(uv0)
			})
			gameContext:Back()
			PlayerAction.ChangeStoryList(uv0)
			manager.audio:Pause("music", false)
		end)

		return
	end

	slot0:InitPlayer()
	slot0:SetStagePos()

	slot4, slot5 = slot0:SetCameraParam()

	slot0:HideMainUI()

	function slot0.player_.onStoryFinished_(slot0)
		uv0:SendStoryToSdk(uv1, slot0)
		uv0:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		uv0:ResetCameraParam(uv2, uv3)

		Input.multiTouchEnabled = true

		uv0.player_:Dispose()

		uv0.player_ = nil

		if uv4.videoPath and uv4.videoPath ~= "" then
			gameContext:Go("/blank")
			manager.audio:PauseAll(true)
			manager.video:Play(uv4.videoPath, function ()
				gameContext:Back()
				PlayerAction.ChangeStoryList(uv0)
				manager.audio:PauseAll(false)
			end)

			return
		end
	end

	slot0.player_:Play(slot1)
end

function slot0.StartStoryById(slot0, slot1, slot2, slot3)
	slot0:InitPlayer()
	slot0:SetStagePos()

	slot4, slot5 = slot0:SetCameraParam()

	slot0:HideMainUI()

	function slot0.player_.onStoryFinished_(slot0)
		uv0:SendStoryToSdk(uv1, slot0)
		uv0:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		uv0:ResetCameraParam(uv2, uv3)

		Input.multiTouchEnabled = true

		uv0.player_:Dispose()

		uv0.player_ = nil

		PlayerAction.ChangeStoryList(uv1)
		uv4()
	end

	slot0.player_:HideSkipBtn(slot3)
	slot0.player_:Play(slot1)
end

function slot0.StartStoryOnEnterChessMap(slot0, slot1, slot2)
	slot0:InitPlayer()
	slot0:SetStagePos()

	slot3, slot4 = slot0:SetCameraParam()

	slot0:HideMainUI()

	function slot0.player_.onStoryFinished_(slot0)
		uv0:SendStoryToSdk(uv1, slot0)
		uv2()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		uv0:ResetCameraParam(uv3, uv4)

		Input.multiTouchEnabled = true

		uv0.player_:Dispose()

		uv0.player_ = nil

		PlayerAction.ChangeStoryList(uv1)
	end

	slot0.player_:Play(slot1)
end

function slot0.StartBattleStory(slot0, slot1, slot2, slot3)
	if slot3 == nil then
		slot3 = true
	end

	if StoryCfg[slot1].trigger[4] == 1 then
		slot6 = gameContext

		slot6:Go("/blank")

		slot6 = manager.audio

		slot6:Pause("music", true)

		slot6 = manager.video

		slot6:Play(slot4.videoPath, function (slot0)
			slot2 = nil

			SDKTools.SendMessageToSDK("story_oper", {
				oper = slot0,
				is_first = PlayerData:GetStoryList()[uv0] and 0 or 1,
				story_id = string.format(uv0)
			})
			gameContext:Back()
			uv1()
			PlayerAction.ChangeStoryList(uv0)
			manager.audio:Pause("music", false)
		end, true)

		return
	end

	if slot3 and slot0:IsStoryPlayed(slot1) then
		slot2()
	else
		slot0:InitPlayer()

		slot6 = Vector3(0, 1, -10)
		slot7 = slot0.stage_
		slot8 = manager.ui.mainCamera.transform.forward
		slot8.y = 0
		slot10 = manager.ui.mainCamera.transform.localEulerAngles
		slot10.z = 0
		slot10.x = 0
		slot7.transform.position = manager.ui.mainCamera.transform.position - Vector3(0, slot6.y, 0) - slot8 * slot6.z
		slot7.transform.localEulerAngles = slot10
		slot11, slot12 = slot0:SetCameraParam()

		slot0:HideMainUI()

		function slot0.player_.onStoryFinished_(slot0)
			uv0:SendStoryToSdk(uv1, slot0)
			uv0:ShowMainUI()
			manager.notify:CallUpdateFunc(WIN_STORY_END)
			uv0:ResetCameraParam(uv2, uv3)

			Input.multiTouchEnabled = true

			uv0.player_:Dispose()

			uv0.player_ = nil

			uv4()
		end

		slot0.player_:Play(slot1)
	end
end

function slot0.CheckBattleStory(slot0, slot1, slot2, slot3, slot4)
	if slot4 == nil then
		slot4 = true
	end

	slot5, slot6 = nil

	for slot10, slot11 in pairs(StoryCfg) do
		if slot11.trigger[1] == uv0 and slot12[2] == slot1 and slot12[3] == slot2 then
			slot5 = slot10
			slot6 = slot11

			if slot12[4] == 1 then
				slot13 = manager.audio

				slot13:Stop("music", true)

				slot13 = manager.video

				slot13:Play(slot11.videoPath, function (slot0)
					slot2 = nil

					SDKTools.SendMessageToSDK("story_oper", {
						oper = slot0,
						is_first = PlayerData:GetStoryList()[uv0] and 0 or 1,
						story_id = string.format(uv0)
					})
					uv1()
					PlayerAction.ChangeStoryList(uv0)
				end, false)

				return
			end

			break
		end
	end

	if not slot5 or slot4 and slot0:IsStoryPlayed(slot5) then
		slot3()
	else
		DestroyLua()
		LuaExchangeHelper.LoadEmpty(LuaHelper.VoidAction(function ()
			manager.uiInit()
			manager.story:InitPlayer()
			manager.story:SetStagePos()

			slot0, slot1 = manager.story:SetCameraParam()

			manager.story:HideMainUI()

			function manager.story.player_.onStoryFinished_(slot0)
				manager.story:SendStoryToSdk(uv0, slot0)

				manager.story.player_.playNext_ = nil
				manager.story.player_.isPlay_ = false
				Input.multiTouchEnabled = true

				if uv1.videoPath and uv1.videoPath ~= "" then
					if manager.story.player_.skipView_ then
						manager.story.player_.skipView_:Dispose()

						manager.story.player_.skipView_ = nil
					end

					manager.audio:StopAll()

					manager.story.player_.blackMask_.alpha = 1

					manager.video:Play(uv1.videoPath, function ()
						manager.story:ResetCameraParam(uv0, uv1)
						PlayerAction.ChangeStoryList(uv2)
						uv3()
					end)

					return
				end

				if slot0 then
					LeanTween.cancel(manager.story.player_.blackMask_.gameObject)
					manager.story:ResetCameraParam(uv2, uv3)
					PlayerAction.ChangeStoryList(uv0)
					uv4()
				else
					manager.story.player_.blackMask_.blocksRaycasts = true

					LeanTween.cancel(manager.story.player_.blackMask_.gameObject)
					LeanTween.alphaCanvas(manager.story.player_.blackMask_, 1, 0.5):setOnComplete(LuaHelper.VoidAction(function ()
						manager.story:ResetCameraParam(uv0, uv1)
						PlayerAction.ChangeStoryList(uv2)
						uv3()
					end))
				end
			end

			manager.story.player_:Play(uv0)

			if whereami ~= "battle" and whereami ~= "battleResult" then
				whereami = "battle"
			end
		end))
	end
end

function slot0.CheckBeforeBattleStory(slot0, slot1, slot2, slot3)
	slot4 = slot0.BEFORE

	if slot2 == nil then
		slot2 = true
	end

	slot5 = slot1
	slot6 = nil

	for slot10, slot11 in pairs(StoryCfg) do
		if slot11.trigger[1] == uv0 and slot12[2] == slot5 and slot12[3] == slot4 then
			slot6 = slot10

			if slot12[4] == 1 then
				slot13 = manager.audio

				slot13:Stop("music", true)

				slot13 = manager.video

				slot13:Play(slot11.videoPath, function (slot0)
					slot2 = nil

					SDKTools.SendMessageToSDK("story_oper", {
						oper = slot0,
						is_first = PlayerData:GetStoryList()[uv0] and 0 or 1,
						story_id = string.format(uv0)
					})
					uv1()
					PlayerAction.ChangeStoryList(uv0, function (slot0, slot1)
					end)
				end)

				return
			end

			break
		end
	end

	if not slot6 or slot2 and slot0:IsStoryPlayed(slot6) then
		slot3()
	else
		slot0:InitPlayer()
		slot0:SetStagePos()

		slot7, slot8 = slot0:SetCameraParam()

		slot0:HideMainUI()

		function slot0.player_.onStoryFinished_(slot0)
			uv0:SendStoryToSdk(uv1, slot0)

			uv0.player_.playNext_ = nil
			uv0.player_.isPlay_ = false

			uv0:ResetCameraParam(uv2, uv3)

			Input.multiTouchEnabled = true

			uv4()
			PlayerAction.ChangeStoryList(uv1)
		end

		slot0.player_:Play(slot6)
	end
end

function slot0.CheckChessBattleStory(slot0, slot1, slot2)
	if WarChessData:GetTemporaryData("battle" .. slot1) and not slot0:IsStoryPlayed(slot3) then
		slot0:InitPlayer()
		slot0:SetStagePos()

		slot4, slot5 = slot0:SetCameraParam()

		slot0:HideMainUI()

		function slot0.player_.onStoryFinished_(slot0)
			uv0:SendStoryToSdk(uv1, slot0)
			uv0:ResetCameraParam(uv2, uv3)

			Input.multiTouchEnabled = true
			uv0.player_.playNext_ = nil
			uv0.player_.isPlay_ = false

			uv4()
			PlayerAction.ChangeStoryList(uv1)
		end

		slot0.player_:Play(slot3)

		return
	end

	slot2()
end

function slot0.CheckRepeatBattleStory(slot0, slot1, slot2, slot3)
	slot0:CheckBeforeBattleStory(slot1, false, slot3)
end

function slot0.SetChessBG(slot0, slot1)
	WaitRenderFrameUtil.inst.StartScreenShot(function ()
		slot0 = ScreenSnap.New(Screen.width, Screen.height)

		slot0:Take()

		slot1 = slot0:GetSprite()

		uv0()

		if uv1.player_.bgs_.ChessBG == nil then
			slot4 = Object.Instantiate(slot2.paintGo_)
			slot4:GetComponent("SpriteRenderer").sprite = slot1
			slot4.name = slot3
			slot4.transform.parent = slot2.stage_.transform
			slot4.transform.localPosition = Vector3.New(0, 100, 0)
			slot2.bgs_[slot3] = slot4
		end

		slot4 = manager.ui.mainCamera.transform.localPosition
		slot6 = slot2.bgs_[slot3]
		slot6.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot4.x, slot4.y, 0)
		slot6.transform.localEulerAngles = Vector3(0, 0, 0)

		if slot6:GetComponent("SpriteRenderer") and slot7.sprite then
			slot10 = manager.ui.mainCameraCom_
			slot11 = 2 * (slot6.transform.localPosition - slot4).z * Mathf.Tan(slot10.fieldOfView * 0.5 * Mathf.Deg2Rad)
			slot17 = slot11 * slot10.aspect / slot7.sprite.bounds.size.x > slot11 / slot7.sprite.bounds.size.y and slot15 or slot16
			slot6.transform.localScale = Vector3.New(slot17, slot17, 0)
		end
	end)
end

function slot0.StartChessStoryLine(slot0, slot1, slot2)
	slot0:HideMainUI()
	slot0:InitPlayer()
	slot0:SetStagePos()

	function slot0.player_.onStoryFinished_(slot0)
		uv0:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)

		Input.multiTouchEnabled = true

		uv0.player_:Dispose()

		uv0.player_ = nil

		uv1()
	end

	slot0.player_:Play(slot1)
end

function slot0.StartChessStoryWithBackground(slot0, slot1, slot2)
	slot0:InitPlayer()
	slot0:SetStagePos()

	slot3, slot4 = slot0:SetCameraParam()

	slot0:HideMainUI()

	function slot0.player_.onStoryFinished_(slot0)
		uv0:SendStoryToSdk(uv1, slot0)
		uv0:ShowMainUI()
		manager.notify:CallUpdateFunc(WIN_STORY_END)
		uv0:ResetCameraParam(uv2, uv3)

		Input.multiTouchEnabled = true

		uv4()
		uv0.player_:Dispose()

		uv0.player_ = nil

		PlayerAction.ChangeStoryList(uv1)
	end

	slot0.player_:Play(slot1)
end

function slot0.SetStagePos(slot0)
	slot0.stage_.transform.position = Vector3(0, -5000, 0)
	slot0.stage_.transform.localEulerAngles = Vector3(0, 0, 0)
end

function slot0.SetCameraParam(slot0, slot1)
	slot0.cameraChanged_ = true
	slot3 = 25
	slot3 = Mathf.Lerp(25, 30, math.abs((manager.ui.mainCameraCom_.pixelWidth / manager.ui.mainCameraCom_.pixelHeight - 2.335766423357664) / -1.0024330900243308))

	manager.ui:SetMainCameraCom("CinemachineBrain", false)

	manager.ui.mainCamera.transform.parent = slot0.stage_.transform
	manager.ui.mainCamera.transform.localPosition = Vector3(0, 1, -10)

	manager.ui:SetMainCameraRot(Vector3.zero)

	slot6 = manager.ui.mainCameraCom_.fieldOfView

	if (slot1 or 0) == 0 then
		manager.ui.mainCameraCom_.fieldOfView = slot3
	else
		slot7 = LeanTween.value(slot6, slot3, slot1)

		slot7:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			manager.ui.mainCameraCom_.fieldOfView = slot0
		end))
		slot7:setOnComplete(System.Action(function ()
			manager.ui.mainCameraCom_.fieldOfView = uv0

			uv1:setOnUpdate(nil):setOnComplete(nil)
		end))
	end

	slot0.delay_timer_ = Timer.New(function ()
		if manager.ui.mainCamera:GetComponent("CameraExtension") then
			uv0 = slot0.shadowRotationImmediately
			slot0.shadowRotationImmediately = true
			uv1 = slot0.radialBlurScale
			slot0.radialBlurScale = 0
		end
	end, 0.05, false, true)

	slot0.delay_timer_:Start()

	slot0.shadowRotationImmediately_ = false
	slot0.fov_ = slot6
	slot0.radialBlurScal_ = 0
end

function slot0.ResetCameraParam(slot0)
	slot0.cameraChanged_ = false
	slot2 = slot0.shadowRotationImmediately_
	slot3 = slot0.radialBlurScal_

	manager.ui:SetMainCameraCom("CinemachineBrain", true)

	manager.ui.mainCameraCom_.fieldOfView = slot0.fov_ or 35
	manager.ui.mainCamera.transform.parent = nil

	manager.ui:SetMainCameraRot()
	manager.ui:SetMainCameraPos()

	if manager.ui.mainCamera:GetComponent("CameraExtension") then
		slot4.shadowRotationImmediately = slot2
		slot4.radialBlurScale = slot3
	end

	if slot0.delay_timer_ then
		slot0.delay_timer_:Stop()

		slot0.delay_timer_ = nil
	end
end

function slot0.IsStoryPlayed(slot0, slot1)
	return PlayerData:GetPlayerInfo().storylist[slot1] or false
end

function slot0.SendStoryToSdk(slot0, slot1, slot2)
	if not slot2 then
		slot4 = nil

		SDKTools.SendMessageToSDK("story_oper", {
			story_id = slot1,
			is_first = PlayerData:GetStoryList()[slot1] and 0 or 1,
			oper = StoryOperDefine.NORMAL
		})
	end
end

function slot0.HideMainUI(slot0)
	slot0.uiShow_ = false

	if manager.ui and manager.ui.uiMain then
		manager.ui.uiMain.gameObject:SetActive(false)
		manager.ui.uiPop.gameObject:SetActive(false)
	end
end

function slot0.ShowMainUI(slot0)
	slot0.uiShow_ = true

	if manager.ui and manager.ui.uiMain then
		manager.ui.uiMain.gameObject:SetActive(true)
		manager.ui.uiPop.gameObject:SetActive(true)
	end
end

function slot0.ResetStoryChoice(slot0)
	uv0 = {}
end

function slot0.SetStoryChoice(slot0, slot1)
	table.insert(uv0, slot1)
end

function slot0.GetStoryChoice(slot0)
	return uv0
end

function slot0.Dispose(slot0)
	if not slot0.uiShow_ then
		slot0:ShowMainUI()
	end

	if slot0.cameraChanged_ then
		slot0:ResetCameraParam()
	end

	if slot0.player_ then
		slot0.player_:Dispose()

		slot0.player_ = nil
	end

	if slot0.timer_ then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.timer_)

		slot0.timer_ = nil
	end
end

return slot0
