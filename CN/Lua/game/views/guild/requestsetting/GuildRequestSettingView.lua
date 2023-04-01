slot0 = class("GuildRequestSettingView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubApplicationsettings"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot1 = GuildData:GetGuildInfo()
	slot0[string.format("toggle%s_", slot1.reviewFlag)].isOn = true
	slot0.inputFieldLevel_.text = slot1.limitLevel
	slot0.reviewFlag_ = slot1.reviewFlag
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.inputFieldLevel_.onEndEdit:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonCancel_, nil, function ()
		uv0:Back()
	end)

	slot1 = slot0.inputFieldLevel_.onEndEdit

	slot1:AddListener(function ()
		if uv0.inputFieldLevel_.text == "" or uv0.inputFieldLevel_.text == "-" then
			uv0.inputFieldLevel_.text = GuildData:GetGuildInfo().limitLevel

			return
		end
	end)

	slot4 = slot0.buttonOk_

	slot0:AddBtnListener(slot4, nil, function ()
		if tonumber(uv0.inputFieldLevel_.text) < GameSetting.club_default_level_limit.value[1] then
			slot0 = slot1
		end

		if GameSetting.hero_level_max.value[1] < slot0 then
			slot0 = slot2
		end

		GuildAction.GuildRequestSetting(uv0.reviewFlag_, slot0, function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("CLUB_SAVE_SETTING")
				GuildData:SetGuildSetting(uv0.reviewFlag_, uv1)
				uv0:Back()
			else
				ShowTips(slot0.result)
			end
		end)
	end)

	for slot4 = 1, 3 do
		slot0:AddToggleListener(slot0[string.format("toggle%s_", slot4)], function (slot0)
			if slot0 then
				uv0.reviewFlag_ = uv1
			end
		end)
	end
end

return slot0
