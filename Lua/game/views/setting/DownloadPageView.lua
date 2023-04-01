slot0 = class("DownloadPageView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/LanguageDownloadUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		if uv0.canceling then
			return
		end

		uv0.canceling = true

		VoicePackageManager.Instance:DownloadCancel()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		CloseDownLoadPage()
	end)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.SetTitle(slot0, slot1)
	slot0.titleText_.text = slot1
end

function slot0.SetProgress(slot0, slot1, slot2)
	slot0.progressImg_.fillAmount = slot1
	slot0.progressText_.text = slot2
end

function slot0.OnEnter(slot0)
	if slot0.params_.title then
		slot0:SetTitle(slot0.params_.title)
	end

	slot0:SetProgress(0, GetTips("DOWNLOAD_START"))
	slot0.cancelGo_:SetActive(true)
	slot0.okGo_:SetActive(false)

	slot0.canceling = false

	VoicePackageManager.Instance:StartDownLoadPackage(slot0.params_.abbr)

	if slot0.updateTimer ~= nil then
		slot0.updateTimer:Stop()

		slot0.updateTimer = nil
	end

	if slot0.updateTimer == nil then
		slot0.updateTimer = Timer.New(function ()
			if VoicePackageManager.Instance:IsDownloading(VoicePackageManager.Instance:UpdateDownloading()) and VoicePackageManager.Instance:GetDownloadInfo(slot0) ~= "" then
				slot2 = string.split(slot1, ":")

				uv0:SetProgress(tonumber(slot2[2]) / tonumber(slot2[3]), slot2[4])
			end

			if VoicePackageManager.Instance:IsSucceed(slot0) then
				if uv0.updateTimer ~= nil then
					uv0.updateTimer:Stop()

					uv0.updateTimer = nil
				end

				uv0.okGo_:SetActive(true)
				uv0.cancelGo_:SetActive(false)
				uv0:SetProgress(1, GetTips("DOWNLOAD_SUCCESS"))
				VoicePackageManager.Instance:InsertDownloadedPackage(uv0.params_.abbr)
				VoicePackageManager.Instance:DownloadShutdown()
				manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_DOWNLOADED, uv0.params_.abbr)
			end

			if VoicePackageManager.Instance:IsFailed(slot0) then
				uv0:SetTitle(GetTips("DOWNLOAD_FAIL"))
				uv0:SetProgress(0, GetTips("DOWNLOAD_FAIL") .. VoicePackageManager.Instance:GetDownloadInfo(slot0))
			end

			if VoicePackageManager.Instance:IsCanceling(slot0) then
				slot1 = VoicePackageManager.Instance:GetDownloadInfo(slot0)

				uv0:SetProgress(0, GetTips("DOWNLOAD_CANCEL"))
			end

			if VoicePackageManager.Instance:IsCanceled(slot0) then
				if uv0.updateTimer ~= nil then
					uv0.updateTimer:Stop()

					uv0.updateTimer = nil
				end

				VoicePackageManager.Instance:DownloadShutdown()
				manager.notify:CallUpdateFunc(LANGUAGE_PACKAGE_CANCEL)
				CloseDownLoadPage()
			end
		end, 0.1, -1)
	end

	slot0.updateTimer:Start()
end

function slot0.OnExit(slot0)
	if slot0.updateTimer ~= nil then
		slot0.updateTimer:Stop()

		slot0.updateTimer = nil
	end
end

function slot0.Dispose(slot0)
	slot0.params_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
