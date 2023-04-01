slot0 = class("ActivityMatrixView", ReduxView)

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeSoloRoguelikeMainUI"
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

	slot0.campController = ControllerUtil.GetController(slot0.m_titleTrans, "camp")
	slot0.entranceController = ControllerUtil.GetController(slot0.m_titleTrans, "entrance")
	slot0.maxCamp = 6
	slot0.rankActivityId = -1
	slot0.rotationDiagram = MatrixRotationDiagram2D.New(slot0.m_rotationDiagram, slot0.m_particle)
	slot0.clickTime = 0
	slot0.selectCamp = ActivityMatrixAction.GetSelectCamp()
	slot0.noticeController = ControllerUtil.GetController(slot0.m_particle.transform, "notice")
	slot0.particleController = ControllerUtil.GetController(slot0.m_particle.transform, "particle")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_storyBtn, nil, function ()
		JumpTools.OpenPageByJump("/activityMatrixStoryReview")
	end)
	slot0:AddBtnListener(slot0.m_clueBtn, nil, function ()
		JumpTools.OpenPageByJump("activityMatrixClue", {
			main_matrix_activity_id = uv0.main_matrix_activity_id
		})
	end)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		if not uv0.subActivityIdList[uv0.selectCamp] then
			return
		end

		JumpTools.OpenPageByJump("activityMatrixScoreExchange", {
			matrix_activity_id = slot0
		})
	end)
	slot0:AddBtnListener(slot0.m_rankBtn, nil, function ()
		if uv0.rankActivityId == -1 then
			return
		end

		JumpTools.OpenPageByJump("/activityMatrixRank", {
			activityId = uv0.rankActivityId
		})
	end)
	slot0:AddBtnListener(slot0.m_leftBtn, nil, function ()
		if Time.realtimeSinceStartup < uv0.clickTime + 0.4 then
			return
		end

		uv0.clickTime = Time.realtimeSinceStartup

		if uv0.selectCamp <= 1 then
			uv0.selectCamp = uv0.maxCamp
		else
			uv0.selectCamp = uv0.selectCamp - 1
		end

		ActivityMatrixAction.SetSelectCamp(uv0.selectCamp)

		uv0.params_.selectCamp = uv0.selectCamp

		uv0.rotationDiagram:Change(uv0.selectCamp)
		uv0:RefreshUI()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_activity_1_3_select", "")
	end)
	slot0:AddBtnListener(slot0.m_rightBtn, nil, function ()
		if Time.realtimeSinceStartup < uv0.clickTime + 0.5 then
			return
		end

		uv0.clickTime = Time.realtimeSinceStartup
		uv0.selectCamp = uv0.selectCamp % uv0.maxCamp + 1

		ActivityMatrixAction.SetSelectCamp(uv0.selectCamp)

		uv0.params_.selectCamp = uv0.selectCamp

		uv0.rotationDiagram:Change(uv0.selectCamp)
		uv0:RefreshUI()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_activity_1_3_select", "")
	end)
	slot0:AddBtnListener(slot0.m_clickBtn, nil, function ()
		uv0:StartMatrix()
	end)
end

function slot0.StartMatrix(slot0)
	if not slot0.subActivityIdList[slot0.selectCamp] then
		return
	end

	slot3 = ActivityMatrixCfg[slot1].preconditions
	slot4 = ActivityMatrixCfg[slot3]

	if slot3 ~= 0 and not ActivityMatrixData:GetIsClearance(slot3) then
		ShowTips(string.format(GetTips("ACTIVITY_MATRIX_PRECONDITIONS"), slot4.name))

		return
	end

	if not ActivityTools.GetActivityIsOpenWithTip(slot1) then
		return
	end

	if ActivityMatrixData:GetGameState(slot1) == MatrixConst.STATE_TYPE.SUCCESS or slot5 == MatrixConst.STATE_TYPE.FAIL then
		OpenPageUntilLoaded("/matrixBlank/activityMatrixOver", {
			matrix_activity_id = slot1
		})
	elseif slot5 == MatrixConst.STATE_TYPE.NOTSTARTED then
		OpenPageUntilLoaded("/activityMatrixSelectHero", {
			matrix_activity_id = slot1
		})
	elseif slot5 == MatrixConst.STATE_TYPE.STARTED then
		JumpTools.GoToSystem("/matrixBlank/activityMatrixOrigin", {
			matrix_activity_id = slot1
		})
	else
		error("activity matrix with error game state by id : " .. slot1 .. " gameState:" .. slot5)
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
end

function slot0.OnEnter(slot0)
	if slot0.params_.playerAnim then
		slot0.m_animator:Play("VolumeSoloRoguelikeMainUI", 0, 0)

		slot0.params_.playerAnim = nil
	else
		slot0.m_animator:Play("VolumeSoloRoguelikeMainUI", 0, 9999999)
	end

	slot0.main_matrix_activity_id = slot0.params_.main_matrix_activity_id
	slot0.subActivityIdList = ActivityCfg[slot0.main_matrix_activity_id] and ActivityCfg[slot0.main_matrix_activity_id].sub_activity_list or {}
	slot0.selectCamp = slot0.params_.selectCamp or slot0.selectCamp or 1

	if slot0.params_.matrix_activity_id then
		slot0.selectCamp = table.indexof(slot0.subActivityIdList, slot0.params_.matrix_activity_id) or slot0.selectCamp
		slot0.params_.matrix_activity_id = nil
	end

	slot0:RefreshUI()
	slot0.rotationDiagram:SetData(slot0.selectCamp)

	slot0.timer = Timer.New(function ()
		uv0:RefrenTime()
	end, 1, -1)

	slot0.timer:Start()
	SetActive(slot0.m_particle, true)
	manager.redPoint:bindUIandKey(slot0.m_clueBtn.transform, string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, slot0.main_matrix_activity_id))
