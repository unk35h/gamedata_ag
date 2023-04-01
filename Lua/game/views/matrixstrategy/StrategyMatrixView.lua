slot0 = class("StrategyMatrixView", ReduxView)

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/VolumeIIIDownUI/OceanusRoguelike/StrategyMatrixMapUI"
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

	slot0.map = nil
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_giveUpBtn, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_MATRIX"),
			OkCallback = function ()
				StrategyMatrixAction.QueryMatrixGiveUp(uv0.matrix_activity_id)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.m_infoBtn, nil, function ()
		JumpTools.OpenPageByJump("/strategyMatrixHero", {
			matrix_activity_id = ActivityConst.OSHINAS_MATRIX,
			heroId = StrategyMatrixData:GetMatrixHeroTeam(ActivityConst.OSHINAS_MATRIX)[1]
		})
	end)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		JumpTools.OpenPageByJump("strategyMatrixRward", {
			matrix_activity_id = ActivityConst.OSHINAS_MATRIX
		})
	end)
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})

	slot1 = manager.windowBar

	slot1:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(slot0.matrix_activity_id))

	slot1 = manager.windowBar

	slot1:SetActivityId(ACTIVITY_MATRIX_COIN, slot0.matrix_activity_id)

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0.map then
			uv0.map:GoBack()
		else
			uv0:Back()
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id
	slot0.mapId = StrategyMatrixData:GetMapId(slot0.matrix_activity_id)

	if slot0.map and slot0.mapId ~= slot0.map:GetMapId() then
		slot0.map:Dispose()

		slot0.map = nil
	end

	slot0.map = slot0.map or StrategyMatrixMap.New(slot0.mapId, slot0.m_content)

	slot0.map:SetData(slot0.matrix_activity_id)

	if slot0.params_.playerAnim then
		slot0.m_animator:Play("StrategyMatrixMapUI", 0, 0)

		slot0.params_.playerAnim = nil

		slot0.map:PlayerAnim(true)
	else
		slot0.m_animator:Play("StrategyMatrixMapUI", 0, 9999999)
		slot0.map:PlayerAnim(false)
	end

	slot0:RefrenTime()

	slot0.timer = Timer.New(function ()
		uv0:RefrenTime()
	end, 1, -1)

	slot0.timer:Start()
	StrategyMatrixAction.SetStrategyRead(slot0.matrix_activity_id)
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, slot0.matrix_activity_id))

	slot1 = {
		"VolumeDown_bg_00418",
		"VolumeDown_bg_00419",
		"VolumeDown_bg_00420",
		"VolumeDown_bg_00421"
	}

	if StrategyMatrixData:GetTierID(slot0.matrix_activity_id) and StrategyMatrixTierTemplateCfg[slot2] then
		slot3 = StrategyMatrixTierTemplateCfg[slot2]
		slot0.m_title.text = GetTips("ACTIVITY_STRATEGY_TITLE_" .. slot3.tier)
		slot0.m_bg.sprite = getSpriteWithoutAtlas("Textures/VolumeIIIDownUI/" .. slot1[slot3.tier])
	else
		slot0.m_title.text = ""
	end
end

function slot0.OnExit(slot0)
	if slot0.map then
		slot0.map:Exit()
	end

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, slot0.matrix_activity_id))
end

function slot0.RefrenTime(slot0)
	if ActivityData:GetActivityData(slot0.matrix_activity_id) and slot1:IsActivitying() then
		slot0.m_timeLab.text = manager.time:GetLostTimeStr(slot1.stopTime)
	else
		slot0.m_timeLab.text = GetTips("TIME_OVER")
	end
end

function slot0.Dispose(slot0)
	if slot0.map then
		slot0.map:Dispose()
	end

	slot0.map = nil

	uv0.super.Dispose(slot0)
end

return slot0
