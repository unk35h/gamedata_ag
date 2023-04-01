slot0 = class("MainHomeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/HomeUI"
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

	slot0.clickCount_ = 0
	slot0.muteAudioHandler_ = handler(slot0, slot0.MuteAudio)
	slot0.bannerView_ = BannerView.New(slot0, slot0.btnActivityGo_)
	slot0.activityEntraceView_ = ActivityEntraceView.New(slot0.activityListGo_)
	slot0.barCon_ = ControllerUtil.GetController(slot0.transform_, "bar")
	slot0.chatCon_ = ControllerUtil.GetController(slot0.transform_, "chat")
	slot0.textLimit_ = slot0.chatTxt_.gameObject:GetComponent("TextExtension")
end

function slot0.MuteAudio(slot0)
	if slot0.talkBubbleTimer_ ~= nil then
		slot0.talkBubbleTimer_:Stop()

		slot0.talkBubbleTimer_ = nil
	end

	HeroTools.StopTalk()

	if slot0.talkDelayTimer_ then
		slot0.talkDelayTimer_:Stop()

		slot0.talkDelayTimer_ = nil
	end

	if slot0.multiTouchTimer_ ~= nil then
		slot0.multiTouchTimer_:Stop()

		slot0.multiTouchTimer_ = nil
	end

	if slot0.idleTimer_ then
		slot0.idleTimer_:Stop()

		slot0.idleTimer_ = nil
	end

	if slot0.interactionTimer_ then
		slot0.interactionTimer_:Stop()

		slot0.interactionTimer_ = nil
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_girl, nil, function ()
		slot0 = uv0

		slot0:DelayToPlayMultiTouchInteraction()
		SetActive(uv0.changeGirlBtn, true)
		SetActive(uv0.changeSkinBtn, true)
		SetActive(uv0.btn_giftGo_, true)

		function slot0()
			SetActive(uv0.changeGirlBtn, false)
			SetActive(uv0.changeSkinBtn, false)
			SetActive(uv0.btn_giftGo_, false)

			if uv0.hideChangeBtnDelayTimer_ ~= nil then
				uv0.hideChangeBtnDelayTimer_:Stop()

				uv0.hideChangeBtnDelayTimer_ = nil
			end
		end

		if uv0.hideChangeBtnDelayTimer_ ~= nil then
			uv0.hideChangeBtnDelayTimer_:Reset()
		else
			uv0.hideChangeBtnDelayTimer_ = Timer.New(slot0, 3, 1)

			uv0.hideChangeBtnDelayTimer_:Start()
		end
	end)
	slot0:AddBtnListener(slot0.btn_genghuan, nil, function ()
		SetActive(uv0.changeGirlBtn, false)
		SetActive(uv0.changeSkinBtn, false)
		SetActive(uv0.btn_giftGo_, false)
		uv0:Go("/changePoster", {
			lastView = "home"
		})
	end)
	slot0:AddBtnListener(slot0.btn_skin, nil, function ()
		SetActive(uv0.changeGirlBtn, false)
		SetActive(uv0.changeSkinBtn, false)
		SetActive(uv0.btn_giftGo_, false)
		uv0:Go("/heroSkin", {
			heroID = uv0.userData_.poster_girl
		})
	end)
	slot0:AddBtnListener(slot0.btn_giftBtn_, nil, function ()
		SetActive(uv0.changeGirlBtn, false)
		SetActive(uv0.changeSkinBtn, false)
		SetActive(uv0.btn_giftGo_, false)
		uv0:Go("/heroArchive", {
			pageID = 3,
			heroID = uv0.userData_.poster_girl
		})
	end)
	slot0:AddBtnListener(slot0.btn_message, nil, function ()
		JumpTools.OpenPageByJump("/userinfo", {
			page = "info"
		}, ViewConst.SYSTEM_ID.PLAYER_INFO)
	end)
	slot0:AddBtnListener(slot0.btn_callback, nil, function ()
		JumpTools.GoToSystem("/recallMain", nil)
	end)
	slot0:AddBtnListenerScale(slot0.btn_regression, nil, function ()
		JumpTools.OpenPageByJump("/regressionNew", {
			isEnter = true,
			Inited = false
		})
	end)
	slot0:AddBtnListenerScale(slot0.buttonNewbie_, nil, function ()
		ActivityNewbieTools.GotoMainView()
	end)
	slot0:AddBtnListenerScale(slot0.btn_newbie_task, nil, function ()
		JumpTools.OpenPageByJump("/noobAdvanceTask", {
			isEnter = true
		})
	end)
	slot0:AddBtnListenerScale(slot0.btn_passport, nil, function ()
		if not PassportData:IsOpen() then
			ShowTips("NOT_IN_OPEN_TIME")

			return
		end

		JumpTools.OpenPageByJump("/passportMain", nil, ViewConst.SYSTEM_ID.PASSPORT_MAIN)
	end)
	slot0:AddBtnListenerScale(slot0.btn_gm, nil, function ()
		JumpTools.GoToSystem("gm")
	end)
	slot0:AddBtnListenerScale(slot0.btn_heroInteractionGM, nil, function ()
		JumpTools.GoToSystem("heroInteractionGM", {
			skinId = uv0.skinId_,
			animator = uv0.animator_,
			idleTimer = uv0.idleTimer_
		})
	end)
	slot0:AddBtnListener(slot0.btn_story, nil, function ()
		JumpTools.GoToSystem("/storylist")
	end)
	slot0:AddBtnListenerScale(slot0.btn_friends_, nil, function ()
		JumpTools.GoToSystem("/friendsUI", {
			friendPage = FriendsConst.FRIEND_TYPE.MY_FRIENDS
		}, ViewConst.SYSTEM_ID.FRIEND)
	end)
	slot0:AddBtnListenerScale(slot0.btn_chat, nil, function ()
		JumpTools.GoToSystem("/chat", {
			chatToggleID = ChatConst.CHAT_CHANNEL_WORLD
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	slot0:AddBtnListenerScale(slot0.btnPreviewTask_, nil, function ()
		JumpTools.OpenPageByJump("previewTaskMain")
	end)
	slot0:AddBtnListenerScale(slot0.btn_task, nil, function ()
		JumpTools.GoToSystem("/task", {
			initNormalizedPosition = true,
			taskIndex = TaskConst.TASK_TYPE.DAILY
		}, ViewConst.SYSTEM_ID.TASK_PLOT)
	end)
	slot0:AddBtnListenerScale(slot0.btn_mail, nil, function ()
		slot0 = handler(uv0, function ()
			JumpTools.GoToSystem("/mailBox")
		end)

		if MailData.GetTotal() > #MailData.GetMailSort() then
			MailData.GetMailListFromServer(slot0)
		else
			slot0()
		end

		MailData.ClickMailBtn(manager.time:GetServerTime())
	end)
	slot0:AddBtnListenerScale(slot0.btn_menu, nil, function ()
		JumpTools.OpenPageByJump("menuPop")
	end)
	slot0:AddBtnListener(slot0.m_cooperationBtn, nil, function ()
		if PlayerData:GetPlayerInfo().userLevel < 35 then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot0))

			return
		end

		JumpTools.GoToSystem("/cooperationBlank/demoCooperationEntry")
	end)
	slot0:AddBtnListener(slot0.m_inviteBtn, nil, function ()
		JumpTools.OpenPageByJump("cooperationApply")
	end)
	slot0:AddBtnListener(slot0.btn_combat, nil, function ()
		JumpTools.GoToSystem("/chapterMap", {
			chapterToggle = 1
		}, ViewConst.SYSTEM_ID.BATTLE)
	end)
	slot0:AddBtnListenerScale(slot0.btn_goddess, nil, function ()
		JumpTools.GoToSystem("/newHero", nil, ViewConst.SYSTEM_ID.HERO)
	end)
	slot0:AddBtnListenerScale(slot0.btn_shop, nil, function ()
		JumpTools.GoToSystem("/rechargeEnter", nil, ViewConst.SYSTEM_ID.SHOP_ENTER)
	end)
	slot0:AddBtnListenerScale(slot0.btn_backPake, nil, function ()
		JumpTools.GoToSystem("/bag", nil, ViewConst.SYSTEM_ID.BAG)
	end)
	slot0:AddBtnListenerScale(slot0.btnGuild_, nil, function ()
		if JumpTools.IsSystemOperationStoped(ViewConst.SYSTEM_ID.GUILD) then
			ShowTips("ERROR_FUNCTION_STOP")

			return nil
		end

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.GUILD) then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.GUILD, slot0))

			return
		end

		if GuildData:GetGuildInfo().id == nil then
			GuildAction.EnterGuild()
		else
			GuildAction.RequiredGuildInfo(function (slot0)
				if isSuccess(slot0.result) then
					JumpTools.OpenPageByJump("/guildEntrace/guildMain")
				else
					ShowTips(slot0.result)
				end
			end)
		end
	end)
	slot0:AddBtnListenerScale(slot0.btn_dorm_, nil, function ()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.DORM, slot0))

			return nil
		end

		if GameDisplayCfg.dorm_begin_story.value[1] and not manager.story:IsStoryPlayed(slot1) then
			slot2 = uv0

			slot2:MuteAudio()

			slot2 = manager.story

			slot2:StartStoryById(slot1, function (slot0)
				JumpTools.OpenPageByJump("/backHomeEnterView")
			end)
		else
			JumpTools.OpenPageByJump("/backHomeEnterView")
		end
	end)
	slot0:AddBtnListenerScale(slot0.btn_draw, nil, function ()
		JumpTools.GoToSystem("/draw", nil, ViewConst.SYSTEM_ID.DRAW)
	end)
	slot0:AddBtnListenerScale(slot0.btn_appear, nil, function ()
		uv0.barCon_:SetSelectedState("on")
	end)
	slot0:AddBtnListenerScale(slot0.btn_hide, nil, function ()
		uv0.barCon_:SetSelectedState("off")
	end)
