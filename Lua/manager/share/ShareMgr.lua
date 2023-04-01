slot0 = require("cjson")
slot1 = import("manager.share.ShareLogoView")
slot2 = class("ShareMgr")

function slot2.Ctor(slot0)
	slot0:InitUI()
	slot0:AddListeners()
	SetActive(slot0.gameObject_, false)

	slot0.shareCallbackHandler_ = handler(slot0, slot0.ShareCallback)

	manager.notify:RegistListener(SHARE_CALLBACK, slot0.shareCallbackHandler_)
end

function slot2.InitUI(slot0)
	slot0.screenSnapPath_ = Application.persistentDataPath .. "/screen_snap/picture_for_share" .. manager.time:GetServerTime() .. ".jpg"
	slot3 = Asset.Load("Atlas/Share", true)
	slot0.gameObject_ = GameObject.Instantiate(Asset.Load("UI/Common/ShareUI"), GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage/Canvas").transform)
	slot0.transform_ = slot0.gameObject_.transform

	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)

	slot0.shareLogoView_ = uv0.New(slot0.goSnapPanel_)

	if not SDKTools.GetIsOverSea() then
		if slot0.buttonTwiiter_ then
			SetActive(slot0.buttonTwiiter_.transform.gameObject, false)
		end
	else
		SetActive(slot0.buttonQQ_.transform.gameObject, false)
		SetActive(slot0.buttonQQZone_.transform.gameObject, false)
		SetActive(slot0.buttonWechat_.transform.gameObject, false)
		SetActive(slot0.buttonWeibo_.transform.gameObject, false)
		SetActive(slot0.buttonWechatMoments_.transform.gameObject, false)
		SetActive(slot0.buttonTwiiter_.transform.gameObject, true)
	end
end

function slot2.Share(slot0, slot1, slot2, slot3, slot4)
	SetActive(slot0.gameObject_, true)

	slot0.shareCallback_ = slot3
	slot5 = manager.ui

	slot5:EventEnabled(false)

	slot5 = manager.tips

	slot5:Show(false)
	slot1()

	slot5 = slot0.shareLogoView_

	slot5:HideLogo()

	slot5 = manager.ui

	slot5:ShowScreenTap(false)
	SetActive(slot0.goSharePanel_, false)

	slot5 = manager.achievementTips

	slot5:Hide(true)
	WaitRenderFrameUtil.inst.StartScreenShot(function ()
		slot1, slot2 = SettingTools.GetSettingScreenSize(tonumber(SettingData:GetSettingData().pic.resolution))

		if not SDKTools.IsSDK() then
			slot2 = Screen.height
			slot1 = Screen.width
		end

		if uv0 then
			uv1.screenSnap_ = ScreenSnap.New(slot2, slot1)
			uv1.screenSnap2_ = ScreenSnap.New(slot2, slot1)
		else
			uv1.screenSnap_ = ScreenSnap.New(slot1, slot2)
			uv1.screenSnap2_ = ScreenSnap.New(slot1, slot2)
		end

		slot3 = uv1.screenSnap_

		slot3:Take()

		slot3 = uv1.screenSnap_
		uv1.imageBg_.sprite = slot3:GetSprite()
		slot4 = uv1.shareLogoView_

		slot4:ShowLogo()
		WaitRenderFrameUtil.inst.StartScreenShot(function ()
			uv0.screenSnap2_:Take()
			uv0.shareLogoView_:HideLogo()
			SetActive(uv0.goSharePanel_, true)
			manager.achievementTips:Hide(false)
			manager.ui:ShowScreenTap(true)
			uv1()
			manager.tips:Show(true)
			manager.ui:EventEnabled(true)

			uv2 = uv0.screenSnap2_:GetSprite()
			uv0.imageShot_.sprite = uv2
			uv0.screenSnapPath_ = Application.persistentDataPath .. "/screen_snap/picture_for_share" .. manager.time:GetServerTime() .. ".jpg"

			uv0.screenSnap2_:SaveSnap(uv0.screenSnapPath_)
		end)
	end)
