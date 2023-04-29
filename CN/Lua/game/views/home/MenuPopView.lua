slot0 = class("MenuPopView", ReduxView)
slot1 = {
	userCenter = 9901,
	activity = 9910,
	guide = 9906,
	query = 9905,
	suggest = 9902,
	shop = 9911,
	psq = 9907,
	forum = 9904,
	attention = 9908,
	uccn = 9909,
	cdk = 9903
}

function slot0.UIName(slot0)
	return "UI/Main/MenuUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.chipCon_ = ControllerUtil.GetController(slot0.chipBtn_.transform, "lock")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.musicBtn_, nil, function ()
		JumpTools.OpenPageByJump("/illuMusic", {
			isEnter = true
		})
	end)
	slot0:AddBtnListener(slot0.taskBtn_, nil, function ()
		JumpTools.GoToSystem("/task", {
			initNormalizedPosition = true,
			taskIndex = TaskConst.TASK_TYPE.DAILY
		}, ViewConst.SYSTEM_ID.TASK_PLOT)
	end)
	slot0:AddBtnListener(slot0.mailBtn_, nil, function ()
		slot0 = handler(uv0, function ()
			JumpTools.GoToSystem("/mailBox")
		end)

		if MailData.GetTotal() > #MailData.GetMailSort() then
			MailData.GetMailListFromServer(slot0)
		else
			slot0()
		end

		MailData.ClickMailBtn(manager.time:GetServerTime())
	end)
	slot0:AddBtnListener(slot0.servantBtn_, nil, function ()
		SDKTools.SendMessageToSDK("weapon_servant_touch", {
			touch_times = 1
		})
		JumpTools.GoToSystem("/weaponServantEnter", nil, ViewConst.SYSTEM_ID.WEAPON_SERVANT)
	end)
	slot0:AddBtnListener(slot0.chipBtn_, nil, function ()
		JumpTools.GoToSystem("/chipManager", nil, ViewConst.SYSTEM_ID.CHIP_MANAGER)
	end)
	slot0:AddBtnListener(slot0.suggestBtn_, nil, function ()
		NeedGameUserInfo()
		SendMessageToSDK("{\"messageType\" : \"StartCustomerService\"}")
		manager.redPoint:setTip(RedPointConst.CUSTOMER_SERVICE_UNREAD, 0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 3,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListener(slot0.guideBtn_, nil, function ()
		OperationAction.OpenOperationUrl("GUIDE_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		})
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 9,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListener(slot0.attentionBtn_, nil, function ()
		saveData("SDK", "followGift", 0)
		manager.redPoint:setTip(RedPointConst.FOLLOW_GIFT, 0)
		uv0:Go("/followGift")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 5,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListener(slot0.psqBtn_, nil, function ()
		SurveyAction.SetSurveyRedPointData()
		JumpTools.OpenPageByJump("survey", {
			type = OperationConst.SURVEY_TYPE.NORMAL
		})
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 4,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListener(slot0.queryBtn_, nil, function ()
		OperationAction.OpenOperationUrl("INQUERY_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		})
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 6,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListener(slot0.cdkBtn_, nil, function ()
		JumpTools.OpenPageByJump("GiftPopUp")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 7,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListener(slot0.forumBtn_, nil, function ()
		OperationAction.OpenOperationUrl("FORUM_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId,
			gameAppId = _G.ChannelLoginInfo.channelAppId,
			token = _G.ChannelLoginInfo.channelToken
		})
		RedPointAction.HandleNeedRedPoint(RED_POINT_ID.FORUM)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 8,
			direction_channel = 4
		})
		manager.redPoint:setTip(RedPointConst.FORUM, 0)
		manager.redPoint:setTip(RedPointConst.FORUM_UNREAD, 0)
	end)
	slot0:AddBtnListener(slot0.signBtn_, nil, function ()
		JumpTools.OpenPageByJump("sign", {
			check = true,
			activityID = ActivityConst.SIGN
		}, ViewConst.SYSTEM_ID.SIGN)
	end)
	slot0:AddBtnListener(slot0.anncBtn_, nil, function ()
		if uv0:GetBulletinID() == false then
			ShowTips("NO_ANNOUNCEMENT")
		else
			JumpTools.OpenPageByJump("bulletin", {
				bulletinID = slot0
			}, ViewConst.SYSTEM_ID.ANNOUNCEMENT)
		end
	end)
	slot0:AddBtnListener(slot0.uccnBtn_, nil, function ()
		OperationAction.OpenOperationUrl("OFFICIAL_URL")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 1,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListener(slot0.activityBtn_, nil, function ()
		OperationAction.OpenOperationUrl("ACTIVITY_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		})
		RedPointAction.HandleNeedRedPoint(RED_POINT_ID.ACTIVITY)
		manager.redPoint:setTip(RedPointConst.OPERATION_ACTIVITY, 0)
	end)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		OperationAction.OpenOperationUrl("SHOPPING_URL", {})
		RedPointAction.HandleNeedRedPoint(RED_POINT_ID.SHOP_TAOBAO)
		manager.redPoint:setTip(RedPointConst.SHOP_TAOBAO, 0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 10,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListener(slot0.settingBtn_, nil, function ()
		JumpTools.GoToSystem("/setting", {
			setType = SettingConst.SETTING_TYPE.SYSTEM
		}, ViewConst.SYSTEM_ID.SETTING)
	end)
	slot0:AddBtnListener(slot0.userCenterBtn_, nil, function ()
		NeedGameUserInfo()
		GameToSDK.GoUserCenter()
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 2,
			direction_channel = 4
		})
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshSDK()
	slot0:RefreshLock()
	slot0:RefreshMusic()
	slot0:BindRedPointUI()
end

function slot0.GetBulletinID(slot0)
	slot1 = manager.time:GetServerTime()

	for slot6, slot7 in ipairs({
		101,
		102,
		104
	}) do
		if BulletinData.GetBulletinIDList()[slot7] then
			for slot12, slot13 in pairs(slot8) do
				if slot1 < BulletinData.GetBulletinPageList()[slot13].endTime then
					return slot14.id
				end
			end
		end
	end

	return false
end

function slot0.RefreshSDK(slot0)
	slot0:RefreshSDKOpen()
end

function slot0.RefreshSDKOpen(slot0)
	slot2 = PlayerData:GetPlayerInfo().userLevel

	if table.keyof(OperationData:GetOperationOpenList(), OperationConst.USER_CENTER) ~= nil and SystemCfg[uv0.userCenter].open_condition[1][2] <= slot2 then
		SetActive(slot0.userCenterBtn_.gameObject, true)
	else
		SetActive(slot0.userCenterBtn_.gameObject, false)
	end

	if table.keyof(slot1, OperationConst.SUGGEST) ~= nil and SystemCfg[uv0.suggest].open_condition[1][2] <= slot2 then
		SetActive(slot0.suggestBtn_.gameObject, true)
	else
		SetActive(slot0.suggestBtn_.gameObject, false)
	end

	if table.keyof(slot1, OperationConst.CD_KEY) ~= nil and SystemCfg[uv0.cdk].open_condition[1][2] <= slot2 then
		SetActive(slot0.cdkBtn_.gameObject, true)
	else
		SetActive(slot0.cdkBtn_.gameObject, false)
	end

	if table.keyof(slot1, OperationConst.FORUM) ~= nil and SystemCfg[uv0.forum].open_condition[1][2] <= slot2 then
		SetActive(slot0.forumBtn_.gameObject, true)
	else
		SetActive(slot0.forumBtn_.gameObject, false)
	end

	if table.keyof(slot1, OperationConst.INQUERY) ~= nil and SystemCfg[uv0.query].open_condition[1][2] <= slot2 then
		SetActive(slot0.queryBtn_.gameObject, true)
	else
		SetActive(slot0.queryBtn_.gameObject, false)
	end

	if table.keyof(slot1, OperationConst.GUIDE) ~= nil and SystemCfg[uv0.guide].open_condition[1][2] <= slot2 then
		SetActive(slot0.guideBtn_.gameObject, true)
	else
		SetActive(slot0.guideBtn_.gameObject, false)
	end

	if table.keyof(slot1, OperationConst.QUESTIONNAIRE) ~= nil and SystemCfg[uv0.psq].open_condition[1][2] <= slot2 then
		SetActive(slot0.psqBtn_.gameObject, true)
	else
		SetActive(slot0.psqBtn_.gameObject, false)
	end

	if table.keyof(slot1, OperationConst.ATTENTION) ~= nil and SystemCfg[uv0.attention].open_condition[1][2] <= slot2 then
		SetActive(slot0.attentionBtn_.gameObject, true)
	else
		SetActive(slot0.attentionBtn_.gameObject, false)
	end

	if table.keyof(slot1, OperationConst.OFFICIAL_WEBSITE) ~= nil and SystemCfg[uv0.uccn].open_condition[1][2] <= slot2 then
		SetActive(slot0.uccnBtn_.gameObject, true)
	else
		SetActive(slot0.uccnBtn_.gameObject, false)
	end

	if table.keyof(slot1, OperationConst.ACTIVITY) ~= nil and SystemCfg[uv0.activity].open_condition[1][2] <= slot2 then
		SetActive(slot0.activityBtn_.gameObject, true)
	else
		SetActive(slot0.activityBtn_.gameObject, false)
	end

	if table.keyof(slot1, OperationConst.SHOP_TAOBAO) ~= nil and SystemCfg[uv0.shop].open_condition[1][2] <= slot2 then
		SetActive(slot0.shopBtn_.gameObject, true)
	else
		SetActive(slot0.shopBtn_.gameObject, false)
	end
end

function slot0.RefreshLock(slot0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER) then
		slot0.chipCon_:SetSelectedState("true")
	else
		slot0.chipCon_:SetSelectedState("false")
	end
end

function slot0.RefreshMusic(slot0)
	slot2 = MusicRecordCfg.all[1]

	if manager.audio:GetBgmPlayer() then
		slot4 = slot1.cueSheet or ""

		if (slot1.cueName or "") ~= "" and slot4 ~= "" then
			for slot9, slot10 in ipairs(MusicRecordCfg.all) do
				if MusicRecordCfg[slot10].cueName == slot3 and slot11.cuesheet == slot4 then
					slot2 = slot10
				end
			end
		end
	end

	slot0.musicTxt_.text = MusicRecordCfg[slot2].musicName
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.anncBtn_.transform, RedPointConst.BULLETIN_UNREAD)
	manager.redPoint:bindUIandKey(slot0.signBtn_.transform, RedPointConst.SIGN)
	manager.redPoint:bindUIandKey(slot0.servantBtn_.transform, RedPointConst.WEAPON_SERVANT_MERGE)
	manager.redPoint:bindUIandKey(slot0.settingBtn_.transform, RedPointConst.SETTING_NEW_FUNCTION)
	manager.redPoint:bindUIandKey(slot0.chipBtn_.transform, RedPointConst.CHIP_MANAGER)
	manager.redPoint:bindUIandKey(slot0.taskBtn_.transform, RedPointConst.TASK)
	manager.redPoint:bindUIandKey(slot0.mailBtn_.transform, RedPointConst.MAIL_UNREAD)
	manager.redPoint:bindUIandKey(slot0.attentionBtn_.transform, RedPointConst.FOLLOW_GIFT)
	manager.redPoint:bindUIandKey(slot0.psqBtn_.transform, RedPointConst.SURVEY)
	manager.redPoint:bindUIandKey(slot0.forumBtn_.transform, RedPointConst.FORUM_PLATFORM)
	manager.redPoint:bindUIandKey(slot0.activityBtn_.transform, RedPointConst.OPERATION_ACTIVITY)
	manager.redPoint:bindUIandKey(slot0.shopBtn_.transform, RedPointConst.SHOP_TAOBAO)
	manager.redPoint:bindUIandKey(slot0.suggestBtn_.transform, RedPointConst.CUSTOMER_SERVICE_UNREAD)
end

function slot0.UnBindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.anncBtn_.transform, RedPointConst.BULLETIN_UNREAD)
	manager.redPoint:unbindUIandKey(slot0.signBtn_.transform, RedPointConst.SIGN)
	manager.redPoint:unbindUIandKey(slot0.servantBtn_.transform, RedPointConst.WEAPON_SERVANT_MERGE)
	manager.redPoint:unbindUIandKey(slot0.settingBtn_.transform, RedPointConst.SETTING_NEW_FUNCTION)
	manager.redPoint:unbindUIandKey(slot0.chipBtn_.transform, RedPointConst.CHIP_MANAGER)
	manager.redPoint:unbindUIandKey(slot0.taskBtn_.transform, RedPointConst.TASK)
	manager.redPoint:unbindUIandKey(slot0.mailBtn_.transform, RedPointConst.MAIL_UNREAD)
	manager.redPoint:unbindUIandKey(slot0.attentionBtn_.transform, RedPointConst.FOLLOW_GIFT)
	manager.redPoint:unbindUIandKey(slot0.psqBtn_.transform, RedPointConst.SURVEY)
	manager.redPoint:unbindUIandKey(slot0.forumBtn_.transform, RedPointConst.FORUM_PLATFORM)
	manager.redPoint:unbindUIandKey(slot0.activityBtn_.transform, RedPointConst.OPERATION_ACTIVITY)
	manager.redPoint:unbindUIandKey(slot0.shopBtn_.transform, RedPointConst.SHOP_TAOBAO)
	manager.redPoint:unbindUIandKey(slot0.suggestBtn_.transform, RedPointConst.CUSTOMER_SERVICE_UNREAD)
end

function slot0.OnTop(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
	slot0:UnBindRedPointUI()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