end

function slot0.OnEnter(slot0)
	slot0:CheckIsNeedOpenWebPage()
	slot0:UpdateFollowGiftRedPoint()
	SurveyAction.UpdateSurveyRedPoint()
	ReduxFactory.GetInstance():OnMainHomeViewTop()
	manager.ui:SetMainCamera("home")

	slot0.noNeedCreateModel_ = false
	slot0.userData_ = PlayerData:GetPlayerInfo()

	slot0.barCon_:SetSelectedState("off")
	slot0:RefreshUserInfo()
	slot0:RefreshDeviceMessage()
	slot0:RefreshVitalityLimit()
	slot0:RefreshPosterGirl(slot0.userData_.poster_girl, HeroTools.HeroUsingSkinInfo(slot0.userData_.poster_girl).id)
	slot0:RefreshBanner()

	if slot0.updateTimer == nil then
		slot0.updateTimer = Timer.New(function ()
			uv0:RefreshDeviceMessage()
			uv0:RefreshVitalityLimit()
		end, 1, -1)
	end

	slot0.updateTimer:Start()
	slot0.barCon_:SetSelectedState("on")

	if slot0.idleTimer_ == nil then
		slot0.idleTimer_ = Timer.New(function ()
			uv0:PlayInteractionAnimation("idle")
		end, 90, -1)
	end

	slot0.idleTimer_:Start()
	slot0:UpdataOperationViewRedPoint()
	slot0:BindRedPointUI()
	slot0:RegistEventListener(SHAKING_MOBILE, function ()
		uv0:PlayInteractionAnimation("shaking")
	end)
	slot0:RegistEventListener(PASSPORT_INIT, function ()
		uv0:CheckPassportBtn()
	end)
	slot0:CheckPassportBtn()

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER) then
		ChipAction:UpdateChipRed()
	end

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.FRIEND) then
		FriendsAction:UpdateFriendsRedTip()
	end

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHAT) then
		ChatAction.EnterChatUI(1)
		slot0:RefreshReceiveMessage()
		slot0.chatCon_:SetSelectedState("on")
	else
		slot0.textLimit_:SetText("")
		slot0.chatCon_:SetSelectedState("off")
	end

	SetActive(slot0.goNewbie_, not JumpTools.IsConditionLocked({
		2,
		GameSetting.newbie_unlock_level_id.value[1]
	}) and not ActivityNewbieTools.IsFinishAllActivity())
	SetActive(slot0.btn_newbie_task.gameObject, GameSetting.advanced_task_open.value[1] <= PlayerData:GetPlayerInfo().userLevel and not TaskData:IsCompletedAllNoobAdvanceTask())
	SetActive(slot0.btn_regression.gameObject, RegressionData:IsRegressionOpen())
	slot0:CheckLocked()
	slot0:CheckActivite()
	slot0:RefreshHeroInteractionGM()
	slot0.activityEntraceView_:OnEnter()
	slot0:CheckHighFpsDeviceSupport()
	BulletinData.SetIslogin(true)
	BulletinTools.TryToCreatTips()
	manager.notify:RegistListener(MUTE_MAIN_AUDIO, slot0.muteAudioHandler_)
