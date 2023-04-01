slot0 = class("PuzzleSelectItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.lockStateController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.completedController_ = ControllerUtil.GetController(slot0.transform_, "complete")
	slot0.enterGameController_ = ControllerUtil.GetController(slot0.transform_, "enterGame")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.Btn_, nil, function ()
		if uv0.isLock_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0.openTime_)))

			return
		end

		if uv0.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleData:SetSelectActivity(uv0.activityID_)

		if uv0.clickCallBack_ ~= nil then
			uv0.clickCallBack_(uv0.index_, uv0.activityID_)
		end

		uv0.transform_:SetAsLastSibling()
	end)
end

slot1 = 0.25
slot2 = 0.25
slot3, slot4, slot5, slot6, slot7 = nil
slot8 = Vector2(1, 1)

function slot0.OnClickItem(slot0, slot1)
	if slot0.index_ == slot1 then
		uv0 = PuzzleTool:GetPuzzlePanelWidth()
		uv1 = uv0 / slot0.drawTrans_.rect.width
		uv2 = Vector3(uv1, uv1, 1)

		PuzzleTool:ScaleBg(uv1)

		uv3 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
		slot5, slot6 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot0.parentTrans_, manager.ui.mainCameraCom_:WorldToScreenPoint(PuzzleTool:GetPanelTrans().position), uv3, uv4)
		slot6 = Vector3(slot6.x, slot6.y, 1)
		slot9 = slot0.transform_.pivot
		slot9.x = slot9.x - 0.5
		slot9.y = slot9.y - 0.5
		slot6.x = slot6.x + slot9.x * slot0.transform_.rect.width * uv1
		slot6.y = slot6.y + slot9.y * slot0.transform_.rect.height * uv1
		slot0.originPos_ = slot0.transform_.localPosition
		slot0.originScale_ = slot0.transform_.localScale

		manager.notify:Invoke(PUZZLE_GAME_ANIM_START)

		slot0.posLeanTween_ = LeanTween.moveLocal(slot0.gameObject_, slot6, uv5):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function ()
			manager.notify:Invoke(PUZZLE_GAME_ANIM_END)

			if uv0.posLeanTween_ then
				uv0.posLeanTween_:setOnComplete(nil)

				uv0.posLeanTween_ = nil
			end

			uv0.enterGameController_:SetSelectedState("true")
		end))

		manager.notify:Invoke(PUZZLE_GAME_ANIM_START)

		slot0.scaleLeanTween_ = LeanTween.scale(slot0.transform_, uv2, uv6):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function ()
			manager.notify:Invoke(PUZZLE_GAME_ANIM_END)

			if uv0.scaleLeanTween_ then
				uv0.scaleLeanTween_:setOnComplete(nil)

				uv0.scaleLeanTween_ = nil
			end
		end))

		slot0:EnterGamePlay()
	else
		slot0.fadeAnim_.enabled = true

		slot0.fadeAnim_:Play("VolumePuzzleMainUI_itemFade", -1, 0)
	end
end

function slot0.EnterGamePlay(slot0)
	if not PuzzleData:IsCompleted(slot0.activityID_) then
		slot0.startAnim_.enabled = true

		slot0.startAnim_:Play("VolumePuzzleMainUI_mess", -1, 0)
		manager.notify:Invoke(PUZZLE_GAME_ANIM_START)

		if slot0.timer_ then
			slot0.timer_:Stop()

			slot0.timer_ = nil
		end

		slot0.timer_ = Timer.New(function ()
			if uv0.startAnim_:GetCurrentAnimatorStateInfo(0):IsName(uv1) and slot0.normalizedTime >= 1 then
				manager.notify:Invoke(PUZZLE_GAME_ANIM_END)

				if uv0.timer_ ~= nil then
					uv0.timer_:Stop()

					uv0.timer_ = nil
				end

				uv0.startAnim_.enabled = false
			end
		end, 0.033, -1)

		slot0.timer_:Start()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_puzzleselect", "")
	end

	slot0:Go("puzzleSelect", {
		mainActivityID = slot0.mainActivityID_,
		activityID = slot0.activityID_
	})
	PuzzleTool:RefreshPuzzleBg(slot0.activityID_)
end

function slot0.SetClickCallBack(slot0, slot1)
	slot0.clickCallBack_ = slot1
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot3

	if slot0.activityID_ == nil then
		slot0.redPointStr_ = string.format("%s_%s_%s", RedPointConst.ACTIVITY_PUZZLE, slot1, slot2)

		manager.redPoint:bindUIandKey(slot0.panelTrans_, slot0.redPointStr_)
	elseif slot0.activityID_ ~= slot2 then
		manager.redPoint:unbindUIandKey(slot0.panelTrans_, slot0.redPointStr_)

		slot0.redPointStr_ = string.format("%s_%s_%s", RedPointConst.ACTIVITY_PUZZLE, slot1, slot2)

		manager.redPoint:bindUIandKey(slot0.panelTrans_, slot0.redPointStr_)
	end

	slot0.mainActivityID_ = slot1
	slot0.activityID_ = slot2
	slot4 = ActivityData:GetActivityData(slot0.activityID_)
	slot0.openTime_ = slot4.startTime
	slot0.stopTime_ = slot4.stopTime
	slot0.isLock_ = manager.time:GetServerTime() < slot0.openTime_

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.isLock_ = manager.time:GetServerTime() < slot0.openTime_

	slot0.lockStateController_:SetSelectedState(tostring(slot0.isLock_))
	slot0:RefreshLock()
	slot0:RefreshCompletedState()
end

function slot0.RefreshLock(slot0)
	if not slot0.isLock_ then
		return
	end

	slot0.isLock_ = manager.time:GetServerTime() < slot0.openTime_

	if slot0.isLock_ then
		slot0.openTimeText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot0.openTime_))
	else
		slot0.lockStateController_:SetSelectedState("false")
	end
end

function slot0.RefreshCompletedState(slot0)
	if not PuzzleData:IsCompleted(slot0.activityID_) then
		slot0.completedController_:SetSelectedState("false")
	else
		slot0.completedController_:SetSelectedState("true")
	end
end

function slot0.UnRegisterRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.panelTrans_, string.format("%s_%s_%s", RedPointConst.ACTIVITY_PUZZLE, ActivityPuzzleCfg[slot0.activityID_].main_activity_id, slot0.activityID_))
end

function slot0.OnExit(slot0)
	slot0:Reset()
end

function slot0.Dispose(slot0)
	slot0:UnRegisterRedPoint()
	uv0.super.Dispose(slot0)
end

function slot0.Reset(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.posLeanTween_ then
		slot0.posLeanTween_:setOnComplete(nil)
		LeanTween.cancel(slot0.gameObject_)

		slot0.posLeanTween_ = nil
	end

	if slot0.scaleLeanTween_ then
		slot0.scaleLeanTween_:setOnComplete(nil)
		LeanTween.cancel(slot0.gameObject_)

		slot0.scaleLeanTween_ = nil
	end

	if slot0.originPos_ ~= nil then
		slot0.transform_.localPosition = slot0.originPos_
		slot0.originPos_ = nil
	end

	if slot0.originScale_ ~= nil then
		slot0.transform_.localScale = slot0.originScale_
		slot0.originScale_ = nil
	end

	slot0.fadeAnim_.enabled = false
	slot0.canvasGroup_.alpha = 1

	slot0.enterGameController_:SetSelectedState("false")
end

return slot0
