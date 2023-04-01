slot0 = class("LoadUIMgr")

function slot0.Ctor(slot0)
	slot0._waittingDlg = nil

	slot0:OnCtor()
end

function slot0.OnCtor(slot0)
	print("Initialize Load UI Mgr")

	slot0._waittingDlg = Object.Instantiate(Asset.Load("UI/Loading"), manager.ui.uiLoad.transform)

	SetActive(slot0._waittingDlg, false)

	slot0._uiImage = slot0._waittingDlg.transform:Find("content").gameObject

	SetActive(slot0._uiImage, false)

	slot0._isLoad = false
	slot0.isForceShow_ = false
end

function slot0.ShowLoad(slot0, slot1)
	if slot0._waittingDlg == nil then
		return
	end

	if slot0.isForceShow_ then
		slot1 = true
	end

	if slot0._isLoad == slot1 then
		return
	end

	if slot0.loadingTimer_ then
		slot0.loadingTimer_:Stop()

		slot0.loadingTimer_ = nil
	end

	if slot1 then
		slot0._isLoad = true
		slot0.loadingTimer_ = Timer.New(function ()
			SetActive(uv0._uiImage, true)

			uv0.loadingTimer_ = nil
		end, 1.5, 1)

		slot0.loadingTimer_:Start()
		SetActive(slot0._waittingDlg, true)
	else
		slot0._isLoad = false

		SetActive(slot0._waittingDlg, false)
		SetActive(slot0._uiImage, false)
	end
end

function slot0.ForceShowLoad(slot0, slot1)
	slot0.isForceShow_ = slot1
end

function slot0.Dispose(slot0)
	if slot0.loadingTimer_ then
		slot0.loadingTimer_:Stop()

		slot0.loadingTimer_ = nil
	end

	Object.Destroy(slot0._waittingDlg)

	slot0._waittingDlg = nil
end

return slot0