end

function slot0.DelayToPlayMultiTouchInteraction(slot0)
	if slot0.playingInteraction_ then
		return
	end

	slot0.clickCount_ = slot0.clickCount_ + 1

	if slot0.multiTouchTimer_ == nil then
		slot0.multiTouchTimer_ = Timer.New(function ()
			if uv0.multiTouchTimer_ then
				uv0.multiTouchTimer_:Stop()

				uv0.multiTouchTimer_ = nil
			end

			if uv0.clickCount_ >= 3 then
				uv0:PlayInteractionAnimation("mainQuickTouch")
				SDKTools.SendMessageToSDK("poster_touch", {
					touch_times = 3,
					hero_id = uv0.posterGirlId_
				})
			else
				uv0:PlayInteractionAnimation("mainTouch")
				SDKTools.SendMessageToSDK("poster_touch", {
					touch_times = 1,
					hero_id = uv0.posterGirlId_
				})
			end

			uv0.clickCount_ = 0
		end, 0.5, 1)

		slot0.multiTouchTimer_:Start()
	end
end

function slot0.CheckIsNeedOpenWebPage(slot0)
	slot1 = GameToSDK.GetData("{\"dataType\" : \"GetWebPageURL\"}")

	print("check webPageUrl", slot1)

	if not string.isNullOrEmpty(slot1) then
		LuaForUtil.OpenWebView(slot1, true)
	end
end

function slot0.UpdateFollowGiftRedPoint(slot0)
	slot1 = getData("SDK", "followGift") or 1

	if not table.keyof(OperationData:GetOperationOpenList(), OperationConst.ATTENTION) then
		slot1 = 0
	end

	manager.redPoint:setTip(RedPointConst.FOLLOW_GIFT, slot1)
end

