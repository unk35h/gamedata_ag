ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")
slot0 = class("ActivityThirdVolumePart2MainView", ActivityMainBaseView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIDownUI/MainUI/VolumeIIIDownMainUI"
end

function slot0.InitSubmoduleButton(slot0)
	slot0.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(slot0.musicGame_, ActivityConst.VOLUME_MUSIC),
		ActivitySubmoduleItem.New(slot0.matrixGo_, ActivityConst.OSHINAS_MATRIX),
		ActivitySubmoduleItem.New(slot0.subPlotGo_, ActivityConst.THIRD_VOLUME_PART_2_SUB_PLOT),
		ActivitySubmoduleItem.New(slot0.ptGo_, ActivityConst.VOLUME_III_DOWN_PT),
		ActivitySubmoduleItem.New(slot0.demonGo_, ActivityConst.VOLUME_DEMON),
		ActivitySubmoduleItem.New(slot0.raceTrialGo_, ActivityConst.VOLUME_RACE_TRIAL),
		ActivityHeroTrialItem.New(slot0.heroTrialGo_, ActivityConst.OCEANUS_HERO_TRIAL),
		ActivitySkinTrialSubmoduleItem.New(slot0.heroSkinGo_, ActivityConst.TYR_SKIN_TRIAL),
		ActivitySubmoduleItem.New(slot0.raceGo_, ActivityConst.ACTIVITY_RACE),
		GuildActivitySubmoduleItem.New(slot0.guildActivityBtn_.gameObject, ActivityConst.GUILD_ACTIVITY, handler(slot0, slot0.OnGuildActivityClick))
	}
end

function slot0.GetActivityID(slot0)
	return ActivityConst.THIRD_VOLUME_PART_2_ACTIVITY
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityData:GetActivityData(slot0:GetActivityID())
	slot2 = slot1.startTime
	slot0.textTime_.text = string.format("%s", manager.time:STimeDescS(slot1.stopTime, "!%Y.%m.%d %H:%M"))
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		slot1 = {}
		slot2 = {}

		for slot6, slot7 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityCfg[uv0:GetActivityID()].activity_theme]) do
			table.insert(slot1, ActivityShopCfg[slot7].shop_id)

			slot8, slot9 = ShopTools.IsShopOpen(ActivityShopCfg[slot7].shop_id)

			if slot8 then
				table.insert(slot2, ActivityShopCfg[slot7].shop_id)
			end
		end

		if #slot2 <= 0 then
			slot3, slot4 = ShopTools.IsShopOpen(slot1[1])

			if slot4 == 2 then
				ShowTips("SHOP_EXPIRED")
			elseif slot4 == 3 then
				ShowTips("SHOP_NOT_OPEN")
			end

			return
		end

		JumpTools.GoToSystem("/shop", {
			shopId = slot2[1],
			showShops = slot2
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.storyBtn_, nil, function ()
		slot0 = 10111

		BattleFieldData:SetCacheChapterClient(ChapterClientCfg[slot0].toggle, slot0)
		JumpTools.OpenPageByJump("/chapterMap", {
			chapterToggle = 1
		})
	end)
end

function slot0.OnGuildActivityClick(slot0)
	slot1 = GuildActivityData:HaveRegister()

	if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) then
		if slot1 then
			StartGuildActivity(GuildActivityData:GetCurrentGrid())
		else
			JumpTools.OpenPageByJump("/guildActivitySignUp", {})
		end
	else
		JumpTools.OpenPageByJump("/guildActivitySignUp", {})
	end

	if not slot1 and manager.redPoint:getTipValue(RedPointConst.GUILD_ACTIVITY_UNREGISTER) == 1 then
		GuildActivityAction.SetUnRegisterRedPointClicked(true)
	end

	slot3 = false

	if GameSetting.activity_club_red_dot_need.value[1] <= GuildActivityData:GetTotalCoinToGet() then
		slot3 = true
	end

	if slot3 and manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_UNGET_COIN, slot0:GetActivityID())) == 0 then
		GuildActivityAction.SetCoinRedPointClicked(true, slot0:GetActivityID())
	end
end

return slot0
