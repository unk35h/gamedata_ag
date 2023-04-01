slot0 = class("GuildActivityWarFieldView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivityUI/GuildActivityWarFieldUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.newMessageHandler_ = handler(slot0, slot0.ChatNewMessage)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.hideLockController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "canNext")
	slot0.chatTextExtension_ = slot0.chatText_:GetComponent(typeof(TextExtension))
end

function slot0.indexItem(slot0, slot1, slot2)
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.dragEventListener_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:GetGuildActivityManager():SetZoom(uv0.mapSlider_.value)
	end))

	slot1 = slot0:GetGuildActivityManager()

	slot1:SetOnZoomByFingerHandler(handler(slot0, slot0.OnZoomChangeByFinger))

	slot1 = slot0:GetGuildActivityManager()

	slot1:SetOnNodeClick(handler(slot0, slot0.OnNodeClick))

	slot1 = slot0:GetGuildActivityManager()

	slot1:SetOnBonusClick(handler(slot0, slot0.OnBonusNodeClick))

	slot1 = slot0:GetGuildActivityManager()

	slot1:SetOnBgClick(handler(slot0, slot0.OnBgClick))

	slot1 = slot0:GetGuildActivityManager()

	slot1:SetOnLevelLoaded(handler(slot0, slot0.OnLevelLoaded))
	slot0:AddBtnListener(slot0.allGetBtn_, nil, function ()
		GuildActivityAction.GetCoin()
	end)
	slot0:AddBtnListener(slot0.leftBtn_, nil, function ()
		uv0:GoToPrevLevel()
	end)
	slot0:AddBtnListener(slot0.rightBtn_, nil, function ()
		uv0:GoToNextLevel()
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if not uv0:IsTop() then
			gameContext:Back()
		end

		JumpTools.OpenPageByJump("guildActivityReward", {
			activityID = uv0.params_.activityID
		})
	end)
	slot0:AddBtnListener(slot0.ratingBtn_, nil, function ()
		if not uv0:IsTop() then
			gameContext:Back()
		end

		JumpTools.OpenPageByJump("guildActivityRate", {
			activityID = uv0.params_.activityID
		})
	end)
	slot0:AddBtnListener(slot0.setupBtn_, nil, function ()
		JumpTools.OpenPageByJump("guildActivityFightHeroSetting", {
			isEnter = true,
			activityID = uv0.params_.activityID
		})
	end)
	slot0:AddBtnListener(slot0.talentBtn_, nil, function ()
		if not uv0:IsTop() then
			gameContext:Back()
		end

		uv0:Go("/guildActivityAffixMain", {
			activityID = uv0.params_.activityID
		})
	end)
	slot0:AddBtnListener(slot0.chatBtn_, nil, function ()
		if not uv0:IsTop() then
			gameContext:Back()
		end

		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(MATERIAL_MODIFY, function (slot0)
		if slot0 == MaterialConst.GUILD_ACTIVITY_COIN then
			uv0:UpdateLevelView()
		end
	end)
	slot0:RegistEventListener(SPAWN_ID_UPDATE, function ()
		uv0:UpdateRightBtn()
	end)
	slot0:RegistEventListener(GUILD_ACTIVITY_COIN_GET_FINISH, function ()
		uv0.currencyAnimator_:Play("currency", -1, 0)
	end)
end

function slot0.OnZoomChangeByFinger(slot0, slot1)
	slot0.mapSlider_.value = slot1
end

function slot0.OnBgClick(slot0)
	if gameContext.routes_[#gameContext.routes_] == "guildActivityNormalPop" or slot1 == "guildActivityElitePop" or slot1 == "guildActivityBossPop" then
		gameContext:Back()
	end
end

function slot0.OnLevelLoaded(slot0, slot1)
	slot0.curMapIndex_ = slot1

	slot0:UpdateLevelView()
end

function slot0.OnNodeClick(slot0, slot1)
	slot2 = ActivityClubCfg[slot1]

	if not slot0:IsTop() then
		gameContext:Back()
	end

	if slot0.animTimer_ ~= nil then
		return
	end

	if slot2.type == 0 then
		-- Nothing
	elseif slot2.type == 1 then
		JumpTools.OpenPageByJump("guildActivityNormalPop", {
			nodeId = slot1
		})
	elseif slot2.type == 2 then
		JumpTools.OpenPageByJump("guildActivityElitePop", {
			nodeId = slot1
		})
	elseif slot2.type == 3 then
		JumpTools.OpenPageByJump("guildActivityBossPop", {
			nodeId = slot1
		})
	end
end

function slot0.OnBonusNodeClick(slot0, slot1)
	GuildActivityAction.GetCoin()
end

function slot0.OnTop(slot0)
	slot0:GetGuildActivityManager():SetOnWarField(false)
	slot0:GetGuildActivityManager():SetOnWarField(true)
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

	slot1:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = {
				"Textures/GuildActivitiesUI/note/activity_club_courses_01",
				"Textures/GuildActivitiesUI/note/activity_club_courses_02",
				"Textures/GuildActivitiesUI/note/activity_club_courses_03",
				"Textures/GuildActivitiesUI/note/activity_club_courses_04",
				"Textures/GuildActivitiesUI/note/activity_club_courses_05",
				"Textures/GuildActivitiesUI/note/activity_club_courses_06",
				"Textures/GuildActivitiesUI/note/activity_club_courses_07",
				"Textures/GuildActivitiesUI/note/activity_club_courses_08"
			}
		}
	})

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		JumpTools.OpenPageUntilLoaded("/thirdVolumePart2Main")
		GuildActivityAction.ExitGuildActivity()
	end)

	slot1 = manager.windowBar

	slot1:RegistHomeCallBack(function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		JumpTools.OpenPageUntilLoaded("/home")
		GuildActivityAction.ExitGuildActivity()
	end)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.curMapIndex_ = slot0.params_.level

	slot0:GetGuildActivityManager():SetOnWarField(true)
	slot0:UpdateLevelView()
	slot0:RegisterRedPoint()
	slot0:StartTimer()
	slot0:UpdateTimer()
	slot0:OnCheckRateUpgrade()
	manager.notify:RegistListener(CHAT_NEW_MESSAGE, slot0.newMessageHandler_)
	slot0:ChatNewMessage()

	if not getData("GuildActivity", "note") then
		saveData("GuildActivity", "note", true)
		JumpTools.OpenPageByJump("gameHelpPro", {
			pages = {
				"Textures/GuildActivitiesUI/note/activity_club_courses_01",
				"Textures/GuildActivitiesUI/note/activity_club_courses_02",
				"Textures/GuildActivitiesUI/note/activity_club_courses_03",
				"Textures/GuildActivitiesUI/note/activity_club_courses_04",
				"Textures/GuildActivitiesUI/note/activity_club_courses_05",
				"Textures/GuildActivitiesUI/note/activity_club_courses_06",
				"Textures/GuildActivitiesUI/note/activity_club_courses_07",
				"Textures/GuildActivitiesUI/note/activity_club_courses_08"
			}
		})
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	LeanTween.cancel(manager.ui.mainCameraCom_.gameObject)
	slot0:GetGuildActivityManager():SetOnWarField(false)
	slot0:UnRegisterRedPoint()
	slot0:StopTimer()
	manager.notify:RemoveListener(CHAT_NEW_MESSAGE, slot0.newMessageHandler_)
	manager.ui:ResetMainCamera()
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
	slot1 = ActivityData:GetActivityData(ActivityConst.GUILD_ACTIVITY_START)
	slot2 = slot1.startTime
	slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr(slot1.stopTime)

	if GuildActivityData:GetTotalCoinToGet() > 0 then
		SetActive(slot0.allGetBtn_.gameObject, true)
	else
		SetActive(slot0.allGetBtn_.gameObject, false)
	end
