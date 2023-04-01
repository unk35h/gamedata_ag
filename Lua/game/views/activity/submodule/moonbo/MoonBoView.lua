slot0 = class("MoonBoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/VolumeBocakeMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
	slot0:AddEventListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.isShowDiceController_ = ControllerUtil.GetController(slot0.transform_, "IsShowDice")
	slot0.isShowDice_ = false
	slot0.IsAniSelfPlay_ = false
	slot0.todices_ = {}
	slot0.activedice1_ = nil
	slot0.activedice2_ = nil
	slot0.activedice3_ = nil
	slot0.activedice4_ = nil
	slot0.activedice5_ = nil
	slot0.activedice6_ = nil
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if uv0.isShowDice_ == false then
			JumpTools.OpenPageByJump("moonBoRewardView", {
				activityId = uv0.activityID_
			})
		end
	end)
	slot0:AddBtnListener(slot0.ruleBtn_, nil, function ()
		if uv0.isShowDice_ == false then
			JumpTools.OpenPageByJump("moonBoIntroduceView", {
				activityId = uv0.activityID_
			})
		end
	end)
	slot0:AddBtnListener(slot0.moonBoBtn_, nil, function ()
		if uv0.isShowDice_ == false then
			uv0.isShowDice_ = true

			if ActivityData:GetActivityIsOpen(ActivityConst.MOONBO) then
				if MoonBoData:GetCanGetCount() <= 0 then
					uv0.isShowDice_ = false

					ShowTips(GetTips("ACTIVITY_MOONCAKE_GAMBLING_NUM_ZERO"))
				else
					MoonBoAction:GetMoonBo()
				end
			else
				uv0.isShowDice_ = false

				ShowTips(GetTips("TIME_OVER"))
			end
		end
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(MOONBO_SUCCESS, function ()
		slot0 = manager.windowBar

		slot0:HideBar()
		AnimatorTools.PlayAnimationWithCallback(uv0.selfAni_, "VolumeBocakeMainUI_close", function ()
			slot0 = uv0.isShowDiceController_

			slot0:SetSelectedState("true")
			SetActive(uv0.diceGo_, true)

			slot1 = MoonBoData
			uv0.todices_ = slot1:GetCurDices()

			SetActive(uv0.activedice1_, false)
			SetActive(uv0.activedice2_, false)
			SetActive(uv0.activedice3_, false)
			SetActive(uv0.activedice4_, false)
			SetActive(uv0.activedice5_, false)
			SetActive(uv0.activedice6_, false)

			slot1 = uv0
			uv0.activedice1_ = slot1:DiceToRight(uv0.dice1_, 1)
			slot1 = uv0
			uv0.activedice2_ = slot1:DiceToRight(uv0.dice2_, 2)
			slot1 = uv0
			uv0.activedice3_ = slot1:DiceToRight(uv0.dice3_, 3)
			slot1 = uv0
			uv0.activedice4_ = slot1:DiceToRight(uv0.dice4_, 4)
			slot1 = uv0
			uv0.activedice5_ = slot1:DiceToRight(uv0.dice5_, 5)
			slot1 = uv0
			uv0.activedice6_ = slot1:DiceToRight(uv0.dice6_, 6)

			SetActive(uv0.activedice1_, true)
			SetActive(uv0.activedice2_, true)
			SetActive(uv0.activedice3_, true)
			SetActive(uv0.activedice4_, true)
			SetActive(uv0.activedice5_, true)
			SetActive(uv0.activedice6_, true)

			slot0 = manager.audio

			slot0:PlayEffect("minigame_activity_1_3", "minigame_diceroll", "")
			AnimatorTools.PlayAnimationWithCallback(uv0.diceAni_, "VolumeBocakeMainUI_roll", function ()
				manager.windowBar:SwitchBar({
					BACK_BAR,
					HOME_BAR,
					INFO_BAR
				})

				uv0.isShowDice_ = false

				uv0.isShowDiceController_:SetSelectedState("false")
				AnimatorTools.Stop()
				JumpTools.OpenPageByJump("moonBoResultView", {
					activityId = uv0.activityID_
				})
			end)
		end)
	end)
end

function slot0.OnEnter(slot0)
	slot0.isEnter_ = true
	slot0.stopTime_ = ActivityData:GetActivityData(ActivityConst.MOONBO).stopTime

	if manager.time:GetServerTime() < slot0.stopTime_ then
		slot0.timeText_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	else
		slot0.timeText_.text = GetTips("TIME_OVER")
	end

	slot0.timer_ = Timer.New(function ()
		MoonBoData:FreshTime()

		if manager.time:GetServerTime() < uv0.stopTime_ then
			uv0.timeText_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
		else
			uv0:StopTimer()

			uv0.timeText_.text = GetTips("TIME_OVER")

			return
		end
	end, 1, -1)

	slot0.timer_:Start()

	slot0.canGetCountText_.text = MoonBoData:GetCanGetCount()
	slot0.onNewDayhandler_ = handler(slot0, slot0.OnNewDay)

	manager.notify:RegistListener(ACTIVITY_MOONBO_NEWDAY, slot0.onNewDayhandler_)
	manager.redPoint:bindUIandKey(slot0.moonBoTrs_, string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.MOONBO))
	slot0.selfAni_:Play("VolumeBocakeMainUI")

	slot0.diceAniGo_ = Object.Instantiate(Asset.Load("UI/VolumeIIIUI/VolumeBocake_shaizi"))
	slot0.diceAniGo_.transform.position = Vector3(0, 0, 10)

	manager.ui:SetMainCamera("moonBo")

	manager.ui.mainCameraCom_.orthographic = true

	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.diceAniGo_)
	slot0.diceAni_:Play("VolumeBocakeMainUI_none")
	SetActive(slot0.diceGo_, false)
	UnityEngine.Physics2D.SyncTransforms()