function slot0.UpdateDormArchitectureRedPoint(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(DormData:GetAllHeroInDorm()) do
		slot9 = slot7.heroID
		slot2[slot8] = (slot2[slot7.architectureID] or 0) + DormTools.getHeroEarn(slot9) + DormData:GetDormHero(slot9):GetEarnings()
	end

	for slot6, slot7 in pairs(slot2) do
		if GameSetting.dorm_entrance_red_dot_need.value[1] < slot7 then
			manager.redPoint:setTip(RedPointConst.DORM_TOTAL_EARN, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.DORM_TOTAL_EARN, 0)
end

function slot0.UpdateDormSpecialEventRedPoint(slot0)
	if #DormData:GetSpecialEvents() ~= 0 then
		manager.redPoint:setTip(RedPointConst.DORM_SPECIAL_EVENT, 1)
	else
		manager.redPoint:setTip(RedPointConst.DORM_SPECIAL_EVENT, 0)
	end
end

function slot0.UpdataSettingNewFunctionRedPoint(slot0)
	manager.redPoint:setTip(RedPointConst.SETTING_NEW_FUNCTION, getData("setting", "newFunction") or 1)
end

function slot0.RefreshUserInfo(slot0)
	slot1 = slot0.userData_
	slot0.name_.text = slot1.nick
	slot0.uid_.text = string.format("%d", slot1.userID)
	slot0.level_.text = string.format("%d", slot1.userLevel)
	slot2 = slot0.userData_.remain_exp

	if LvTools.GetIsMaxLv(slot0.userData_.userLevel, "user") then
		slot0.expImg_.fillAmount = 1
	else
		slot0.expImg_.fillAmount = GameLevelSetting[slot3].user_level_exp == 0 and 0 or slot2 / slot4
	end
end

function slot0.RefreshDeviceMessage(slot0)
	if manager.time:STimeDescS(manager.time:GetServerTime(), "!%H:%M") ~= slot0.lastTimeString_ then
		slot0.time_.text = slot1
		slot0.lastTimeString = slot1
	end

	if Application.internetReachability ~= slot0.lastNetMessage_ then
		SetActive(slot0.signal_, slot2 == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork)
		SetActive(slot0.wifi_, slot2 == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork)

		slot0.lastNetMessage_ = slot2
	end

	if UnityEngine.SystemInfo.batteryLevel ~= slot0.lastBatteryLevel_ then
		slot0.battery_.fillAmount = slot3
		slot0.lastBatteryLevel_ = slot3
	end
end

function slot0.RefreshVitalityLimit(slot0)
	slot1 = {}
	slot2 = manager.time:GetServerTime()
	slot7 = ItemConst.ITEM_SUB_TYPE.PROPS_VITALITY_TIME_VALID

	for slot7, slot8 in ipairs(MaterialData:GetMaterialListBySubTypes({
		slot7
	})) do
		if ItemTools.GetItemExpiredTimeByInfo(slot8) ~= nil and slot9 ~= 0 and slot2 < slot9 then
			table.insert(slot1, slot8)
		end
	end

	if #slot1 <= 0 then
		SetActive(slot0.vitalityTimerGo_, false)

		return
	end

	table.sort(slot1, function (slot0, slot1)
		if ((ItemTools.GetItemExpiredTimeByInfo(slot0) or 0) > 0 and 1 or 0) ~= ((ItemTools.GetItemExpiredTimeByInfo(slot1) or 0) > 0 and 1 or 0) then
			return slot5 < slot4
		end

		if slot2 ~= slot3 then
			return slot2 < slot3
		end

		return slot0.id < slot1.id
	end)

	slot0.vitalityTimerText_.text = manager.time:GetLostTimeStr(slot1[1].time_valid)

	SetActive(slot0.vitalityTimerGo_, true)
end

function slot0.UpdataOperationViewRedPoint(slot0)
	slot1 = OperationData:GetOperationOpenList()

	if RedPointData:GetRedPointOpen(RED_POINT_ID.ACTIVITY) and table.keyof(slot1, OperationConst.ACTIVITY) ~= nil then
		manager.redPoint:setTip(RedPointConst.OPERATION_ACTIVITY, 1)
	else
		manager.redPoint:setTip(RedPointConst.OPERATION_ACTIVITY, 0)
	end

	if RedPointData:GetRedPointOpen(RED_POINT_ID.FORUM) and table.keyof(slot1, OperationConst.FORUM) ~= nil then
		manager.redPoint:setTip(RedPointConst.FORUM, 1)
	else
		manager.redPoint:setTip(RedPointConst.FORUM, 0)
	end

	if RedPointData:GetRedPointOpen(RED_POINT_ID.SHOP_TAOBAO) and table.keyof(slot1, OperationConst.SHOP_TAOBAO) ~= nil then
		manager.redPoint:setTip(RedPointConst.SHOP_TAOBAO, 1)
	else
		manager.redPoint:setTip(RedPointConst.SHOP_TAOBAO, 0)
	end
end

function slot0.RefreshPosterGirl(slot0, slot1, slot2)
	if slot0.posterGirlId_ == slot2 then
		return
	end

	slot0.posterGirlId_ = slot2

	if HeroCfg[slot1] then
		slot4 = HeroTools.HeroUsingSkinInfo(slot1)
		slot0.skinId_ = slot4.id
		slot7 = "Char/" .. slot4.main_model_id
		slot8 = slot4.home_weapon_show and slot4.home_weapon_show ~= 0

		if slot0 and not slot0.noNeedCreateModel_ then
			if slot0.tpose_ then
				manager.resourcePool:DestroyOrReturn(slot0.tpose_, ASSET_TYPE.TPOSE)

				slot0.tpose_ = nil
			end

			slot0.tpose_ = manager.resourcePool:Get(slot7, ASSET_TYPE.TPOSE)
			slot9 = HeroPosAndRotCfg[slot3.id].position_main
			slot10 = HeroPosAndRotCfg[slot3.id].rotation_main
			slot11 = HeroPosAndRotCfg[slot3.id].scale_main
			slot0.tpose_.transform.localPosition = Vector3.New(slot9[1], slot9[2], slot9[3])
			slot0.tpose_.transform.localEulerAngles = Vector3.New(slot10[1], slot10[2], slot10[3])
			slot0.tpose_.transform.localScale = Vector3.New(slot11[1], slot11[2], slot11[3])

			if slot0:FindTrs(slot2 .. "ui", slot0.tpose_.transform) then
				slot12.localEulerAngles = Vector3.zero
			end

			if slot0:FindTrs(string.format("%dui/%dui_tpose", slot5, slot5), slot0.tpose_.transform) then
				slot14 = slot0:FindCom(typeof(Animator), "", slot13)
				slot0.animator_ = slot14

				if slot14 then
					LuaForUtil.EnableEyeController(slot13.transform, true)
					manager.resourcePool:ResetBlendShapes(slot13.transform)
					slot14:Play("action1_1")
				end

				HeroTools.SetHeroModelWeaponActivity(slot13, slot8)
			end

			if slot0.params_.changePoster then
				slot0.params_.changePoster = nil

				if not slot0.assistantVoiceTime_ or HeroConst.SET_ASSISTANT_VOICE_CD <= Time.realtimeSinceStartup - slot0.assistantVoiceTime_ then
					slot0.assistantVoiceTime_ = Time.realtimeSinceStartup

					slot0:PlayInteractionAnimation("showing")
				end
			end
		end
	end
end

function slot0.RefreshBanner(slot0)
	slot0.bannerView_:RefreshData(slot0, {
		space = 0,
		data = ActivityTools.GetCurrentAdvInfo(),
		onclick = function (slot0)
			if not ActivityTools.IsValidAdv(slot0.id) then
				ShowTips("TIME_OVER")
				uv0:RefreshBanner()

				return
			end

			ActivityTools.ClickAdv(slot0)
			OperationRecorder.Record("home", "activity_open")
		end
	})
end

function slot0.PlayInteractionAnimation(slot0, slot1)
	if slot0.interactionTimer_ then
		slot0.interactionTimer_:Stop()

		slot0.interactionTimer_ = nil
	end

	if HeroTools:GetUnlockInteractionCfg(SkinCfg[slot0.skinId_].hero) and slot3[slot1 .. "_talk"] ~= nil and #slot3[slot1 .. "_talk"] > 0 then
		slot5 = #slot3[slot1] > 0

		if #slot3[slot1 .. "_talk"] == 1 then
			slot0:PlaySpecialAnimation(slot5 and slot3[slot1][1] or nil, slot3[slot1 .. "_talk"][1], slot3[slot1 .. "_delay"][1])
		else
			slot7 = slot0:RandomIndexOfInteractionType(slot1 .. "_talk")

			slot0:PlaySpecialAnimation(slot5 and slot3[slot1][slot7] or nil, slot3[slot1 .. "_talk"][slot7], slot3[slot1 .. "_delay"][slot7])
		end
	end
end

function slot0.PlaySpecialAnimation(slot0, slot1, slot2, slot3)
	if slot0.playingInteraction_ then
		return
	end

	if slot0.idleTimer_ then
		slot0.idleTimer_:Reset()
	end

	if slot0.animator_ and slot1 ~= nil then
		LuaForUtil.EnableEyeController(slot0.animator_.transform, false)
		manager.resourcePool:ResetBlendShapes(slot0.animator_.transform)
		AnimatorTools.PlayAnimationWithCallback(slot0.animator_, slot1, handler(slot0, slot0.OnPlaySpecialCallback))

		slot0.playingInteraction_ = true
	else
		slot0.playingInteraction_ = false
	end

	slot4 = SkinCfg[slot0.skinId_].hero
	slot5 = string.split(slot2, "_")

	print(string.format("播放%d的%s动作，声音为%s， 延迟为 %d 毫秒", slot0.skinId_, tostring(slot1), tostring(slot2), slot3))

	slot6 = nil

	if slot0.animator_ then
		slot6 = slot0.animator_.transform
	end

	if slot3 > 0 then
		if slot0.talkDelayTimer_ then
			slot0.talkDelayTimer_:Stop()

			slot0.talkDelayTimer_ = nil
		end

		slot0.talkDelayTimer_ = Timer.New(function ()
			uv0:PlayHeroTalk(uv1[1], uv1[2], nil, uv2)
		end, slot3 / 1000)

		slot0.talkDelayTimer_:Start()
	else
		slot0:PlayHeroTalk(slot5[1], slot5[2], nil, slot6)
	end
end

function slot0.OnPlaySpecialCallback(slot0)
	slot0.playingInteraction_ = false

	if slot0.animator_ then
		LuaForUtil.EnableEyeController(slot0.animator_.transform, true)
		manager.resourcePool:ResetBlendShapes(slot0.animator_.transform)
		AnimatorTools.CrossFade(slot0.animator_, "action1_1")
	end
end

function slot0.PlayHeroTalk(slot0, slot1, slot2, slot3, slot4)
	HeroTools.PlayTalk(slot1, slot2, slot3, slot4)

	slot5 = manager.audio:GetVoiceLength(string.format("vo_sys_%d", slot1), string.format("v_s_%d_%s", slot1, slot2), string.format("vo_sys_%d.awb", slot1))

	if HeroVoiceCfg.get_id_list_by_file[slot2] then
		if HeroVoiceDescCfg[tonumber(slot1)] then
			SetActive(slot0.talkBubbleGo_, true)

			slot0.talkLabel_.text = slot8[slot6[1]]

			if slot0.talkBubbleTimer_ ~= nil then
				slot0.talkBubbleTimer_:Stop()

				slot0.talkBubbleTimer_ = nil
			end

			slot0.talkBubbleTimer_ = TimeTools.StartAfterSeconds(slot5 / 1000, function ()
				SetActive(uv0.talkBubbleGo_, false)

				if uv0.talkBubbleTimer_ ~= nil then
					uv0.talkBubbleTimer_:Stop()

					uv0.talkBubbleTimer_ = nil
				end
			end, {})
		else
			error(string.format("HeroVoiceDescCfg don't have any items which id = %s", tostring(slot1)))
		end
	else
		error(string.format("HeroVoiceCfg don't have any items which file = %s", tostring(slot2)))
	end
end

function slot0.RandomIndexOfInteractionType(slot0, slot1)
	slot2 = tostring(SkinCfg[slot0.skinId_].hero) .. "_" .. slot1

	if not slot0.lastRandom_ then
		slot0.lastRandom_ = {}
	end

	slot4 = slot0.lastRandom_[slot2] or 0
	slot5 = {}
	slot6 = {}

	if not HeroTools:GetUnlockInteractionCfg(SkinCfg[slot0.skinId_].hero) then
		print("error")
	end

	for slot10, slot11 in ipairs(slot3[slot1]) do
		if slot10 ~= slot4 then
			table.insert(slot5, slot11)
			table.insert(slot6, slot10)
		end
	end

	slot9 = slot6[math.round(math.random(#slot6))]
	slot0.lastRandom_[slot2] = slot9

	return slot9
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.btn_mail_transform, RedPointConst.MAIL_UNREAD)
	manager.redPoint:bindUIandKey(slot0.btn_combat_transform, RedPointConst.COMBAT)
	manager.redPoint:bindUIandKey(slot0.btn_goddess_transform, RedPointConst.GODDESS)
	manager.redPoint:bindUIandKey(slot0.btn_task_transform, RedPointConst.TASK)
	manager.redPoint:bindUIandKey(slot0.hero_transform, RedPointConst.HERO)
	manager.redPoint:bindUIandKey(slot0.btn_friends_.transform, RedPointConst.FRIEND)
	manager.redPoint:bindUIandKey(slot0.btn_passport.transform, RedPointConst.PASSPORT)
	manager.redPoint:bindUIandKey(slot0.btn_shop_red.transform, RedPointConst.RECHARGE_ENTER)
	manager.redPoint:bindUIandKey(slot0.btn_message.transform, RedPointConst.ILLU_MAIN)
	manager.redPoint:bindUIandKey(slot0.transformNewbie_, RedPointConst.NEWBIE_POINT)
	manager.redPoint:bindUIandKey(slot0.btnGuild_.transform, RedPointConst.GUILD)
	manager.redPoint:bindUIandKey(slot0.btn_regression.transform, RedPointConst.REGRESSION)
	manager.redPoint:bindUIandKey(slot0.btnPreviewTask_.transform, RedPointConst.PREVIEW_TASK)
	manager.redPoint:bindUIandKey(slot0.btn_menu.transform, RedPointConst.MAIN_HOME_MENU)
	manager.redPoint:bindUIandKey(slot0.btn_callback.transform, RedPointConst.RECALL)
	manager.redPoint:bindUIandKey(slot0.btn_newbie_task.transform, RedPointConst.NOOB_ADVANCE)
	manager.redPoint:bindUIandKey(slot0.btn_dorm_.transform, RedPointConst.BACKHOME)
end

function slot0.CheckPassportBtn(slot0)
	if PassportData:IsOpen() and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.PASSPORT_MAIN) then
		SetActive(slot0.btn_passport.gameObject, true)
	else
		SetActive(slot0.btn_passport.gameObject, false)
	end
end

function slot0.CheckLocked(slot0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DRAW) then
		ControllerUtil.GetController(slot0.btn_draw.gameObject.transform, "locked"):SetSelectedState("true")
	else
		ControllerUtil.GetController(slot0.btn_draw.gameObject.transform, "locked"):SetSelectedState("false")
	end

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		ControllerUtil.GetController(slot0.btn_dorm_.gameObject.transform, "locked"):SetSelectedState("true")
	else
		ControllerUtil.GetController(slot0.btn_dorm_.gameObject.transform, "locked"):SetSelectedState("false")
	end

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.GUILD) then
		ControllerUtil.GetController(slot0.btnGuild_.gameObject.transform, "name"):SetSelectedState("true")
	else
		ControllerUtil.GetController(slot0.btnGuild_.gameObject.transform, "name"):SetSelectedState("false")
	end

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SHOP_ENTER) then
		ControllerUtil.GetController(slot0.btn_shop.transform, "name"):SetSelectedState("true")
	else
		ControllerUtil.GetController(slot0.btn_shop.transform, "name"):SetSelectedState("false")
	end
