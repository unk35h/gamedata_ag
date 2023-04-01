slot1 = manager.net

slot1:Bind(11001, function (slot0)
	ActivityData:InitActivityData(slot0)
	uv0.DealWithAllActivityData()
end)

slot1 = manager.net

slot1:Bind(11003, function (slot0)
	ActivityData:UpdateActivityData(slot0.activity)
end)

slot1 = manager.net

slot1:Bind(64031, function (slot0)
	ActivityData:RefreshActivityTime(slot0)
end)

slot1 = manager.notify

slot1:RegistListener(ACTIVITY_UPDATE, function (slot0)
	uv0.UpdateRedPoint(slot0)
end)

return {
	DealWithAllActivityData = function ()
		for slot4, slot5 in pairs(ActivityData:GetAllActivityData()) do
			uv0.DealWithActivityData(slot5)
		end

		uv0.AfterDealWithActivityData()
	end,
	DealWithActivityData = function (slot0)
		if ActivityTemplateConst.MAIN_ACTIVITY == ActivityTools.GetActivityType(slot0.id) then
			uv0.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.DEMON == slot1 then
			SubDemonChallengeAction.Init()
			SubDemonChallengeAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.NEW_DEMON == slot1 then
			NewDemonChallengeAction.Init()
			NewDemonChallengeAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.TALENT_TREE == slot1 then
			TalentTreeAction.Init()
		elseif ActivityTemplateConst.BATTLE_FIRST_PASS == slot1 then
			BattleFirstPassAction.Init()
			BattleFirstPassAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.STORY == slot1 then
			uv0.InitStoryRedPoint(slot0.id)
		elseif ActivityTemplateConst.SOLO_CHALLENGE == slot1 then
			SoloChallengeAction.InitRedPoint(slot0.id)
		elseif ActivityTemplateConst.FISHING == slot1 then
			FishingAction.Init()
		elseif ActivityTemplateConst.LIMITED_CALCULATION == slot1 then
			LimitedCalculationAction.Init()
			LimitedCalculationAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.SKIN_EXCHANGE == slot1 then
			SkinExchangeAction.Init()
			SkinExchangeAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.SUMMER_ACTIVITY_PT == slot1 then
			SummerActivityPtAction.Init()
		elseif ActivityTemplateConst.ACTIVITY_PUZZLE == slot1 then
			PuzzleAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.COWBOY == slot1 then
			CowboyAction.Init()
			CowboyAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_RACE == slot1 then
			ActivityRaceAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.GUILD_ACTIVITY == slot1 then
			GuildActivityAction.Init()
		elseif ActivityTemplateConst.XH1ST_SEAL == slot1 then
			XH1stSealAction.Init()
			XH1stSealAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.RACE_TRIAL == slot1 then
			RaceTrailAction.Init(slot0.id)
			RaceTrailAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.INFINITY_POOL_TASK == slot1 then
			uv0.InitInfinityPoolTaskRedPoint(slot0.id)
		elseif ActivityTemplateConst.MARDUK_SPECIAL == slot1 then
			MardukSpecialAction.Init(slot0.id)
		elseif ActivityTemplateConst.SURVIVE_SOLO == slot1 then
			SurviveSoloAction.Init(slot0.id)
			SurviveSoloAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.PAPER_CUT == slot1 then
			PaperCutAction.Init(slot0.id)
		elseif ActivityTemplateConst.SPRING_ANTITHETICAL_COUPLET == slot1 then
			AntitheticalCoupletAction.Init()
			AntitheticalCoupletAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.VALENTINE_GAME == slot1 then
			ValentineGameAction.Init()
			ValentineGameAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_AFFIX_SELECT == slot1 then
			ActivityAffixSelectAction.Init()
			ActivityAffixSelectAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_CULTIVATE_HERO == slot1 then
			CultivateHeroAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_PT_2 == slot1 then
			ActivityPt2Action.Init()
			ActivityPt2Action.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_SET == slot1 then
			uv0.InitActivitySetRedPoint(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_RECALL == slot1 then
			ActivityRecallAction.Init()
		elseif ActivityTemplateConst.CHESS_ACTIVITY_CHINESE_ZONE == slot1 then
			RedPointData:UpdateRedPoint(slot0.id)
		end
	end,
	AfterDealWithActivityData = function ()
		SkuldTravelData:InitRedPointGroup()
	end,
	UpdateRedPoint = function (slot0)
		if ActivityTools.GetActivityType(slot0) == ActivityTemplateConst.ACTIVITY_PUZZLE then
			if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() then
				for slot8, slot9 in ipairs(ActivityCfg[slot0].sub_activity_list) do
					manager.redPoint:setTip(string.format("%s_%s_%s_normal", RedPointConst.ACTIVITY_PUZZLE, slot3, slot9), 0)
					manager.redPoint:setTip(string.format("%s_%s_%s_video", RedPointConst.ACTIVITY_PUZZLE, slot3, slot9), 0)
				end
			end
		elseif slot0 == ActivityConst.MOONBO then
			MoonBoData:FreshTime()
		elseif slot1 == ActivityTemplateConst.HERO_TRIAL then
			if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() then
				for slot6, slot7 in ipairs(ActivityHeroTrialCfg.get_id_list_by_activity_id[slot0]) do
					manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, slot0, slot7), 0)
				end
			end
		elseif slot1 == ActivityTemplateConst.SKIN_TRIAL then
			SkinTrialAction.UpdateRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.SUMMER_ACTIVITY_PT then
			SummerActivityPtAction.UpdateRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.COWBOY then
			CowboyAction:CloseActivity(slot0)
		elseif slot1 == ActivityTemplateConst.ACTIVITY_RACE then
			ActivityRaceAction.UpdateRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.GUILD_ACTIVITY then
			GuildActivityAction.UpdateRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.DEMON then
			SubDemonChallengeAction.RefreshRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.RACE_TRIAL then
			RaceTrailAction.UpdateRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.STORY_STAGE then
			if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() then
				ActivityStoryAction.UpdateRedPoint(slot0, 0)
			end
		elseif slot1 == ActivityTemplateConst.MARDUK_SPECIAL then
			if slot0 == ActivityConst.FACTORY_MARDUK then
				MardukSpecialAction.UpdateRedPoint(slot0)
			end
		elseif slot1 == ActivityTemplateConst.SEQUENTIAL_BATTLE_SUB then
			SequentialBattleAction.StopRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.SPRING_FESTIVAL_GREETING then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, slot0), 0)
		elseif slot1 == ActivityTemplateConst.SPRING_FESTIVAL_RIDDLE then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_RIDDLE, slot0))
		elseif slot0 == ActivityConst.ACTIVITY_1_6 then
			SkuldTravelAction:CheckUnBindActivitySkuld()
			SkuldTravelAction:CheckUnBindChapterKey()
		elseif slot0 == ActivityConst.CHESS_ACTIVITY_CHINESE_ZONE then
			RedPointData:UpdateRedPoint(slot0)
		end

		uv0.UpdateShopRedPoint(slot0)
	end,
	InitRedPointKey = function (slot0)
		slot1 = nil
		slot2 = {}

		if not ActivityCfg[slot0].sub_activity_list or #slot3 == 0 or slot0 == ActivityConst.OSIRIS_ACTIVITY then
			manager.redPoint:addGroup(string.format("%s%s", RedPointConst.MAIN_ACTIVITY, slot0), {
				string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.OSIRIS_TASK_DAILY),
				string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS),
				RedPointConst.OSIRIS_DEMON,
				RedPointConst.OSIRIS_RACE_TRIAL,
				string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.OSIRIS_HERO_TRIAL_STAGE)
			})

			return
		end

		for slot7, slot8 in ipairs(slot3) do
			table.insert(slot2, ActivityTools.GetRedPointKey(slot8) .. slot8)
		end

		manager.redPoint:addGroup(RedPointConst.MAIN_ACTIVITY .. slot0, slot2)
	end,
	InitStoryRedPoint = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			if ActivityCfg[slot6].activity_template == ActivityTemplateConst.STORY_STAGE or ActivityCfg[slot6].activity_template == ActivityTemplateConst.SUB_PLOT then
				table.insert(slot1, RedPointConst.ACTIVITY_STORY_STAGE .. slot6)
			elseif ActivityCfg[slot6].activity_template == ActivityTemplateConst.CHESS then
				table.insert(slot1, string.format("%s_%s", RedPointConst.WAR_CHESS, slot6))
			else
				print("未知的红点类型")
			end
		end

		if ActivityCfg[slot0].activity_theme == ActivityConst.THEME.SUMMER then
			slot8 = "%s_%s"

			table.insert(slot1, string.format(slot8, RedPointConst.ACTIVITY_SIDE_STORY, ActivityCfg[slot0].activity_theme))

			slot3 = {}
			slot7 = ActivityCfg[slot0].activity_theme

			for slot7, slot8 in ipairs(ActivityStoryCollect[slot7].story_id) do
				table.insert(slot3, string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, slot2, slot8))
			end

			manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, slot2), slot3)
		end

		manager.redPoint:addGroup(RedPointConst.ACTIVITY_STORY_STAGE .. slot0, slot1)
	end,
	InitInfinityPoolTaskRedPoint = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			if ActivityCfg[slot6].activity_template == ActivityTemplateConst.TASK then
				table.insert(slot1, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot6))
			end
		end

		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.INFINITY_POOL_TASK, slot0), slot1)
	end,
	InitActivitySetRedPoint = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			if ActivityCfg[slot6].activity_template == ActivityTemplateConst.TASK then
				table.insert(slot1, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot6))
			elseif ActivityCfg[slot6].activity_template == ActivityTemplateConst.ACTIVITY_SHOP then
				table.insert(slot1, string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, slot6))
			end
		end

		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_SET, slot0), slot1)
	end,
	InitLoginShopRedPoint = function ()
		slot3 = ActivityTemplateConst.ACTIVITY_SHOP

		for slot3, slot4 in ipairs(ActivityCfg.get_id_list_by_activity_template[slot3]) do
			if ActivityData:GetActivityIsOpen(slot4) and ActivityData:GetActivityData(slot4).stopTime <= manager.time:GetServerTime() + 259200 and ActivityShopCfg[slot4] then
				slot8 = ShopListCfg[ActivityShopCfg[slot4].shop_id].cost_id or {}

				for slot12, slot13 in ipairs(slot8) do
					if ItemTools.getItemNum(slot13) > 0 then
						manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, slot4), 1)

						break
					end
				end
			end
		end
	end,
	UpdateShopRedPoint = function (slot0)
		if ActivityCfg[slot0].activity_template == ActivityTemplateConst.ACTIVITY_SHOP and not ActivityData:GetActivityIsOpen(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, slot0), 0)
		end
	end,
	OnLogin = function (slot0)
	end,
	OnLogout = function ()
		PaperCutTool:OnLogout()
	end,
	ReceivePointReward = function (slot0)
		manager.net:SendWithLoadingNew(60054, {
			point_reward_id_list = slot0
		}, 60055, uv0.OnReceivePointReward)
	end,
	OnReceivePointReward = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {}

			for slot6, slot7 in ipairs(slot1.point_reward_id_list) do
				if ActivityTemplateConst.LIMITED_CALCULATION == ActivityTools.GetActivityType(ActivityPointRewardCfg[slot7].activity_id) then
					LimitedCalculationAction:OnReceivePointReward(slot8.activity_id, slot8.id)
				elseif ActivityTemplateConst.SUB_SINGLE_MATRIX == slot9 then
					ActivityMatrixAction.OnReceivePointReward(slot8.activity_id, slot8.id)
				end

				table.insertto(slot2, slot8.reward_item_list)
			end

			getReward(mergeReward(slot2))
			manager.notify:Invoke(ACTIVITY_REWARD_GET, {
				point_reward_id_list = slot1.point_reward_id_list
			})
			manager.notify:CallUpdateFunc(RECEIVE_POINT_REWARD, slot1.point_reward_id_list)
		else
			ShowTips(slot0.result)
		end
	end,
	GetBonus = function (slot0)
		manager.net:SendWithLoadingNew(60054, {
			point_reward_id_list = slot0
		}, 60055, uv0.OnGetBonusCallback)
	end,
	OnGetBonusCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {}

			for slot6, slot7 in ipairs(slot1.point_reward_id_list) do
				table.insertto(slot2, ActivityPointRewardCfg[slot7].reward_item_list)
			end

			getReward(mergeReward(slot2))
			manager.notify:Invoke(ACTIVITY_REWARD_GET, {
				point_reward_id_list = slot1.point_reward_id_list
			})
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	GetRankData = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(65000, {
			activity_id = slot0,
			start = slot1 or 1,
			stop = slot2 or 100,
			version = ActivityData:GetRankVersion(slot0)
		}, 65001, function (slot0, slot1)
			if isSuccess(slot0.result) then
				ActivityData:SetRankVersion(uv0, slot0.version)

				if (slot0.version ~= slot1.version or slot1.version == 0) and uv1 ~= nil then
					uv1(slot0)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end
}
