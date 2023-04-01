slot0 = require("cjson")
slot1 = class("FishingGameView", ReduxView)

function slot1.UIName(slot0)
	return "UI/Fishing/Game/FishingGameUI"
end

function slot1.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot1.OnCtor(slot0)
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.bubbleNumController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "bubbleNum")
	slot0.buffController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "buff")
	slot0.pauseController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "pause")
	slot0.hook_ = FishHook.New(slot0.hookGo_)
	slot0.roleSpine_ = slot0.roleGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	slot0.waterSpine_ = slot0.seaWeaterGo_:GetComponent("Spine.Unity.SkeletonGraphic")

	slot0:PlayRoleAnimation("idle", true)
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.hookBtn_, nil, function ()
		if uv0.hook_ then
			uv0.hook_:StartHooking()
		end
	end)

	slot1 = FishGameManager.GetInstance()

	slot1:SetPauseHandler(handler(slot0, slot0.OnPause))

	slot1 = FishGameManager.GetInstance()

	slot1:SetContinueHandler(handler(slot0, slot0.OnContinue))

	slot1 = FishGameManager.GetInstance()

	slot1:SetScoreChangeHandler(handler(slot0, slot0.OnScoreChange))

	slot1 = FishGameManager.GetInstance()

	slot1:SetScoreAddHandler(handler(slot0, slot0.OnScoreAdd))

	slot1 = FishGameManager.GetInstance()

	slot1:AddBuffHandler(handler(slot0, slot0.OnBuffChange))
	slot0:AddBtnListener(slot0.pauseBtn_, nil, function ()
		FishGameManager.GetInstance():Pause()
	end)
	slot0:AddBtnListener(slot0.continueBtn_, nil, function ()
		FishGameManager.GetInstance():Continue()
	end)
	slot0:AddBtnListener(slot0.exitBtn_, nil, function ()
		uv0.pauseController_:SetSelectedState("false")
		manager.audio:PlayEffect("minigame_fishing", "fishing_stopall", "")
		uv0:Back()
	end)

	slot0.onAnimationCompleteHandler_ = handler(slot0, slot0.OnAnimationComplete)
	slot0.roleSpine_.AnimationState.Complete = slot0.roleSpine_.AnimationState.Complete + slot0.onAnimationCompleteHandler_
end

function slot1.OnAnimationComplete(slot0, slot1)
	if slot1.Animation.Name == "PushButton" then
		slot0:PlayRoleAnimation("look", true)
	end
end

function slot1.PlayRoleAnimation(slot0, slot1, slot2)
	if slot0.curName_ ~= nil and slot0.curName_ == slot1 then
		return
	end

	slot0.curName_ = slot1

	slot0.roleSpine_.AnimationState:SetAnimation(0, slot1, slot2)
end

function slot1.AddEventListeners(slot0)
end

function slot1.OnPause(slot0)
	slot0.pauseController_:SetSelectedState("true")

	slot0.roleSpine_.AnimationState.TimeScale = 0
	slot0.waterSpine_.AnimationState.TimeScale = 0
end

function slot1.OnContinue(slot0)
	slot0.pauseController_:SetSelectedState("false")

	slot0.roleSpine_.AnimationState.TimeScale = 1
	slot0.waterSpine_.AnimationState.TimeScale = 1
end

function slot1.OnScoreChange(slot0)
	slot1 = tonumber(slot0.scoreLabel_.text)
	slot2 = FishGameManager.GetInstance():GetScore()
	slot0.tween_ = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		slot1 = uv0 or 0
		slot3 = math.floor(slot1 + (uv1 - slot1) * slot0)
		uv2.scoreLabel_.text = tostring(slot3)
		uv2.scoreLabelAnimation_.text = tostring(slot3)
	end)):setOnComplete(LuaHelper.VoidAction(function ()
		if uv0.tween_ then
			uv0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			uv0.tween_ = nil
		end

		uv0.scoreLabel_.text = tostring(FishGameManager.GetInstance():GetScore())
		uv0.scoreLabelAnimation_.text = tostring(FishGameManager.GetInstance():GetScore())

		uv0.scoreAnimator_:Play("fishing_scoring", -1, 0)
	end)):setEase(LeanTweenType.easeOutQuad)

	slot0.bubbleNumController_:SetSelectedIndex(FishGameManager.GetInstance():GetTreasureLimitNum())
end

function slot1.OnScoreAdd(slot0, slot1)
	SetActive(slot0.scoreGo_, true)
	slot0.goalAnimator_:Play("FishGoal", -1, 0)

	slot0.scoreAddLabel_.text = slot1

	manager.audio:PlayEffect("minigame_fishing", "fishing_gain", "")
end

function slot1.OnBuffChange(slot0, slot1, slot2, slot3)
	if slot2 == 1 then
		slot0.curBuff_ = slot1
		slot0.curBuffMilliseconds_ = 20

		SetActive(slot0.buffGo_, true)

		slot0.buffNameLabel_.text = GetTips("ACTIVITY_FISHING_BUFF_NAME_" .. slot1)
		slot0.buffDescLabel_.text = GetTips("ACTIVITY_FISHING_BUFF_DESC_" .. slot1)
		slot0.buffProgress_.fillAmount = 1

		slot0.buffController_:SetSelectedState(tostring(slot1))

		if slot1 == 1 then
			slot0.doubleAnimator_:Play("ef_ui_buff_double", -1, 0)
		elseif slot1 == 3 then
			slot0.timeAnimator_:Play("ef_ui_buff_double", -1, 0)
		end
	elseif slot2 == 0 then
		slot0.buffController_:SetSelectedState("0")

		slot0.curBuff_ = 0
		slot0.curBuffMilliseconds_ = 0
		slot0.buffProgress_.fillAmount = 0

		SetActive(slot0.buffGo_, false)
	elseif slot2 == 2 then
		if slot0.curBuffMilliseconds_ > 0 then
			slot0.curBuffMilliseconds_ = slot0.curBuffMilliseconds_ - Time.deltaTime
		end

		if slot0.curBuffMilliseconds_ < 0 then
			slot0.curBuffMilliseconds_ = 0
		end

		slot0.buffProgress_.fillAmount = slot0.curBuffMilliseconds_ / 20
	end
