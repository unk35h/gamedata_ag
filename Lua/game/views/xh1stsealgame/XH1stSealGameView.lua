slot0 = class("XH1stSealGameView", ReduxView)

function slot0.GetItemIndex(slot0, slot1, slot2)
	if slot1 == 1 and slot2 == 1 then
		return 2
	end

	if slot1 == 1 and slot2 == 2 then
		return 3
	end

	if slot1 == 1 and slot2 == 3 then
		return 4
	end

	if slot1 == 2 and slot2 == 1 then
		return 9
	end

	if slot1 == 2 and slot2 == 2 then
		return 1
	end

	if slot1 == 2 and slot2 == 3 then
		return 5
	end

	if slot1 == 3 and slot2 == 1 then
		return 8
	end

	if slot1 == 3 and slot2 == 2 then
		return 7
	end

	if slot1 == 3 and slot2 == 3 then
		return 6
	end

	return 1
end

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng1stUI/XH1stSealUI/XH1stSealGameUI"
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

	slot0.dialogController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "dialog")
	slot0.resetController_ = ControllerUtil.GetController(slot0.resetBtn_.transform, "name")
	slot0.playingController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "playing")
	slot0.faceController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "face")
	slot4 = slot0.itemBtn5_.transform
	slot5 = "babelItem"
	slot0.itemControllers_ = {
		ControllerUtil.GetController(slot0.itemBtn1_.transform, "babelItem"),
		ControllerUtil.GetController(slot0.itemBtn2_.transform, "babelItem"),
		ControllerUtil.GetController(slot0.itemBtn3_.transform, "babelItem"),
		ControllerUtil.GetController(slot0.itemBtn4_.transform, "babelItem"),
		ControllerUtil.GetController(slot4, slot5)
	}
	slot0.sealItemGos_ = {
		slot0.rewarditmei0Go_,
		slot0.rewarditmei1Go_,
		slot0.rewarditmei2Go_,
		slot0.rewarditmei3Go_,
		slot0.rewarditmei4Go_,
		slot0.rewarditmei5Go_,
		slot0.rewarditmei6Go_,
		slot0.rewarditmei7Go_,
		slot0.rewarditmei8Go_
	}
	slot0.sealItems_ = {}

	for slot4, slot5 in ipairs(slot0.sealItemGos_) do
		slot6 = XH1stSealSealItemView.New(slot5)

		slot6:SetItemClick(handler(slot0, slot0.OnItemClick))
		table.insert(slot0.sealItems_, slot6)
	end

	slot0.rewardItemGos_ = {
		slot0.rewarditme0Go_,
		slot0.rewarditme1Go_,
		slot0.rewarditme2Go_,
		slot0.rewarditme3Go_,
		slot0.rewarditme4Go_,
		slot0.rewarditme5Go_,
		slot0.rewarditme6Go_,
		slot0.rewarditme7Go_
	}
	slot0.rewardItems_ = {}

	for slot4, slot5 in ipairs(slot0.rewardItemGos_) do
		slot6 = XH1stSealRewardItemView.New(slot5)

		slot6:SetItemClick(handler(slot0, slot0.OnItemClick))
		table.insert(slot0.rewardItems_, slot6)
	end
end

