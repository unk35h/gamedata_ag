slot0 = class("GuildBossMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubBossmain"
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

	slot0.indexController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "index")
	slot0.difficultyController_ = ControllerUtil.GetController(slot0.difficultyBtn_.transform, "difficulty")
	slot0.lockedController_ = ControllerUtil.GetController(slot0.difficultyBtn_.transform, "locked")
	slot0.checkedController_ = ControllerUtil.GetController(slot0.firstBonusBtn_.transform, "checked")
	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.nameList_ = {
		slot0.nameLabel1_,
		slot0.nameLabel2_,
		slot0.nameLabel3_,
		slot0.nameLabel4_,
		slot0.nameLabel5_
	}
	slot0.btnList_ = {
		slot0.challengeBtn1_,
		slot0.challengeBtn2_,
		slot0.challengeBtn3_,
		slot0.challengeBtn4_,
		slot0.challengeBtn5_
	}
	slot0.progressBarList_ = {
		slot0.progressBar1_,
		slot0.progressBar2_,
		slot0.progressBar3_,
		slot0.progressBar4_,
		slot0.progressBar5_
	}
	slot0.progressLabelList_ = {
		slot0.progressLabel1_,
		slot0.progressLabel2_,
		slot0.progressLabel3_,
		slot0.progressLabel4_,
		slot0.progressLabel5_
	}
	slot0.lockedBtnList_ = {
		slot0.lockedBtn1_,
		slot0.lockedBtn2_,
		slot0.lockedBtn3_,
		slot0.lockedBtn4_,
		slot0.lockedBtn5_
	}
	slot0.affixList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.buffListGo_, AffixItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.haveGetBuffList_[slot1])
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.lockedBtnList_) do
		slot0:AddBtnListener(slot5, nil, function ()
			ShowTips("CLUB_BOSS_PREPOSE_FINISH_TIP")
		end)
	end

	for slot4, slot5 in ipairs(slot0.btnList_) do
		slot0:AddBtnListener(slot5, nil, function ()
			uv0:EnterLevel(uv1)
		end)
	end

	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
			uv0.indexController_:SetSelectedIndex(0)
		end
	end)
	slot0:AddBtnListener(slot0.bossBtn_, nil, function ()
		JumpTools.OpenPageByJump("/guildBossChallenge", {})
	end)
	slot0:AddBtnListener(slot0.firstBonusBtn_, nil, function ()
		if GuildData:CanGetBonus() then
			GuildAction.GetGuildBossReward(GuildData:GetGuildInfo().id, 3, 1)

			return
		end

		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = ClubBossPreposeCfg[1].personal_reward
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
	end)
	slot0:AddBtnListener(slot0.difficultyBtn_, nil, function ()
		if not GuildData:IsCaptainOrDeputy() then
			ShowTips("CLUB_BOSS_DIFFICULTY_CANT_TIP")

			return
		end

		slot0, slot1 = GuildData:GetLastTime()

		uv0.statusController_:SetSelectedState(slot0)

		if slot0 == "challenge" then
			ShowTips("CLUB_BOSS_DIFFICULTY_EXPIRED_TIP")

			return
		end

		JumpTools.OpenPageByJump("guildDifficultChose", {})
	end)
	slot0:AddBtnListener(slot0.helpSettingBtn_, nil, function ()
		JumpTools.OpenPageByJump("/guildBossSetAssistant", {})
	end)

	slot1 = slot0.eventTrigger_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0:IsOpenSectionView() then
			JumpTools.Back()
		end

		uv0.drag_ = true
	end))

	slot1 = slot0.eventTrigger_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0.drag_ = false
	end))
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_BOSS_INIT, function ()
		uv0.haveGetBuffList_ = GuildData:GetHaveGetBossBuffList()
		uv0.stageDataList_ = GuildData:GetPreInfoList()

		uv0:UpdateView()
	end)
	slot0:RegistEventListener(GUILD_BOSS_BONUS_GET, function ()
		uv0:UpdateFirstBonusCheck()
	end)
	slot0:RegistEventListener(GUILD_EXIT, function ()
		uv0:Go("/home")
	end)
	slot0:RegistEventListener(GUILD_BOSS_DIFFICULTY_CHANGE, function ()
		uv0:UpdateView()
	end)
end

