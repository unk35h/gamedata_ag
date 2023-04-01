slot0 = class("FollowGiftView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/WelfareUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.weChatList_ = LuaList.New(handler(slot0, slot0.RefreshWeChatReward), slot0.wechatlistTrs_, CommonItem)
	slot0.weiboList_ = LuaList.New(handler(slot0, slot0.RefreshWeiboReward), slot0.weibolistTrs_, CommonItem)
	slot0.bilibiliList_ = LuaList.New(handler(slot0, slot0.RefreshBilibiliReward), slot0.bilibiliTrs_, CommonItem)
	slot0.twitterList_ = LuaList.New(handler(slot0, slot0.RefreshTwitterReward), slot0.twitterTrs_, CommonItem)
	slot0.facebookList_ = LuaList.New(handler(slot0, slot0.RefreshFacebookReward), slot0.facebookTrs_, CommonItem)
	slot0.discordList_ = LuaList.New(handler(slot0, slot0.RefreshDiscordReward), slot0.discordTrs_, CommonItem)
	slot0.youtubeList_ = LuaList.New(handler(slot0, slot0.RefreshYoutubeReward), slot0.youtubeTrs_, CommonItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.wechatBtn_, nil, function ()
		uv0:Go("followPop")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 51,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListener(slot0.weiboBtn_, nil, function ()
		GameToSDK.SendMessage(SDKTools.ToJsonFormat({
			messageType = "GetPlatformData",
			platform = OperationConst.PLATFORM.WEIBO
		}))
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 52,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListener(slot0.bilibiliBtn_, nil, function ()
		if OperationAction.GetOperationUrl("FOLLOW_BILIBILI") then
			Application.OpenURL(slot0)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.BILIBILI)
			SDKTools.SendMessageToSDK("direction", {
				direction_type = 53,
				direction_channel = 4
			})
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	slot0:AddBtnListener(slot0.twitterBtn_, nil, function ()
		if OperationAction.GetOperationUrl("FOLLOW_TWITTER") then
			Application.OpenURL(slot0)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.TWITTER)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	slot0:AddBtnListener(slot0.facebookBtn_, nil, function ()
		if OperationAction.GetOperationUrl("FOLLOW_FACEBOOK") then
			Application.OpenURL(slot0)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.FACEBOOK)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	slot0:AddBtnListener(slot0.discordBtn_, nil, function ()
		if OperationAction.GetOperationUrl("FOLLOW_DISCORD") then
			Application.OpenURL(slot0)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.DISCORD)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	slot0:AddBtnListener(slot0.youtubeBtn_, nil, function ()
		if OperationAction.GetOperationUrl("FOLLOW_YOUTUBE") then
			Application.OpenURL(slot0)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.YOUTUBE)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:ShowDefaultBar()

	slot4 = OperationData

	SetActive(slot0.weiboGo_, slot4:IsFollowOpen(OperationConst.PLATFORM.WEIBO))

	slot4 = OperationData

	SetActive(slot0.wechatGo_, slot4:IsFollowOpen(OperationConst.PLATFORM.WECHAT))

	slot4 = OperationData

	SetActive(slot0.bilibiliGo_, slot4:IsFollowOpen(OperationConst.PLATFORM.BILIBILI))

	slot4 = OperationData

	SetActive(slot0.twitterGo_, slot4:IsFollowOpen(OperationConst.PLATFORM.TWITTER))

	slot4 = OperationData

	SetActive(slot0.facebookGo_, slot4:IsFollowOpen(OperationConst.PLATFORM.FACEBOOK))

	slot4 = OperationData

	SetActive(slot0.discordGo_, slot4:IsFollowOpen(OperationConst.PLATFORM.DISCORD))

	slot4 = OperationData

	SetActive(slot0.youtubeGo_, slot4:IsFollowOpen(OperationConst.PLATFORM.YOUTUBE))

	slot1 = slot0.weChatList_

	slot1:StartScroll(#GameSetting.wechat_follow_reward.value)

	slot1 = slot0.weiboList_

	slot1:StartScroll(#GameSetting.weibo_follow_reward.value)

	slot1 = slot0.bilibiliList_

	slot1:StartScroll(#GameSetting.bilibili_follow_reward.value)

	slot1 = slot0.twitterList_

	slot1:StartScroll(#GameSetting.twitter_follow_reward.value)

	slot1 = slot0.facebookList_

	slot1:StartScroll(#GameSetting.facebook_follow_reward.value)

	slot1 = slot0.discordList_

	slot1:StartScroll(#GameSetting.discord_follow_reward.value)

	slot1 = slot0.youtubeList_

	slot1:StartScroll(#GameSetting.youtube_follow_reward.value)
	slot0:RegistEventListener(GET_PLATFORM_DATA_CALLBACK, function (slot0)
		if slot0.code == 0 then
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.WEIBO)
		elseif slot0.code ~= 2 then
			ShowTips(slot0.message or "")
		end
	end)
end

function slot0.RefreshWeChatReward(slot0, slot1, slot2)
	slot3 = GameSetting.wechat_follow_reward.value[slot1]

	slot2:RefreshData({
		id = slot3[1],
		number = slot3[2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.RefreshWeiboReward(slot0, slot1, slot2)
	slot3 = GameSetting.weibo_follow_reward.value[slot1]

	slot2:RefreshData({
		id = slot3[1],
		number = slot3[2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.RefreshBilibiliReward(slot0, slot1, slot2)
	slot3 = GameSetting.bilibili_follow_reward.value[slot1]

	slot2:RefreshData({
		id = slot3[1],
		number = slot3[2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.RefreshTwitterReward(slot0, slot1, slot2)
	slot3 = GameSetting.twitter_follow_reward.value[slot1]

	slot2:RefreshData({
		id = slot3[1],
		number = slot3[2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.RefreshFacebookReward(slot0, slot1, slot2)
	slot3 = GameSetting.facebook_follow_reward.value[slot1]

	slot2:RefreshData({
		id = slot3[1],
		number = slot3[2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.RefreshDiscordReward(slot0, slot1, slot2)
	slot3 = GameSetting.discord_follow_reward.value[slot1]

	slot2:RefreshData({
		id = slot3[1],
		number = slot3[2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.RefreshYoutubeReward(slot0, slot1, slot2)
	slot3 = GameSetting.youtube_follow_reward.value[slot1]

	slot2:RefreshData({
		id = slot3[1],
		number = slot3[2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.weChatList_:Dispose()
	slot0.weiboList_:Dispose()
	slot0.bilibiliList_:Dispose()
	slot0.twitterList_:Dispose()
	slot0.facebookList_:Dispose()
	slot0.discordList_:Dispose()
	slot0.youtubeList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
