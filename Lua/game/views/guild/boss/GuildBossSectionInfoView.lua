SectionBaseView = import("game.views.sectionInfo.SectionInfoBaseView")
slot0 = class("GuildBossSectionInfoView", SectionBaseView)

function slot0.Init(slot0)
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.nameController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "name")

	slot0.nameController_:SetSelectedState("clubBossPrepose")
	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.clubBossPreposeGo_)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:RegistEventListener(GUILD_EXIT, function ()
		uv0:Go("/home")
	end)
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

function slot0.RefreshData(slot0)
	slot0.cfg_ = BattleStageTools.GetStageCfg(slot0.params_.sectionType, slot0.params_.section)
	slot0.cost = slot0.cfg_.cost or 0

	uv0.super.RefreshData(slot0)

	slot0.lock_ = false
	slot0.lockTips_ = ""
	slot0.isFirstClear_ = 0 == 0
end

function slot0.RefreshStageInfo(slot0)
	slot0.cfg_ = BattleStageTools.GetStageCfg(slot0.params_.sectionType, slot0.params_.section)

	if slot0.oldCfgID_ ~= slot0.cfg_.id then
		slot0.sectionName_.text = ClubBossPreposeCfg[slot0.params_.index].name
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot0.cfg_.background_1))
		slot0.oldCfgID_ = slot0.cfg_.id
		slot0.titleCanvasGroup_.alpha = 0
		slot0.multiple_ = 1
		slot2 = GuildData:GetGuildBossBuffList()[slot0.params_.index]
		slot0.bossBuffDescLabel_.text = getAffixDesc(slot2)
		slot0.bossBuffNameLabel_.text = getAffixName(slot2)
		slot0.bossBuffIcon_.sprite = getAffixSprite(slot2)
		slot3 = ClubBossPreposeCfg[slot0.params_.index].point_max
		slot4 = math.min(slot0.params_.preData.score, slot3)
		slot0.bossProgressImage_.fillAmount = slot4 / slot3
		slot0.bossProgressLabel_.text = string.format("%d%%", 100 * slot4 / slot3)
		slot0.lastLabel_.text = string.format("%d/%d", GuildData:GetBossLastTime(), GameSetting.club_boss_prepose_max.value[1])
	end
end

function slot0.OnClickBtn(slot0)
	if GuildData:GetBossLastTime() <= 0 then
		ShowTips("ERROR_BATTLE_DAILY_BATTLE_TIMES_LIMIT")

		return
	end

	slot1, slot2 = GuildData:GetLastTime()

	if slot1 ~= "prepose" then
		ShowTips("CLUB_BOSS_PREPOSE_FINISH_TIP")

		return
	end

	if ClubBossPreposeCfg[slot0.params_.index].point_max <= GuildData:GetPreInfoList()[slot0.params_.index].score then
		ShowMessageBox({
			isTop = true,
			content = GetTips("CLUB_BOSS_PREPOSE_FINISH_CONFIRM_TIP"),
			OkCallback = function ()
				uv0:GoToSelectHero()
			end,
			CancelCallback = function ()
			end
		})
	else
		slot0:GoToSelectHero()
	end
end

function slot0.GoToSelectHero(slot0)
	slot0:Go("/guildBossSelectHero", {
		section = slot0.params_.section,
		sectionType = slot0.params_.sectionType,
		activityID = slot0.params_.activityId,
		multiple = slot0.multiple_,
		dest = slot0.params_.index
	})
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