end

function slot0.CheckRecallActivity(slot0)
	slot2 = ActivityRecallData:GetDataByPara("recallLevel")
	slot3 = ActivityRecallData:GetDataByPara("recallActivityID")

	if ActivityData:GetActivityData(ActivityConst.RECALL_INVITE).stopTime == 1 or slot0.userData_.userLevel < slot2 or slot3 == nil then
		SetActive(slot0.btn_callback.gameObject, false)
	else
		SetActive(slot0.btn_callback.gameObject, manager.time:GetServerTime() < slot1.stopTime)
	end
end

function slot0.CheckActivite(slot0)
	function slot1()
		uv0:CheckHeroGiftActivite()
		uv0:CheckPreviewTaskActivity()
		uv0:CheckRecallActivity()
	end

	slot1()

	slot0.activiteTime_ = Timer.New(slot1, 1, -1)

	slot0.activiteTime_:Start()
end

function slot0.CheckHeroGiftActivite(slot0)
	if slot0.isHeroGiftOpen_ == (ActivityData:GetActivityIsOpen(ActivityConst.HELLA_HERO_GIFT) and HeroGiftData:GetReceiveHeroGift(ActivityConst.HELLA_HERO_GIFT) == 0) then
		return
	end

	slot0.isHeroGiftOpen_ = slot1

	SetActive(slot0.btnHeroGiftGo_, slot1)
