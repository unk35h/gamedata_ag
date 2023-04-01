slot0 = class("BaseView")
slot1 = import("game.const.ViewConst")

function slot0.Ctor(slot0, ...)
	manager.notify:RegistListener(GAME_FOCUS_CHANGE, handler(slot0, slot0.OnGameFocusChange))
end

function slot0.UpdateLastOpenTime(slot0)
	slot0.__lastOpenTime = Time.realtimeSinceStartup
end

function slot0.GetStayTime(slot0)
	slot0.__lastOpenTime = slot0.__lastOpenTime or 0

	return math.floor((Time.realtimeSinceStartup - slot0.__lastOpenTime) * 1000)
end

slot2 = {
	StartTimerLoop = function (slot0, slot1, slot2, slot3, slot4, slot5)
		if slot0.pressing_ then
			slot0.curTime_ = 1
			slot0.pressTimer_ = Timer.New(function ()
				slot0 = true

				if uv0.curTime_ <= uv1 * 10 then
					if uv0.curTime_ % (uv2 / 0.1) == 0 then
						slot0 = uv3(1)
					end
				elseif uv0.curTime_ % (uv4 / 0.1) == 0 then
					slot0 = uv3(1)
				end

				uv0.curTime_ = uv0.curTime_ + 1

				if not slot0 then
					uv0:StopLongClickTimer()
				end
			end, 0.1, -1)

			slot0.pressTimer_:Start()
			slot5(0)
		end
	end
}

function slot0.Dispose(slot0)
	manager.notify:RemoveListener(GAME_FOCUS_CHANGE, handler(slot0, slot0.OnGameFocusChange))
end

function slot0.OnGameFocusChange(slot0, slot1, slot2)
	if not slot1 then
		slot0:StopLongClickTimer()
	end
end

function slot0.FindGo(slot0, slot1, slot2)
	if slot0:FindTrs(slot1, slot2) ~= nil then
		return slot3.gameObject
	end
end

function slot0.FindTrs(slot0, slot1, slot2)
	if slot2 == nil then
		return slot0.transform_:Find(slot1)
	else
		return slot2:Find(slot1)
	end
end

function slot0.FindCom(slot0, slot1, slot2, slot3)
	if slot2 == nil then
		if slot3 == nil then
			return slot0.transform_:GetComponent(slot1)
		else
			return slot3:GetComponent(slot1)
		end
	else
		slot4 = nil

		if ((slot3 ~= nil or slot0:FindTrs(slot2)) and slot0:FindTrs(slot2, slot3)) == nil then
			print(string.format("can not find %s %s", slot2, slot1))
		end

		return slot4:GetComponent(slot1)
	end
end

function slot0.RegistEventListener(slot0, slot1, slot2)
	if not slot0.registFunc_ then
		slot0.registFunc_ = {}
	end

	if slot0.registFunc_[slot1] then
		manager.notify:RemoveListener(slot1, slot0.registFunc_[slot1])
	end

	slot0.registFunc_[slot1] = slot2

	manager.notify:RegistListener(slot1, slot2)
end

function slot0.RemoveAllEventListener(slot0)
	if slot0.registFunc_ then
		for slot4, slot5 in pairs(slot0.registFunc_) do
			manager.notify:RemoveListener(slot4, slot5)
		end
	end
end

function slot0.AutoBindUI(slot0)
	slot5 = true
	slot1 = slot0.gameObject_:GetComponentsInChildren(typeof(UnityEngine.Transform), slot5)
	slot6 = slot1

	for slot5, slot6 in pairs(slot1.ToTable(slot6)) do
		slot7 = string.split(slot6.name, "_")
		slot8 = #slot7
		slot9 = slot7[slot8]

		if slot8 > 1 and slot7[1] == "e" then
			for slot13 = 2, slot8 - 1 do
				if uv0.COMPOMENT_TRANS[slot7[slot13]] then
					if slot7[slot13] == "go" then
						slot0[slot7[slot13] .. "_" .. slot9 .. "_"] = slot6.gameObject
					elseif slot7[slot13] == "trs" then
						slot0[slot7[slot13] .. "_" .. slot9 .. "_"] = slot6
					else
						slot0[slot7[slot13] .. "_" .. slot9 .. "_"] = slot6:GetComponent(slot14)
					end
				end
			end
		end
	end
end

function slot0.BindCfgUI(slot0, slot1, slot2)
	slot2 = slot2 or slot0

	if not slot1 then
		ComponentBinder.GetInstance():BindCfgUI(slot2, slot0.gameObject_)
	else
		ComponentBinder.GetInstance():BindCfgUI(slot2, slot1)
	end
end

