slot0 = class("AbyssMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/AbyssUI/AbyssMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stageController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "stage")
	slot0.unlockController_ = ControllerUtil.GetController(slot0.challengeGo_.transform, "unlock")
	slot0.levelNumController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "levelNum")
	slot0.resetGrayedController_ = ControllerUtil.GetController(slot0.resetBtn_.transform, "grayed")
	slot0.levelItems_ = {}

	for slot5, slot6 in ipairs({
		slot0.levelGo1_,
		slot0.levelGo2_,
		slot0.levelGo3_,
		slot0.levelGo4_,
		slot0.levelGo5_
	}) do
		table.insert(slot0.levelItems_, AbyssLevelItemView.New(slot6))
	end

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, AbyssListItemView)
	slot0.levelView_ = AbyssLevelView.New(slot0.bossGo_)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.layerCfgIdList_[slot1], slot0.layerCfgIdList_[slot1], handler(slot0, slot0.OnItemClick))
	slot2:SetSelect(slot0.layerCfgIdList_[slot1] == slot0.curLayerId_)
end

function slot0.OnItemClick(slot0, slot1)
	slot0:SelectLayer(slot1)
	slot0:ReplayLayerTimeline()
end

function slot0.ReplayLayerTimeline(slot0)
	for slot4, slot5 in ipairs(slot0.levelItems_) do
		slot5.playableDirector_.time = 0.75
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bonusBtn_, nil, function ()
		JumpTools.OpenPageByJump("abyssReward", {})
	end)
	slot0:AddBtnListener(slot0.rankBtn_, nil, function ()
		JumpTools.OpenPageByJump("/abyssRank", {})
	end)

	slot4 = slot0.resetBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		if AbyssData:GetLayerResetTime() <= 0 then
			ShowTips("ABYSS_LAYER_RESET_CLICK_TIP")

			return
		end

		slot2 = AbyssData:GetLayerStatus(uv0.curLayerId_ + 1)

		if uv0.curLayerId_ < AbyssData:GetCurrentLayer() and slot2 >= 2 then
			slot3 = slot0

			if AbyssData:GetLayerStatus(slot0) == 1 then
				slot3 = slot0 - 1
			end

			ShowTips(string.format(GetTips("ABYSS_LAYER_CHALLENGING_RESET_TIP"), slot3))

			return
		end

		slot9 = AbyssData
		slot10 = AbyssData

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = string.format(GetTips("ABYSS_LAYER_RESET_TIP"), slot9:GetLayerResetTime(), slot10:GetLayerResetLimit()),
			OkCallback = function ()
				AbyssAction.ResetLayer(uv0.curLayerId_)
			end,
			CancelCallback = function ()
			end
		})
	end)

	for slot4, slot5 in ipairs(slot0.levelItems_) do
		slot9 = slot5.gameObject_

		slot0:AddBtnListener(slot9:GetComponent(typeof(Button)), nil, function ()
			uv0:SelectStage(uv1)
		end)
	end
end

function slot0.SelectLayer(slot0, slot1)
	if slot0.curLayerId_ == slot1 then
		return
	end

	slot0.curLayerId_ = slot1

	saveData("abyss", "layer", slot1)
	saveData("abyss", "refreshTime", AbyssData:GetRefreshTimestamp())

	slot0.curLevelCfg_ = AbyssCfg[slot0.curLayerId_]

	slot0.uiList_:Refresh()
	slot0:UpdateLayerView()
end

function slot0.CancelSelectLevel(slot0)
	for slot4, slot5 in ipairs(slot0.levelItems_) do
		slot5:SetSelect(false)
	end
end

function slot0.SelectStage(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.levelItems_) do
		slot6:SetSelect(slot5 == slot1)
	end

	slot0:SwitchToStage("detail", slot0.curLayerId_, slot1)
end