end

function slot0.CheckPreviewTaskActivity(slot0)
	if slot0.isPreviewTaskOpen_ == ActivityData:GetActivityIsOpen(PreviewTaskData:GetCurActivityID()) then
		return
	end

	slot0.isPreviewTaskOpen_ = slot2

	SetActive(slot0.btnPreviewTaskGo_, slot2)
end

function slot0.CheckHighFpsDeviceSupport(slot0)
	slot2 = GameLocalData:GetCommonModule("highFps").checkDevice == nil
	slot3 = false

	if _G.MODEL ~= nil then
		slot4 = _G.CPUINFO
		slot5 = _G.MODEL

		for slot9, slot10 in pairs(HighFpsSupportCfg) do
			slot11 = slot10.is_support

			if slot4 == slot9 or slot5 == slot9 then
				slot3 = slot11 == 1

				break
			end
		end
	end

	if slot3 and slot2 == true then
		manager.redPoint:setTip(RedPointConst.HIGH_FPS_DEVICE_SURRPORT, 1)
	end

	GameLocalData:SaveToCommonModule("highFps", "deviceSupport", slot3)
end

function slot0.RefreshHeroInteractionGM(slot0)
	HeroInteractionGMData:Updata(slot0.skinId_, slot0.idleTimer_, slot0.animator_)
