slot1 = require("cjson")
slot2 = 2520
slot3 = 1

return {
	GetMainUIName = function (slot0)
		if ActivityConst.VOLUME_III_COWBOY == slot0 then
			return "UI/VolumeIIIUI/VolumeWindAndFarceMainUI"
		else
			return "UI/VolumeIIIUI/VolumeWindAndFarceMainUI"
		end
	end,
	GetGameHelpKey = function (slot0)
		if ActivityConst.VOLUME_III_COWBOY == slot0 then
			return "ACTIVITY_COWBOY_TIPS"
		else
			return ""
		end
	end,
	GetGameUIName = function (slot0)
		if ActivityConst.VOLUME_III_COWBOY == slot0 then
			return "UI/VolumeIIIUI/VolumeWindAndFarceUI"
		else
			return "UI/VolumeIIIUI/VolumeWindAndFarceUI"
		end
	end,
	GetInfoUIName = function (slot0)
		if ActivityConst.VOLUME_III_COWBOY == slot0 then
			return "UI/VolumeIIIUI/VolumeXiuGameruleUI"
		else
			return "UI/VolumeIIIUI/VolumeXiuGameruleUI"
		end
	end,
	LoadCowboyLevel = function (slot0, slot1, slot2, slot3, slot4)
		if SceneManager.GetSceneByName("X105") and slot5.isLoaded == true then
			return
		end

		if slot0.operation_ then
			return
		end

		slot0.callback_ = slot1
		slot0.onTimeChange_ = slot2
		slot0.onScoreChange_ = slot3
		slot0.onAttack_ = slot4
		slot0.operation_ = Asset.LoadLevelAsync("Levels/X105", true)
		slot0.raycaster_ = manager.ui.mainCamera:AddComponent(typeof(Physics2DRaycaster))

		if slot0.loadTimer_ then
			slot0.loadTimer_:Stop()

			slot0.loadTimer_ = nil
		end

		slot0.loadTimer_ = FrameTimer.New(handler(slot0, slot0.Process), 1, -1)

		slot0.loadTimer_:Start()
	end,
	Process = function (slot0)
		if slot0.operation_:IsDone() then
			if not gameContext:GetOpenPageHandler("cowboyGame") and SceneManager.GetSceneByName("X105") and slot1.isLoaded == true then
				SceneManager.UnLoadSceneAsync("X105")
			end

			if slot0.loadTimer_ then
				slot0.loadTimer_:Stop()

				slot0.loadTimer_ = nil
			end

			slot0.operation_ = nil

			if slot0.callback_ then
				slot0.callback_()
			end

			slot0.callback_ = nil
		end
	end,
	InitCowboySence = function (slot0, slot1, slot2)
		slot0.mainActivityID_ = slot1
		slot0.activityID_ = slot2

		ComponentBinder.GetInstance():BindCfgUI(slot0, slot0:GetBgGo())
		slot0:GameEnter()
	end,
	GetBgGo = function (slot0)
		slot1, slot2 = nil

		if SceneManager.GetSceneByName("X105").rootCount > 0 then
			slot1 = SceneManager.GetSceneByName("X105"):GetRootGameObjects()
		end

		if slot1 then
			for slot6 = 0, slot1.Length - 1 do
				if slot1[slot6].name == "bg" then
					slot2 = slot1[slot6]
				end
			end
		end

		return slot2
	end,
	GameEnter = function (slot0)
		slot0.cowboyData_ = {}
		slot0.cows_ = {}
		slot0.cowboyGo_ = nil
		slot0.aniController_ = nil
		slot0.cowboyState_ = ""
		slot0.frameTimer_ = nil
		slot0.totalTime_ = 0
		slot0.curTime_ = 0
		slot0.isEnd_ = false
		slot0.isPausing_ = false
		slot0.score_ = 0
		slot0.cowIndex_ = 1
		slot0.show_ = {}
		slot0.unshow_ = {}
		slot0.cowIDList_ = {}
		slot0.attackTimer_ = nil

		slot0.GetTempCorners(slot0)
		slot0.AssetData(slot0)
		slot0.DrawCowboy(slot0)
		slot0.Start(slot0)
	end,
	GetTempCorners = function (slot0)
		if slot0.corners == nil then
			slot0.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
		end
	end,
	AssetData = function (slot0)
		slot0.cowboyData_ = uv0.decode(AssetEx.LoadText("Cowboy/CowboyData_" .. slot0.mainActivityID_))
		slot3 = table.indexof(ActivityCfg[slot0.mainActivityID_].sub_activity_list, slot0.activityID_)
		slot0.cows_ = slot0.cowboyData_.LevelInfos[slot3].cows
		slot0.totalTime_ = slot0.cowboyData_.LevelInfos[slot3].timeLimit
	end,
	DrawCowboy = function (slot0)
		slot1 = Object.Instantiate(slot0["cowboy_" .. slot0.cowboyData_.cowboyId], slot0.container_.transform)
		slot1.transform.localPosition = Vector2(slot0.cowboyData_.cowboyPosX, -slot0.cowboyData_.cowboyPosY)
		slot0.cowboyGo_ = slot1
		slot5 = "Animator"
		slot0.aniController_ = slot0.cowboyGo_:GetComponent(slot5)

		for slot5 = 0, slot0.aniController_.runtimeAnimatorController.animationClips.Length - 1 do
			if slot0.aniController_.runtimeAnimatorController.animationClips[slot5].name == "attack" then
				slot0.attackTime_ = slot6.length

				break
			end
		end

		slot2 = slot1:GetComponent("SpriteRenderer").sprite.texture
		slot3 = slot1:GetComponent("SpriteRenderer").size
		slot4 = slot3.x / slot2.width
		slot5 = slot3.y / slot2.height
		slot0.hitLeft_ = slot3.x / 2 - slot0.cowboyData_.hitLeft * slot4
		slot0.hitRight_ = slot3.x / 2 - slot0.cowboyData_.hitRight * slot4

		SetActive(slot0.cowboyGo_, true)
	end,
	Start = function (slot0)
		slot0.curTime_ = slot0.totalTime_
		slot0.score_ = 0
		slot0.isEnd_ = false
		slot0.isPausing_ = false
		slot0.cowboyState_ = "run"
		slot0.cowIndex_ = 1
		slot0.show_ = {}
		slot0.unshow_ = {}

		manager.audio:Pause("music", false)
		manager.audio:Pause("effect", false)

		slot0.oriFrame_ = GameLocalData:GetCommonModule("userSetting").frame or PictureQualitySettingCfg[5].frame

		if slot0.oriFrame_ == 0 then
			SettingAction.ChangePicSetting("frame", 1)
		end

		if not slot0.frameTimer_ then
			slot0.frameTimer_ = FrameTimer.New(handler(slot0, slot0.Update), 1, -1)
		end

		manager.audio:PlayBGM("bgm_activity_1_3_1_minigame_main", "bgm_activity_1_3_1_minigame_main", "bgm_activity_1_3_1_minigame_main.awb")
		slot0.frameTimer_:Start()
	end,
	Update = function (slot0)
		if slot0.isPausing_ then
			return
		end

		slot0.UpdateSelf(slot0)

		if slot0.isEnd_ then
			slot0.EndGame(slot0)

			return
		end

		slot0.PlayCowRun(slot0)
		slot0.CheckReCow(slot0)
		slot0.CheckNewCow(slot0)
		slot0.CheckGet(slot0)

		slot0.curTime_ = slot0.curTime_ - Time.deltaTime

		if slot0.curTime_ < 0 then
			slot0.isEnd_ = true
		end
	end,
	EndGame = function (slot0)
		slot1 = manager.audio

		slot1:Pause("music", true)
		slot0:Pause()

		if ActivityTools.ActivityOpenCheckByMessageBox(slot0.mainActivityID_, function ()
			JumpTools.OpenPageByJump("/cowboy", {
				activityId = uv0.mainActivityID_
			})
		end) then
			slot2 = CowboyAction

			slot2:SendActivityInfo(slot0.mainActivityID_, slot0.activityID_, slot0.score_, function ()
				JumpTools.OpenPageByJump("cowboyGameOver", {
					mainActivityID = uv0.mainActivityID_,
					activityID = uv0.activityID_,
					score = uv0.score_
				})
			end)
		end
	end,
	UpdateSelf = function (slot0)
		slot1 = slot0.curTime_ > 0 and slot0.curTime_ or 0

		if slot0.onTimeChange_ then
			slot0.onTimeChange_(tostring(math.ceil(slot1)))
		end

		if slot0.onScoreChange_ then
			slot0.onScoreChange_(slot0.score_)
		end
	end,
	PlayCowRun = function (slot0)
		if slot0.aniController_:GetCurrentAnimatorStateInfo(0):IsName("run") then
			slot2 = slot0.aniController_:GetCurrentAnimatorClipInfo(0)[0].clip.length
			slot4 = math.round(slot2 / (1 / slot0.aniController_:GetCurrentAnimatorClipInfo(0)[0].clip.frameRate))

			if math.ceil(slot0.aniController_:GetCurrentAnimatorStateInfo(0).normalizedTime / slot2 * slot4 % slot4) <= 1 then
				if not slot0.isPlayCowRun_ then
					manager.audio:PlayEffect("minigame_activity_1_3", "minigame_run", "")

					slot0.isPlayCowRun_ = true
				end
			else
				slot0.isPlayCowRun_ = false
			end
		end
	end,
	CheckGet = function (slot0)
		slot1 = slot0.attackTrans_
		slot2 = nil
		slot3 = -1
		slot4 = nil

		for slot8, slot9 in ipairs(slot0.show_) do
			slot4 = slot9.GetHitRect(slot9)

			if not slot9.GetIsHitOrTaunt(slot9) then
				slot10 = slot0.cowboyGo_.transform.localPosition.x
				slot11 = slot9.gameObject_.transform.localPosition.x

				if slot0.cowboyState_ == "attack" and (slot11 <= slot10 and slot10 - slot11 < slot0.hitLeft_ + slot4.hitRight or slot10 < slot11 and slot11 - slot10 < slot0.hitRight_ + slot4.hitLeft) then
					slot3 = math.max(slot9.GetData(slot9).index, slot3)
				end

				if slot10 < slot11 and slot11 - slot10 > slot0.hitRight_ + slot4.hitLeft and not slot9.GetIsPass(slot9) then
					slot9.SetIsPass(slot9)
					slot9.SetState(slot9, "runAway")
				end
			end
		end

		if slot3 >= 0 and not slot0.isHitted_ then
			for slot8, slot9 in ipairs(slot0.show_) do
				if slot3 == slot9.GetData(slot9).index then
					slot0.isHitted_ = true

					slot9.SetState(slot9, "fall")
					slot9.SetIsHitOrTaunt(slot9)

					slot0.score_ = slot0.score_ + ActivityCowboyPointCfg[slot2.cowId + 1].point

					if ActivityCowboyPointCfg[slot2.cowId + 1].point > 0 then
						manager.audio:PlayEffect("minigame_activity_1_3", "minigame_extra_points", "")
					else
						manager.audio:PlayEffect("minigame_activity_1_3", "minigame_minus_points", "")
					end
				end
			end
		end
	end,
	CheckReCow = function (slot0)
		slot1, slot2, slot3, slot4, slot5 = nil

		for slot9 = #slot0.show_, 1, -1 do
			slot10 = slot0.show_[slot9]

			if slot10.transform_.localPosition.x > uv0 / 2 + slot10:GetWidth() then
				slot10:SetStop(true)
				SetActive(slot10.gameObject_, false)
				table.remove(slot0.show_, slot9)

				if not slot0.unshow_[slot10:GetData().cowId] then
					slot0.unshow_[slot4] = {}

					table.insert(slot0.cowIDList_, slot4)
				end

				if #slot0.unshow_[slot4] > 5 then
					slot10:OnExit()
				else
					table.insert(slot0.unshow_[slot4], slot10)
				end
			end
		end
	end,
	CheckNewCow = function (slot0)
		while slot0.cowIndex_ <= #slot0.cows_ and slot0.cows_[slot0.cowIndex_].showTime <= slot0.totalTime_ - slot0.curTime_ do
			if slot0.unshow_[slot0.cows_[slot0.cowIndex_].cowId] and #slot0.unshow_[slot1.cowId] > 0 then
				table.remove(slot0.unshow_[slot1.cowId], 1)

				slot3 = slot0.unshow_[slot1.cowId][1].gameObject_
				slot4 = slot3:GetComponent("SpriteRenderer")
				slot4.sortingOrder = slot1.index
				slot10 = slot0.cowboyData_.deltaY
				slot3.transform.localPosition = Vector2(-uv0 / 2 - slot4.size.x / 2, slot10)

				for slot10, slot11 in ipairs(ActivityCowboySpeedCfg[slot0.activityID_].speed) do
					if slot1.cowId + 1 == slot11[1] then
						speed = slot11[2]

						break
					end
				end

				slot2:SetData(slot1, speed, slot0.cowboyData_.fallSpeed)
				slot2:SetState("run")
				slot2:SetStop(false)
				table.insert(slot0.show_, slot2)
				SetActive(slot3, true)
			else
				slot2 = Object.Instantiate(slot0["cow_" .. slot1.cowId], slot0.container_.transform)
				slot3 = slot2:GetComponent("SpriteRenderer")
				slot2.transform.localPosition = Vector2(-uv0 / 2 - slot3.size.x / 2, slot0.cowboyData_.deltaY)
				slot3.sortingOrder = slot1.index
				slot5 = nil
				slot6 = QuarryItem.New(slot2)

				for slot11, slot12 in ipairs(ActivityCowboySpeedCfg[slot0.activityID_].speed) do
					if slot1.cowId + 1 == slot12[1] then
						slot5 = slot12[2]

						break
					end
				end

				slot6:SetData(slot1, slot5, slot0.cowboyData_.fallSpeed)
				slot6:SetState("run")
				slot6:SetStop(false)
				table.insert(slot0.show_, slot6)
				SetActive(slot2, true)
			end

			slot0.cowIndex_ = slot0.cowIndex_ + 1
		end
	end,
	Attack = function (slot0)
		if slot0.aniController_ ~= nil and not slot0.aniController_:GetCurrentAnimatorStateInfo(0):IsName("attack") then
			slot0.aniController_:Play("attack")
			manager.audio:PlayEffect("minigame_activity_1_3", "minigame_attack", "")

			slot0.cowboyState_ = "attack"
			slot0.isHitted_ = false

			if slot0.attackTimer_ then
				slot0.attackTimer_:Stop()

				slot0.attackTimer_ = nil
			end

			slot1 = 0
			slot0.attackTimer_ = FrameTimer.New(function ()
				if uv0 > 0 then
					slot1 = uv1.attackTime_ / uv1.aniController_:GetCurrentAnimatorStateInfo(0).speed

					TimeTools.StartAfterSeconds(slot1, function ()
						uv0.cowboyState_ = "run"
					end, {})
					uv1.onAttack_(slot1)
				end

				uv0 = uv0 + 1
			end, 1, 2)

			slot0.attackTimer_:Start()
		end
	end,
	Pause = function (slot0)
		slot0.isPausing_ = true

		if slot0.bgAni_ == nil or slot0.aniController_ == nil then
			return
		else
			slot0.bgAni_.enabled = false
			slot0.aniController_.enabled = false
		end

		for slot4, slot5 in ipairs(slot0.show_) do
			slot5.Pause(slot5)
		end
	end,
	Continue = function (slot0)
		slot0.isPausing_ = false

		if slot0.bgAni_ == nil or slot0.aniController_ == nil then
			return
		else
			slot0.bgAni_.enabled = true
			slot0.aniController_.enabled = true
		end

		for slot4, slot5 in ipairs(slot0.show_) do
			slot5.Continue(slot5)
		end
	end,
	Restart = function (slot0)
		for slot4, slot5 in ipairs(slot0.show_) do
			slot5.OnExit(slot5)
		end

		for slot4, slot5 in ipairs(slot0.cowIDList_) do
			if slot0.unshow_[slot5] then
				for slot9, slot10 in ipairs(slot0.unshow_[slot5]) do
					slot10.OnExit(slot10)
				end
			end
		end

		slot0.bgAni_.enabled = true
		slot0.aniController_.enabled = true

		slot0.Start(slot0)
	end,
	GameOver = function (slot0)
		Object.Destroy(slot0.cowboyGo_)

		if slot0.oriFrame_ == 0 then
			SettingAction.ChangePicSetting("frame", 0)
		end

		slot1 = ipairs
		slot3 = slot0.show_ or {}

		for slot4, slot5 in slot1(slot3) do
			slot5.OnExit(slot5)
		end

		slot1 = ipairs
		slot3 = slot0.cowIDList_ or {}

		for slot4, slot5 in slot1(slot3) do
			if slot0.unshow_[slot5] then
				for slot9, slot10 in ipairs(slot0.unshow_[slot5]) do
					slot10.OnExit(slot10)
				end
			end
		end

		if slot0.frameTimer_ then
			slot0.frameTimer_:Stop()

			slot0.frameTimer_ = nil
		end

		if slot0.attackTimer_ then
			slot0.attackTimer_:Stop()

			slot0.attackTimer_ = nil
		end
	end,
	Hide = function (slot0)
		uv0 = 1 - uv0

		SetActive(slot0.furnitureGo_, uv0 == 1)
	end,
	UnLoadCowboyLevel = function (slot0)
		if slot0.operation_ then
			return
		end

		if SceneManager.GetSceneByName("X105") and slot1.isLoaded == true then
			SceneManager.UnloadSceneAsync("X105")
		end

		Object.Destroy(slot0.raycaster_)
	end
}