function slot0.UpdateLayerView(slot0)
	slot4 = tostring

	slot0.levelNumController_:SetSelectedState(slot4(#slot0.curLevelCfg_.stage_list))

	for slot4 = 1, #slot0.curLevelCfg_.stage_list do
		slot0.levelItems_[slot4]:SetData(slot0.curLevelCfg_, slot4)
	end

	slot0.currentFloorLabel_.text = slot0.curLevelCfg_.id

	if AbyssData:GetLayerStatus(slot0.curLayerId_) == 0 then
		slot0.unlockController_:SetSelectedState("false")
	else
		slot0.unlockController_:SetSelectedState("true")
	end

	SetActive(slot0.resetBtn_.gameObject, AbyssData:IsLayerChallenging(slot0.curLayerId_))

	if AbyssData:GetLayerResetTime() <= 0 then
		slot0.resetGrayedController_:SetSelectedState("true")
	else
		slot0.resetGrayedController_:SetSelectedState("false")
	end
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(ABYSS_STAGE_RESET_TIME_UPDATE, function (slot0, slot1)
		if slot0 == uv0.curLayerId_ then
			uv0.uiList_:Refresh()
			uv0:UpdateLayerView()
		end
	end)
	slot0:RegistEventListener(ABYSS_LAYER_RESET_TIME_UPDATE, function (slot0)
		if slot0 == uv0.curLayerId_ then
			ShowTips("ABYSS_RESET_LAYER_FINISH_TIP")
			uv0.uiList_:Refresh()
			uv0:UpdateLayerView()
		end
	end)
end

function slot0.OnAbyssUpdate(slot0)
	slot0:OnItemClick(slot0:GetInitLayer())
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	slot1 = manager.windowBar

	slot1:SetGameHelpKey("ABYSS_DESC")

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0.stageController_:GetSelectedState() == "detail" then
			uv0:CancelSelectLevel()
			uv0:SwitchToStage("list", uv0.curLayerId_, uv0.curStageIndex_)
		else
			JumpTools.Back()
		end
	end)

	slot1 = manager.windowBar

	slot1:RegistHomeCallBack(function ()
		uv0:CancelSelectLevel()
		gameContext:Go("/home", nil, , true)
	end)
end

function slot0.SwitchToStage(slot0, slot1, slot2, slot3, slot4)
	slot4 = slot4 or false

	if slot0.stageController_:GetSelectedState() ~= slot1 then
		slot0:PlaySound()
	end

	slot0.stageController_:SetSelectedState(slot1, slot4)

	if slot0.curStageIndex_ == slot3 and slot2 == slot0.curStageOfLayerId_ then
		return
	end

	slot0.curStageIndex_ = slot3
	slot0.curStageOfLayerId_ = slot2

	if slot0.stageController_:GetSelectedState() == "detail" and slot1 == "detail" then
		slot0.levelView_.animator_:Play("AbyssLevelItemUI_right_cx", -1, 0)
	end

	slot0.levelView_:SetData(slot0.curLayerId_, slot0.curStageIndex_)
end

function slot0.PlaySound(slot0)
	manager.audio:PlayEffect("ui_system", "Challenge_whoosh", "")
end

function slot0.InitData(slot0)
	slot0.layerCfgIdList_ = {}

	for slot4 = #AbyssCfg.all, 1, -1 do
		table.insert(slot0.layerCfgIdList_, AbyssCfg.all[slot4])
	end
end

function slot0.OnEnter(slot0)
	slot0:InitData()
	slot0:AddEventListeners()
	AbyssAction.ClickChallengeRedPoint()

	if slot0.levelView_ then
		slot0.levelView_:OnEnter()
	end

	for slot4, slot5 in ipairs(slot0.levelItems_) do
		slot5:OnEnter()
	end

	slot0.uiList_:StartScroll(#slot0.layerCfgIdList_)
	slot0:SelectLayer(slot0:GetInitLayer())
	slot0:SwitchToStage("list", slot0.curLayerId_, 1, true)
	manager.redPoint:bindUIandKey(slot0.rewardNoticeContainer_, RedPointConst.ABYSS_REWARD, {
		x = 0,
		y = 0
	})
	slot0:StartTimer()
	slot0:UpdateTimer()

	if AbyssData:NeedTipBack() then
		ShowTips(string.format(GetTips("ABYSS_BACK_TIP"), AbyssData:GetFirstLockLayer()))
		AbyssAction.ReadBackFlag()
	end

	if PlayerData:GetUnclaimed(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.ABYSS) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function ()
				PlayerAction.ReadUnclaimedMessage(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.ABYSS)
			end
		})
	end
end

function slot0.OnExit(slot0)
	slot0:CancelSelectLevel()

	slot0.keepLayerId_ = slot0.curLayerId_

	manager.redPoint:unbindUIandKey(slot0.rewardNoticeContainer_, RedPointConst.ABYSS_REWARD)
	slot0:StopTimer()
	slot0:RemoveAllEventListener()

	if slot0.levelView_ then
		slot0.levelView_:OnExit()
	end

	for slot4, slot5 in ipairs(slot0.levelItems_) do
		slot5:OnExit()
	end

	manager.windowBar:HideBar()
end

function slot0.GetInitLayer(slot0)
	slot1 = getData("abyss", "layer") or AbyssData:GetCurrentLayer()

	if manager.time:GetServerTime() < (getData("abyss", "refreshTime") or 0) then
		return slot1
	end

	return AbyssData:GetCurrentLayer()
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.UpdateTimer(slot0)
	slot0.lastDayLabel_.text = manager.time:GetLostTimeStr(AbyssData:GetRefreshTimestamp(), nil, true)
end

function slot0.OnMainHomeViewTop(slot0)
	slot0.keepLayerId_ = nil
end

function slot0.Dispose(slot0)
	slot0:StopTimer()

	if slot0.levelItems_ then
		for slot4, slot5 in pairs(slot0.levelItems_) do
			slot5:Dispose()
		end

		slot0.levelItems_ = nil
	end

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	if slot0.levelView_ then
		slot0.levelView_:Dispose()

		slot0.levelView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
