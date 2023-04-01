slot0 = class("TowerGameView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/snakeactive/MardukSnakemainUI"
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

	slot0.selectStageItemHandler_ = handler(slot0, slot0.OnSelectStageItem)
	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiList_, TowerGameItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1)
	slot2:SetSelectCallBack(slot0.selectStageItemHandler_)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()

	slot0.stopTime_ = ActivityData:GetActivityData(ActivityConst.FACTORY_TOWERGAME).stopTime
	slot0.timer_ = Timer.New(function ()
		if manager.time:GetServerTime() < uv0.stopTime_ then
			uv0.timeText_.text = manager.time:GetLostTimeStr(uv0.stopTime_)

			uv0:RefreshItemTime()
		else
			uv0:StopTimer()

			uv0.timeText_.text = GetTips("TIME_OVER")

			return
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	slot1 = manager.windowBar

	slot1:SetGameHelpKey("ACTIVITY_TOWER_DEFENSE_DESC")

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0:IsOpenSectionView() then
			uv0:RefreshSelectStageItem(0)

			uv0.m_scrollCom.horizontal = true
		end

		JumpTools.Back()
	end)
end

function slot0.OnTowerGameBack(slot0)
	if slot0:IsOpenSectionView() then
		slot0:RefreshSelectStageItem(0)

		slot0.m_scrollCom.horizontal = true
	end
end

function slot0.OnTowerGameRefresh(slot0)
	slot0.list_:Refresh()
end

function slot0.RefreshUI(slot0)
	slot0.stopTime_ = ActivityData:GetActivityData(ActivityConst.FACTORY_TOWERGAME).stopTime

	if manager.time:GetServerTime() < slot0.stopTime_ then
		slot0.timeText_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	else
		slot0.timeText_.text = GetTips("TIME_OVER")
	end

	slot0.list_:StartScroll(#TowerGameCfg.all)
	slot0:RefreshSelectStageItem(0)
	slot0:RefreshItemTime()
	manager.redPoint:bindUIandKey(slot0.rewardbtntrans_, RedPointConst.MARDUK_TOWERGAME_REWARD)
end

function slot0.RefreshItemTime(slot0)
	for slot5, slot6 in pairs(slot0.list_:GetItemList()) do
		slot6:UpdateTime()
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("towerGameRewardView", {
			activityId = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.planeBtn_, nil, function ()
		JumpTools.OpenPageByJump("towerGamePlaneView", {
			activityId = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.bgbtn_, nil, function ()
		uv0:TryToCloseSectionView()
	end)

	slot1 = slot0.scrollViewEvent_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:TryToCloseSectionView()
	end))

	slot1 = slot0.scrollViewEvent_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:TryToCloseSectionView()
	end))
end

function slot0.IsOpenSectionView(slot0)
	return slot0:IsOpenRoute("towerGameSectionInfoView")
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopTimer()
	slot0:RemoveTween()
	manager.redPoint:unbindUIandKey(slot0.rewardbtntrans_, RedPointConst.MARDUK_TOWERGAME_REWARD)
end

function slot0.OnSelectStageItem(slot0, slot1, slot2)
	slot0:RefreshSelectStageItem(slot1)
	TowerGameData:SetLevleClick(slot1)

	if slot0.list_:GetItemList()[slot2] then
		slot0.m_scrollCom.horizontal = false

		slot0:RemoveTween()

		slot7 = LeanTween.value(slot0.m_scrollContent, slot0.m_scrollContent.transform.localPosition.x, -slot4.transform_.localPosition.x + slot0.m_scrollViewTrans.rect.width / 3 - slot4.transform_.rect.width / 2, 0.2)
		slot0.tween_ = slot7:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.m_scrollContent.transform.localPosition = Vector3(slot0, 0, 0)
		end))
	else
		slot0.m_scrollCom.horizontal = true
	end

	if slot0:IsOpenSectionView() then
		JumpTools.Back()
	end
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil)
		LeanTween.cancel(slot0.m_scrollContent)

		slot0.tween_ = nil
	end
end

function slot0.TryToCloseSectionView(slot0)
	if slot0:IsOpenSectionView() then
		slot0:RefreshSelectStageItem(0)

		slot0.m_scrollCom.horizontal = true

		JumpTools.Back()
	end
end

function slot0.RefreshSelectStageItem(slot0, slot1)
	slot0.selectStageID_ = slot1

	for slot6, slot7 in pairs(slot0.list_:GetItemList()) do
		slot7:RefreshSelect(slot0.selectStageID_)
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	slot0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	slot0:StopTimer()

	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	slot0.selectStageItemHandler_ = nil
end

return slot0