function slot0.OnItemClick(slot0, slot1)
	if slot0.playing_ then
		return
	end

	if slot0.cding_ then
		return
	end

	slot0.cding_ = true

	if slot0.cdTimer_ then
		slot0.cdTimer_:Stop()

		slot0.cdTimer_ = nil
	end

	slot0.cdTimer_ = TimeTools.StartAfterSeconds(0.3, function ()
		uv0.cding_ = false

		if uv0.cdTimer_ then
			uv0.cdTimer_:Stop()

			uv0.cdTimer_ = nil
		end
	end, {})

	CustomLog.Log(debug.traceback(string.format("click item")))
	ShowPopItem(POP_ITEM, {
		slot1.id,
		slot1.number
	})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.roleBtn_, nil, function ()
		if uv0.playing_ then
			return
		end

		uv0:PlayDialog("click")
	end)
	slot0:AddBtnListener(slot0.sealBtn_, nil, function ()
		if uv0.playing_ then
			return
		end

		if uv0.cding_ then
			return
		end

		slot0 = ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item
		slot2 = ItemCfg[slot0[1]]

		if (MaterialData:GetMaterial(slot0[1]) and slot1.num or 0) < slot0[2] then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), tostring(slot2.name)))

			return
		end

		if XH1stSealData:IsTicketFinish(uv0.currentTicketId_) then
			ShowTips("XH1ST_SEAL_TICKET_FINISH_TIP")

			return
		end

		uv0:SetPlaying(true)
		CustomLog.Log(debug.traceback(string.format("start seal")))
		XH1stSealAction.RequestSeal(ActivityConst.ACTIVITY_2_0_SEAL, uv0.currentTicketId_ or 1)
	end)

	slot4 = slot0.resetBtn_

	slot0:AddBtnListener(slot4, nil, function ()
		if uv0.playing_ then
			return
		end

		slot0 = false

		for slot5, slot6 in ipairs(ActivitySealTicketCfg.get_id_list_by_ticket_id[uv0.currentTicketId_]) do
			if ActivitySealTicketCfg[slot6].is_main_reward == 1 and XH1stSealData:HaveGotReward(uv0.currentTicketId_, slot7.row, slot7.column) then
				slot0 = true

				break
			end
		end

		if not slot0 then
			ShowTips("XH1ST_SEAL_NOT_MAIN_REWARD_TIP")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("RESET_INFINITY"),
			OkCallback = function ()
				XH1stSealAction.ResetSeal(ActivityConst.ACTIVITY_2_0_SEAL, uv0.currentTicketId_)
			end
		})
	end)

	for slot4 = 1, 5 do
		slot0:AddBtnListener(slot0["itemBtn" .. slot4 .. "_"], nil, function ()
			if uv0.playing_ then
				return
			end

			uv0:SelectTicket(uv1)
		end)
	end
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(XH1ST_SEAL_UPDATE, function ()
		uv0:SelectTicket(uv0.currentTicketId_)
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.SelectTicket(slot0, slot1)
	if not XH1stSealData:IsUnLock(slot1) then
		ShowTips(string.format(GetTips("XH1ST_SEAL_NOT_UNLOCK_TIP"), tostring(slot1 - 1)))

		return
	end

	slot0.currentTicketId_ = slot1

	for slot5, slot6 in ipairs(slot0.itemControllers_) do
		if XH1stSealData:IsUnLock(slot5) then
			slot6:SetSelectedState(slot1 == slot5 and "select" or "normal")
		else
			slot6:SetSelectedState("lock")
		end
	end

	slot0.ticketIdList_ = ActivitySealTicketCfg.get_id_list_by_ticket_id[slot1]

	slot0:UpdateView()
	slot0:StopAnimators()
end

function slot0.StopAnimators(slot0)
	for slot4, slot5 in ipairs(slot0.sealItems_) do
		slot5:StopAnimators()
	end
end

function slot0.UpdateBar(slot0)
	slot1 = ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		slot1[1]
	})
	manager.windowBar:SetBarCanAdd(slot1[1], true)
	manager.windowBar:SetGameHelpKey("XH1ST_SEAL_DESC")
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
	slot0:SelectTicket(XH1stSealData:GetCurrentTicket())
	slot0:UpdateTimer()
	slot0:PlayDialog("enter")
end

function slot0.OnExit(slot0)
	slot0.cding_ = false

	if slot0.cdTimer_ then
		slot0.cdTimer_:Stop()

		slot0.cdTimer_ = nil
	end

	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	slot0:StartTimer()
	slot0:StopTimer()
	slot0:StopDialogTimer()
	manager.audio:Stop("effect")
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
	slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_SEAL).stopTime)
