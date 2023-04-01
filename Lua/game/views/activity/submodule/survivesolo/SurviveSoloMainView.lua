slot0 = class("SurviveSoloMainView", ReduxView)

function slot0.UIName(slot0)
	return SurviveSoloTools.GetMainUIName(slot0.params_.activityId)
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

	slot0.levelBtn_ = {}
	slot0.levelTime_ = {}
	slot0.levelText_ = {}
	slot0.openCon_ = {}
	slot0.clearCon_ = {}
	slot0.activityList_ = ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[slot0.params_.activityId]

	for slot4, slot5 in ipairs(slot0.activityList_) do
		table.insert(slot0.levelBtn_, slot0["levelBtn_" .. slot4])
		table.insert(slot0.levelTime_, slot0["levelTime_" .. slot4])
		table.insert(slot0.levelText_, slot0["levelText_" .. slot4])

		slot0.levelText_[slot4].text = BattleSoloSlayerCfg[ActivitySoloSlayerCfg[slot5].stage_id].name

		table.insert(slot0.openCon_, ControllerUtil.GetController(slot0["levelBtn_" .. slot4].transform, "open"))
		table.insert(slot0.clearCon_, ControllerUtil.GetController(slot0["levelBtn_" .. slot4].transform, "clear"))
	end

	slot0.levelData_ = {}
	slot0.indexCon_ = ControllerUtil.GetController(slot0.transform_, "index")

	if slot0.scrollView_ then
		slot0.positionCon_ = ControllerUtil.GetController(slot0.transform_, "position")
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0:SetIndex(0)
		end

		JumpTools.OpenPageByJump("surviveSoloReward", {
			activityId = uv0.activityID_
		})
	end)

	slot4 = slot0.bgBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0:SetIndex(0)
		end
	end)

	for slot4, slot5 in ipairs(slot0.activityList_) do
		slot0:AddBtnListener(slot0.levelBtn_[slot4], nil, function ()
			if uv0.levelData_[uv1].startTime <= manager.time:GetServerTime() and slot0 < uv0.levelData_[uv1].stopTime then
				SurviveSoloData:SetLastIndex(uv0.activityID_, uv1)
				uv0:SetIndex(uv1)
			elseif slot0 < uv0.levelData_[uv1].startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0.levelData_[uv1].startTime)))
			else
				ShowTips("TIME_OVER")
			end
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0:GetActivityData()
	slot0:RefreshUI()
	slot0:BindUIRedPoint()
end

function slot0.GetActivityData(slot0)
	slot0.activityID_ = slot0.params_.activityId
	slot4 = slot0.activityID_
	slot0.activityData_ = ActivityData:GetActivityData(slot4)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime

	for slot4, slot5 in ipairs(slot0.activityList_) do
		slot0.levelData_[slot4] = ActivityData:GetActivityData(slot5)
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshLevel()
	slot0:RefreshTime()

	slot0.selectIndex_ = SurviveSoloData:GetLastIndex(slot0.activityID_)

	if slot0:IsOpenSectionView() then
		slot0:SetIndex(slot0.selectIndex_ or 0)
	else
		slot0:SetIndex(0)
	end

	if slot0.scrollView_ then
		slot0.positionCon_:SetSelectedState(slot0.selectIndex_ or 0)
	end
end

function slot0.RefreshLevel(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(slot0.activityList_) do
		if SurviveSoloData:GetData(slot6) then
			slot0.clearCon_[slot5]:SetSelectedState(slot1.time > 0 and "true" or "false")
		else
			slot0.clearCon_[slot5]:SetSelectedState("false")
		end
	end
end

function slot0.RefreshTime(slot0)
	slot1 = nil

	slot0:StopTimer()
	slot0:RefreshLevelTime()

	if manager.time:GetServerTime() < slot0.startTime_ then
		slot0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.startTime_ - manager.time:GetServerTime()

			uv1:RefreshLevelTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot2 < slot0.stopTime_ then
		slot0.timeTxt_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.stopTime_ - manager.time:GetServerTime()

			uv1:RefreshLevelTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end

			uv1.timeTxt_.text = manager.time:GetLostTimeStr(uv1.stopTime_)
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function slot0.RefreshLevelTime(slot0)
	slot1 = manager.time:GetServerTime()

	for slot5, slot6 in ipairs(slot0.activityList_) do
		if slot1 < slot0.levelData_[slot5].startTime then
			slot0.openCon_[slot5]:SetSelectedState("false")

			slot0.levelTime_[slot5].text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(slot0.levelData_[slot5].startTime))
		else
			slot0.openCon_[slot5]:SetSelectedState("true")
		end
	end
end

function slot0.SetIndex(slot0, slot1)
	slot0.selectIndex_ = slot1

	if slot1 ~= 0 and slot1 ~= -1 then
		slot0:SetScrollEnable(false)

		slot2 = ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[slot0.activityID_][slot1]
		slot4 = manager.redPoint

		slot4:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot2, 0)
		JumpTools.OpenPageByJump("surviveSoloSectionInfo", {
			index = slot1,
			section = ActivitySoloSlayerCfg[slot2].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO,
			activityID = slot2,
			repeat_id = slot2,
			backFunc = function ()
				uv0:SetIndex(0)
			end
		})

		if slot0.scrollView_ then
			slot0.positionCon_:SetSelectedState(0)
			slot0.positionCon_:SetSelectedState(slot1)
		end
	else
		slot0:SetScrollEnable(true)
	end

	slot0.indexCon_:SetSelectedState(slot1)
end

function slot0.SetScrollEnable(slot0, slot1)
	if slot0.scrollView_ then
		slot0.scrollView_.enabled = slot1
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.BindUIRedPoint(slot0)
	slot4 = slot0.rewardBtn_.gameObject.transform
	slot5 = RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. slot0.activityID_

	manager.redPoint:bindUIandKey(slot4, slot5)

	for slot4, slot5 in ipairs(slot0.activityList_) do
		manager.redPoint:bindUIandKey(slot0.levelBtn_[slot4].gameObject.transform, RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot5)
	end
end

function slot0.UnbindUIRedPoint(slot0)
	slot4 = slot0.rewardBtn_.gameObject.transform
	slot5 = RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. slot0.activityID_

	manager.redPoint:unbindUIandKey(slot4, slot5)

	for slot4, slot5 in ipairs(slot0.activityList_) do
		manager.redPoint:unbindUIandKey(slot0.levelBtn_[slot4].gameObject.transform, RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot5)
	end
end

function slot0.IsOpenSectionView(slot0)
	return slot0:IsOpenRoute("surviveSoloSectionInfo")
end

function slot0.OnTop(slot0)
	slot0:UpdataBar()
end

function slot0.UpdataBar(slot0)
	if SurviveSoloTools.GetGameHelpKey(slot0.params_.activityId) ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(slot1)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	slot2 = manager.windowBar

	slot2:RegistBackCallBack(function ()
		if uv0:IsOpenSectionView() then
			uv0:SetIndex(0)
			JumpTools.Back()
		else
			JumpTools.Back()
		end
	end)
end

function slot0.OnExit(slot0)
	slot0:UnbindUIRedPoint()
	slot0:StopTimer()
	slot0:SetIndex(-1)

	if slot0.scrollView_ then
		slot0.positionCon_:SetSelectedState(-1)
	end

	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
