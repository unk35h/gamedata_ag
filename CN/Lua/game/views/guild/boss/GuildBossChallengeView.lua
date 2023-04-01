slot0 = class("GuildBossChallengeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubBossChallengeUI"
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

	slot0.statusController_ = ControllerUtil.GetController(slot0.titleGo_.transform, "status")
	slot0.bonusLockController_ = ControllerUtil.GetController(slot0.bonusLockGo_.transform, "bonusLock")
	slot0.btnOpenController_ = ControllerUtil.GetController(slot0.prepareBtn_.transform, "btnOpen")
	slot0.difficultyController_ = ControllerUtil.GetController(slot0.difficultyGo_.transform, "difficulty")
	slot0.bonusList_ = LuaList.New(handler(slot0, slot0.indexBonusItem), slot0.bonusListGo_, GuildBossChallengeRewardItemView)
	slot5 = AffixItemView
	slot0.buffList_ = LuaList.New(handler(slot0, slot0.indexAffixItem), slot0.buffListGo_, slot5)
	slot0.avatarView_ = GuildBossAvatarView.New(slot0.displayGo_)
	slot0.skillList_ = {}
	slot1 = CollectMonsterCfg[GuildData:GetCurBossId()]

	for slot5 = 1, 6 do
		if slot1[string.format("skill%s", slot5)] ~= "" then
			slot0.skillList_[slot5] = BattleBossChallengeSkillItem.New(slot0.skillItemGo_, slot0.skillContainer_)
		end
	end
end

function slot0.indexBonusItem(slot0, slot1, slot2)
	slot2:SetData(slot0.bonusDataList_[slot1], GuildData:GetBossPersonalScore())
end

function slot0.indexAffixItem(slot0, slot1, slot2)
	slot2:SetData(slot0.haveGetBuffList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.prepareBtn_, nil, function ()
		slot0, slot1 = GuildData:GetLastTime()

		if slot0 == "prepose" then
			ShowTips("CLUB_BOSS_CHALLENGE_NOT_OPEN_TIP")

			return
		end

		uv0:Go("/guildBossSelectHero", {
			dest = 6,
			section = GuildData:GetCurrentBossStageId(),
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE
		})
	end)
	slot0:AddBtnListener(slot0.rankBtn_, nil, function ()
		JumpTools.OpenPageByJump("/guildBossRank", {})
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("guildBossReward", {})
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_BOSS_PERSONAL_REWARD_GET, function ()
		uv0:UpdateView()
	end)
	slot0:RegistEventListener(GUILD_EXIT, function ()
		uv0:Go("/home")
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
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

function slot0.InitData(slot0)
	slot1 = GuildData
	slot0.haveGetBuffList_ = slot1:GetHaveGetBossBuffList()
	slot4 = GuildData
	slot0.bonusDataList_ = deepClone(ClubBossCfg[slot4:GetBossDifficulty()].personal_reward)

	table.sort(slot0.bonusDataList_, function (slot0, slot1)
		return slot1[1] < slot0[1]
	end)
end

function slot0.OnEnter(slot0)
	slot0:InitData()
	slot0:AddEventListeners()
	manager.ui:SetMainCamera("clubBoss")

	if slot0.avatarView_ then
		slot0.avatarView_:OnEnter()
	end

	slot0:UpdateView()
	saveData("guild_boss", "challenge", 0)
	GuildAction.GetAssistBriefInfo(GuildData:GetGuildInfo().id)
	manager.redPoint:setTip(RedPointConst.GUILD_BOSS_CHALLENGE_OPEN, 0)
	manager.redPoint:bindUIandKey(slot0.rewardNoticeContainer_, RedPointConst.GUILD_BOSS_COMMON_BONUS, {
		x = 0,
		y = 0
	})
	slot0:AddGuildBossTimer()
end

function slot0.OnExit(slot0)
	manager.ui:ResetMainCamera()
	manager.redPoint:unbindUIandKey(slot0.rewardNoticeContainer_, RedPointConst.GUILD_BOSS_COMMON_BONUS)
	slot0:RemoveAllEventListener()

	if slot0.avatarView_ then
		slot0.avatarView_:OnExit()
	end

	slot0:StopGuildBossTimer()
	manager.windowBar:HideBar()
end

function slot0.OnMainHomeViewTop(slot0)
end

slot1 = {
	"CLUB_BOSS_DIFFICULTY_1",
	"CLUB_BOSS_DIFFICULTY_2",
	"CLUB_BOSS_DIFFICULTY_3",
	"CLUB_BOSS_DIFFICULTY_4"
}

function slot0.UpdateView(slot0)
	slot2 = CollectMonsterCfg[GuildData:GetCurBossId()]
	slot0.bossNameLabel_.text = slot2.name
	slot0.bossDescribeLabel_.text = slot2.desc

	slot0.bonusList_:StartScroll(#slot0.bonusDataList_)
	slot0.buffList_:StartScroll(#slot0.haveGetBuffList_)
	slot0.avatarView_:SetBossID(GuildData:GetBossData().challengeInfo.boss_id)

	slot0.scoreSlider.fillAmount = math.min(GuildData:GetBossPersonalScore() / ClubBossCfg[GuildData:GetBossDifficulty()].personal_reward[4][1], 1)
	slot0.currentScoreLabel_.text = GuildData:GetBossPersonalScore()
	slot4 = ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp
	slot5 = GuildData:GetCurrentBossDamage()
	slot6 = GuildData:GetCurrentBossRemainHp()
	slot0.expProgressLabel_.text = slot6
	slot0.expProgressLabel2_.text = "/ " .. slot4

	slot0.sliderGo_:GetComponent("SplineProgressBar"):SetValue(slot6 / slot4)

	slot10 = GuildData
	slot12 = slot10
	slot8 = false

	for slot12 = #deepClone(ClubBossCfg[slot10.GetBossDifficulty(slot12)].personal_reward), 1, -1 do
		if slot7[slot12][1] <= GuildData:GetBossPersonalScore() then
			slot0.bonusLockController_:SetSelectedIndex(slot12)

			slot8 = true

			break
		end
	end

	if not slot8 then
		slot0.bonusLockController_:SetSelectedIndex(0)
	end

	slot0:UpdateGuildBossTimer()

	slot9 = GuildData:GetBossDifficulty()

	slot0.difficultyController_:SetSelectedIndex(slot9 - 1)

	slot0.difficulty_.text = GetTips(uv0[slot9])

	slot0:RefreshSkill()
end

function slot0.RefreshSkill(slot0)
	slot2 = CollectMonsterCfg[GuildData:GetCurBossId()]

	for slot6 = 1, 6 do
		if slot2[string.format("skill%s", slot6)] ~= "" then
			if not slot0.skillList_[slot6] then
				slot0.skillList_[slot6] = BattleBossChallengeSkillItem.New(slot0.skillItemGo_, slot0.skillContainer_)
			end

			slot0.skillList_[slot6]:SetText(slot7, slot2[string.format("skill_desc%s", slot6)])
			slot0.skillList_[slot6]:Show(true)
		elseif slot0.skillList_[slot6] then
			slot0.skillList_[slot6]:Show(false)
		end
	end
end

function slot0.UpdateGuildBossTimer(slot0)
	slot1, slot2 = GuildData:GetLastTime()

	slot0.statusController_:SetSelectedState(slot1)

	if slot1 == "prepose" then
		slot0.stageLabel_.text = GetTips("CLUB_BOSS_PREPOSE_TIP")
		slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr(slot2)

		slot0.btnOpenController_:SetSelectedState("false")
	else
		slot0.stageLabel_.text = GetTips("CLUB_BOSS_CHALLENGE_TIP")
		slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr(slot2)

		slot0.btnOpenController_:SetSelectedState("true")
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
	if slot0.bonusList_ then
		slot0.bonusList_:Dispose()

		slot0.bonusList_ = nil
	end

	if slot0.buffList_ then
		slot0.buffList_:Dispose()

		slot0.buffList_ = nil
	end

	if slot0.avatarView_ then
		slot0.avatarView_:Dispose()

		slot0.avatarView_ = nil
	end

	if slot0.skillList_ then
		for slot4, slot5 in pairs(slot0.skillList_) do
			slot5:Dispose()
		end

		slot0.skillList_ = {}
	end

	uv0.super.Dispose(slot0)
end

return slot0