end

function slot0.UpdateView(slot0)
	slot0.rewardItems_[1]:SetData(1, slot0.ticketIdList_[5])
	slot0.rewardItems_[2]:SetData(2, slot0.ticketIdList_[4])
	slot0.rewardItems_[3]:SetData(3, slot0.ticketIdList_[3])
	slot0.rewardItems_[4]:SetData(4, slot0.ticketIdList_[2])
	slot0.rewardItems_[5]:SetData(5, slot0.ticketIdList_[1])
	slot0.rewardItems_[6]:SetData(6, slot0.ticketIdList_[6])
	slot0.rewardItems_[7]:SetData(7, slot0.ticketIdList_[10])
	slot0.rewardItems_[8]:SetData(8, slot0.ticketIdList_[14])
	slot0.sealItems_[1]:SetData(1, slot0.ticketIdList_[12])
	slot0.sealItems_[2]:SetData(2, slot0.ticketIdList_[7])
	slot0.sealItems_[3]:SetData(3, slot0.ticketIdList_[8])
	slot0.sealItems_[4]:SetData(4, slot0.ticketIdList_[9])
	slot0.sealItems_[5]:SetData(5, slot0.ticketIdList_[13])
	slot0.sealItems_[6]:SetData(6, slot0.ticketIdList_[17])
	slot0.sealItems_[7]:SetData(7, slot0.ticketIdList_[16])
	slot0.sealItems_[8]:SetData(8, slot0.ticketIdList_[15])
	slot0.sealItems_[9]:SetData(9, slot0.ticketIdList_[11])

	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item[1])
	slot2 = ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list

	if slot0.currentTicketId_ == slot2[#slot2] then
		SetActive(slot0.resetBtn_.gameObject, true)

		slot4 = false

		for slot9, slot10 in ipairs(ActivitySealTicketCfg.get_id_list_by_ticket_id[slot0.currentTicketId_]) do
			if ActivitySealTicketCfg[slot10].is_main_reward == 1 and XH1stSealData:HaveGotReward(slot0.currentTicketId_, slot11.row, slot11.column) then
				slot4 = true

				break
			end
		end

		if not slot4 then
			slot0.resetController_:SetSelectedState("nouse")
		else
			slot0.resetController_:SetSelectedState("use")
		end
	else
		SetActive(slot0.resetBtn_.gameObject, false)
	end

	if XH1stSealData:IsTicketFinish(slot0.currentTicketId_) then
		SetActive(slot0.sealBtn_.gameObject, false)
	else
		SetActive(slot0.sealBtn_.gameObject, true)
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.OnSealResult(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		slot0:PlaySealEffect(slot1.coordinate.row, slot1.coordinate.column, function ()
			uv0:ShowResult(uv1, uv2)
		end)
	else
		slot0:SetPlaying(false)
	end
end

function slot0.PlaySealEffect(slot0, slot1, slot2, slot3)
	manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_stamp_stamp", "")
	slot0:PlayAnimator(slot0.sealItems_[slot0:GetItemIndex(slot1, slot2)].sealAnimator_, "sealAnimator", slot3)
end

function slot0.PlayLinkEffect(slot0, slot1, slot2)
	slot0:PlayNext(slot1, 1, slot2)
end

function slot0.PlayNext(slot0, slot1, slot2, slot3)
	slot0:PlayOneCoordinateLine(slot1[slot2], function ()
		uv0 = uv0 + 1

		if uv0 <= #uv1 then
			uv2:PlayNext(uv1, uv0, uv3)
		else
			uv3()
		end
	end)
end

function slot0.PlayOneCoordinateLine(slot0, slot1, slot2)
	slot8 = ""

	manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_stamp_lianxian", slot8)

	slot3 = 0
	slot4 = #slot1

	for slot8, slot9 in ipairs(slot1) do
		slot10 = XH1stSealData
		slot10 = slot10:DecodeCoordinateNumber(slot9)

		slot0:PlayAnimator(slot0.sealItems_[slot0:GetItemIndex(slot10[1], slot10[2])].linkAnimator_, "linkAnimator", function ()
			uv0 = uv0 + 1

			if uv1 <= uv0 then
				uv2()
			end
		end)
	end
end

function slot0.ShowResult(slot0, slot1, slot2)
	slot3, slot4, slot5 = XH1stSealData:OnSealSuccess(slot2.ticket_id, slot1.coordinate.row, slot1.coordinate.column)
	slot6 = #slot3 > 0

	for slot11, slot12 in ipairs(ActivitySealTicketCfg.get_id_list_by_ticket_id[slot2.ticket_id]) do
		if ActivitySealTicketCfg[slot12].row == slot1.coordinate.row and slot13.column == slot1.coordinate.column then
			slot0:UpdateView()
			getReward(slot13.reward_item_list, nil, function ()
				if #uv0 > 0 then
					slot0 = uv1

					slot0:PlayLinkEffect(uv2, function ()
						getReward(uv0)
						uv1:SetPlaying(false)
					end)
				else
					uv1:SetPlaying(false)
				end
			end)

			break
		end
	end

	if slot6 then
		if slot4 then
			slot0:PlayDialog("reward2")
		else
			slot0:PlayDialog("reward1")
		end
	else
		slot0:PlayDialog("seal")
	end
end

function slot0.PlayDialog(slot0, slot1)
	slot0:StopDialogTimer()

	slot3 = ActivitySealDialogCfg[ActivitySealDialogCfg.get_id_list_by_action[slot1][1]]

	slot0.dialogController_:SetSelectedState(slot1)

	slot4 = math.random(1, #slot3.sheetName)
	slot5 = nil

	if slot3.face and slot3.face[slot4] then
		slot5 = slot3.face[slot4]
	end

	CustomLog.Log(debug.traceback(string.format("face = %s", tostring(slot5))))
	slot0.faceController_:SetSelectedState(slot5)

	slot7 = slot3.cueName[slot4]
	slot8 = slot3.awbName[slot4]
	slot0.talkLabel_.text = slot3.word[slot4]

	if slot3.sheetName[slot4] ~= "" then
		slot10 = manager.audio

		slot10:PlayEffect(slot6, slot7, slot8)

		slot10 = manager.audio
		slot0.talkBubbleTimer_ = TimeTools.StartAfterSeconds(slot10:GetVoiceLength(slot6, slot7, slot8) / 1000, function ()
			uv0:StopDialogTimer()
		end, {})
	end
end

function slot0.StopDialogTimer(slot0)
	slot0.dialogController_:SetSelectedState("normal")
	CustomLog.Log(debug.traceback(string.format("ResetNormal")))
	slot0.faceController_:SetSelectedState("normal")

	if slot0.talkBubbleTimer_ ~= nil then
		slot0.talkBubbleTimer_:Stop()

		slot0.talkBubbleTimer_ = nil
	end
end

function slot0.PlayAnimator(slot0, slot1, slot2, slot3)
	slot1.speed = 1

	slot1:Play(slot2, -1, 0)
	slot1:Update(0)
	TimeTools.StartAfterSeconds(slot1:GetCurrentAnimatorStateInfo(0).length, function ()
		uv0()
	end, {})
end

function slot0.SetPlaying(slot0, slot1)
	slot0.playing_ = slot1

	slot0.playingController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.Dispose(slot0)
	slot0:SetPlaying(false)

	if slot0.sealItems_ then
		for slot4, slot5 in pairs(slot0.sealItems_) do
			slot5:Dispose()
		end

		slot0.sealItems_ = nil
	end

	if slot0.rewardItems_ then
		for slot4, slot5 in pairs(slot0.rewardItems_) do
			slot5:Dispose()
		end

		slot0.rewardItems_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