function slot0.ReBindTimeLineAnimator(slot0, slot1, slot2)
	slot1:RebuildGraph()

	slot1.time = 0

	for slot8 = 0, slot1.playableAsset.outputTrackCount - 1 do
		if string.split(slot3:GetOutputTrack(slot8).name, "@")[1] == "Animator" then
			slot1:SetGenericBinding(slot9, slot0:FindCom(typeof(Animator), slot10[2], slot2))
		end
	end
end

function slot0.AddBtnListenerScale(slot0, slot1, slot2, slot3, ...)
	slot4 = {
		...
	}
	slot5 = nil
	slot5 = (slot1 ~= nil and type(slot1) ~= "string" or slot0:FindCom(typeof(Button), slot1, slot2)) and slot1
	slot6 = slot0:GetOrAddComponent(slot5.gameObject, typeof(EventTriggerListener))
	slot7 = slot5.gameObject.transform.localScale

	slot6:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function ()
		if not uv0.interactable then
			return
		end

		LeanTween.cancel(uv0.gameObject)

		uv0.gameObject.transform.localScale = uv1
	end))
	slot6:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function ()
		if not uv0.interactable then
			return
		end

		LeanTween.scale(uv0.gameObject, uv1 * 1.1, 0.8):setEase(LeanTweenType.easeOutElastic)
	end))

	if type(slot3) == "string" then
		slot8 = slot5.onClick

		slot8:AddListener(function ()
			if not uv0.interactable then
				return
			end

			uv1:RecordOperation(uv0)
			uv1[uv2](uv1, unpack(uv3))
		end)
	else
		slot8 = slot5.onClick

		slot8:AddListener(function ()
			if not uv0.interactable then
				return
			end

			uv1:RecordOperation(uv0)
			uv2(unpack(uv3))
		end)
	end

	slot0:SetListener(slot6)
	slot0:SetListener(slot5.onClick)
end

function slot0.RemoveBtnListenerScale(slot0, slot1, slot2)
	slot3 = slot0:FindCom(typeof(Button), slot1, slot2)
	slot4 = slot0:GetOrAddComponent(slot3.gameObject, typeof(EventTriggerListener))

	slot4:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	slot4:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	slot3.onClick:RemoveAllListeners()
end

function slot0.AddPressByTimeListener(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = slot0:GetOrAddComponent(slot1, typeof(EventTriggerListener))
	slot0.pressing_ = false
	slot8 = slot6

	function slot9(slot0, slot1, slot2, slot3)
		if uv0.pressTimer_ then
			uv0.pressTimer_:Stop()

			uv0.pressTimer_ = nil
		end

		if type(slot0) == "string" then
			uv0:__slot0_None__(slot1, slot2)
		else
			slot0(slot1, slot2, slot3)
		end
	end

	slot7:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0.pressTimer_ then
			uv1(uv2, slot0, slot1, uv3)
		else
			uv1(uv4, slot0, slot1, uv3)
		end
	end))
	slot7:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if not uv0.pressTimer_ then
			uv0.pressTimer_ = Timer.New(function ()
				uv0(uv1, uv2, uv3, uv4)
			end, uv4, 1)

			uv0.pressTimer_:Start()
		end
	end))
	slot0:SetListener(slot7)
end

function slot0.AddPressingByTimeListener(slot0, slot1, slot2, slot3, slot4, slot5, slot6, ...)
	slot7 = {
		...
	}
	slot8 = slot0:GetOrAddComponent(slot1, typeof(EventTriggerListener))
	slot9 = slot1.transform.localScale
	slot0.pressing_ = false

	function slot10(slot0)
		if type(slot0) == "string" then
			return uv0:__slot0_None__(unpack(uv1))
		else
			return slot0(unpack(uv1))
		end
	end

	slot8:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function ()
		uv0:StopLongClickTimer()

		if uv1 then
			uv1()
		end
	end))
	slot8:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function ()
		if uv0.pressTimer_ == nil and not uv0.pressing_ then
			uv0.pressing_ = true

			uv1.StartTimerLoop(uv0, "PressTimer", uv2, uv3, uv4, function (slot0)
				OperationRecorder.Record(uv0.class.__cname, uv1.name .. slot0)

				return uv2(uv3)
			end)
		end
	end))
	slot0:SetListener(slot8)
end

function slot0.AddBtnListener(slot0, slot1, slot2, slot3, ...)
	slot4 = {
		...
	}
	slot5 = nil
	slot5 = (slot1 ~= nil and type(slot1) ~= "string" or slot0:FindCom(typeof(Button), slot1, slot2)) and slot1

	if type(slot3) == "string" then
		slot6 = slot5.onClick

		slot6:AddListener(function ()
			uv0:RecordOperation(uv1)
			uv0[uv2](uv0, unpack(uv3))
		end)
	else
		slot6 = slot5.onClick

		slot6:AddListener(function ()
			uv0:RecordOperation(uv1)
			uv2(unpack(uv3))
		end)
	end

	slot0:SetListener(slot5.onClick)
end

