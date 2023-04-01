slot0 = class("AwakeNameView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/AwakeNameUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
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
	slot0:AddBtnListener(slot0.buttonConfirm_, nil, function ()
		if uv0.inputName_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")
		else
			slot1, slot2 = textLimit(uv0.inputName_.text, GameSetting.user_name_max.value[1])
			uv0.inputName_.text = slot1

			if not nameRule(slot1) then
				ShowTips("ERROR_USER_NAME_VER_WORD")

				return
			end

			WordVerifyBySDK(slot0, function (slot0)
				if slot0 then
					if not uv0 then
						return
					end

					PlayerAction.AwakeName(uv1, function ()
						SendMessageManagerToSDK("role_create", {
							curNameText = uv0
						})
						CheckNewGuide()

						if uv1.gameObject_ then
							SetActive(uv1.gameObject_, false)
						end
					end)
				else
					ShowTips("ERROR_USER_NAME_VER_WORD")
				end
			end, JUDGE_MESSAGE_TYPE.PLAYER_NAME)
		end
	end)
end

function slot0.Cacheable(slot0)
	return false
end

return slot0
