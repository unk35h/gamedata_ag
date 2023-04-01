slot0 = class("GuildShareInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubShareMessagePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	dealEnter(slot0.inputFieldNotice_)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0.inputFieldNotice_.text = ""

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonCancel_, nil, function ()
		uv0.inputFieldNotice_.text = ""

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonOk_, nil, function ()
		slot0 = uv0.inputFieldNotice_.text
		uv0.inputFieldNotice_.text, slot3 = textLimit(uv0.inputFieldNotice_.text, GameSetting.club_share_max.value[1])

		if not slot3 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), slot1))

			return
		end

		WordVerifyBySDK(slot2, function (slot0)
			if not slot0 then
				ShowTips("SENSITIVE_WORD")
			else
				GuildAction.GuildShare(uv0, function (slot0)
					if isSuccess(slot0.result) then
						uv0:Back()

						uv0.inputFieldNotice_.text = ""

						ChatAction.RequireGuildShareInfo()
						JumpTools.OpenPageByJump("chat", {
							ignoreBG = true,
							chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_RECRUIT
						}, ViewConst.SYSTEM_ID.CHAT)
					else
						ShowTips(slot0.result)
					end
				end)
			end
		end, JUDGE_MESSAGE_TYPE.GUILD_SHARE)
	end)
end

return slot0