end

function slot0.Render(slot0)
end

function slot0.ChangePosterCallback(slot0)
end

function slot0.UnBindRedPointUI(slot0, slot1, slot2)
	manager.redPoint:unbindUIandKey(slot1, slot2)

	if slot1:Find("notice_img") then
		SetActive(slot3.gameObject, false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.vitalityTimerGo_.transform)
end

function slot0.RemovePosterTween(slot0)
	if slot0.posterTween_ then
		slot0.posterTween_:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(slot0.posterTween_.id)

		slot0.posterTween_ = nil
	end
end

function slot0.PlayHeroGreeting(slot0)
	slot0:DelayToPlayInteractionAnimation("greeting", 1.2)
end

function slot0.DelayToPlayInteractionAnimation(slot0, slot1, slot2)
	if slot0.playingInteraction_ then
		return
	end

	if slot2 == nil then
		slot2 = 1
	end

	if slot0.interactionTimer_ then
		slot0.interactionTimer_:Stop()

		slot0.interactionTimer_ = nil
	end

	slot0.interactionTimer_ = TimeTools.StartAfterSeconds(slot2, handler(slot0, slot0.PlayInteractionAnimation), {
		slot1
	})
end

function slot0.CheckSomething(slot0)
	slot2 = RechargeData:HaveMonthCard() and not RechargeData:IsSignToday() and not manager.guide:IsPlaying()
	slot4 = SurveyData:GetPraise() and not manager.guide:IsPlaying()
	slot5 = ChatData:IsMuted() and not ChatData:GetShowMutedTips() and not manager.guide:IsPlaying()
	slot6 = RegressionData:CheckRegressionGift() and not manager.guide:IsPlaying()
	slot7 = ActivityAdvertiseTools.NeedShowAdvertise() and not manager.guide:IsPlaying()

	if SignTools.IsCanSign() and not manager.guide:IsPlaying() or slot4 or slot6 or slot5 or slot7 then
		SetActive(slot0.mask_, true)
	else
		SetActive(slot0.mask_, false)
	end

	if slot0.needToPlayTalk_ and not slot3 and not slot4 then
		slot0:PlayHeroGreeting()

		slot0.needToPlayTalk_ = false
	end

	if slot0.params_.isFirstCheck then
		if slot3 or slot4 then
			slot0.needToPlayTalk_ = true
		else
			slot0:PlayHeroGreeting()
		end

		slot0.params_.isFirstCheck = false
	end

	if slot0.showTimer_ or not slot3 and not slot4 and not slot2 and not slot5 and not slot6 and not slot7 then
		return
	end

	slot8 = Timer.New(function ()
		uv0.showTimer_ = nil

		if manager.guide:IsPlaying() then
			return
		end

		if uv1 then
			JumpTools.OpenPageByJump("sign", {
				check = true,
				activityID = ActivityConst.SIGN
			}, ViewConst.SYSTEM_ID.SIGN)

			return
		end

		if uv2 then
			JumpTools.OpenPageByJump("sign", {
				check = true,
				activityID = ActivityConst.SIGN
			}, ViewConst.SYSTEM_ID.SIGN)

			return
		end

		if uv3 then
			JumpTools.OpenPageByJump("praise")

			return
		end

		if uv4 then
			JumpTools.OpenPageByJump("activityAdvertise")

			return
		end

		if uv5 then
			JumpTools.OpenPageByJump("chatMuted")

			return
		end

		if uv6 then
			JumpTools.OpenPageByJump("regressionNewGift")

			return
		end
	end, 1, 1)
	slot0.showTimer_ = slot8

	slot8:Start()
end

function slot0.InitBar(slot0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:SetBarType(CurrencyConst.CURRENCY_TYPE_VITALITY, "hyaline")
	manager.windowBar:SetBarType(CurrencyConst.CURRENCY_TYPE_GOLD, "hyaline")
	manager.windowBar:SetBarType(CurrencyConst.CURRENCY_TYPE_DIAMOND, "hyaline")
	manager.windowBar:SetBarType(CurrencyConst.GetPlatformDiamondId(), "hyaline")
end

function slot0.OnTop(slot0)
	slot0:InitBar()
	manager.windowBar:SetPlayAni()
	RedPointAction.UpdateSDKRedPoint()
	slot0:CheckSomething()

	slot1 = HeroTools.HeroUsingSkinInfo(slot0.userData_.poster_girl).id

	if slot0.posterGirlId_ and slot1 ~= slot0.posterGirlId_ then
		slot0:RefreshPosterGirl(slot0.userData_.poster_girl, slot1)

		slot0.characterEffect_ = slot0:FindCom("CharacterEffect", string.format("%dui/%dui_tpose", slot1, slot1), slot0.tpose_.transform)
		slot0.characterEffect_.ditherAlpha = 0
		slot2 = slot0.characterEffect_

		slot2:ForceUpdate()
		slot0:RemovePosterTween()

		slot2 = LeanTween.value(slot0.tpose_.gameObject, 0, 1, 0.3)
		slot2 = slot2:setEase(LeanTweenType.linear)
		slot2 = slot2:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.characterEffect_.ditherAlpha = slot0
		end))
		slot0.posterTween_ = slot2:setOnComplete(LuaHelper.VoidAction(function ()
			uv0:RemovePosterTween()
		end))
	end

	slot0:CheckCooperationInviteEntry()
