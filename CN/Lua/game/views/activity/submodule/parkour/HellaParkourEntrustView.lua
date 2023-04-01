slot0 = class("HellaParkourEntrustView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/HellaUI/Parkour/HellaParkourEntrustUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.entrustList = LuaList.New(handler(slot0, slot0.IndexEntrustItem), slot0.m_entrustList, HellaParkourEntrustItem)
	slot0.targetList = LuaList.New(handler(slot0, slot0.IndexTargetItem), slot0.m_targetList, HellaParkourTargetItem)
	slot0.specialTargetList = LuaList.New(handler(slot0, slot0.IndexSpecailTargetItem), slot0.m_specialTargetList, HellaParkourTargetItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		JumpTools.OpenPageByJump("hellaParkourReward", {
			parkour_activity_id = uv0.parkour_activity_id,
			entrust_activity_id = uv0.entrusts[uv0.selectIndex]
		})
	end)
	slot0:AddBtnListener(slot0.m_entrustBtn, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.entrusts[uv0.selectIndex]) then
			ShowTips("TIP_EXPIRED")

			return
		end

		BattleController.GetInstance():LaunchBattle(BattleParkourStageTemplate.New(slot0, uv0.parkour_activity_id))
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_HELLA_PARKOUR_DESCRIPE")
	slot0:Refresh()
end

function slot0.OnEnter(slot0)
	slot0.parkour_activity_id = slot0.params_.parkour_activity_id or 0
	slot0.entrusts = ActivityCfg[slot0.parkour_activity_id] and slot1.sub_activity_list or {}

	ParkourAction.SetParkourRead(slot0.parkour_activity_id)

	slot0.timer = Timer.New(function ()
		uv0:OnTimerEvent()
	end, 1, -1)

	slot0.timer:Start()

	if slot0.params_.entrust_activity_id and table.indexof(slot0.entrusts, slot0.params_.entrust_activity_id) and ActivityData:GetActivityIsOpen(slot0.params_.entrust_activity_id) then
		slot0:SetSelectIndex(slot2)
		slot0.entrustList:StartScroll(#slot0.entrusts, slot2)

		return
	end

	for slot5, slot6 in ipairs(slot0.entrusts) do
		if ActivityData:GetActivityIsOpen(slot6) then
			slot0:SetSelectIndex(slot5)
			slot0.entrustList:StartScroll(#slot0.entrusts, slot5)

			return
		end
	end

	slot0:SetSelectIndex(1)
	slot0.entrustList:StartScroll(#slot0.entrusts)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	slot0.selectIndex = nil

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

function slot0.OnTimerEvent(slot0)
	for slot5, slot6 in ipairs(slot0.entrustList:GetItemList()) do
		slot6:RefreshTime()
	end
end

function slot0.Refresh(slot0)
	slot1 = slot0.entrusts[slot0.selectIndex]
	slot2 = ActivityParkourCfg[slot1]
	slot0.m_title.text = slot2.name
	slot0.m_des.text = slot2.desc
	slot0.targetData = BattleParkourStageCfg[slot2.stage_id].three_star_need

	slot0.targetList:StartScroll(3)
	slot0.specialTargetList:StartScroll(1)
	manager.redPoint:SetRedPointIndependent(slot0.m_rewardBtn.transform, manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, slot1)))
end

function slot0.IndexEntrustItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.entrusts[slot1])
	slot2:SetSelectedIndex(slot0.selectIndex)
	slot2:RegistCallBack(handler(slot0, slot0.SetSelectIndex))
end

function slot0.SetSelectIndex(slot0, slot1)
	if slot1 == slot0.selectIndex then
		return
	end

	if slot1 ~= 0 and not ActivityData:GetActivityIsOpen(slot0.entrusts[slot1]) then
		slot4 = manager.time:GetServerTime()

		if ActivityData:GetActivityData(slot2) and slot4 < slot3.startTime then
			ShowTips(string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(slot3.startTime)))
		else
			ShowTips("TIME_OVER")
		end

		slot0.selectIndex = 1

		return
	end

	slot0.selectIndex = slot1

	for slot6, slot7 in pairs(slot0.entrustList:GetItemList()) do
		slot7:SetSelectedIndex(slot0.selectIndex)
	end

	slot0:Refresh()
end

function slot0.IndexTargetItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.entrusts[slot0.selectIndex], slot0.targetData[slot1], false)
end

function slot0.IndexSpecailTargetItem(slot0, slot1, slot2)
	slot3 = slot1 + 3

	slot2:SetData(slot3, slot0.entrusts[slot0.selectIndex], slot0.targetData[slot3], true)
end

function slot0.Dispose(slot0)
	slot0.entrustList:Dispose()
	slot0.targetList:Dispose()
	slot0.specialTargetList:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
