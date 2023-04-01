slot0 = class("FireWorkMakeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/Firework/FireworkMakeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_makeBtn, nil, function ()
		uv0:StartGame()
	end)

	slot1 = slot0.m_fishEvent

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0.stateController:GetSelectedState() == "1" then
			uv0:EndQte()
		end
	end))
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		if uv0.stateController:GetSelectedState() == "1" then
			return
		end

		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	if not slot0.params_.start then
		return
	end

	slot0.params_.start = false

	slot0:NewGame()

	if not getData("FireWork", "showHelp") then
		JumpTools.OpenPageByJump("gameHelpPro", {
			startIndex = 2,
			pages = GameSetting.activity_firework_describe and GameSetting.activity_firework_describe.value or {}
		})
		saveData("FireWork", "showHelp", 1)
	end
end

function slot0.OnUpdate(slot0)
	if not slot0.params_.start then
		return
	end

	slot0.params_.start = false

	slot0:NewGame()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	slot0:RemoveTween()
	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_stop", "")
end

function slot0.NewGame(slot0)
	slot0.activity_id = slot0.params_.fire_activity_id
	slot1 = ActivityFireWorkCfg[slot0.activity_id]
	slot0.m_name.text = slot1.name
	slot0.m_des.text = slot1.desc
	slot0.m_icon.sprite = getSpriteWithoutAtlas("Textures/EmptyDream/letter_role_title/" .. slot1.icon)
	slot0.m_arror.localRotation = Quaternion.Euler(0, 0, 0)
	slot0.m_circle.localRotation = Quaternion.Euler(0, 0, 0)
	slot0.m_countDownLab.text = ""
	slot0.m_countDownProgress.fillAmount = 0
	slot0.m_countLab.text = ""

	slot0.stateController:SetSelectedIndex(0)
	SetActive(slot0.m_baozu, false)
end

function slot0.StartGame(slot0)
	slot0.countDown = 3

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	slot0:RefreshCountDown()

	slot0.timer = Timer.New(function ()
		uv0.countDown = uv0.countDown - 1

		uv0:RefreshCountDown()

		if uv0.countDown <= 0 then
			uv0:StartQte()
		end
	end, 1, 3)

	slot0.timer:Start()
	slot0.stateController:SetSelectedIndex(4)

	slot0.tagret = slot0:RandomAngle()
	slot0.m_circle.localRotation = Quaternion.Euler(0, 0, slot0.tagret)

	slot0.m_circleAnimator:Play("circle", 0, 0)

	slot0.m_countLab.text = GetTips("ACTIVITY_FIRE_WORK_PHASE") .. "1/3"

	SetActive(slot0.m_baozu, true)

	slot0.m_countDownProgress.fillAmount = 1

	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_leader", "")
end

function slot0.RefreshCountDown(slot0)
	if slot0.countDown > 0 then
		slot0.m_countDownLab.text = slot0.countDown
	else
		slot0.m_countDownLab.text = ""
	end

	if slot0.countDown == 3 then
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_three", "")
	elseif slot0.countDown == 2 then
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_two", "")
	elseif slot0.countDown == 1 then
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_one", "")
	else
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_pointer", "")
	end
end

function slot0.StartQte(slot0)
	slot0:RemoveTween()

	slot0.max = 3
	slot0.count = 1
	slot0.m_countLab.text = GetTips("ACTIVITY_FIRE_WORK_PHASE") .. slot0.count .. "/" .. slot0.max

	slot0:DoTween(slot0.tagret)
	slot0.stateController:SetSelectedIndex(1)
	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_pointer", "")
end

function slot0.DoTween(slot0, slot1)
	slot0.tagret = slot1
	slot0.m_circle.localRotation = Quaternion.Euler(0, 0, slot0.tagret)
	slot0.m_countDownProgress.transform.localRotation = Quaternion.Euler(0, 0, slot0.m_arror.localEulerAngles.z)
	slot3 = LeanTween.rotateAroundLocal(slot0.m_arror.gameObject, Vector3.New(0, 0, -1), 360, 2)
	slot3 = slot3:setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.m_countDownProgress.fillAmount = (360 - slot0) / 360
	end))
	slot0.tween = slot3:setOnComplete(LuaHelper.VoidAction(function ()
		uv0:RemoveTween()
		uv0:GotoFail()
	end))
end

function slot0.EndQte(slot0)
	if (slot0.tagret + 360 - (slot0.m_arror.localEulerAngles.z + 360) % 360) % 360 <= 35 or slot2 >= 325 then
		if slot2 <= 15 or slot2 >= 345 then
			slot0.count = slot0.count + 1

			SDKTools.SendMessageToSDK("activity_firework_opt", {
				result = 2,
				activity_id = slot0.activity_id
			})

			slot0.m_effectTransform.localRotation = slot0.m_arror.localRotation

			slot0.m_animator:Play("arrow", 0, 0)
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_sign", "")
		else
			SDKTools.SendMessageToSDK("activity_firework_opt", {
				result = 1,
				activity_id = slot0.activity_id
			})
		end

		if slot0.max < slot0.count then
			slot0:RemoveTween()
			slot0:GotoWin()
		else
			slot0.m_countLab.text = GetTips("ACTIVITY_FIRE_WORK_PHASE") .. slot0.count .. "/" .. slot0.max

			slot0:RemoveTween()
			slot0:DoTween(slot0:RandomAngle())
			slot0.m_circleAnimator:Play("circle", 0, 0)
		end
	else
		SDKTools.SendMessageToSDK("activity_firework_opt", {
			result = 0,
			activity_id = slot0.activity_id
		})
		slot0:RemoveTween()
		slot0:GotoFail()
	end
end

function slot0.GotoFail(slot0)
	slot0.stateController:SetSelectedIndex(1)
	JumpTools.OpenPageByJump("fireWorkResult", {
		isWin = false,
		fire_activity_id = slot0.activity_id
	})
	SDKTools.SendMessageToSDK("activity_firework_over", {
		is_success = 0,
		activity_id = slot0.activity_id
	})
	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_stop", "")
end

function slot0.GotoWin(slot0)
	slot0.stateController:SetSelectedIndex(1)

	if FireWorkData:GetInvited(slot0.activity_id) then
		JumpTools.OpenPageByJump("fireWorkResult", {
			isWin = true,
			fire_activity_id = slot0.activity_id
		})
	else
		FireWorkAction.QueryInvite(slot0.activity_id)
	end

	SDKTools.SendMessageToSDK("activity_firework_over", {
		is_success = 1,
		activity_id = slot0.activity_id
	})
	manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_stop", "")
end

function slot0.RemoveTween(slot0)
	if slot0.tween then
		slot0.tween:setOnComplete(nil)
		LeanTween.cancel(slot0.m_arror.gameObject)

		slot0.tween = nil
	end
end

function slot0.RandomAngle(slot0)
	return -((-slot0.m_arror.localEulerAngles.z + 360) % 360 + math.random(120, 300)) % 360
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
