slot1 = class("SlayerMainView_1_7", import("game.views.activity.Submodule.slayer.volume.VolumeSlayerMainView"))

function slot1.OnEnter(slot0)
	slot0.slayer_activity_id = slot0.params_.slayer_activity_id or 0

	slot0:RefreshTime()

	slot0.timer = Timer.New(function ()
		uv0:RefreshTime()
	end, 1, -1)

	slot0.timer:Start()
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, slot0.slayer_activity_id))
	manager.redPoint:bindUIandKey(slot0.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot0.slayer_activity_id))
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		JumpTools.OpenPageByJump("slayerRewardView_1_7", {
			slayer_activity_id = uv0.slayer_activity_id
		})
	end)
	slot0:AddBtnListener(slot0.m_entrustBtn, nil, function ()
		if not ActivityTools.GetActivityIsOpenWithTip(uv0.slayer_activity_id, true) then
			return
		end

		JumpTools.OpenPageByJump("/slayerStageView_1_7", {
			init_tag = true,
			slayer_activity_id = uv0.slayer_activity_id
		})
	end)
end

function slot1.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SOLO_SLAYER_DESCRIPE")
	slot0:PlayAudio()
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:StopAudio()
end

function slot1.PlayAudio(slot0)
	manager.audio:PlayEffect("minigame_activity_1_7", "minigame_activity_1_7_Sword_loop", "")
end

function slot1.StopAudio(slot0)
	manager.audio:StopEffect()
end

return slot1