end

function slot1.OnTop(slot0)
	slot0:UpdateBar()
end

function slot1.UpdateBar(slot0)
end

function slot1.RegisterEvents(slot0)
end

function slot1.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.fishData_ = uv0.decode(AssetEx.LoadText("Fishing/fishData.json"))

	FishGameManager.GetInstance():Init(slot0, slot0.container_)
	FishGameManager.GetInstance():SetHook(slot0.hook_)

	for slot7, slot8 in ipairs(slot0.fishData_.LevelInfos[math.random(1, slot0.fishData_.levelNum)].fishes) do
		slot10 = Object.Instantiate(Asset.Load("UI/Fishing/Game/Fishes/" .. slot8.fishId), slot0.container_)
		slot10.transform.localPosition = Vector2(slot8.posX + slot10.transform.rect.width / 2, -slot8.posY - slot10.transform.rect.height / 2)
		slot10.transform.localScale = Vector3.New(slot8.scaleX / 1000, slot8.scaleY / 1000, 0)
		slot11 = FishItem.New(slot10)

		slot11:SetData(slot8)
		FishGameManager.GetInstance():AddFish(slot11)
	end

	slot0:RegisterEvents()
	SetActive(slot0.buffGo_, false)

	slot0.scoreLabel_.text = "0"
	slot0.scoreLabelAnimation_.text = "0"

	FishGameManager.GetInstance():Start()
	manager.audio:PlayBGM("bgm_activity_1_2_summer1_minigame_fishing", "bgm_activity_1_2_summer1_minigame_fishing", "bgm_activity_1_2_summer1_minigame_fishing.awb")
	manager.audio:PlayEffect("minigame_fishing", "fishing_wave", "")
end

slot2 = "notPlayed"

function slot1.Update(slot0)
	if slot0.end_ then
		slot0.roleSpine_.AnimationState.TimeScale = 0
		slot0.waterSpine_.AnimationState.TimeScale = 0

		return
	end

	if FishGameManager.GetInstance():GetStatus() == "cast" then
		if uv0 == "notPlayed" then
			slot0:PlayRoleAnimation("PushButton", false)

			uv0 = "playing"
		end
	elseif slot1 == "catch" then
		uv0 = "notPlayed"

		slot0:PlayRoleAnimation("Happy", true)
	elseif slot1 == "fail" then
		uv0 = "notPlayed"

		slot0:PlayRoleAnimation("Sad", true)
	elseif slot1 == "idle" then
		uv0 = "notPlayed"

		slot0:PlayRoleAnimation("idle", true)
	end

	if FishGameManager.GetInstance():GetSeconds() < 0 then
		slot2 = 0
	end

	slot0.countdownLabel_.text = tostring(math.floor(slot2))

	if FishGameManager.GetInstance():GetIsEnd() then
		slot0.end_ = true

		if ActivityTools.ActivityOpenCheckByMessageBox(ActivityConst.SUMMER_FISHING, function ()
			JumpTools.OpenPageByJump("/fishingEnter", {
				activityId = ActivityConst.SUMMER_FISHING
			})
		end) then
			slot7 = FishGameManager.GetInstance()
			slot8 = FishGameManager.GetInstance()

			FishingAction.EndingFishing(ActivityConst.SUMMER_FISHING, slot7:GetScore(), slot8:GetTreasureNum(), function (slot0, slot1)
				slot2 = {}

				for slot6, slot7 in ipairs(slot1) do
					table.insert(slot2, {
						id = slot7.id,
						num = slot7.num,
						len = slot7.length
					})
				end

				slot7 = FishGameManager.GetInstance()

				JumpTools.OpenPageByJump("fishEnding", {
					score = slot7:GetScore(),
					gainScore = slot0,
					fishes = slot2,
					callback = function ()
						uv0:Back()
					end
				})
			end)
		end
	end

	slot0.bubbleNumController_:SetSelectedIndex(FishGameManager.GetInstance():GetTreasureLimitNum())
end

function slot1.GetBubbleTarget(slot0)
	if FishGameManager.GetInstance():GetTreasureLimitNum() == 1 then
		return slot0.iconTransform1_
	end

	return slot0.iconTransform2_
end

function slot1.AppearBubble(slot0, slot1)
	slot0[string.format("iconTransform%d_", slot1)]:GetComponent(typeof(CanvasGroup)).alpha = 1
end

function slot1.OnExit(slot0)
	slot0:RemoveAllEventListener()
	FishGameManager.GetInstance():Dispose()
	manager.windowBar:HideBar()
	manager.audio:StopEffect()
end

function slot1.OnMainHomeViewTop(slot0)
end

function slot1.Cacheable(slot0)
	return false
end

function slot1.Dispose(slot0)
	AnimatorTools.Stop()
	FishGameManager.GetInstance():Dispose()

	slot0.roleSpine_.AnimationState.Complete = slot0.roleSpine_.AnimationState.Complete - slot0.onAnimationCompleteHandler_

	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