function slot0.AddBtnHandler(slot0, slot1, slot2, ...)
	if ... then
		slot1.onClick:AddListener(handlerArg(slot0, slot0[slot2], ...))
	else
		slot1.onClick:AddListener(handler(slot0, slot0[slot2]))
	end

	slot0:RecordOperation(slot1)
	slot0:SetListener(slot1.onClick)
end

function slot0.StopLongClickTimer(slot0)
	slot0.pressing_ = false

	if slot0.pressTimer_ then
		slot0.pressTimer_:Stop()

		slot0.pressTimer_ = nil
	end
end

function slot0.RemoveBtnListener(slot0, slot1, slot2)
	slot0:FindCom(typeof(Button), slot1, slot2).onClick:RemoveAllListeners()
end

function slot0.AddPonitListener(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetOrAddComponent(slot1, typeof(EventTriggerListener))
	slot5 = slot1:GetComponent("RectTransform")

	slot4:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerEnter, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0(slot0, slot1)
	end))
	slot4:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerExit, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0(slot0, slot1)
	end))
	slot0:SetListener(slot4)
end

function slot0.AddDragListener(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0:GetOrAddComponent(slot1, typeof(EventTriggerListener))
	slot6 = slot1:GetComponent("RectTransform")
	slot0.pressPos_ = nil

	slot5:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0.pressPos_ == nil then
			uv1()

			uv0.pressPos_ = LuaHelper.ScreenToLocal(uv2, slot1.position, slot1.enterEventCamera)
		end
	end))
	slot5:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0.pressPos_ then
			slot2 = LuaHelper.ScreenToLocal(uv1, slot1.position, slot1.enterEventCamera)

			uv2(uv0.pressPos_.x - slot2.x, uv0.pressPos_.y - slot2.y, slot2, slot1.position)
		end
	end))
	slot5:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0 then
			slot2 = LuaHelper.ScreenToLocal(uv1, slot1.position, slot1.enterEventCamera)

			uv0(uv2.pressPos_.x - slot2.x, uv2.pressPos_.y - slot2.y, slot2)
		end

		uv2.pressPos_ = nil
	end))
	slot0:SetListener(slot5)
end

function slot0.AddToggleListener(slot0, slot1, slot2)
	slot1.onValueChanged:AddListener(slot2)
	slot0:SetListener(slot1.onValueChanged)
end

function slot0.EndTimeLinePlay(slot0)
	if slot0.gameObject_ == nil then
		return
	end

	if slot0:FindGo("panel") and slot1:GetComponent("PlayableDirector") then
		slot2.time = slot2.duration
	end
end

function slot0.SetGaussionBg(slot0, slot1)
	if slot0.gameObject_ == nil then
		return
	end

	if (slot0.gaussianGo_ or slot0:FindGo("Canvas")) == nil then
		return
	end

	if slot1 then
		slot2.layer = 18
	else
		slot2.layer = 5
	end
end

function slot0.PlayTimeLineAni(slot0, slot1)
	if slot0.playable_ then
		slot0.playable_.playableAsset = Asset.Load(slot1)

		slot0:ReBindTimeLineAnimator(slot0.playable_)
		slot0.playable_:Play()
	end
end

function slot0.GetOrAddComponent(slot0, slot1, slot2)
	if slot1:GetComponent(slot2) ~= nil then
		return slot3
	else
		return slot1:AddComponent(slot2)
	end
end

function slot0.SetListener(slot0, slot1)
	slot0.listeners_ = slot0.listeners_ or {}

	table.insert(slot0.listeners_, slot1)
end

function slot0.RemoveAllListeners(slot0)
	if slot0.listeners_ then
		for slot4, slot5 in ipairs(slot0.listeners_) do
			slot5:RemoveAllListeners()
		end

		for slot4 = 1, #slot0.listeners_ do
			slot0.listeners_[slot4] = nil
		end

		slot0.listeners_ = nil
	end
end

slot3 = 900

function slot0.RecordOperation(slot0, slot1)
	if OperationData:IsFunctionStoped(uv0) then
		return
	end

	if string.isNullOrEmpty(slot0:GetBtnOperationKey(slot1)) then
		return
	end

	SDKTools.SendMessageToSDK("button_touch", {
		button_name = slot3
	})
end

function slot0.GetBtnOperationKey(slot0, slot1)
	if isNil(slot1) then
		return nil
	end

	slot2 = slot1.gameObject.name
	slot3 = slot1.transform

	while slot3 ~= slot0.transform_ and not isNil(slot3) and not isNil(slot3.parent) do
		slot2 = slot3.parent.name .. "_" .. slot2
	end

	return slot2
end

function slot0.CheckListenersLeak(slot0)
	if slot0.listeners_ ~= nil and #slot0.listeners_ > 0 then
		Debug.LogError(string.format("%s有%d个事件没移除", slot0.class.__cname, #slot0.listeners_))
	end
end

return slot0
