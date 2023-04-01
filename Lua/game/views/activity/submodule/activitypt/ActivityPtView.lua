slot0 = class("ActivityPtView", ReduxView)

function slot0.UIName(slot0)
	return ActivityPtTools.GetMainUIName(slot0.params_.activityId)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.indexController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "index")
	slot0.btns_ = {}
	slot0.selectedControllers_ = {}
	slot4 = slot0.params_.activityId

	for slot4, slot5 in ipairs(ActivityPtRepeatCfg.get_id_list_by_activity_id[slot4]) do
		table.insert(slot0.btns_, slot0["btn" .. slot4 .. "_"])
		table.insert(slot0.selectedControllers_, ControllerUtil.GetController(slot0["btn" .. slot4 .. "_"].transform, "status"))
	end
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.indexController_

	slot1:AddSelectChangeListener(function (slot0)
		uv0:SelectIndex(slot0)
	end)

	slot4 = slot0.exchangeBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0.indexController_:SetSelectedIndex(0)
		end

		slot1 = {}
		slot5 = ActivityShopCfg[uv0.params_.activityId].activity_theme

		for slot5, slot6 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[slot5]) do
			if ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[slot6].shop_id].activity_id) and slot8:IsActivitying() then
				table.insert(slot1, ActivityShopCfg[slot6].shop_id)
			end
		end

		slot2, slot3 = ShopTools.IsShopOpen(slot0.shop_id)

		if slot2 then
			JumpTools.GoToSystem("/shop", {
				shopId = slot0.shop_id,
				showShops = slot1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif slot3 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif slot3 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)

	for slot4, slot5 in ipairs(slot0.btns_) do
		slot0:AddBtnListener(slot5, nil, function ()
			if not ActivityData:GetActivityData(uv0.params_.activityId):IsActivitying() then
				ShowTips("SOLO_TIME_OVER")

				return
			end

			uv0:EnterLevel(uv1)
		end)
	end

	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0.indexController_:SetSelectedIndex(0)
		end
	end)

	if slot0.eventTrigger_ then
		slot1 = slot0.eventTrigger_

		slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
			if uv0:IsOpenSectionView() then
				JumpTools.Back()
			end

			uv0.drag_ = true
		end))

		slot1 = slot0.eventTrigger_

		slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
			uv0.drag_ = false
		end))
	end
end

function slot0.SelectIndex(slot0, slot1)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.EnterLevel(slot0, slot1)
	slot0.indexController_:SetSelectedIndex(slot1)

	slot2 = ActivityPtRepeatCfg.get_id_list_by_activity_id[slot0.params_.activityId][slot1]

	JumpTools.OpenPageByJump("activityPtSectionInfo", {
		index = slot1,
		section = ActivityPtRepeatCfg[slot2].stage_id,
		sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME,
		activityId = slot0.params_.activityId,
		repeat_id = slot2
	})
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
	slot0.indexController_:SetSelectedIndex(0)
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:RegistBackCallBack(function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0.indexController_:SetSelectedIndex(0)
		else
			JumpTools.Back()
		end
	end)
	manager.windowBar:SetGameHelpKey(ActivityPtTools.GetHelpKey(slot0.params_.activityId))
end

function slot0.OnEnter(slot0)
	if not slot0.activityID_ or slot0.activityID_ ~= slot0.params_.activityId then
		slot0.activityID_ = slot0.params_.activityId

		slot0:ReLoad()
	end

	slot0:AddEventListeners()
	slot0:PlayEnterVoice()
	saveData("activity_pt_" .. slot0.params_.activityId, "opened", 1)
	manager.redPoint:setTip(RedPointConst.SUMMER_ACTIVITY_PT_OPEN .. "_" .. slot0.params_.activityId, 0)

	if slot0.params_.index then
		slot0.indexController_:SetSelectedIndex(slot0.params_.index)
	end

	slot0:RefreshTime()

	for slot5, slot6 in ipairs(slot0.selectedControllers_) do
		if SummerActivityPtData:GetLevelChallengeCount(ActivityPtRepeatCfg.get_id_list_by_activity_id[slot0.params_.activityId][slot5]) > 0 then
			slot6:SetSelectedIndex(1)
		else
			slot6:SetSelectedIndex(0)
		end
	end
end

function slot0.ReLoad(slot0)
	if slot0.gameObject_ then
		slot0:Dispose()
		Object.Destroy(slot0.gameObject_)
	end

	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:UIName()), slot0:UIParent())
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.PlayEnterVoice(slot0)
	slot1, slot2, slot3, slot4 = ActivityPtTools.GetEnterVoice(slot0.params_.activityId)

	if slot1 then
		manager.audio:PlayEffect(slot2, slot3, slot4)
	end
end

function slot0.RefreshTime(slot0)
	slot1 = nil
	slot2 = manager.time:GetServerTime()
	slot3 = ActivityData:GetActivityData(slot0.params_.activityId)
	slot5 = slot3.stopTime
	slot9 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[slot0.params_.activityId].shop_id].activity_id).stopTime - slot2

	slot0:StopTimer()

	if slot2 < slot3.startTime and slot3:IsActivitying() == false then
		slot0.timeLabel_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1 - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv2:StopTimer()
				uv2:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot2 < slot5 or slot2 < slot8 then
		if slot2 < slot5 then
			slot0.timeLabel_.text = manager.time:GetLostTimeStr2(slot5)
		else
			slot0.timeLabel_.text = GetTips("TIME_OVER")
		end

		if slot0.shopTimeGo_ then
			if slot9 <= GameSetting.time_remaining_show.value[1] * 86400 then
				slot0.shopTimeLabel_.text = manager.time:GetLostTimeStr2(slot8)

				SetActive(slot0.shopTimeGo_, true)
			else
				SetActive(slot0.shopTimeGo_, false)
			end
		end

		slot0.timer_ = Timer.New(function ()
			uv0 = manager.time:GetServerTime()
			uv1 = uv2 - uv0
			uv3 = uv4 - uv0

			if uv1 <= 0 and uv3 <= 0 then
				uv5:StopTimer()
				uv5:RefreshTime()

				return
			end

			if uv0 < uv2 then
				uv5.timeLabel_.text = manager.time:GetLostTimeStr2(uv2)
			else
				uv5.timeLabel_.text = GetTips("TIME_OVER")
			end

			if uv5.shopTimeGo_ then
				if uv3 <= GameSetting.time_remaining_show.value[1] * 86400 then
					uv5.shopTimeLabel_.text = manager.time:GetLostTimeStr2(uv4)

					SetActive(uv5.shopTimeGo_, true)
				else
					SetActive(uv5.shopTimeGo_, false)
				end
			end
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeLabel_.text = GetTips("TIME_OVER")
		slot0.shopTimeLabel_.text = GetTips("TIME_OVER")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.audio:Stop("effect")
	slot0.indexController_:SetSelectedState(-1)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.IsOpenSectionView(slot0)
	return slot0:IsOpenRoute("activityPtSectionInfo")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
