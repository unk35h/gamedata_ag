slot0 = class("VolumeSlayerMainView", ReduxView)

function slot0.UIName(slot0)
	return SlayerTools.GetMainUIName(slot0.params_.slayer_activity_id or 0)
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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		JumpTools.OpenPageByJump("hellaSlayerReward", {
			slayer_activity_id = uv0.slayer_activity_id
		})
	end)
	slot0:AddBtnListener(slot0.m_entrustBtn, nil, function ()
		if not ActivityTools.GetActivityIsOpenWithTip(uv0.slayer_activity_id, true) then
			return
		end

		JumpTools.OpenPageByJump("/volumeSlayer", {
			init_tag = true,
			slayer_activity_id = uv0.slayer_activity_id
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
	if slot0.params_.playerAnim then
		slot0.m_animator:Play("VolumeCutgrassMainUI", 0, 0)

		slot0.params_.playerAnim = nil
	else
		slot0.m_animator:Play("VolumeCutgrassMainUI", 0, 9999999)
	end

	slot0.slayer_activity_id = slot0.params_.slayer_activity_id or 0

	slot0:RefreshTime()

	slot0.timer = Timer.New(function ()
		uv0:RefreshTime()
	end, 1, -1)

	slot0.timer:Start()
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, slot0.slayer_activity_id))
	manager.redPoint:bindUIandKey(slot0.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot0.slayer_activity_id))
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, slot0.slayer_activity_id))
	manager.redPoint:unbindUIandKey(slot0.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot0.slayer_activity_id))
end

function slot0.RefreshTime(slot0)
	if ActivityData:GetActivityData(slot0.slayer_activity_id) then
		slot0.m_timeLab.text = manager.time:GetLostTimeStr(slot1.stopTime)
	else
		slot0.m_timeLab.text = GetTips("TIME_OVER")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
