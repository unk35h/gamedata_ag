slot0 = class("CowboyGameView", ReduxView)
slot1 = require("cjson")

function slot0.UIName(slot0)
	return CowboyTools.GetGameUIName(slot0.params_.mainActivityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.onSenceLoadedHandler_ = handler(slot0, slot0.OnCowboySenceLoaded)
	slot0.onTimeChangeHandler_ = handler(slot0, slot0.OnTimeChange)
	slot0.onScoreChangeHandler_ = handler(slot0, slot0.OnScoreChange)
	slot0.onAttackHandler_ = handler(slot0, slot0.OnAttack)
	slot0.OnGameFocusChange_ = handler(slot0, slot0.OnGameFocusChange1)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.catchBtn_, nil, function ()
		CowboyTools:Attack()
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		if uv0.isPause_ then
			return
		end

		manager.audio:Pause("music", true)
		manager.audio:Pause("effect", true)
		uv0:OnCowboyPause()
		JumpTools.OpenPageByJump("cowboyGameBack", {
			mainActivityID = uv0.mainActivityID_
		})
	end)
	slot0:AddBtnListener(slot0.stopBtn_, nil, function ()
		if uv0.isPause_ then
			return
		end

		manager.audio:Pause("music", true)
		manager.audio:Pause("effect", true)
		uv0:OnCowboyPause()
		JumpTools.OpenPageByJump("cowboyGamePause", {
			mainActivityID = uv0.mainActivityID_
		})
	end)
	slot0:AddBtnListener(slot0.hideBtn_, nil, function ()
		CowboyTools:Hide()
	end)
end

function slot0.OnEnter(slot0)
	slot0.mainActivityID_ = slot0.params_.mainActivityID
	slot0.activityID_ = slot0.params_.activityID
	slot0.isPause_ = false

	SetActive(slot0.cdImg_, false)

	slot0.attackMask_.fillAmount = 0

	slot0:RegisterEvents()
	slot0:InitializeCowboy()
end

function slot0.InitializeCowboy(slot0)
	manager.ui:SetMainCamera("cowboy")

	manager.ui.mainCameraCom_.orthographic = true

	CowboyTools:LoadCowboyLevel(slot0.onSenceLoadedHandler_, slot0.onTimeChangeHandler_, slot0.onScoreChangeHandler_, slot0.onAttackHandler_)
end

function slot0.OnCowboySenceLoaded(slot0)
	CowboyTools:InitCowboySence(slot0.mainActivityID_, slot0.activityID_)
end

function slot0.OnTimeChange(slot0, slot1)
	slot0.time_.text = slot1
end

function slot0.OnScoreChange(slot0, slot1)
	slot0.scoreText_.text = slot1
end

function slot0.OnAttack(slot0, slot1)
	slot0:StopTimer()
	SetActive(slot0.cdImg_, true)

	slot2 = 0
	slot0.timer_ = Timer.New(function ()
		if uv1 < uv0 then
			uv2:StopTimer()
			SetActive(uv2.cdImg_, false)
		end

		uv2.attackMask_.fillAmount = 1 - uv0 / uv1

		if not uv2.isPause_ then
			uv0 = uv0 + 0.01
		end
	end, 0.01, -1)

	slot0.timer_:Start()
end

function slot0.OnGameFocusChange1(slot0, slot1, slot2)
	if slot2 or not slot1 then
		manager.audio:Pause("music", true)
		manager.audio:Pause("effect", true)
		CowboyTools:Pause()
	elseif slot0.isPause_ == false then
		manager.audio:Pause("music", false)
		manager.audio:Pause("effect", false)
		CowboyTools:Continue()
	end
end

function slot0.OnCowboyPause(slot0)
	slot0.isPause_ = true

	CowboyTools:Pause()
end

function slot0.OnCowboyContinue(slot0)
	slot0.isPause_ = false

	SetActive(slot0.cdImg_, false)
	CowboyTools:Continue()
end

function slot0.OnCowboyRestart(slot0)
	slot0:StopTimer()

	slot0.isPause_ = false

	SetActive(slot0.cdImg_, false)
	CowboyTools:Restart()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.attackMask_.fillAmount = 0
end

function slot0.RegisterEvents(slot0)
	manager.notify:RegistListener(GAME_FOCUS_CHANGE, slot0.OnGameFocusChange_)
end

function slot0.RemoveEvents(slot0)
	manager.notify:RemoveListener(GAME_FOCUS_CHANGE, slot0.OnGameFocusChange_)
end

function slot0.OnExit(slot0)
	slot0:RemoveEvents()
	slot0:StopTimer()
	CowboyTools:GameOver()
	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	CowboyTools:UnLoadCowboyLevel()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
