slot0 = class("OperationView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.btn_uccnBtn_, nil, function ()
		OperationAction.OpenOperationUrl("OFFICIAL_URL")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 1,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListenerScale(slot0.btn_psqBtn_, nil, function ()
		SurveyAction.SetSurveyRedPointData()
		JumpTools.OpenPageByJump("survey", {
			type = OperationConst.SURVEY_TYPE.NORMAL
		})
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 4,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListenerScale(slot0.btn_mycenterBtn_, nil, function ()
		NeedGameUserInfo()
		GameToSDK.GoUserCenter()
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 2,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListenerScale(slot0.btn_attentionBtn_, nil, function ()
		uv0.handler_:SetFollowGiftRedPointData()
		uv0:Go("/followGift")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 5,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListenerScale(slot0.btn_suggestBtn_, nil, function ()
		NeedGameUserInfo()
		SendMessageToSDK("{\"messageType\" : \"StartCustomerService\"}")
		manager.redPoint:setTip(RedPointConst.CUSTOMER_SERVICE_UNREAD, 0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 3,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListenerScale(slot0.btn_cdkBtn_, nil, function ()
		JumpTools.OpenPageByJump("GiftPopUp")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 7,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListenerScale(slot0.btn_forumBtn_, nil, function ()
		OperationAction.OpenOperationUrl("FORUM_URL", {
			gameAppId = _G.ChannelLoginInfo.channelAppId,
			token = _G.ChannelLoginInfo.channelToken
		})
		RedPointAction.HandleRedPoint(RED_POINT_ID.FORUM)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 8,
			direction_channel = 4
		})
		manager.redPoint:setTip(RedPointConst.FORUM, 0)
		manager.redPoint:setTip(RedPointConst.FORUM_UNREAD, 0)
	end)
	slot0:AddBtnListenerScale(slot0.btn_queryBtn_, nil, function ()
		OperationAction.OpenOperationUrl("INQUERY_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		})
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 6,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListenerScale(slot0.btn_guideBtn_, nil, function ()
		OperationAction.OpenOperationUrl("GUIDE_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		})
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 9,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListenerScale(slot0.btn_activityBtn_, nil, function ()
		OperationAction.OpenOperationUrl("ACTIVITY_URL", {
			userID = PlayerData:GetPlayerInfo().userID,
			signuserID = PlayerData:GetPlayerInfo().signUserId
		})
		RedPointAction.HandleRedPoint(RED_POINT_ID.ACTIVITY)
		manager.redPoint:setTip(RedPointConst.OPERATION_ACTIVITY, 0)
	end)
	slot0:AddBtnListenerScale(slot0.btn_shopBtn_, nil, function ()
		OperationAction.OpenOperationUrl("SHOPPING_URL", {})
		RedPointAction.HandleRedPoint(RED_POINT_ID.SHOP_TAOBAO)
		manager.redPoint:setTip(RedPointConst.SHOP_TAOBAO, 0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 10,
			direction_channel = 4
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	slot0:UpdataOperationViewRedPoint()
	manager.redPoint:bindUIandKey(slot0.btn_suggestGo_.transform, RedPointConst.CUSTOMER_SERVICE_UNREAD)
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

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.btn_suggestGo_.transform, RedPointConst.CUSTOMER_SERVICE_UNREAD)
end

function slot0.RefreshUI(slot0)
	SetActive(slot0.btn_uccnGo_, table.keyof(OperationData:GetOperationOpenList(), OperationConst.OFFICIAL_WEBSITE) ~= nil)
	SetActive(slot0.btn_psqGo_, table.keyof(slot1, OperationConst.QUESTIONNAIRE) ~= nil)
	SetActive(slot0.btn_mycenterGo_, table.keyof(slot1, OperationConst.USER_CENTER) ~= nil)
	SetActive(slot0.btn_attentionGo_, table.keyof(slot1, OperationConst.ATTENTION) ~= nil)
	SetActive(slot0.btn_suggestGo_, table.keyof(slot1, OperationConst.SUGGEST) ~= nil)
	SetActive(slot0.btn_cdkGo_, table.keyof(slot1, OperationConst.CD_KEY) ~= nil)
	SetActive(slot0.btn_forumGo_, table.keyof(slot1, OperationConst.FORUM) ~= nil)
	SetActive(slot0.btn_queryGo_, table.keyof(slot1, OperationConst.INQUERY) ~= nil)
	SetActive(slot0.btn_guideGo_, table.keyof(slot1, OperationConst.GUIDE) ~= nil)
	SetActive(slot0.btn_activityGo_, table.keyof(slot1, OperationConst.ACTIVITY) ~= nil)
	SetActive(slot0.btn_shopGo_, table.keyof(slot1, OperationConst.SHOP_TAOBAO) ~= nil)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
