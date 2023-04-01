slot0 = class("ActivityPt2View", ReduxView)

function slot0.UIName(slot0)
	return ActivityPt2Tools.GetMainUIName(slot0.params_.mainActivityId)
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

	slot0.normalBtn_ = {}
	slot0.challengeBtn_ = {}
	slot0.hardBtn_ = {}
	slot0.normalCon_ = {}
	slot0.challengeCon_ = {}
	slot0.hardCon_ = {}
	slot5 = ActivityCfg[slot0.params_.mainActivityId].sub_activity_list[1]

	for slot5, slot6 in ipairs(ActivityPt2Cfg.get_id_list_by_activity_id[slot5]) do
		table.insert(slot0.normalBtn_, slot0["normalBtn_" .. slot5])
		table.insert(slot0.normalCon_, ControllerUtil.GetController(slot0["normalBtn_" .. slot5].transform, "status"))
	end

	slot5 = slot1[2]

	for slot5, slot6 in ipairs(ActivityPt2Cfg.get_id_list_by_activity_id[slot5]) do
		table.insert(slot0.challengeBtn_, slot0["challengeBtn_" .. slot5])
		table.insert(slot0.challengeCon_, ControllerUtil.GetController(slot0["challengeBtn_" .. slot5].transform, "status"))
	end

	slot5 = slot1[3]

	for slot5, slot6 in ipairs(ActivityPt2Cfg.get_id_list_by_activity_id[slot5]) do
		table.insert(slot0.hardBtn_, slot0["hardBtn_" .. slot5])
		table.insert(slot0.hardCon_, ControllerUtil.GetController(slot0["hardBtn_" .. slot5].transform, "status"))
	end

	slot0.tgl_ = {
		slot0.tgl_1,
		slot0.tgl_2,
		slot0.tgl_3
	}
	slot0.lockCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "lock")
	slot0.typeCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "type")
	slot0.indexCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "index")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0.indexCon_:SetSelectedIndex(0)
		end

		slot1 = {}
		slot5 = ActivityShopCfg[uv0.activityID_].activity_theme

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
	slot0:AddBtnListener(slot0.rankBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ActivityRaceAction.QueryRankList(uv0.rankID_, function ()
			uv0:Go("/activityRaceRank", {
				activityID = uv0.rankID_
			})
		end)
	end)

	slot4 = slot0.bgBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0.indexCon_:SetSelectedIndex(0)
		end
	end)

	for slot4, slot5 in ipairs(slot0.tgl_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				if uv0 ~= uv1.index_ then
					uv1.changeCanvas_.alpha = 0
					uv1.changeAni_.enabled = false

					manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_pt_whoosh", "")

					uv1.index_ = uv0
				end

				uv1.indexCon_:SetSelectedState(0)
				uv1.typeCon_:SetSelectedStateWithCallback(uv0, function ()
					uv0.changeAni_.enabled = true

					uv0.changeAni_:Play("eff_middle_cx", 0, 0)
				end)
				ActivityPt2Data:SetLastStage(uv1.activityID_, uv0, 1)
			end
		end)
	end

	for slot4, slot5 in ipairs(slot0.normalBtn_) do
		slot0:AddBtnListener(slot5, nil, function ()
			uv0:EnterLevel(1, uv1)
		end)
	end

	for slot4, slot5 in ipairs(slot0.challengeBtn_) do
		slot0:AddBtnListener(slot5, nil, function ()
			uv0:EnterLevel(2, uv1)
		end)
	end

	for slot4, slot5 in ipairs(slot0.hardBtn_) do
		slot0:AddBtnListener(slot5, nil, function ()
			uv0:EnterLevel(3, uv1)
		end)
	end

	slot0:AddBtnListener(slot0.lockBtn_, nil, function ()
		slot3 = ActivityPt2Cfg[ActivityPt2Cfg[ActivityPt2Cfg.get_id_list_by_activity_id[ActivityCfg[uv0.activityID_].sub_activity_list[3]][1]].pre_stage]

		ShowTips(string.format(GetTips("ACTIVITY_XUHENG_PT_EXLOCK"), slot3.time, BattleActivityPtStageV2ChallengeCfg[slot3.stage_id].name))
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

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshData()
	slot0:RefreshTime()
	slot0:RefreshState()
end

function slot0.RefreshData(slot0)
	slot0.activityID_ = slot0.params_.mainActivityId
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
end

function slot0.RefreshTime(slot0)
	slot1 = nil
	slot2 = manager.time:GetServerTime()
	slot3 = ActivityData:GetActivityData(slot0.params_.mainActivityId)
	slot5 = slot3.stopTime
	slot9 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[slot0.params_.mainActivityId].shop_id].activity_id).stopTime - slot2

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

