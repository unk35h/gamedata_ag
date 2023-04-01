slot0 = class("ChatWorldView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0.switchChannelHandler_ = handler(slot0, slot0.OnSwitchChannel)

	manager.notify:RegistListener(CHAT_NEW_CHANNEL, slot0.switchChannelHandler_)
	slot0:OnSwitchChannel()
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(CHAT_NEW_CHANNEL, slot0.switchChannelHandler_)
end

function slot0.OnUpdate(slot0)
end

function slot0.Dispose(slot0)
	slot0.inputFieldChannel_.onEndEdit:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot1 = slot0.inputFieldChannel_.onEndEdit

	slot1:AddListener(function ()
		if tonumber(uv0.inputFieldChannel_.text) == ChatData:GetWorldChannelNum() then
			return
		end

		if uv0.inputFieldChannel_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			uv0.inputFieldChannel_.text = ChatData:GetWorldChannelNum()

			return
		end

		if tonumber(uv0.inputFieldChannel_.text) == nil or slot0 <= 0 then
			ShowTips("INPUT_CHANNEL_NUM")

			uv0.inputFieldChannel_.text = ChatData:GetWorldChannelNum()
		else
			if manager.time:GetServerTime() - ChatData:GetChannelTimestamp() < 5 then
				ShowTips("SWITCH_CHANNEL_FREQUENTLY")

				uv0.inputFieldChannel_.text = ChatData:GetWorldChannelNum()

				return
			end

			ChatAction.SetWorldChannelNum(slot0, function (slot0)
				if slot0 == 0 then
					ChatData:SetChannelTimestamp()
				else
					uv0.inputFieldChannel_.text = ChatData:GetWorldChannelNum()

					ShowTips(slot0)
				end
			end)
		end
	end)
end

function slot0.OnSwitchChannel(slot0)
	slot0.inputFieldChannel_.text = ChatData:GetWorldChannelNum()
end

return slot0
