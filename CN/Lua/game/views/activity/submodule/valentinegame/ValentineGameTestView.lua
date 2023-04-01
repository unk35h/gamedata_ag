slot0 = class("ValentineGameTestView", ReduxView)

function slot0.UIName(slot0)
	return ValentineGameTools.GetTestUIName(slot0.params_.activityId)
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

	slot0.levelData_ = {}
	slot0.rewardItems_ = {}
	slot0.levelBtn_ = {}
	slot0.levelText_ = {}
	slot0.levelStateCon_ = {}
	slot0.levelCompleteCon_ = {}

	for slot4 = 1, #ActivityCfg[slot0.params_.activityId].sub_activity_list do
		slot0.levelBtn_[slot4] = slot0["level_" .. slot4]
		slot0.levelText_[slot4] = slot0["levelText_" .. slot4]
		slot0.levelStateCon_[slot4] = ControllerUtil.GetController(slot0.levelBtn_[slot4].transform, "state")
		slot0.levelCompleteCon_[slot4] = ControllerUtil.GetController(slot0.levelBtn_[slot4].transform, "complet")
	end

	slot0.rewardItems_ = {
		ValentineGameSPRewardItem.New(slot0.rewardGo_1),
		ValentineGameSPRewardItem.New(slot0.rewardGo_2),
		ValentineGameSPRewardItem.New(slot0.rewardGo_3)
	}
	slot0.stateCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.indexCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "index")
end

function slot0.AddUIListeners(slot0)
	for slot4 = 1, #ActivityCfg[slot0.params_.activityId].sub_activity_list do
		slot0:AddBtnListener(slot0.levelBtn_[slot4], nil, function ()
			if manager.time:GetServerTime() < uv0.levelData_[uv1].startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0.levelData_[uv1].startTime)))
			else
				ValentineGameData:SetLastLevel(uv0.activityID_, uv0.list_[uv1])

				uv0.curIndex_ = uv1

				uv0:RefreshLevelTime()
				uv0:RefreshReward()
			end
		end)
	end

	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		slot1 = uv0.list_[uv0.curIndex_]

		if uv0.levelData_[uv0.curIndex_].startTime <= manager.time:GetServerTime() and slot0 < uv0.levelData_[uv0.curIndex_].stopTime then
			JumpTools.OpenPageByJump("/valentineGameLoading", {
				mainActivityID = uv0.activityID_,
				activityID = slot1
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		slot1 = uv0.list_[uv0.curIndex_]

		if uv0.levelData_[uv0.curIndex_].startTime <= manager.time:GetServerTime() and slot0 < uv0.levelData_[uv0.curIndex_].stopTime then
			ValentineGameAction:GetReward(slot1)
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()
	slot0:BindUIRedPoint()
end

function slot0.RefreshData(slot0)
	slot0.activityID_ = slot0.params_.activityId
	slot4 = slot0.activityID_
	slot0.activityData_ = ActivityData:GetActivityData(slot4)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
	slot0.list_ = ActivityCfg[slot0.params_.activityId].sub_activity_list

	for slot4, slot5 in ipairs(slot0.list_) do
		slot0.levelData_[slot4] = ActivityData:GetActivityData(slot5)
	end
end

function slot0.RefreshUI(slot0)
	slot0.curIndex_ = table.indexof(slot0.list_, ValentineGameData:GetLastLevel(slot0.activityID_)) or 1

	slot0:RefreshTime()
	slot0:RefreshList()
	slot0:RefreshReward()
end

function slot0.RefreshTime(slot0)
	slot1 = nil

	slot0:StopTimer()
	slot0:RefreshLevelTime()

	if manager.time:GetServerTime() < slot0.startTime_ then
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
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.stopTime_ - manager.time:GetServerTime()

			uv1:RefreshLevelTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	end
end

function slot0.RefreshLevelTime(slot0)
	slot1 = manager.time:GetServerTime()

	for slot5, slot6 in ipairs(slot0.list_) do
		if slot1 < slot0.levelData_[slot5].startTime then
			slot0.levelStateCon_[slot5]:SetSelectedState("lock")
			slot0.levelCompleteCon_[slot5]:SetSelectedState("false")

			slot0.levelText_[slot5].text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(slot7))
		elseif slot5 ~= slot0.curIndex_ then
			slot0.levelStateCon_[slot5]:SetSelectedState("normal")
		else
			slot0.levelStateCon_[slot5]:SetSelectedState("selected")
		end
	end
end

function slot0.RefreshList(slot0)
	for slot4, slot5 in ipairs(slot0.list_) do
		if ValentineGameData:GetData(slot5) and slot6.isClear then
			slot0.levelCompleteCon_[slot4]:SetSelectedState("true")
		else
			slot0.levelCompleteCon_[slot4]:SetSelectedState("false")
		end
	end
end

function slot0.RefreshReward(slot0)
	slot0.indexCon_:SetSelectedState(slot0.curIndex_)
	ValentineGameData:SetOpen(slot0.list_[slot0.curIndex_])

	for slot7, slot8 in ipairs(ActivityValentineCfg[slot0.list_[slot0.curIndex_]].reward_item_list) do
		slot0.rewardItems_[slot7]:SetData(slot8)
	end

	for slot7 = #slot3 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot7]:Show(false)
	end

	if ValentineGameData:GetData(slot1) and slot4.isReward then
		slot0:SetPoint(slot4.point, slot2)
		slot0.stateCon_:SetSelectedState("received")
	elseif slot4 and slot4.isClear then
		slot0:SetPoint(slot4.point, slot2)
		slot0.stateCon_:SetSelectedState("complete")
	else
		slot0.testText_.text = slot2.desc

		slot0.stateCon_:SetSelectedState("test")
	end
end

function slot0.SetPoint(slot0, slot1, slot2)
	slot3, slot4 = ValentineGameTools.GetPointRule(slot0.params_.activityId)

	if slot1 <= slot3 then
		slot0.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_1")
		slot0.completeText_.text = slot2.result_desc[1]
	elseif slot1 <= slot4 then
		slot0.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_2")
		slot0.completeText_.text = slot2.result_desc[2]
	else
		slot0.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_3")
		slot0.completeText_.text = slot2.result_desc[3]
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.BindUIRedPoint(slot0)
	for slot4, slot5 in ipairs(slot0.list_) do
		manager.redPoint:bindUIandKey(slot0.levelBtn_[slot4].transform, RedPointConst.VALENTINE_GAME .. "_" .. slot5)
	end
end

function slot0.UnBindUIRedPoint(slot0)
	for slot4, slot5 in ipairs(slot0.list_) do
		manager.redPoint:unbindUIandKey(slot0.levelBtn_[slot4].transform, RedPointConst.VALENTINE_GAME .. "_" .. slot5)
	end
end

function slot0.OnValentineGameReward(slot0)
	slot0:RefreshReward()
end

function slot0.OnTop(slot0)
	if ValentineGameTools.GetGameHelpKey(slot0.activityID_) ~= "" then
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
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopTimer()

	for slot4 = 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot4]:OnExit()
	end

	slot0:UnBindUIRedPoint()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot4]:Dispose()
	end

	slot0.super.Dispose(slot0)
end

return slot0