function slot0.RefreshState(slot0)
	slot0.lockCon_:SetSelectedState(slot0:IsLockEx() and "true" or "false")

	slot3 = ActivityCfg[slot0.params_.mainActivityId].sub_activity_list
	slot4 = ActivityPt2Data:GetLastStage(slot0.activityID_) and slot2.type or 1

	slot0.typeCon_:SetSelectedState(slot4)

	slot0.index_ = slot4
	slot0.tgl_[slot4].isOn = true

	if slot0:IsOpenSectionView() and slot2 then
		slot0.indexCon_:SetSelectedState(slot2.type .. "_" .. slot2.index)
	else
		slot0.indexCon_:SetSelectedState(0)
	end

	for slot8, slot9 in ipairs(slot0.normalCon_) do
		if (ActivityPt2Data:GetNormalData(slot3[1], ActivityPt2Cfg.get_id_list_by_activity_id[slot3[1]][slot8]) and slot11.clear_time or 0) > 0 then
			slot9:SetSelectedState("get")
		else
			slot9:SetSelectedState("nor")
		end
	end

	for slot8, slot9 in ipairs(slot0.challengeCon_) do
		if (ActivityPt2Data:GetChallengeData(slot3[2], ActivityPt2Cfg.get_id_list_by_activity_id[slot3[2]][slot8]) and slot11.clear_time or 0) > 0 then
			slot9:SetSelectedState("get")
		else
			slot9:SetSelectedState("nor")
		end
	end

	for slot8, slot9 in ipairs(slot0.hardCon_) do
		if (ActivityPt2Data:GetHardData(slot3[3]) and slot10.clear_time or 0) > 0 then
			slot9:SetSelectedState("get")
		else
			slot9:SetSelectedState("nor")
		end
	end

	slot0.rankID_ = slot3[4]

	if ActivityPt2Data:GetHardData(slot3[3]) and slot5.clear_time > 0 then
		slot0.score_.text = ActivityPt2Data:GetExScore(slot3[3])
	else
		slot0.score_.text = GetTips("NO_RECORD")
	end
end

function slot0.EnterLevel(slot0, slot1, slot2)
	slot0.lockBtn_.interactable = false

	for slot6, slot7 in ipairs(slot0.tgl_) do
		slot7.interactable = false
	end

	ActivityPt2Data:SetLastStage(slot0.activityID_, slot1, slot2)
	slot0.indexCon_:SetSelectedState(slot1 .. "_" .. slot2)

	slot6 = nil

	JumpTools.OpenPageByJump("activityPt2SectionInfo", {
		section = ActivityPt2Cfg[ActivityPt2Cfg.get_id_list_by_activity_id[ActivityCfg[slot0.params_.mainActivityId].sub_activity_list[slot1]][slot2]].stage_id,
		sectionType = (slot1 ~= 1 or BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL) and (slot1 ~= 2 or BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE) and BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD,
		mainActivityId = slot0.activityID_,
		activityId = slot3,
		repeat_id = slot4,
		backCall = function ()
			uv0.indexCon_:SetSelectedIndex(0)
		end
	})
end

function slot0.IsLockEx(slot0)
	slot3 = ActivityPt2Cfg[ActivityPt2Cfg.get_id_list_by_activity_id[ActivityCfg[slot0.activityID_].sub_activity_list[3]][1]].pre_stage
	slot6 = ActivityPt2Cfg[slot3]

	if not ActivityPt2Data:GetChallengeData(ActivityCfg[slot0.params_.mainActivityId].sub_activity_list[2], slot3) or slot5.clear_time <= 0 then
		return true
	end

	return slot6.time < slot5.use_time
end

function slot0.IsOpenSectionView(slot0)
	return slot0:IsOpenRoute("activityPt2SectionInfo")
end

function slot0.OnTop(slot0)
	slot0.lockBtn_.interactable = true

	for slot4, slot5 in ipairs(slot0.tgl_) do
		slot5.interactable = true
	end

	slot2 = ActivityPt2Tools.GetChallengeCurrencyID(slot0.activityID_)

	if ActivityPt2Tools.GetHelpKey(slot0.activityID_) ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			slot2,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
		manager.windowBar:SetGameHelpKey(slot1)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			slot2,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
	end

	slot3 = manager.windowBar

	slot3:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)

	slot3 = manager.windowBar

	slot3:SetBarCanAdd(slot2, true)

	slot3 = manager.windowBar

	slot3:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)

	slot3 = manager.windowBar

	slot3:RegistBackCallBack(function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0.indexCon_:SetSelectedIndex(0)
		else
			JumpTools.Back()
		end
	end)
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.windowBar:HideBar()
	slot0.indexCon_:SetSelectedState(-1)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
