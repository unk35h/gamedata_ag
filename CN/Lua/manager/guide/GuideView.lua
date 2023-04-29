slot0 = class("GuideView")
slot1 = Vector2(85, 75)

function slot0.Ctor(slot0)
	slot0._isInit = false
end

function slot0.Init(slot0)
	if slot0._isInit then
		return
	end

	slot0.gameObject_ = GameObject.Instantiate(Asset.Load("UI/Guide/GuideNewUI"), manager.ui.uiTips.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddUIListener()

	slot0._isInit = true

	SetActive(slot0.gameObject_, false)
end

function slot0.InitUI(slot0)
	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.btnMaskBtn_.onClick

	slot1:AddListener(function ()
		manager.guide:OnComponentClick()
	end)

	slot1 = slot0.eventTrigger_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		manager.guide:OnEventTrigger("pointerClick", slot1)
	end))

	slot1 = slot0.eventTrigger_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		manager.guide:OnEventTrigger("pointerUp", slot1)
	end))

	slot1 = slot0.eventTrigger_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		manager.guide:OnEventTrigger("pointerDown", slot1)
	end))

	slot1 = slot0.eventTrigger_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		manager.guide:OnEventTrigger("beginDrag", slot1)
	end))

	slot1 = slot0.eventTrigger_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		manager.guide:OnEventTrigger("drag", slot1)
	end))

	slot1 = slot0.eventTrigger_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		manager.guide:OnEventTrigger("endDrag", slot1)
	end))
end

function slot0.RemoveUIListener(slot0)
	slot0.btnMaskBtn_.onClick:RemoveAllListeners()
	slot0.eventTrigger_:RemoveAllListeners()
end

function slot0.ShowTalk(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot1 or slot1 == "" then
		SetActive(slot0.textPanel_, false)

		return
	end

	SetActive(slot0.textPanel_, true)

	slot0.textCom_.text = slot1
	slot0.dialogNameText_.text = slot4
	slot0.dialogHeadImg_.sprite = getSpriteViaConfig("StoryHeadIcon", string.format("story_%s", slot5))

	if slot2 == 1 then
		slot0.textRect_.anchorMax = Vector2.New(0, 1)
		slot0.textRect_.anchorMin = Vector2.New(0, 1)
	elseif slot2 == 2 then
		slot0.textRect_.anchorMax = Vector2.New(1, 1)
		slot0.textRect_.anchorMin = Vector2.New(1, 1)
	elseif slot2 == 3 then
		slot0.textRect_.anchorMax = Vector2.New(1, 0)
		slot0.textRect_.anchorMin = Vector2.New(1, 0)
	elseif slot2 == 4 then
		slot0.textRect_.anchorMax = Vector2.New(0, 0)
		slot0.textRect_.anchorMin = Vector2.New(0, 0)
	else
		slot0.textRect_.anchorMax = Vector2.New(0.5, 0.5)
		slot0.textRect_.anchorMin = Vector2.New(0.5, 0.5)
	end

	if slot6 == 1 then
		slot0.textRect_.anchoredPosition = Vector2.New((slot3[1] or 0) + ReduxView.VIEW_ADAPT_DISTANCE, slot3[2] or 0)
	elseif slot6 == 2 then
		slot0.textRect_.anchoredPosition = Vector2.New((slot3[1] or 0) - ReduxView.VIEW_ADAPT_DISTANCE, slot3[2] or 0)
	else
		slot0.textRect_.anchoredPosition = Vector2.New(slot3[1] or 0, slot3[2] or 0)
	end
end

function slot0.ShowHoldMask(slot0, slot1, slot2)
	slot3 = slot1:GetComponent("RectTransform")

	SetActive(slot0.gameObject_, true)
	SetActive(slot0.btnMaskGo_, true)

	slot4 = Vector3(0, 0, 0)
	slot5 = Vector3(0, 0, 0)
	slot7 = Vector2(0, 0)
	slot0.btnMaskCom_.sizeDelta = Vector2(slot3.rect.width, slot3.rect.height) + uv0 + Vector2(0, 0)
	slot0.btnMaskCom_.position = slot3.position
	slot0.btnMaskCom_.eulerAngles = slot3.eulerAngles
	slot0.btnMaskCom_.localScale = slot2
	slot0.maskImgCom1_.sizeDelta = Vector2(slot3.rect.width, slot3.rect.height) + slot7
	slot0.maskImgCom2_.sizeDelta = Vector2(slot3.rect.width, slot3.rect.height) + slot7
	slot0.maskImgCom1_.position = slot3.position
	slot0.maskImgCom2_.position = slot3.position
	slot0.maskImgCom1_.pivot = slot3.pivot
	slot0.maskImgCom2_.pivot = slot3.pivot
	slot0.maskImgCom1_.eulerAngles = slot3.eulerAngles
	slot0.maskImgCom2_.eulerAngles = slot3.eulerAngles
	slot0.maskImgCom1_.localScale = slot2
	slot0.maskImgCom2_.localScale = slot2

	if slot1:GetComponent(typeof(Image)) and slot8.enabled then
		slot0.maskImage1_.sprite = slot8.sprite
		slot0.maskImage2_.sprite = slot8.sprite
	else
		slot0.maskImage1_.sprite = nil
		slot0.maskImage2_.sprite = nil
	end

	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	slot0.timer_ = Timer.New(function ()
		if isNil(uv0) then
			uv1.timer_:Stop()

			uv1.timer_ = nil

			return
		end

		uv1.maskImgCom1_.sizeDelta = Vector2(uv2.rect.width, uv2.rect.height) + uv3
		uv1.maskImgCom2_.sizeDelta = Vector2(uv2.rect.width, uv2.rect.height) + uv3
		uv1.maskImgCom1_.position = uv2.position
		uv1.maskImgCom2_.position = uv2.position
		uv1.maskImgCom1_.eulerAngles = uv2.eulerAngles
		uv1.maskImgCom2_.eulerAngles = uv2.eulerAngles
		uv1.maskImgCom1_.localScale = uv4
		uv1.maskImgCom2_.localScale = uv4
		uv1.btnMaskCom_.sizeDelta = Vector2(uv2.rect.width, uv2.rect.height) + uv5 + uv6
		uv1.btnMaskCom_.position = uv2.position
		uv1.btnMaskCom_.eulerAngles = uv2.eulerAngles
		uv1.btnMaskCom_.localScale = uv4
	end, 0.033, -1)

	slot0.timer_:Start()
end

function slot0.Hide(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	SetActive(slot0.gameObject_, false)
end

function slot0.HideButton(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	SetActive(slot0.btnMaskGo_, false)
end

function slot0.Dispose(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	slot0.timer_ = nil

	if slot0._isInit then
		slot0:RemoveUIListener()
		Object.Destroy(slot0.gameObject_)
	end

	slot0._isInit = false
end

return slot0
