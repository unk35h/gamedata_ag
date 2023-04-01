slot0 = class("HeroArchiveView", ReduxView)
slot1 = {
	"heroarchivesGo_",
	"heartlinkGo_",
	"archivegiftGo_",
	"archivevoiceGo_"
}
slot2 = {
	"archives",
	"heart",
	"gift",
	"voice"
}
slot3 = {
	GIFT = 3,
	ARCHIVE = 1,
	VOICE = 4,
	HEART = 2
}

function slot4(slot0)
	return math.ceil(slot0 / math.round(HeroConst.HERO_LOVE_LV_MAX / 5))
end

function slot5(slot0)
	return getSprite(SpritePathConst.texturePath[3] .. slot0)
end

function slot0.UIName(slot0)
	return "UI/HeroArchive/HeroArchiveUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.pages = {
		HeroArchivePage,
		HeroHeartLinkPage,
		HeroArchiveGiftPage,
		HeroArchiveVoicePage
	}
	slot0.heroIDp_ = {}
	slot0.pageContain_ = {}
	slot0.toggleContain_ = {}
	slot0.pageID_ = 0
	slot0.lv_ = 0

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rightController_ = ControllerUtil.GetController(slot0.rightTrs_, "conName")
	slot0.colorController_ = ControllerUtil.GetController(slot0.archivegiftGo_.transform, "ColorChange")
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 4 do
		slot0:AddToggleListener(slot0[uv0[slot4] .. "Tgl_"], function (slot0)
			if slot0 then
				if uv0 == uv1.HEART then
					manager.redPoint:setTip(RedPointConst.HERO_HEARTLINK_ID .. uv2.archiveID_, 0)
					ArchiveRedPoint.SetRedPointData("heartLink", uv2.archiveID_)
				end

				if uv2.pageID_ == uv0 then
					return
				end

				uv2.rightController_:SetSelectedState(uv3[uv0])
				uv2:RefreshPage(uv0)

				if uv0 == 1 then
					OperationRecorder.Record("hero", "archiveMessage")
				elseif uv0 == 2 then
					OperationRecorder.Record("hero", "archiveArchive")
				elseif uv0 == 3 then
					OperationRecorder.Record("hero", "archiveGift")
				elseif uv0 == 4 then
					OperationRecorder.Record("hero", "archiveVoice")
				end
			end
		end)
	end
end

function slot0.OnSendGift(slot0, slot1, slot2)
	if slot0.lv_ < LvTools.LoveExpToLevel(ArchiveData:GetArchive(slot0.archiveID_).exp) then
		slot0.lv_ = slot3
	end

	slot0.pageContain_[uv0.GIFT]:OnSendGift(slot1, slot2)
end

function slot0.RefreshPage(slot0, slot1)
	if slot0.pageID_ == uv0.GIFT then
		slot0:RefreshLoveCircle()
	end

	slot0:RecordStay(slot0.pageID_)

	slot0.pageID_ = slot1

	if not slot0.pageContain_[slot1] then
		slot0.pageContain_[slot1] = slot0.pages[slot1].New(slot0[uv1[slot1]])

		slot0.pageContain_[slot1]:RegisterInterruptVoice(handler(slot0, slot0.InterruptVoice))

		if slot1 == uv0.GIFT then
			slot0.pageContain_[slot1]:RegisterCircle(handler(slot0, slot0.RefreshLoveCircle))
		end
	end

	if slot1 == uv0.VOICE then
		slot0.pageContain_[uv0.VOICE]:RefreshUI(slot0.heroID_)
	else
		slot0.pageContain_[slot1]:RefreshUI(slot0.archiveID_, slot0.heroID_)
	end
end