end

function slot0.GetCooperationInviteEntryGo(slot0)
	return slot0.m_inviteBtn.gameObject
end

function slot0.RefreshReceiveMessage(slot0)
	slot0:ClearMsgTimer()

	slot0.msgTimer_ = Timer.New(function ()
		slot0 = ChatData:GetWorldChatData()

		if slot0[#slot0] then
			slot2 = ""
			slot3 = ""

			if slot1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or slot1.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
				slot2 = slot1.id == USER_ID and (PlayerData:GetPlayerInfo().nick or "") or slot1.nick or ""
				slot3 = slot1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and (slot1.content or "") or string.format("[%s]", ChatStickerCfg[tonumber(slot1.content)].name)
			end

			slot4 = ""

			if slot2 ~= "" then
				slot4 = slot2 .. ":" .. slot3
			end

			uv0.textLimit_:SetText(slot4)

			return
		end

		uv0.textLimit_:SetText("")
	end, 2, -1)

	slot0.msgTimer_:Start()
end

function slot0.ClearMsgTimer(slot0)
	if slot0.msgTimer_ then
		slot0.msgTimer_:Stop()

		slot0.msgTimer_ = nil
	end
end

function slot0.OnHomeSignUpdate(slot0)
	slot0:CheckSomething()
end

function slot0.OnHeroGiftReward(slot0)
	slot0:CheckHeroGiftActivite()
end

function slot0.OnChangeNickname(slot0, slot1)
	slot0.name_.text = slot1.nick
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(MUTE_MAIN_AUDIO, slot0.muteAudioHandler_)
	slot0:RemoveAllEventListener()
	SetActive(slot0.talkBubbleGo_, false)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	slot0:MuteAudio()
	slot0:ClearMsgTimer()
	slot0.activityEntraceView_:OnExit()

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHAT) then
		ChatAction.EnterChatUI(2)
	end

	if slot0.tpose_ then
		slot0.tpose_.transform.localScale = Vector3.New(1, 1, 1)

		manager.resourcePool:DestroyOrReturn(slot0.tpose_, ASSET_TYPE.TPOSE)

		slot0.tpose_ = nil
		slot0.posterGirlId_ = nil
	end

	if slot0.updateTimer then
		slot0.updateTimer:Stop()

		slot0.updateTimer = nil
	end

	if slot0.showTimer_ then
		slot0.showTimer_:Stop()

		slot0.showTimer_ = nil
	end

	if slot0.redPointTimer_ then
		slot0.redPointTimer_:Stop()

		slot0.redPointTimer_ = nil
	end

	if slot0.activiteTime_ then
		slot0.activiteTime_:Stop()

		slot0.activiteTime_ = nil
	end

	if slot0.multiTouchTimer_ then
		slot0.multiTouchTimer_:Stop()

		slot0.multiTouchTimer_ = nil
	end

	slot0.isHeroGiftOpen_ = nil

	AnimatorTools.Stop()
	slot0:UnBindRedPointUI(slot0.btn_mail_transform, RedPointConst.MAIL_UNREAD)
	slot0:UnBindRedPointUI(slot0.btn_combat_transform, RedPointConst.COMBAT)
	slot0:UnBindRedPointUI(slot0.btn_goddess_transform, RedPointConst.GODDESS)
	slot0:UnBindRedPointUI(slot0.btn_task_transform, RedPointConst.TASK)
	slot0:UnBindRedPointUI(slot0.hero_transform, RedPointConst.HERO)
	slot0:UnBindRedPointUI(slot0.btn_friends_.transform, RedPointConst.FRIEND)
	slot0:UnBindRedPointUI(slot0.btn_passport.transform, RedPointConst.PASSPORT)
	slot0:UnBindRedPointUI(slot0.btn_shop_red.transform, RedPointConst.RECHARGE_ENTER)
	slot0:UnBindRedPointUI(slot0.btn_message.transform, RedPointConst.ILLU_MAIN)
	slot0:UnBindRedPointUI(slot0.transformNewbie_, RedPointConst.NEWBIE_POINT)
	slot0:UnBindRedPointUI(slot0.btnGuild_.transform, RedPointConst.GUILD)
	slot0:UnBindRedPointUI(slot0.btn_regression.transform, RedPointConst.REGRESSION)
	slot0:UnBindRedPointUI(slot0.btnPreviewTask_.transform, RedPointConst.PREVIEW_TASK)
	slot0:UnBindRedPointUI(slot0.btn_menu.transform, RedPointConst.MAIN_HOME_MENU)
	slot0:UnBindRedPointUI(slot0.btn_callback.transform, RedPointConst.RECALL)
	slot0:UnBindRedPointUI(slot0.btn_newbie_task.transform, RedPointConst.NOOB_ADVANCE)
	slot0:UnBindRedPointUI(slot0.btn_dorm_.transform, RedPointConst.BACKHOME)

	slot0.playingInteraction_ = false
end

function slot0.Dispose(slot0)
	slot0.muteAudioHandler_ = nil

	slot0.activityEntraceView_:Dispose()

	slot0.activityEntraceView_ = nil

	slot0:RemoveAllListeners()

	if slot0.bannerView_ then
		slot0.bannerView_:Dispose()

		slot0.bannerView_ = nil
	end

	slot0.noNeedCreateModel_ = true

	if slot0.hideChangeBtnDelayTimer_ then
		slot0.hideChangeBtnDelayTimer_:Stop()

		slot0.hideChangeBtnDelayTimer_ = nil
	end

	slot0:RemovePosterTween()
	uv0.super.Dispose(slot0)
end

return slot0
