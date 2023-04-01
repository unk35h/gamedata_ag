slot0 = class("LanguagePackageItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.downloadBtn_, nil, function ()
		if LuaForUtil.GetFreeDiskSpace() < VoicePackageManager.Instance:GetPackageSize(uv0.info_.affix) + 200 then
			ShowMessageBox({
				content = GetTips("VOICE_STORAGE_FULL"),
				OkCallback = function ()
				end,
				CancelCallback = function ()
				end,
				MaskCallback = function ()
				end
			})
		else
			OpenDownLoadPage(nil, uv0.info_.affix)
		end
	end)
	slot0:AddBtnListenerScale(slot0.deleteBtn_, nil, function ()
		ShowMessageBox({
			content = string.format(GetTips("VOICE_DELETE_INFO"), GetI18NText(uv0.info_.name)),
			OkCallback = function ()
				VoicePackageManager.Instance:DeleteDownLoadPackage(uv0.info_.affix)
				manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_DELETED, uv0.info_.affix)
				uv0:RefreshData(uv0.info_)
			end,
			CancelCallback = function ()
			end,
			MaskCallback = function ()
			end
		})
	end)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.Render(slot0)
	slot0:RefreshData(slot0.info_)
end

function slot0.RefreshData(slot0, slot1)
	if slot1 then
		slot0.info_ = slot1
		slot0.nameText_.text = GetI18NText(slot1.name)
		slot3 = SettingData:GetSoundSettingData().voice_language
		slot4 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]

		if VoicePackageManager.Instance:IsHavePackage(slot1.affix) then
			slot0.spaceText_.text = ""

			if slot3 == slot1.id then
				slot0.controller_:SetSelectedState("in_use")

				slot0.tipText_.text = GetTips("TIP_USING")
			else
				slot0.controller_:SetSelectedState("downloaded")

				if table.indexof(slot4.voice_list, slot1.id) == 1 then
					SetActive(slot0.deleteBtn_.gameObject, false)
				end

				slot0.tipText_.text = GetTips("DOWNLOADED")
			end
		else
			slot0.controller_:SetSelectedState("not_downloaded")

			slot0.spaceText_.text = string.format("(%.2fMB)", VoicePackageManager.Instance:GetPackageSize(slot1.affix))
			slot0.tipText_.text = GetTips("NOT_DOWNLOADED")
		end
	end
end

function slot0.Dispose(slot0)
	slot0.params_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