function slot0.OnEnter(slot0)
	slot0:ShowDefaultBar()
	manager.ui:SetMainCamera("hero")

	slot0.heroID_ = slot0.params_.heroID
	slot0.pageID_ = slot0.params_.pageID or 1
	slot1 = nil
	slot0.archiveID_, slot1 = HeroTools.GetHeroOntologyID(slot0.heroID_)
	slot0.lv_ = LvTools.LoveExpToLevel(ArchiveData:GetArchive(slot0.archiveID_).exp)

	slot0.heroAvatarView_:SetSkinId(HeroTools.HeroUsingSkinInfo(slot0.heroID_).id)
	slot0.heroAvatarView_:ShowHeroModel(true)
	manager.redPoint:bindUIandKey(slot0.heartTrs_, RedPointConst.HERO_HEARTLINK_ID .. slot0.archiveID_)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshLoveCircle()

	slot0[uv0[slot0.pageID_] .. "Tgl_"].isOn = true

	slot0.rightController_:SetSelectedState(uv0[slot0.pageID_])
	slot0:RefreshPage(slot0.pageID_)

	slot1 = {}
	slot5 = slot0.archiveID_

	for slot5, slot6 in ipairs(HeroRecordCfg[slot5].hero_id) do
		if HeroCfg[slot6].private ~= 1 and not HeroTools.GetIsHide(slot6) then
			table.insert(slot1, slot6)
		end
	end

	slot0:RefreshHeroToggles(slot1, slot0.heroID_)
	slot0:RefreshCV()
end

function slot0.RefreshCV(slot0)
	slot0.cvtextText_.text = "CV:" .. GetI18NText(HeroRecordCfg[slot0.archiveID_]["cv_" .. VoiceLanguageCfg[SettingData:GetSoundSettingData().voice_language].affix])
end

function slot0.RefreshHeroToggles(slot0, slot1, slot2)
	slot3 = 1

	for slot7, slot8 in ipairs(slot1) do
		if not slot0.toggleContain_[slot3] then
			slot0.toggleContain_[slot3] = HeroArchiveToggle.New(slot0.noumenonGo_)
		end

		slot0.toggleContain_[slot3]:AddUIListener(function (slot0)
			uv0.heroID_ = slot0
			uv0.params_.heroID = slot0

			uv0.heroAvatarView_:SetSkinId(HeroTools.HeroUsingSkinInfo(uv0.heroID_).id)
			uv0.heroAvatarView_:ShowHeroModel(true)
			uv0:RefreshPage(uv0.pageID_)
			OperationRecorder.Record("hero", "hero_record_switch")
		end)
		slot0.toggleContain_[slot3]:RefreshUI(slot8, slot2 == slot8)

		slot3 = slot3 + 1
	end

	for slot7 = slot3, #slot0.toggleContain_ do
		slot0.toggleContain_[slot7]:OnExit()
	end

	if slot0.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.heroContent_)
	end
end

function slot0.InterruptVoice(slot0)
	for slot4 = 1, #uv0 do
		if slot0.pageContain_[slot4] and slot0.pageContain_[slot4].StopVoice then
			slot0.pageContain_[slot4]:StopVoice()
		end
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	manager.redPoint:unbindUIandKey(slot0.heartTrs_, RedPointConst.HERO_HEARTLINK_ID .. slot0.archiveID_)
	slot0.heroAvatarView_:OnExit()

	if slot0.pageContain_[uv0.HEART] then
		slot0.pageContain_[uv0.HEART]:OnExit()
	end

	slot0:InterruptVoice()
	slot0:RecordStay(slot0.pageID_)

	slot0.pageID_ = 0

	HeroTools.StopTalk()
end

function slot0.RefreshLoveCircle(slot0, slot1)
	slot1 = slot1 or ArchiveData:GetArchive(slot0.archiveID_).lv

	slot0.colorController_:SetSelectedIndex(uv0(slot1) - 1)

	slot0.lovelevelText_.text = slot1
end

function slot0.Dispose(slot0)
	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:Dispose()

		slot0.heroAvatarView_ = nil
	end

	for slot4, slot5 in pairs(slot0.pageContain_) do
		slot5:Dispose()
	end

	for slot4, slot5 in pairs(slot0.toggleContain_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.RecordStay(slot0, slot1)
	if slot0:GetStayTime() == 0 then
		return
	end

	slot3 = 0

	if slot1 == uv0.ARCHIVE then
		slot3 = 20108
	elseif slot1 == uv0.HEART then
		slot3 = 20109
	elseif slot1 == uv0.GIFT then
		slot3 = 20111
	elseif slot1 == uv0.VOICE then
		slot3 = 20112
	end

	OperationRecorder.RecordStayView("STAY_VIEW_HERO_ARCHIVE", slot2, slot0.heroID_, slot3)
	slot0:UpdateLastOpenTime()
end

return slot0