end

function slot0.DiceToRight(slot0, slot1, slot2)
	slot4 = nil

	if slot0.todices_[slot2] == 1 then
		slot4 = slot1.transform:Find("1").gameObject
	elseif slot3 == 2 then
		slot4 = slot1.transform:Find("2").gameObject
	elseif slot3 == 3 then
		slot4 = slot1.transform:Find("3").gameObject
	elseif slot3 == 4 then
		slot4 = slot1.transform:Find("4").gameObject
	elseif slot3 == 5 then
		slot4 = slot1.transform:Find("5").gameObject
	elseif slot3 == 6 then
		slot4 = slot1.transform:Find("6").gameObject
	end

	return slot4
end

function slot0.OnNewDay(slot0)
	if ActivityData:GetActivityIsOpen(ActivityConst.MOONBO) then
		slot0.canGetCountText_.text = MoonBoData:GetCanGetCount()
	else
		slot0.canGetCountText_.text = 0
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MOONCAKE_GAMBLING_DESCRIPE")

	if MoonBoData:GetIsShowReward() == true then
		MoonBoData:SetIsShowReward(false)
		getReward(MoonBoData:GetCurReward())
	end

	slot0.canGetCountText_.text = MoonBoData:GetCanGetCount()

	if slot0.isEnter_ == false then
		slot0.selfAni_:Play("VolumeBocakeMainUI", 0, 1)
	end

	slot0.diceAni_:Play("VolumeBocakeMainUI_none")
	SetActive(slot0.diceGo_, false)

	slot0.isEnter_ = false
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	AnimatorTools.Stop()
	slot0:StopTimer()
	manager.notify:RemoveListener(ACTIVITY_MOONBO_NEWDAY, slot0.onNewDayhandler_)
	manager.redPoint:unbindUIandKey(slot0.moonBoTrs_, string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.MOONBO))

	manager.ui.mainCameraCom_.orthographic = false

	manager.ui:ResetMainCamera()

	if slot0.diceAniGo_ then
		Object.Destroy(slot0.diceAniGo_)

		slot0.diceAniGo_ = nil
	end
end

function slot0.Dispose(slot0)
	slot0:StopTimer()
	slot0:RemoveAllEventListener()
	slot0.super.Dispose(slot0)
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
