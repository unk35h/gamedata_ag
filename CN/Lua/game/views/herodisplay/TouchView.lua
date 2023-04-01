slot0 = class("TouchView")

function slot0.Ctor(slot0)
end

function slot0.AddTimer(slot0)
	slot1, slot2 = nil

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.timer_ = FrameTimer.New(function ()
		if UnityEngine.EventSystems.EventSystem.current.currentSelectedGameObject then
			return
		end

		if uv0.hideUIFlag_ == true then
			if Input.GetMouseButtonDown(0) then
				uv0.mousePosition_ = Input.mousePosition
			end

			if Input.GetMouseButtonUp(0) and uv0.mousePosition_ and Input.mousePosition.x == uv0.mousePosition_.x and Input.mousePosition.y == uv0.mousePosition_.y then
				manager.notify:Invoke(CLICK_TRIGGER)

				uv0.hideUIFlag_ = false
			end
		end

		if GameToSDK.PLATFORM_ID == 2 then
			if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject() then
				return
			end

			if Input.GetMouseButton(0) then
				if math.abs(Input.GetAxis("Mouse Y")) <= math.abs(Input.GetAxis("Mouse X")) then
					manager.notify:Invoke(TOUCH_HORIZONTAL, slot0 * -10)
				else
					manager.notify:Invoke(TOUCH_VERTICAL, slot1 * -0.1)
				end
			elseif Input.GetAxis("Mouse ScrollWheel") < 0 then
				manager.notify:Invoke(MULTI_TOUCH_SCALE, 0.5)
			elseif Input.GetAxis("Mouse ScrollWheel") > 0 then
				manager.notify:Invoke(MULTI_TOUCH_SCALE, -0.5)
			end
		else
			if Input.touchCount <= 0 then
				return
			end

			if Input.touchCount == 1 then
				if not UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(Input.GetTouch(0).fingerId) then
					if Input.GetTouch(0).phase == UnityEngine.TouchPhase.Began then
						slot0.rawPosition = slot0.position
						slot0.deltaPosition = Vector2(0, 0)
						uv0.lastPosition_ = slot0.position
						uv0.touchBegan_ = true
					elseif slot0.phase == UnityEngine.TouchPhase.Ended then
						uv0.touchBegan_ = false
					end

					if uv0.touchBegan_ ~= true then
						return
					end

					slot1 = slot0.position - uv0.lastPosition_
					uv0.lastPosition_ = slot0.position

					if math.abs(slot1.y) <= math.abs(slot1.x) then
						manager.notify:Invoke(TOUCH_HORIZONTAL, slot2 * -0.25)
					else
						manager.notify:Invoke(TOUCH_VERTICAL, slot3 * -0.0008 * Screen.dpi / 96 * manager.ui.mainCameraCom_.fieldOfView / 28)
					end
				end
			else
				slot0 = Input.GetTouch(0)

				if Input.GetTouch(1).phase == UnityEngine.TouchPhase.Began then
					uv1 = slot1
					uv2 = slot0

					return
				end

				slot4 = Vector2.Distance(slot0.position, slot1.position) - Vector2.Distance(uv2.position, uv1.position)

				if not UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(Input.GetTouch(0).fingerId) and not UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(Input.GetTouch(1).fingerId) then
					manager.notify:Invoke(MULTI_TOUCH_SCALE, slot4 / -20)
				end
			end
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.OnEnter(slot0)
	slot0:AddTimer()

	slot0.hideUIFlag_ = false
end

function slot0.OnExit(slot0)
	slot0.timer_:Stop()

	slot0.timer_ = nil
end

function slot0.Dispose(slot0)
end

function slot0.HideUI(slot0)
	slot0.hideUIFlag_ = true
	slot0.mousePosition_ = nil
end

return slot0
