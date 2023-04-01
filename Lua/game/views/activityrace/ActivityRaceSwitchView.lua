slot0 = class("ActivityRaceSwitchView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIDownUI/ActivityRace/ActivityRaceSwitchUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.selectStageItemHandler_ = handler(slot0, slot0.OnSelectStageItem)
	slot0.selectAffixItemHandler_ = handler(slot0, slot0.OnSelectAffixItem)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.raceController_ = ControllerUtil.GetController(slot0.transform_, "race")
	slot0.indexController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "index")
	slot0.stageItemList_ = {}
	slot2 = nil

	for slot6 = 1, slot0.stagePanelTrans_.childCount do
		slot0.stageItemList_[slot6] = ActivityRaceStageItem.New(slot0.stagePanelTrans_:GetChild(slot6 - 1).gameObject)
	end

	slot0.affixItemList_ = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0.indexController_:SetSelectedIndex(0)
			uv0:RefreshSelectStageItem(0)
		end

		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		slot2 = {}
		slot6 = ActivityShopCfg[ActivityRaceCfg[uv0.activityID_].main_activity_id].activity_theme

		for slot6, slot7 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[slot6]) do
			table.insert(slot2, ActivityShopCfg[slot7].shop_id)
		end

		slot3, slot4 = ShopTools.IsShopOpen(slot1.shop_id)

		if slot3 then
			JumpTools.GoToSystem("/shop", {
				shopId = slot1.shop_id,
				showShops = slot2
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif slot4 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif slot4 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0.indexController_:SetSelectedIndex(0)
			uv0:RefreshSelectStageItem(0)
		end

		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("activityRaceRewardPanel", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0.indexController_:SetSelectedIndex(0)
			uv0:RefreshSelectStageItem(0)
		end
	end)

	slot1 = slot0.scrollViewEvent_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
		end
	end))
end

function slot0.OnEnter(slot0)
	slot0.indexController_:SetSelectedIndex(0)
	slot0:RefreshSelectStageItem(0)

	slot0.activityID_ = slot0.params_.activityID
	slot0.stageIDList_ = ActivityRaceCfg[slot0.activityID_].stage_list
	slot0.unlockStageList_ = ActivityRaceData:GetStateList()[slot0.activityID_].unlockStageList

	slot0:RegisterRedPoint()
	slot0:RefreshUI()
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	slot1 = manager.windowBar

	slot1:SetGameHelpKey("ACTIVITY_RACE_DESCRIPE")

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0.indexController_:SetSelectedIndex(0)
			uv0:RefreshSelectStageItem(0)
		else
			JumpTools.Back()
		end
	end)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in ipairs(slot0.stageItemList_) do
		slot5:OnExit()
	end

	slot0:UnRegisterRedPoint()
	SetActive(slot0.affixinfoTrs_.gameObject, false)

	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end

	slot0.selectStageID_ = nil
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.stageItemList_) do
		slot5:Dispose()
	end

	for slot4, slot5 in ipairs(slot0.affixItemList_) do
		slot5:Dispose()
	end

	slot0.affixItemList_ = nil
	slot0.selectStageItemHandler_ = nil
	slot0.selectAffixItemHandler_ = nil

	slot0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshStageItem()
	slot0:RefreshAffixItem()
	slot0:RefreshRaceBuff()
	slot0.raceController_:SetSelectedState(tostring(ActivityRaceCfg[slot0.activityID_].race_id))
end

function slot0.RefreshStageItem(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(slot0.stageItemList_) do
		slot6:SetData(slot0.activityID_, slot0.stageIDList_[slot5], slot5, slot0.unlockStageList_[slot0.stageIDList_[slot5]] == nil)
		slot6:SetSelectCallBack(slot0.selectStageItemHandler_)
	end
end

function slot0.OnSelectStageItem(slot0, slot1, slot2)
	slot0.indexController_:SetSelectedIndex(slot1)
	slot0:RefreshSelectStageItem(slot2)

	if slot0:IsOpenSectionView() then
		JumpTools.Back()
	end
end

function slot0.RefreshSelectStageItem(slot0, slot1)
	slot0.selectStageID_ = slot1

	for slot5, slot6 in ipairs(slot0.stageItemList_) do
		slot6:RefreshSelect(slot0.selectStageID_)
	end
end

function slot0.RefreshAffixItem(slot0)
	slot0.affixIDList_ = ActivityRaceCfg[slot0.activityID_].buff_pool
	slot4 = slot0.activityID_
	slot0.unlockAffixList_ = ActivityRaceData:GetUnlockAffixList(slot4)

	for slot4, slot5 in ipairs(slot0.affixIDList_) do
		if slot0.affixItemList_[slot4] == nil then
			slot0.affixItemList_[slot4] = ActivityRaceAffixItem.New(slot0.affixItemTemplate_, slot0.affixpanelTrans_)
		end

		slot7 = nil

		if slot0.unlockAffixList_[slot5] ~= nil == true then
			slot7 = ActivityAffixPoolCfg[slot0.unlockAffixList_[slot5]].affix[2]
		end

		slot0.affixItemList_[slot4]:SetData(slot4, slot5, slot7, slot6)
		slot0.affixItemList_[slot4]:RegistSelectCallBack(slot0.selectAffixItemHandler_)
	end

	for slot4 = #slot0.affixItemList_, #slot0.affixIDList_ + 1, -1 do
		slot0.affixItemList_[slot4]:SetActive(false)
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot5 = nil

	if slot0.unlockAffixList_[slot0.affixIDList_[slot1]] ~= nil == true then
		slot5 = slot0.unlockAffixList_[slot3][2]
	end

	slot2:SetData(slot1, slot3, slot5, slot4)
	slot2:RegistSelectCallBack(slot0.selectAffixItemHandler_)
end

function slot0.RefreshRaceBuff(slot0)
	slot0.raceBuffDesc.text = getAffixDesc(ActivityAffixPoolCfg[ActivityRaceCfg[slot0.activityID_].race_buff].affix)
end

function slot0.OnSelectAffixItem(slot0, slot1, slot2, slot3)
	slot3 = slot3 and slot3 or 1

	if slot0:IsOpenSectionView() then
		JumpTools.Back()
	end

	slot0.affixinfoTrs_:SetParent(slot0.affixItemList_[slot1].transform_)

	slot0.affixinfoTrs_.localPosition = Vector3(0, 0, 0)

	slot0.affixinfoTrs_:SetParent(slot0.transform_)

	if AffixTypeCfg[slot2] == nil then
		-- Nothing
	end

	if slot4.description[slot3] == nil then
		-- Nothing
	end

	slot0.affixcontentText_.text = GetCfgDescription(slot4.description[slot3], slot3)
	slot0.affixnameText_.text = slot4.name

	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end

	slot0.countdownTimer_ = Timer.New(function ()
		SetActive(uv0.affixinfoTrs_.gameObject, false)
	end, 2, 1)

	slot0.countdownTimer_:Start()
	SetActive(slot0.affixinfoTrs_.gameObject, true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.affixInfoDescTrans_)
end

function slot0.IsOpenSectionView(slot0)
	return slot0:IsOpenRoute("activityRaceSectionInfo")
end

function slot0.RegisterRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.rewardBtnTrans_, string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, ActivityRaceCfg[slot0.activityID_].main_activity_id, slot0.activityID_))
end

function slot0.UnRegisterRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardBtnTrans_, string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, ActivityRaceCfg[slot0.activityID_].main_activity_id, slot0.activityID_))
end

return slot0