end

function slot0.RefreshUI(slot0)
	slot0.campController:SetSelectedIndex(slot0.selectCamp - 1)

	slot1 = slot0.subActivityIdList[slot0.selectCamp]
	slot6 = slot1
	slot0.m_scoreLab.text = ActivityMatrixData:GetMatrixScore(slot6)

	slot0:RefrenTime()

	slot0.rankActivityId = -1

	for slot6, slot7 in ipairs(ActivityCfg[slot1].sub_activity_list) do
		if ActivityCfg[slot7] and ActivityTemplateConst.SINGLE_MATRIX_RANK == ActivityCfg[slot7].activity_template then
			slot0.rankActivityId = slot7

			break
		end
	end

	if slot0.rankActivityId == -1 then
		SetActive(slot0.m_rankBtn.gameObject, false)
	else
		SetActive(slot0.m_rankBtn.gameObject, true)
	end

	manager.redPoint:SetRedPointIndependent(slot0.m_rewardBtn.transform, ActivityMatrixData:GetMatrixPointCanReward(slot1))
	ActivityMatrixAction.SetActivityMtairxRead(slot0.main_matrix_activity_id, slot1)

	if slot0.selectCamp == 3 then
		slot0.noticeController:SetSelectedIndex(1)
	else
		slot0.noticeController:SetSelectedIndex(0)
	end

	if not ActivityMatrixData:GetIsClearance(ActivityMatrixCfg[slot1].preconditions) or not ActivityData:GetActivityIsOpen(slot1) then
		slot0.particleController:SetSelectedIndex(0)
	elseif MatrixConst.STATE_TYPE.NOTSTARTED ~= ActivityMatrixData:GetGameState(slot1) then
		slot0.particleController:SetSelectedIndex(2)
	else
		slot0.particleController:SetSelectedIndex(1)
	end

	slot5 = slot0.selectCamp
	slot6 = false

	for slot10 = slot5 + 1, slot5 + 3 do
		if ActivityMatrixAction.CheckSubReadRedPonit(slot0.subActivityIdList[slot10 % slot0.maxCamp]) or ActivityMatrixData:GetMatrixPointCanReward(slot12) then
			slot6 = true

			break
		end
	end

	slot10 = slot0.m_rightBtn.transform

	manager.redPoint:SetRedPointIndependent(slot10, slot6)

	slot6 = false

	for slot10 = slot5 - 1, slot5 - 2, -1 do
		if (slot10 + slot0.maxCamp) % slot0.maxCamp == 0 then
			slot11 = slot0.maxCamp
		end

		if ActivityMatrixAction.CheckSubReadRedPonit(slot0.subActivityIdList[slot11]) or ActivityMatrixData:GetMatrixPointCanReward(slot12) then
			slot6 = true

			break
		end
	end

	manager.redPoint:SetRedPointIndependent(slot0.m_leftBtn.transform, slot6)
end

function slot0.RefrenTime(slot0)
	slot1 = manager.time:GetServerTime()

	if ActivityData:GetActivityData(slot0.main_matrix_activity_id) and slot1 < slot2.stopTime then
		slot0.m_mainTimeLab.text = manager.time:GetLostTimeStr(slot2.stopTime)
	else
		slot0.m_mainTimeLab.text = GetTips("TIME_OVER")
	end

	slot5 = ActivityMatrixCfg[slot0.subActivityIdList[slot0.selectCamp]].preconditions
	slot6 = ActivityMatrixCfg[slot5]

	if slot5 ~= 0 and not ActivityMatrixData:GetIsClearance(slot5) then
		slot0.entranceController:SetSelectedIndex(0)

		slot0.m_timeLab.text = string.format(GetTips("ACTIVITY_MATRIX_PRECONDITIONS"), slot6.name)

		return
	end

	if ActivityData:GetActivityIsOpen(slot3) then
		slot0.entranceController:SetSelectedIndex(1)
	else
		slot0.entranceController:SetSelectedIndex(0)

		if ActivityData:GetActivityData(slot3) and slot1 < slot7.startTime then
			slot0.m_timeLab.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot7.startTime))
		else
			slot0.m_timeLab.text = GetTips("TIME_OVER")
		end
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	slot0.clickTime = 0

	manager.redPoint:unbindUIandKey(slot0.m_clueBtn.transform, string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, slot0.main_matrix_activity_id))
end

function slot0.OnReceivePointReward(slot0)
	manager.redPoint:SetRedPointIndependent(slot0.m_rewardBtn.transform, ActivityMatrixData:GetMatrixPointCanReward(slot0.subActivityIdList[slot0.selectCamp]))
end

function slot0.Dispose(slot0)
	slot0.rotationDiagram:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
