slot0 = class("MardukSpecialMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/special/MardukSpecialUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0.items_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rankLockController_ = ControllerUtil.GetController(slot0.rankBtn_.transform, "rankLock")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("mardukSpecialReward", {
			activityId = uv0.params_.activityId
		})
	end)
	slot0:AddBtnListener(slot0.rankBtn_, nil, function ()
		if not uv0.rankOpen_ then
			return
		end

		JumpTools.OpenPageByJump("/mardukSpecialRank", {
			activityId = uv0.params_.activityId,
			subActivityId = uv0.activityIds_[uv0.curIndex_]
		})
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("MARDUK_SPECIAL_NOTE")
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.activityIds_ = ActivityCfg[slot0.params_.activityId].sub_activity_list

	for slot4, slot5 in ipairs(slot0.activityIds_) do
		if not slot0.items_[slot4] then
			slot0.items_[slot4] = slot0:CreateItem(slot4)
		end

		slot0.items_[slot4]:SetData(slot4, slot0.params_.activityId, slot5)
	end

	manager.redPoint:bindUIandKey(slot0.rewardbtntrans_, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.FACTORY_MARDUK))
	slot0:StartTimer()
	slot0:UpdateTimer()
end

function slot0.OnExit(slot0)
	AnimatorTools.Stop()
	slot0:StopTimer()
	slot0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(slot0.rewardbtntrans_, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.FACTORY_MARDUK))
	manager.windowBar:HideBar()
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.CreateItem(slot0, slot1)
	slot3 = MardukSpecialItemView.New(slot0["item" .. slot1 .. "Go_"])

	slot3:SetItemSelectHandler(handler(slot0, slot0.OnNodeSelect))

	return slot3
end

function slot0.OnNodeSelect(slot0, slot1, slot2)
	if not slot2 then
		slot0.items_[slot0.curIndex_]:ShowSelect(false)

		slot0.curIndex_ = nil

		slot0:UpdateView()

		return
	end

	if slot0.curIndex_ ~= nil and slot1 == slot0.curIndex_ then
		return
	end

	slot0:SetSelect(slot1)
end

function slot0.SetSelect(slot0, slot1)
	if slot0.curIndex_ then
		slot0.items_[slot0.curIndex_]:ShowSelect(false)
	end

	slot0.curIndex_ = slot1

	if slot0.curIndex_ then
		slot0:ScrollToItem(slot1)
	end

	slot0:UpdateView()
end

function slot0.ScrollToItem(slot0, slot1)
	slot2 = slot0.container_.rect.width

	if 21 + 491 * (slot1 - 1) + 1091 / 2 - slot0.scrollViewTransform_.rect.width / 2 < 0 then
		slot6 = 0
	end

	slot0.container_.localPosition.x = -slot6

	LeanTween.moveLocalX(slot0.container_.gameObject, -slot6, 0.2)
	slot0.items_[slot1]:ShowSelect(true)
end

function slot0.UpdateView(slot0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contenttrans_)

	slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr(ActivityData:GetActivityData(slot0.params_.activityId).stopTime)
end

function slot0.UpdateTimer(slot0)
	slot1 = false
	slot2 = 0

	for slot6, slot7 in ipairs(slot0.activityIds_) do
		if #ActivityCfg[slot7].sub_activity_list > 0 then
			if slot2 == 0 then
				slot2 = slot7
			end

			if ActivityData:GetActivityIsOpen(slot7) then
				slot1 = true

				break
			end
		end
	end

	slot0.rankOpen_ = slot1

	if slot1 then
		slot0.rankLockController_:SetSelectedState("false")
	else
		slot0.rankLockController_:SetSelectedState("true")

		slot4 = ActivityData:GetActivityData(slot2).stopTime

		if ActivityData:GetActivityData(slot2).stopTime < manager.time:GetServerTime() then
			slot0.timeLabel_.text = GetTips("TIME_OVER")
		else
			slot0.timeLabel_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(slot2).startTime))
		end
	end

	if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0.params_.activityId).stopTime then
		slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr(slot4)
	else
		slot0.lastTimeLabel_.text = GetTips("TIME_OVER")
	end

	for slot8, slot9 in pairs(slot0.items_) do
		slot9:UpdateTime()
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.items_ then
		for slot4, slot5 in pairs(slot0.items_) do
			slot5:Dispose()
		end

		slot0.items_ = nil
	end

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
