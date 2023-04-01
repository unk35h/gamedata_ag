slot0 = class("ShowTransitionMgr", import("game.extend.BaseView"))
slot1 = "SHOW_START"
slot2 = "SHOW_OVER"
slot3 = "HIDE_START"
slot4 = "HIDE_OVER"

function slot0.Ctor(slot0)
	slot0:OnCtor()

	slot0.transitionState_ = uv0
end

function slot0.OnCtor(slot0)
	if not slot0.gameObject_ then
		slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Common/switch"), manager.ui.uiMessage.transform)

		SetActive(slot0.gameObject_, false)

		slot0.image_ = slot0.gameObject_.transform:GetComponentInChildren(typeof(Image))
		slot0.color_ = slot0.image_.color
		slot0.color_.a = 0
		slot0.image_.color = slot0.color_
		slot0.animator_ = slot0.gameObject_:GetComponent("Animator")
	end

	gameContext:SetActions(handler(slot0, slot0.Show), handler(slot0, slot0.Hide))
end

function slot0.RegistCanEndFunc(slot0, slot1)
	slot0.canEndFunc_ = slot1
end

function slot0.Show(slot0, slot1, slot2)
	slot0.transitionState_ = uv0
	slot3 = nil

	if gameContext ~= nil and (not ViewConst.PLAY_TRANSITION_URL_LIST[gameContext:GetLastOpenPage()] or not slot2) then
		slot0:ClearTimer()
		manager.ui:UIEventEnabled(true)

		slot0.transitionState_ = uv1

		if slot1 then
			slot1()
		end

		return
	end

	SetActive(slot0.gameObject_, true)
	slot0.animator_:Play("enter")
	slot0:ClearTimer()
	manager.ui:UIEventEnabled(false)

	if slot3 then
		manager.loadScene:SetShouldLoadSceneName(slot3)
	end

	slot0.waitNextFrameToCallback = false
	slot0.timer_ = FrameTimer.New(function ()
		slot0 = true

		if uv0.canEndFunc_ then
			slot0 = uv0.canEndFunc_() and manager.loadScene:CanEnd()
		end

		if not uv0.animator_:GetCurrentAnimatorStateInfo(0):IsName("enter") then
			uv0.animator_:Play("enter")
		end

		if slot1.normalizedTime > 1 and slot1:IsName("enter") and slot0 then
			if not uv0.waitNextFrameToCallback then
				uv0.waitNextFrameToCallback = true
			else
				manager.ui:UIEventEnabled(true)

				uv0.transitionState_ = uv1

				LoadingUIManager.inst:CloseLoadUI()
				uv0:ClearTimer()

				if uv2 then
					uv2()
				end

				uv0.waitNextFrameToCallback = false
			end
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.Hide(slot0, slot1, slot2)
	slot0.transitionState_ = uv0

	if gameContext ~= nil and (not ViewConst.PLAY_TRANSITION_URL_LIST[gameContext:GetLastOpenPage()] or not slot2) then
		SetActive(slot0.gameObject_, false)

		slot0.transitionState_ = uv1

		if slot1 then
			slot1()
		end

		return
	end

	slot0.animator_:Play("out")
	slot0:ClearTimer()
	manager.ui:UIEventEnabled(false)

	slot0.timer_ = FrameTimer.New(function ()
		if not uv0.animator_:GetCurrentAnimatorStateInfo(0):IsName("out") then
			uv0.animator_:Play("out")
		end

		if slot0.normalizedTime > 1 and slot0:IsName("out") then
			manager.ui:UIEventEnabled(true)

			uv0.transitionState_ = uv1

			uv0:ClearTimer()

			if uv2 then
				uv2()
			end
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.IsTransitionOver(slot0)
	return slot0.transitionState_ == uv0
end

function slot0.Dispose(slot0)
	gameContext:SetActions(nil, )

	if slot0.gameObject_ ~= nil then
		Object.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
	end

	slot0:ClearTimer()

	slot0.image_ = nil
	slot0.canEndFunc_ = nil
	slot0.animator_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.ClearTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
