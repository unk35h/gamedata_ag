slot0 = class("VolumeSlayerView", ReduxView)

function slot0.UIName(slot0)
	return SlayerTools.GetSelectUIName(slot0.params_.slayer_activity_id or 0)
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

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, VolumeSlayerItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		JumpTools.OpenPageByJump("hellaSlayerReward", {
			slayer_activity_id = uv0.slayer_activity_id,
			region_activity_id = uv0.regionList[uv0.selectIndex]
		})
	end)
	slot0:AddBtnListener(slot0.m_entrustBtn, nil, function ()
		slot0 = uv0.regionList[uv0.selectIndex]

		uv0:Go("/sectionSelectHeroSlayer", {
			section = ActivitySlayerCfg[slot0].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SLAYER,
			region_activity_id = slot0,
			activityID = uv0.slayer_activity_id
		})
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_VOLUME_SLAYER_DESCRIPE")
end

function slot0.OnEnter(slot0)
	slot0.slayer_activity_id = slot0.params_.slayer_activity_id or 0
	slot0.regionList = ActivityCfg[slot0.slayer_activity_id] and slot1.sub_activity_list or {}

	if slot0.params_.init_tag and not ActivityData:GetActivityIsOpen(slot0.regionList[slot0.selectIndex]) then
		slot0.params_.init_tag = nil

		for slot5, slot6 in ipairs(slot0.regionList) do
			if ActivityData:GetActivityIsOpen(slot6) then
				slot0.selectIndex = slot5

				break
			end
		end
	end

	if slot0.params_.region_activity_id then
		slot0.selectIndex = table.indexof(slot0.regionList, slot0.params_.region_activity_id) or 1
		slot0.params_.region_activity_id = nil
	end

	slot0.selectIndex = slot0.selectIndex or 1

	slot0.list:StartScroll(#slot0.regionList, slot0.selectIndex, true)
	SlayerAction.SetSlayerRead(slot0.regionList[slot0.selectIndex])

	slot0.timer = Timer.New(function ()
		uv0:OnTimerEvent()
	end, 1, -1)

	slot0.timer:Start()
	slot0:Refresh()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

function slot0.OnTimerEvent(slot0)
	for slot5, slot6 in ipairs(slot0.list:GetItemList()) do
		slot6:RefreshTime()
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.regionList[slot1]
	slot4 = false

	if slot1 == #slot0.regionList then
		slot4 = true
	end

	slot2:SetData(slot1, slot0.slayer_activity_id, slot3, slot4)
	slot2:SetSelectedIndex(slot0.selectIndex)
	slot2:RegistCallBack(handler(slot0, slot0.SetSelectIndex))
end

function slot0.SetSelectIndex(slot0, slot1)
	if slot1 == slot0.selectIndex then
		return
	end

	if slot1 ~= 0 then
		if not ActivityTools.GetActivityIsOpenWithTip(slot0.regionList[slot1], true) then
			return
		end

		SlayerAction.SetSlayerRead(slot2)
	end

	slot0.selectIndex = slot1

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	for slot5, slot6 in pairs(slot0.list:GetItemList()) do
		slot6:SetSelectedIndex(slot0.selectIndex)
	end

	slot4 = ActivitySlayerCfg[slot0.regionList[slot0.selectIndex]] and slot3.buff_desc or {}
	slot5 = ""

	for slot9, slot10 in ipairs(slot4) do
		slot5 = slot5 .. slot10 .. "\n"
	end

	slot0.m_buffDes.text = slot5
	slot7 = BattleSlayerStageCfg[slot3.stage_id]
	slot0.m_title.text = slot7.name
	slot0.m_des.text = slot7.tips

	manager.redPoint:SetRedPointIndependent(slot0.m_rewardBtn.transform, SlayerAction.GetSlayerRewardState(slot0.slayer_activity_id, slot2))
end

function slot0.Dispose(slot0)
	slot0.selectIndex = nil

	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnSlayerReward(slot0)
	slot0:Refresh()
end

return slot0
