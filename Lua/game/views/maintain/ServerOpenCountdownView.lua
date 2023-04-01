slot0 = class("ServerOpenCountdownView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/ServerUI"
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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		OperationAction.OpenOperationUrl("FORUM_URL", {
			gameAppId = _G.ChannelLoginInfo.channelAppId,
			token = _G.ChannelLoginInfo.channelToken
		})
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 8,
			direction_channel = 3
		})
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		Application.OpenURL("https://open.ys4fun.com/web-api/pass/linkrouter/qqun")
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.now_ = slot0.params_.now
	slot0.currentServerTime_ = manager.time:GetServerTime()
	slot0.passedSeconds_ = 0

	if not slot0.timer_ then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTime()
		end, 0.2, -1)
	end

	slot0.timer_:Start()
	slot0:UpdateTime()

	if tostring(_G.CHANNEL_MASTER_ID) == "1" or GameToSDK.PLATFORM_ID == 1 then
		SetActive(slot0.okBtn_.gameObject, true)
		SetActive(slot0.cancelBtn_.gameObject, true)
	else
		SetActive(slot0.okBtn_.gameObject, false)
		SetActive(slot0.cancelBtn_.gameObject, false)
	end
end

function slot0.UpdateTime(slot0)
	slot0.passedSeconds_ = manager.time:GetServerTime() - slot0.currentServerTime_
	slot0.contentText_.text = slot0.params_.content
	slot1 = slot0.params_.countdown
	slot2 = ""
	slot5 = slot0.params_.countdown - (slot0.params_.now + slot0.passedSeconds_)
	slot6 = math.floor(slot5 / 86400)
	slot8 = math.floor(slot5 / 60) - slot6 * 24 * 60 - (math.floor(slot5 / 3600) - slot6 * 24) * 60

	if slot5 >= 86400 then
		slot2 = string.format(TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_1].desc, slot6, slot7, slot8)
	elseif slot5 >= 3600 then
		slot2 = string.format(TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_2].desc, slot7, slot8)
	elseif slot5 >= 600 then
		slot2 = string.format(TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_3].desc, slot8)
	elseif slot5 > 0 then
		slot2 = TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_4].desc
	else
		slot0:Back()
	end

	slot0.countdownText_.text = slot2
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
