slot0 = class("GuildChangeNoticeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubNoticeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
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
		if OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.CHANGE_CLUB_SIGN) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		slot0 = uv0.inputFieldNotice_.text
		uv0.inputFieldNotice_.text, slot3 = textLimit(uv0.inputFieldNotice_.text, GameSetting.club_announcement_max.value[1])

		if not slot3 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), slot1))

			return
		end

		if not nameRule(slot2, true) then
			ShowTips("ERROR_USER_NAME_VER_WORD")

			return
		end

		WordVerifyBySDK(slot2, function (slot0)
			if not slot0 then
				ShowTips("SENSITIVE_WORD")
			else
				GuildAction.GuildChangeNotice(uv0, function (slot0)
					if isSuccess(slot0.result) then
						uv0:Back()

						uv0.inputFieldNotice_.text = ""

						ShowTips("CLUB_CHANGED_NOTICE_SUCCESS")
					else
						ShowTips(slot0.result)
					end
				end)
			end
		end, JUDGE_MESSAGE_TYPE.GUILD_NOTICE)
	end)
end

return slot0