end

function slot2.AddListeners(slot0)
	slot1 = slot0.buttonCancel_.onClick

	slot1:AddListener(function ()
		uv0:OnClickClose()
	end)

	if slot0.buttonQQ_ then
		slot1 = slot0.buttonQQ_.onClick

		slot1:AddListener(function ()
			uv0:OnClickShare("QQ")
		end)
	end

	if slot0.buttonQQZone_ then
		slot1 = slot0.buttonQQZone_.onClick

		slot1:AddListener(function ()
			uv0:OnClickShare("QZone")
		end)
	end

	if slot0.buttonWechat_ then
		slot1 = slot0.buttonWechat_.onClick

		slot1:AddListener(function ()
			uv0:OnClickShare("Wechat")
		end)
	end

	if slot0.buttonWechatMoments_ then
		slot1 = slot0.buttonWechatMoments_.onClick

		slot1:AddListener(function ()
			uv0:OnClickShare("WechatMoments")
		end)
	end

	if slot0.buttonWeibo_ then
		slot1 = slot0.buttonWeibo_.onClick

		slot1:AddListener(function ()
			uv0:OnClickShare("SinaWeibo")
		end)
	end

	if slot0.buttonTwiiter_ then
		slot1 = slot0.buttonTwiiter_.onClick

		slot1:AddListener(function ()
			uv0:OnClickShare(nil)
		end)
	end

	slot1 = slot0.buttonSave_.onClick

	slot1:AddListener(function ()
		if GameToSDK.PLATFORM_ID == 2 then
			ReceiveSavePhotoMessage(true)
		else
			LuaForUtil.SavePhotoToAlbum(uv0.screenSnapPath_)
		end
	end)
end

function slot2.RemoveListeners(slot0)
	slot0.buttonCancel_.onClick:RemoveAllListeners()
	slot0.buttonQQ_.onClick:RemoveAllListeners()
	slot0.buttonQQZone_.onClick:RemoveAllListeners()
	slot0.buttonWechat_.onClick:RemoveAllListeners()
	slot0.buttonWechatMoments_.onClick:RemoveAllListeners()
	slot0.buttonWeibo_.onClick:RemoveAllListeners()
	slot0.buttonTwiiter_.onClick:RemoveAllListeners()
	slot0.buttonSave_.onClick:RemoveAllListeners()
end

function slot2.OnClickClose(slot0)
	SetActive(slot0.gameObject_, false)

	slot0.screenSnap_ = nil
	slot0.screenSnap2_ = nil
	slot0.shareCallback_ = nil
end

function slot2.OnClickShare(slot0, slot1)
	if not SDKTools.IsSDK() then
		ShowTips("请用移动端分享")

		return
	end

	slot5 = {}
	slot6 = nil
	slot0.paltform_ = slot1

	SendMessageToSDK(uv0.encode({
		imageUrl = "",
		messageType = slot1 == nil and "Share" or "ShareWithPlatform",
		url = GetTips("SHARE_URL"),
		title = GetTips("SHARE_TITLE"),
		content = GetTips("SHARE_CONTENT"),
		imagePath = slot0.screenSnapPath_,
		platform = slot1
	}))
end

function slot2.ShareCallback(slot0, slot1)
	if slot1 == 0 then
		if slot0.shareCallback_ then
			slot0.shareCallback_()
		end
	elseif slot1 == 2 then
		-- Nothing
	end
end

function slot2.Dispose(slot0)
	if slot0.shareLogoView_ then
		slot0.shareLogoView_:Dispose()

		slot0.shareLogoView_ = nil
	end

	if slot0.gameObject_ then
		manager.notify:RemoveListener(SHARE_CALLBACK, slot0.shareCallbackHandler_)

		slot0.shareCallbackHandler_ = nil

		slot0:RemoveListeners()
		Object.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
		slot0.transform_ = nil
	end
end

return slot2
