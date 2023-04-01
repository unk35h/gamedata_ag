slot0 = class("FollowGiftView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PraiseUI/PraiseUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.catController = ControllerUtil.GetController(slot0.m_cat, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_encourage, nil, function ()
		if uv0.backTimer then
			return
		end

		uv0:OnEncourage()
		uv0:Back()
		SDKTools.SendMessageToSDK("comment", {
			comment = 1,
			sub_id = _G.deviceInfo and tostring(_G.deviceInfo.subId) or nil,
			comment_source = SurveyData:GetSourceId()
		})
	end)
	slot0:AddBtnListener(slot0.m_gossiping, nil, function ()
		if uv0.backTimer then
			return
		end

		uv0.stateController:SetSelectedIndex(1)
		uv0.catController:SetSelectedIndex(1)
		SDKTools.SendMessageToSDK("comment", {
			comment = 2,
			sub_id = _G.deviceInfo and tostring(_G.deviceInfo.subId) or nil,
			comment_source = SurveyData:GetSourceId()
		})
	end)
	slot0:AddBtnListener(slot0.m_nextTime, nil, function ()
		if uv0.backTimer then
			return
		end

		uv0.backTimer = Timer.New(function ()
			uv0.backTimer = nil

			uv0:Back()
		end, 1, 1)

		uv0.backTimer:Start()
		uv0.catController:SetSelectedIndex(2)
		SDKTools.SendMessageToSDK("comment", {
			comment = 3,
			sub_id = _G.deviceInfo and tostring(_G.deviceInfo.subId) or nil,
			comment_source = SurveyData:GetSourceId()
		})
		SurveyAction.Praise(1)
	end)
	slot0:AddBtnListener(slot0.m_consider, nil, function ()
		if uv0.backTimer then
			return
		end

		uv0.stateController:SetSelectedIndex(0)
		uv0.catController:SetSelectedIndex(3)
	end)
	slot0:AddBtnListener(slot0.m_gossipingSure, nil, function ()
		if uv0.backTimer then
			return
		end

		uv0:OnGossiping()
		uv0:Back()
	end)
end

function slot0.OnEncourage(slot0)
	GameToSDK.SendMessage("{\"messageType\" : \"MarketComments\"}")
	SurveyAction.Praise(2)
end

function slot0.OnGossiping(slot0)
	if _G.CHANNEL_MASTER_ID == 0 then
		OperationAction.OpenOperationUrl("OFFICIAL_SUGGEST_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId,
			gameAppId = _G.ChannelLoginInfo.channelAppId,
			token = _G.ChannelLoginInfo.channelToken
		})
	elseif _G.CHANNEL_MASTER_ID == 1 then
		OperationAction.OpenOperationUrl("OFFICIAL_SUGGEST_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId,
			gameAppId = _G.ChannelLoginInfo.channelAppId,
			token = _G.ChannelLoginInfo.channelToken
		})
	else
		OperationAction.OpenOperationUrl("CHANNEL_SUGGEST_URL")
	end

	SurveyAction.Praise(3)
end

function slot0.OnEnter(slot0)
	slot0.stateController:SetSelectedIndex(0)
	slot0.catController:SetSelectedIndex(0)
	SurveyData:SetPraise(false)
end

function slot0.OnExit(slot0)
	if slot0.backTimer then
		slot0.backTimer:Stop()

		slot0.backTimer = nil
	end
end

return slot0