end

function slot0.GoToPrevLevel(slot0)
	if slot0.animTimer_ ~= nil then
		return
	end

	slot0.curMapIndex_ = slot0.curMapIndex_ - 1

	slot0:GotoLevel(slot0.curMapIndex_)
end

function slot0.GoToNextLevel(slot0)
	if slot0.animTimer_ ~= nil then
		return
	end

	if GuildActivityData:GetMySpawnNodeId(slot0.curMapIndex_ + 1) == nil or slot1 == 0 then
		ShowTips("ACTIVITY_CLUB_NEXT_MAP_LOCK_TIP")

		return
	end

	slot0.curMapIndex_ = slot0.curMapIndex_ + 1

	slot0:GotoLevel(slot0.curMapIndex_)
end

function slot0.OnGuildActivityEnterNewLevel(slot0)
	if slot0.animTimer_ ~= nil then
		return
	end

	slot0.curMapIndex_ = slot0.curMapIndex_ + 1

	slot0:GotoLevel(slot0.curMapIndex_)
end

slot1 = nil

function slot0.GotoLevel(slot0, slot1)
	if not slot0:IsTop() then
		gameContext:Back()
	end

	uv0 = slot1

	SetActive(slot0.cloudGo_, true)

	slot0.animTimer_ = 1

	AnimatorTools.PlayAnimationWithCallback(slot0.cloudAnimator_, "cloud", function ()
		SetActive(uv0.cloudGo_, false)

		uv0.animTimer_ = nil
	end)
	slot0.cloudAnimator_:Play("cloud", -1, 0)
