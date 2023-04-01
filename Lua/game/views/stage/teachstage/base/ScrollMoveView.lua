slot0 = class("ScrollMoveView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.parentView_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.fixWidth = slot3

	slot0:InitUI()
	slot0:AddListeners()

	slot0.needInitScroll_ = true
end

function slot0.OnExit(slot0)
	slot0.scrollView_.enabled = true
	slot0.needInitScroll_ = true
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot1 = slot0.scrollViewEvent_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0.drag_ = true
	end))

	slot1 = slot0.scrollViewEvent_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0.drag_ = false
	end))

	slot1 = slot0.scrollViewEvent_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0.scrollView_.enabled = true
	end))

	slot1 = slot0.scrollViewEvent_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if not slot1.dragging and uv0.parentView_:IsOpenSectionInfo() then
			uv0.isOpenInfoView_ = false

			JumpTools.Back()
		end

		uv0.scrollView_.enabled = true
	end))

	slot1 = slot0.scrollView_.onValueChanged

	slot1:AddListener(function (slot0)
		if uv0.isOpenInfoView_ and math.abs(uv0.horizontalNormalizedPosition_ - uv0.scrollView_.horizontalNormalizedPosition) >= 0.001 then
			uv0.isOpenInfoView_ = false
			uv0.scrollView_.horizontalNormalizedPosition = uv0.horizontalNormalizedPosition_

			if uv0.parentView_:IsOpenSectionInfo() then
				LeanTween.cancel(uv0.gameObject_)
				JumpTools.Back()
			end
		end
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	slot0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	slot0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	slot0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	slot0.scrollView_.onValueChanged:RemoveAllListeners()
end

function slot0.InitScrollPosition(slot0, slot1, slot2)
	slot3 = BattleFieldData:GetStoryBackFlag()

	if slot0.needInitScroll_ and slot0.contentRect_.rect.width < slot0.viewportRect_.rect.width then
		slot0:RemoveTween()

		if slot3 == true then
			slot0:StopMove(0)

			return
		end

		if slot2 then
			slot4 = slot0.contentRect_.localPosition
			slot0.contentRect_.localPosition = Vector3(0, slot4.y, slot4.z)
		else
			slot0.tween_ = LeanTween.value(slot0.gameObject_, slot0.viewportRect_.rect.width, 0, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
				if uv0.drag_ then
					uv0:RemoveTween()

					return
				end

				slot1 = uv0.contentRect_.localPosition
				uv0.contentRect_.localPosition = Vector3(slot0, slot1.y, slot1.z)
			end)):setOnComplete(System.Action(function ()
				uv0:RemoveTween()
			end)):setEase(LeanTweenType.easeOutSine)
		end

		slot0.needInitScroll_ = false

		return
	end

	if slot0.needInitScroll_ then
		slot0.scrollView_.horizontalNormalizedPosition = 0
	end

	if (slot1 - slot0.viewportRect_.rect.width / 2 + 200) / (slot0.contentRect_.rect.width - slot0.viewportRect_.rect.width) < 0 then
		slot5 = 0

		if slot0.needInitScroll_ then
			slot0.scrollView_.horizontalNormalizedPosition = -1
		end
	elseif slot5 > 1 then
		slot5 = 1
	end

	slot0:RemoveTween()

	if slot3 == true then
		slot0:StopMove(slot5)

		return
	end

	if slot2 then
		slot0.horizontalNormalizedPosition_ = slot5
		slot0.scrollView_.horizontalNormalizedPosition = slot5
	else
		slot0.tween_ = LeanTween.value(slot0.gameObject_, slot0.scrollView_.horizontalNormalizedPosition, slot5, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
			if uv0.drag_ then
				uv0:RemoveTween()

				return
			end

			uv0.horizontalNormalizedPosition_ = slot0
			uv0.scrollView_.horizontalNormalizedPosition = slot0
		end)):setOnComplete(System.Action(function ()
			uv0:RemoveTween()
		end)):setEase(LeanTweenType.easeOutSine)
	end

	slot0.needInitScroll_ = false
end

function slot0.ScrollPosition(slot0, slot1, slot2)
	if slot0.parentView_:IsOpenSectionInfo() then
		if slot0.contentRect_.rect.width < slot0.viewportRect_.rect.width then
			slot0.contentRect_.sizeDelta = Vector2(slot0.viewportRect_.rect.width, 648)
		end

		slot3 = slot1 - slot0.viewportRect_.rect.width / 2 + 200

		slot0:RemoveTween()

		slot0.scrollView_.enabled = false

		if slot2 then
			slot4 = slot3 / (slot0.contentRect_.rect.width - slot0.viewportRect_.rect.width)
			slot0.horizontalNormalizedPosition_ = slot4
			slot0.scrollView_.horizontalNormalizedPosition = slot4

			if slot0.parentView_:IsOpenSectionInfo() then
				slot0.isOpenInfoView_ = true
			end
		else
			slot0.tween_ = LeanTween.value(slot0.gameObject_, slot0.scrollView_.horizontalNormalizedPosition, slot3 / (slot0.contentRect_.rect.width - slot0.viewportRect_.rect.width), 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
				uv0.horizontalNormalizedPosition_ = slot0
				uv0.scrollView_.horizontalNormalizedPosition = slot0
			end)):setOnComplete(System.Action(function ()
				if uv0.parentView_:IsOpenSectionInfo() then
					uv0.isOpenInfoView_ = true
				end

				uv0:RemoveTween()
			end)):setEase(LeanTweenType.easeOutSine)
		end
	else
		if not slot0.fixWidth then
			slot0:ClacuteScrollWidth()
		end

		slot0.scrollView_.enabled = true
	end
end

function slot0.StopMove(slot0, slot1)
	BattleFieldData:SetStoryBackFlag(false)

	slot0.horizontalNormalizedPosition_ = slot1
	slot0.scrollView_.horizontalNormalizedPosition = slot1
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end
end

function slot0.ClacuteScrollWidth(slot0)
	slot0.contentRect_.sizeDelta = Vector2(slot0.scrollWidth_ - slot0.viewportRect_.rect.width + slot0.viewportRect_.rect.width / 4, 648)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.scrollWidth_ = slot2

	slot0:ClacuteScrollWidth()
	slot0:InitScrollPosition(slot1, slot3)
	slot0:ScrollPosition(slot1, slot3)
end

function slot0.SetHorizontalNormalizedPosition(slot0, slot1, slot2)
	slot0.needInitScroll_ = false
	slot0.scrollWidth_ = slot2

	slot0:ClacuteScrollWidth()

	slot0.scrollView_.horizontalNormalizedPosition = slot1
end

function slot0.GetHorizontalNormalizedPosition(slot0)
	return slot0.scrollView_.horizontalNormalizedPosition
end

return slot0
