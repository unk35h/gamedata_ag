slot0 = require("cjson")
slot1 = class("HeroDisplayShareView", ReduxView)

function slot1.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.screenSnapPath_ = Application.persistentDataPath .. "/screen_snap/picture_for_share.jpg"
	slot0.shareCallbackHandler_ = handler(slot0, slot0.ShareCallback)
end

function slot1.SetData(slot0, slot1, slot2, slot3)
	slot0.heroId_ = slot1
	slot0.showWeapon_ = slot2
	slot0.posIndex_ = slot3
end

function slot1.OnSnape(slot0)
	slot2, slot3 = SettingTools.GetSettingScreenSize(tonumber(SettingData:GetSettingData().pic.resolution))

	if not SDKTools.IsSDK() then
		slot3 = _G.SCREEN_HEIGHT
		slot2 = _G.SCREEN_WIDTH
	end

	slot0.screenSnap_ = ScreenSnap.New(slot3, slot2)

	slot0.screenSnap_:Take()

	slot4 = slot0.screenSnap_:GetSprite()
	slot0.imageShot_.sprite = slot4
	slot0.imageBg_.sprite = slot4

	slot0.screenSnap_:SaveSnap(slot0.screenSnapPath_)
	SetActive(slot0.gameObject_, true)
end

function slot1.OnEnter(slot0)
	print("分享功能差异化")

	if not SDKTools.GetIsOverSea() then
		SetActive(slot0.buttonTwiiter_.transform.gameObject, false)
	else
		SetActive(slot0.buttonQQ_.transform.gameObject, false)
		SetActive(slot0.buttonQQZone_.transform.gameObject, false)
		SetActive(slot0.buttonWechat_.transform.gameObject, false)
		SetActive(slot0.buttonWeibo_.transform.gameObject, false)
		SetActive(slot0.buttonWechatMoments_.transform.gameObject, false)
		SetActive(slot0.buttonTwiiter_.transform.gameObject, true)
	end

	manager.notify:RegistListener(SHARE_CALLBACK, slot0.shareCallbackHandler_)
end

function slot1.OnExit(slot0)
	manager.notify:RemoveListener(SHARE_CALLBACK, slot0.shareCallbackHandler_)

	slot0.screenSnap_ = nil
end

function slot1.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.shareCallbackHandler_ = nil
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonCancel_, nil, function ()
		SetActive(uv0.gameObject_, false)
	end)
	slot0:AddBtnListener(slot0.buttonQQ_, nil, function ()
		uv0:Share("QQ")
	end)
	slot0:AddBtnListener(slot0.buttonQQZone_, nil, function ()
		uv0:Share("QZone")
	end)
	slot0:AddBtnListener(slot0.buttonWechat_, nil, function ()
		uv0:Share("Wechat")
	end)
	slot0:AddBtnListener(slot0.buttonWechatMoments_, nil, function ()
		uv0:Share("WechatMoments")
	end)
	slot0:AddBtnListener(slot0.buttonWeibo_, nil, function ()
		uv0:Share("SinaWeibo")
	end)
	slot0:AddBtnListener(slot0.buttonTwiiter_, nil, function ()
		uv0:Share(nil)
	end)
	slot0:AddBtnListener(slot0.buttonSave_, nil, function ()
		if GameToSDK.PLATFORM_ID == 2 then
			ReceiveSavePhotoMessage(true)
		else
			LuaForUtil.SavePhotoToAlbum(uv0.screenSnapPath_)
		end
	end)
end

function slot1.Share(slot0, slot1)
	if not SDKTools.IsSDK() then
		ShowTips("SHARE_PLATFORM")

		return
	end

	slot5 = nil
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

function slot1.ShareCallback(slot0, slot1)
	if slot1 == 0 then
		slot0:SendToSDK(slot0.paltform_)
	elseif slot1 == 2 then
		-- Nothing
	end
end

function slot1.SendToSDK(slot0, slot1)
	slot2 = HeroDisplayData:GetHeroPoseList(slot0.heroId_)[slot0.posIndex_]
	slot3 = 0

	if slot0.showWeapon_ and slot2.hasWeapon then
		slot3 = 1
	end

	SDKTools.SendMessageToSDK("screenshot", {
		screenshot_oper = 2,
		hero_id = slot0.heroId_,
		weapon_on = slot3,
		posture_id = slot0.posIndex_,
		logo_location = HeroDisplayData.settingProfile_.logoPos == 0 and 2 or HeroDisplayData.settingProfile_.logoPos,
		card_show = HeroDisplayData.settingProfile_.cardShow and 1 or 0,
		card_location = HeroDisplayData.settingProfile_.cardPos == 0 and 1 or HeroDisplayData.settingProfile_.cardPos,
		lv_show = HeroDisplayData.settingProfile_.cardShowLv and 1 or 0,
		uid_show = HeroDisplayData.settingProfile_.cardShowUID and 1 or 0,
		share_channel = SDKTools.PlatformStrToId(slot1)
	})
end

return slot1
