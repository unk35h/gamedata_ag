slot0 = class("StrategyMatrixThorView", ReduxView)

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/EmptyDream/ThorRoguelike/ThorRoguelikeMapUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.showDropDownConrtoller = ControllerUtil.GetController(slot0.m_dropDownBtn.transform, "showDropDown")
	slot0.difficultyController = ControllerUtil.GetController(slot0.m_dropDownBtn.transform, "difficulty")
	slot0.hardLockController = ControllerUtil.GetController(slot0.m_levelBtn2.transform, "lock")
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
			matrix_activity_id = uv0.matrix_activity_id,
			heroId = StrategyMatrixData:GetMatrixHeroTeam(uv0.matrix_activity_id)[1]
		})
	end)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		JumpTools.OpenPageByJump("strategyMatrixRward", {
			matrix_activity_id = uv0.matrix_activity_id
		})
	end)
	slot0:AddBtnListener(slot0.m_dropDownBtn, nil, function ()
		if uv0.showDropDownConrtoller:GetSelectedState() == "hide" then
			uv0.showDropDownConrtoller:SetSelectedState("show")
		else
			uv0.showDropDownConrtoller:SetSelectedState("hide")
		end
	end)
	slot0:AddBtnListener(slot0.m_levelBtn1, nil, function ()
		uv0.showDropDownConrtoller:SetSelectedState("hide")
		uv0:OnDropDownClick(1)
	end)
	slot0:AddBtnListener(slot0.m_levelBtn2, nil, function ()
		uv0.showDropDownConrtoller:SetSelectedState("hide")

		if ActivityTools.GetActivityIsOpenWithTip(ActivityConst.STRATEGY_MATRIX_THOR_HARD) then
			if StrategyMatrixData:GetIsClearance(ActivityConst.STRATEGY_MATRIX_THOR) then
				uv0:OnDropDownClick(2)
			else
				ShowTips("THOR_STRATEGY_UNLOCK")
			end
		end
	end)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		uv0.showDropDownConrtoller:SetSelectedState("hide")
	end)
	slot0:AddBtnListener(slot0.m_storyBtn, nil, function ()
		JumpTools.OpenPageByJump("/strategyMatrixThorStoryReview")
	end)
end

function slot0.InitBar(slot0)
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
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:Refresh()

	slot1 = slot0.params_.matrix_activity_id
	slot0.timer = Timer.New(function ()
		uv0:RefrenTime()
	end, 1, -1)

	slot0.timer:Start()
end

function slot0.OnUpdate(slot0)
	slot0:Refresh()
	slot0:InitBar()
end

function slot0.OnTop(slot0)
	slot0:InitBar()

	if slot0.map then
		slot0.map:OnTop()
	end
end

function slot0.Refresh(slot0)
	if slot0.matrix_activity_id == slot0.params_.matrix_activity_id then
		return
	end

	slot0.showDropDownConrtoller:SetSelectedState("hide")

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
	StrategyMatrixAction.SetStrategyRead(ActivityConst.STRATEGY_MATRIX_THOR)
	StrategyMatrixAction.SetStrategyRead(ActivityConst.STRATEGY_MATRIX_THOR_HARD)
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, slot0.matrix_activity_id))

	slot1 = ActivityConst.STRATEGY_MATRIX_THOR_HARD == slot0.matrix_activity_id

	if StrategyMatrixData:GetTierID(slot0.matrix_activity_id) and StrategyMatrixTierTemplateCfg[slot2] then
		slot0.m_title.text = GetTips("THOR_STRATEGY_TITLE_" .. StrategyMatrixTierTemplateCfg[slot2].tier)
		slot4 = {
			"EDream_bg_0137",
			"EDream_bg_0138",
			"EDream_bg_0139",
			"EDream_bg_0140"
		}
		slot5 = {
			"EDream_bg_0147",
			"EDream_bg_0148",
			"EDream_bg_0149",
			"EDream_bg_0150"
		}

		if slot1 then
			slot0.m_bg.sprite = getSpriteWithoutAtlas("Textures/EmptyDream/" .. slot5[slot3.tier])
		else
			slot0.m_bg.sprite = getSpriteWithoutAtlas("Textures/EmptyDream/" .. slot4[slot3.tier])
		end
	else
		slot0.m_title.text = ""
	end

	slot0.m_difficultyLab.text = slot1 and GetTips("HARDLEVEL_HARD") or GetTips("HARDLEVEL_EASY")

	slot0.difficultyController:SetSelectedIndex(slot1 and 1 or 0)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.map then
		slot0.map:Exit()
	end

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, slot0.matrix_activity_id))

	slot0.matrix_activity_id = nil
end

function slot0.RefrenTime(slot0)
	if ActivityData:GetActivityData(slot0.matrix_activity_id) and slot1:IsActivitying() then
		slot0.m_timeLab.text = manager.time:GetLostTimeStr(slot1.stopTime)
	else
		slot0.m_timeLab.text = GetTips("TIME_OVER")
	end

	if ActivityData:GetActivityIsOpen(ActivityConst.STRATEGY_MATRIX_THOR_HARD) and StrategyMatrixData:GetIsClearance(ActivityConst.STRATEGY_MATRIX_THOR) then
		slot0.hardLockController:SetSelectedIndex(0)
	else
		slot0.hardLockController:SetSelectedIndex(1)
	end
end

function slot0.OnDropDownClick(slot0, slot1)
	StrategyMatrixData:SetDifficultySelect(slot1)

	slot2 = nil

	StrategyMatrixAction.GotoStrategyMatrix((slot1 ~= 2 or not ActivityData:GetActivityIsOpen(ActivityConst.STRATEGY_MATRIX_THOR_HARD) or ActivityConst.STRATEGY_MATRIX_THOR_HARD) and ActivityConst.STRATEGY_MATRIX_THOR, true)
end

function slot0.Dispose(slot0)
	if slot0.map then
		slot0.map:Dispose()
	end

	slot0.map = nil

	uv0.super.Dispose(slot0)
end

return slot0