function slot0.EnterLevel(slot0, slot1)
	slot0.indexController_:SetSelectedIndex(slot1)
	JumpTools.OpenPageByJump("guildBossSectionInfo", {
		index = slot1,
		section = slot0.stageDataList_[slot1].stage_id,
		sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE,
		activityId = slot0.params_.activityId,
		preData = slot0.stageDataList_[slot1]
	})
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
	slot0.indexController_:SetSelectedIndex(0)
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "guildBossNote",
		type = "jump",
		params = {}
	})
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
	GuildAction.RequestClubBossInfo(GuildData:GetGuildInfo().id)
	saveData("guild_boss", "prepose", 0)
	manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_OPEN, 0)
	manager.redPoint:bindUIandKey(slot0.bossRedPointContainer_, RedPointConst.GUILD_BOSS_BOSS_BTN, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(slot0.firstNoticeContainer_, RedPointConst.GUILD_BOSS_PREPOSE_FIRST_BONUS, {
		x = 0,
		y = 0
	})
	GuildAction.GetAssistBriefInfo(GuildData:GetGuildInfo().id)
	slot0:AddGuildBossTimer()

	if slot0.params_.isEnter then
		slot0.animator_:Play("ClubBossmain", -1, 0)

		slot0.animator_.speed = 1
	else
		slot1 = slot0.animator_:GetCurrentAnimatorClipInfo(0)

		slot0.animator_:Play(slot1[0].clip.name, 0, slot1[0].clip.length)

		slot0.animator_.speed = 0
	end

	slot0.params_.isEnter = nil
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.bossRedPointContainer_, RedPointConst.GUILD_BOSS_BOSS_BTN)
	manager.redPoint:unbindUIandKey(slot0.firstNoticeContainer_, RedPointConst.GUILD_BOSS_PREPOSE_FIRST_BONUS)
	slot0:RemoveAllEventListener()
	slot0:StopGuildBossTimer()
	manager.windowBar:HideBar()
end

function slot0.UpdateView(slot0)
	for slot4, slot5 in ipairs(slot0.stageDataList_) do
		slot0.nameList_[slot4].text = ClubBossPreposeCfg[slot4].name
		slot6 = ClubBossPreposeCfg[slot4].point_max
		slot7 = math.min(slot5.score, slot6)
		slot0.progressBarList_[slot4].fillAmount = slot7 / slot6
		slot0.progressLabelList_[slot4].text = string.format("%d", 100 * slot7 / slot6)
	end

	slot0.affixList_:StartScroll(#slot0.haveGetBuffList_)

	slot0.timeLabel_.text = string.format("%d/%d", GuildData:GetBossLastTime(), GameSetting.club_boss_prepose_max.value[1])

	slot0.difficultyController_:SetSelectedIndex(GuildData:GetBossDifficulty() - 1)
	slot0:UpdateGuildBossTimer()
	slot0:UpdateFirstBonusCheck()
end

function slot0.UpdateFirstBonusCheck(slot0)
	if GuildData:IsGetFirstBossBonus() then
		slot0.checkedController_:SetSelectedState("true")
	elseif GuildData:CanGetBonus() then
		slot0.checkedController_:SetSelectedState("canGet")
	else
		slot0.checkedController_:SetSelectedState("false")
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.IsOpenSectionView(slot0)
	return slot0:IsOpenRoute("guildBossSectionInfo")
end

function slot0.UpdateGuildBossTimer(slot0)
	slot1, slot2 = GuildData:GetLastTime()

	slot0.statusController_:SetSelectedState(slot1)

	if slot1 == "prepose" then
		slot0.stageLabel_.text = GetTips("CLUB_BOSS_PREPOSE_TIP")
		slot0.openTimeText_.text = GetTips("GONGHUIBOSS_LIEXIZHENGZHAO")
		slot0.lastDayLabel_.text = manager.time:GetLostTimeStr(slot2)

		slot0.lockedController_:SetSelectedState("false")
	else
		slot0.stageLabel_.text = GetTips("CLUB_BOSS_CHALLENGE_TIP")
		slot0.openTimeText_.text = GetTips("GONGHUIBOSS_LIEXIKAIFANG")
		slot0.lastDayLabel_.text = manager.time:GetLostTimeStr(slot2)

		slot0.lockedController_:SetSelectedState(GuildData:IsCaptainOrDeputy() and "true" or "false")
	end
end

function slot0.AddGuildBossTimer(slot0)
	if slot0.guildBossTimer_ == nil then
		slot0.guildBossTimer_ = Timer.New(function ()
			uv0:UpdateGuildBossTimer()
		end, 1, -1)
	end

	slot0.guildBossTimer_:Start()
end

function slot0.StopGuildBossTimer(slot0)
	if slot0.guildBossTimer_ then
		slot0.guildBossTimer_:Stop()

		slot0.guildBossTimer_ = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.affixList_ then
		slot0.affixList_:Dispose()

		slot0.affixList_ = nil
	end

	if slot0.payTimer_ ~= nil then
		slot0.payTimer_:Stop()

		slot0.payTimer_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