end

function slot0.OnEnterNewLevel(slot0)
	slot0:GetGuildActivityManager():LoadLevel(uv0)

	slot0.params_.level = uv0
end

function slot0.UpdateLevelView(slot0)
	slot0.mapNameLabel_.text = ActivityClubMapCfg[ActivityClubMapCfg.all[slot0.curMapIndex_]].map_name

	SetActive(slot0.leftBtn_.gameObject, true)
	SetActive(slot0.rightBtn_.gameObject, true)

	if slot0.curMapIndex_ == 1 then
		SetActive(slot0.leftBtn_.gameObject, false)
	end

	if slot0.curMapIndex_ == #ActivityClubMapCfg.all then
		SetActive(slot0.rightBtn_.gameObject, false)
	end

	slot0.footPrintLabel_.text = string.format("%d/%d", GuildActivityData:GetMyOccupiedNum(), GuildActivityData:GetMaxOccupyCount())
	slot0.profitLabel_.text = string.format("%d(+%d/%s)", MaterialData:GetMaterial(MaterialConst.GUILD_ACTIVITY_COIN).num, GuildActivityData:GetCoinGain(), GetTips("HOUR"))

	slot0:UpdateRightBtn()
end

function slot0.UpdateRightBtn(slot0)
	slot1 = GuildActivityData:GetMySpawnNodeId(slot0.curMapIndex_ + 1)

	if slot0.curMapIndex_ == #ActivityClubMapCfg.all then
		slot0.hideLockController_:SetSelectedState("true")
	elseif slot1 == nil or slot1 == 0 then
		slot0.hideLockController_:SetSelectedState("false")
	else
		slot0.hideLockController_:SetSelectedState("true")
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.GetGuildActivityManager(slot0)
	return GuildActivityLuaBridge.GetManager()
end

function slot0.Dispose(slot0)
	slot0.newMessageHandler_ = nil

	slot0.mapSlider_.onValueChanged:RemoveAllListeners()
	slot0:GetGuildActivityManager():SetOnZoomByFingerHandler(nil)

	if slot0.timer_ then
		slot0.timer_:Dispose()

		slot0.timer_ = nil
	end

	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

function slot0.RegisterRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_RATE, slot0.params_.activityID))
	manager.redPoint:bindUIandKey(slot0.talentBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, slot0.params_.activityID))
	manager.redPoint:bindUIandKey(slot0.setupBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_ON_FIGHT_NOT_FULL, slot0.params_.activityID))
end

function slot0.UnRegisterRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_RATE, slot0.params_.activityID))
	manager.redPoint:unbindUIandKey(slot0.talentBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, slot0.params_.activityID))
	manager.redPoint:unbindUIandKey(slot0.setupBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_ON_FIGHT_NOT_FULL, slot0.params_.activityID))
end

function slot0.OnCheckRateUpgrade(slot0)
	slot1, slot2 = GuildActivityData:CheckRateUpgrade(slot0.params_.activityID)

	if slot1 == true then
		JumpTools.OpenPageByJump("guildActivityRateUpgrad", {
			rateID = slot2
		})
		GuildActivityData:RefreshRateRedPoint(slot0.params_.activityID)
		slot0:UpdateLevelView()
	end
end

function slot0.ChatNewMessage(slot0)
	if #ChatChannelData:GetCacheContent(ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY) > 0 then
		slot2 = slot1[#slot1]
		slot3 = slot2.content

		if slot2.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			slot3 = string.format("[%s]", ChatStickerCfg[tonumber(slot2.content)].name)
		end

		slot0.chatTextExtension_:SetText(string.format("%s:%s", slot2.nick, slot3))
	else
		slot0.chatText_.text = ""
	end
end

return slot0
