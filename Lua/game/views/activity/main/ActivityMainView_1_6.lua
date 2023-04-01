ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")
slot0 = class("ActivityMainView_1_6", ActivityMainBaseView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/MainUI/EmptyDreamMainUI"
end

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.shopController_ = ControllerUtil.GetController(slot0.shopBtn_.transform, "name")
end

function slot0.InitSubmoduleButton(slot0)
	slot0.travelbtncom_ = {}
	slot1 = ComponentBinder.GetInstance()

	slot1:BindCfgUI(slot0.travelbtncom_, slot0.leftBtn1_.transform.gameObject)

	slot0.travelbtncom_.skuldLockController_ = ControllerUtil.GetController(slot0.leftBtn1_.transform, "lock")
	slot0.submoduleBtnList_ = {
		ActivityHeroTrialItem.New(slot0.heroTrialGo_, ActivityConst.THOR_HERO_TRIAL),
		ActivitySkinTrialSubmoduleItem.New(slot0.heroSkinGo_, ActivityConst.THOR_SKIN_TRIAL),
		ActivitySubmoduleItem.New(slot0.demonGo_, ActivityConst.DREAM_DEMON_CHALLENGE),
		ActivitySubmoduleItem.New(slot0.leftBtn2_, ActivityConst.SPRING_FESTIVAL_PT),
		ActivitySubmoduleItem.New(slot0.rightBtn3_, ActivityConst.STRATEGY_MATRIX_THOR, function ()
			slot0 = nil

			if (StrategyMatrixCfg[(StrategyMatrixData.GetDifficultySelect() ~= 2 or not ActivityData:GetActivityIsOpen(ActivityConst.STRATEGY_MATRIX_THOR_HARD) or ActivityConst.STRATEGY_MATRIX_THOR_HARD) and ActivityConst.STRATEGY_MATRIX_THOR].enter_story_id or 0) ~= 0 and not manager.story:IsStoryPlayed(slot3) then
				slot4 = manager.story

				slot4:StartStoryById(slot3, function (slot0)
					ActivityTools.JumpToSubmodulePage(uv0)
				end)
			else
				ActivityTools.JumpToSubmodulePage(slot0)
			end
		end)
	}
end

function slot0.OnEnter(slot0)
	slot4 = {
		BACK_BAR,
		slot5
	}
	slot5 = HOME_BAR

	manager.windowBar:SwitchBar(slot4)
	slot0:RefreshUI()

	for slot4, slot5 in pairs(slot0.submoduleBtnList_) do
		slot5:OnEnter()
	end

	manager.redPoint:bindUIandKey(slot0.leftBtn1_.transform, RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.submoduleBtnList_) do
		slot5:OnExit()
	end

	manager.redPoint:unbindUIandKey(slot0.leftBtn1_.transform, RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	slot0:StopTimer()
end

function slot0.GetActivityID(slot0)
	return ActivityConst.ACTIVITY_1_6
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityData:GetActivityData(slot0:GetActivityID())
	slot0.timeText1_.text = string.format("%s", manager.time:STimeDescS(slot1.startTime, "!%Y <size=28>%m.%d</size>"))
	slot0.timeText2_.text = string.format("%s", manager.time:STimeDescS(slot1.stopTime, "!<size=28>%m.%d</size> %H:%M"))
	slot4 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	slot0.travelbtncom_.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(slot4.startTime, "!%m.%d"), manager.time:STimeDescS(slot4.stopTime, "!%m.%d"))

	slot0.travelbtncom_.skuldLockController_:SetSelectedState(SkuldTravelData:GetSkuldTravelIsOpen() and "false" or "true")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.subPlotBtn_, nil, function ()
		slot0 = 10112
		slot1 = BattleFieldData:GetCacheChapter(slot0)

		if BattleStageData:GetStageData()[ChapterCfg[ChapterClientCfg[slot0].chapter_list[2]].section_id_list[1]] then
			uv0:Go("/chapterVariantBase", {
				chapterClientID = slot0,
				chapterID = slot1
			})
		else
			uv0:Go("/chapterSection", {
				chapterID = slot1
			})
		end
	end)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		slot1 = {}

		for slot5, slot6 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityCfg[uv0:GetActivityID()].activity_theme]) do
			table.insert(slot1, ActivityShopCfg[slot6].shop_id)
		end

		slot2, slot3 = ShopTools.IsShopOpen(slot1[1])

		if slot2 then
			JumpTools.GoToSystem("/shop", {
				shopId = slot1[1],
				showShops = slot1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif slot3 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif slot3 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	slot0:AddBtnListener(slot0.leftBtn1_, nil, function ()
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			JumpTools.GoToSystem("/skuldTravelView")
		else
			slot0 = GameSetting.travel_skuld_unlock.value[1]
			slot2, slot3 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot0)

			ShowTips(string.format(GetTips("MISSION_PROGRESS_UNLOCK_EX"), getChapterDifficulty(slot0), slot2 .. "-" .. slot3))
		end
	end)
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	if ActivityData:GetActivityData(ActivityConst.ACTIVITY_1_6_PT_SHOP).stopTime - manager.time:GetServerTime() < 0 then
		slot0.shopController_:SetSelectedState("off")

		return
	end

	slot4 = true

	if slot3 <= 432000 then
		slot0.shopController_:SetSelectedState("on")

		slot0.shopTimeText_.text = manager.time:GetLostTimeStr2(slot2, nil, true)
	else
		slot0.shopController_:SetSelectedState("off")

		slot4 = false
	end

	slot0.timer_ = Timer.New(function ()
		uv0 = uv1 - manager.time:GetServerTime()

		if uv0 <= uv2 then
			if uv0 <= 0 then
				uv3.shopController_:SetSelectedState("off")
				uv3:StopTimer()

				return
			end

			if uv4 then
				uv3.shopController_:SetSelectedState("on")

				uv3.shopTimeText_.text = manager.time:GetLostTimeStr2(uv1, nil, true)
				uv4 = false
			end

			uv3.shopTimeText_.text = manager.time:GetLostTimeStr2(uv1, nil, true)
		elseif uv4 == false then
			uv3.shopController_:SetSelectedState("off")

			uv4 = true
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
