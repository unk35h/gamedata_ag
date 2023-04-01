slot0 = class("UserInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/UserInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	SetActive(slot0.signinput_.gameObject, false)
	slot0:SetCharLimit()

	slot0.PosterGirl_ = slot0:FindCom("SelfAdaptImage", nil, slot0.PosterGirl_.transform)
	slot0.inputfieldHelper_ = slot0:GetOrAddComponent(slot0.signinput_.gameObject, typeof(InputFieldHelper))
	slot1 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV

	print("GameToSDK.CURRENT_SDK_ID" .. tostring(GameToSDK.CURRENT_SDK_ID))
	SetActive(slot0.btn_logoutTrs_.gameObject, slot1)
	SetActive(slot0.userCenterBtn_.gameObject, not slot1)

	slot0.isHeroShowController_ = ControllerUtil.GetController(slot0.viewBtn_.transform, "ViewButton")
	slot0.heroItemList_ = {}
	slot0.heroItemController_ = {}

	for slot5 = 1, 3 do
		slot0.heroItemList_[slot5] = NewHeroHead.New(slot0[string.format("headGo%s_", slot5)])

		slot0.heroItemList_[slot5]:SetRedPointEnable(false)

		slot0.heroItemController_[slot5] = ControllerUtil.GetController(slot0[string.format("headGo%s_", slot5)].transform, "switch")
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.nameTrs_, function ()
		JumpTools.OpenPageByJump("changeName")
	end)
	slot0:AddBtnListener(nil, slot0.btn_change_nameTrs_, function ()
		JumpTools.OpenPageByJump("changeName")
	end)
	slot0:AddBtnListener(nil, slot0.sign_textBtn_, function ()
		uv0.signinput_.text = uv0.userData_.sign

		SetActive(uv0.signinput_.gameObject, true)
		uv0.signinput_:ActivateInputField()
		SetActive(uv0.sign_.gameObject, false)
	end)

	slot1 = slot0.signinput_.onEndEdit

	slot1:AddListener(function ()
		if uv0.signinput_.text ~= nil and slot0 ~= "" and uv0.userData_.sign == slot0 then
			return
		end

		if not OperationData:IsOperationOpen(OperationConst.CHANGE_SIGN) then
			ShowTips("OPERATION_DISABLED")

			uv0.signinput_.text = uv0.userData_.sign

			return
		end

		slot0, slot2 = textLimit(slot0, GameSetting.personal_signature_max.value[1])

		if not slot2 then
			ShowTips("PERSONAL_SIGNATURE_MAX")

			return
		end

		if not nameRule(slot1, true) then
			ShowTips("ERROR_USER_NAME_VER_WORD")

			return
		end

		WordVerifyBySDK(slot0, function (slot0)
			if not slot0 then
				ShowTips("SENSITIVE_WORD")
				uv0:RefreshSign(uv0.userData_.sign)
				SetActive(uv0.signinput_.gameObject, false)
				SetActive(uv0.sign_.gameObject, true)

				return
			end

			if uv0.userData_.sign == uv1 then
				SetActive(uv0.signinput_.gameObject, false)
				SetActive(uv0.sign_.gameObject, true)

				return
			end

			PlayerAction.ChangeSign(uv1)
		end, JUDGE_MESSAGE_TYPE.PLAYER_SIGN)
	end)
	slot0:AddBtnListener(nil, slot0.btn_copyTrs_, function ()
		UnityEngine.GUIUtility.systemCopyBuffer = uv0.userData_.userID

		ShowTips("COPY_SUCCESS")
	end)
	slot0:AddBtnListener(nil, slot0.btn_logoutTrs_, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("TIP_EXIT_GAME"),
			OkCallback = function ()
				OperationRecorder.Record("account_change", "account_change_confirm")
				BulletinData.OnLogout()
				GameToSDK.Logout()
			end,
			CancelCallback = function ()
				OperationRecorder.Record("account_change", "account_change_cancel")
			end
		})
	end)
	slot0:AddBtnListener(slot0.userCenterBtn_, nil, function ()
		NeedGameUserInfo()
		GameToSDK.GoUserCenter()
	end)
	slot0:AddBtnListener(slot0.illustratedhandbookBtn_, nil, function ()
		JumpTools.GoToSystem("/illustratedMain", nil, ViewConst.SYSTEM_ID.ILLUSTRATION)
	end)
	slot0:AddBtnListener(slot0.buttonAchievement_, nil, function ()
		JumpTools.GoToSystem("/achievementManager", nil, ViewConst.SYSTEM_ID.ACHIEVEMENT)
	end)

	slot4 = slot0.headBtn_

	slot0:AddBtnListener(slot4, nil, function ()
		JumpTools.OpenPageByJump("HeadIconChange")
	end)

	for slot4 = 1, 3 do
		slot5 = slot0.heroItemList_[slot4]

		slot5:RegisterClickListener(function ()
			JumpTools.OpenPageByJump("/HeroShowChange", {
				heroID = uv0.heroes_[uv1]
			})
		end)
	end

	slot0:AddBtnListener(slot0.viewBtn_, nil, function ()
		PlayerAction.ChangeHeroShow(1 - uv0.isHeroShow_)
	end)
	slot0:AddBtnListener(slot0.giftBtn_, nil, function ()
		JumpTools.OpenPageByJump("GiftPopUp")
	end)
	slot0:AddBtnListener(slot0.medalBtn_, nil, function ()
		JumpTools.OpenPageByJump("/MainSticker", {
			list = PlayerData:GetStickerShow()
		})
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener()
end

function slot0.OnTop(slot0)
	slot0:HideChangeNameBtn()
	slot0:ShowDefaultBar()
end

function slot0.OnEnter(slot0)
	slot0.userData_ = PlayerData:GetPlayerInfo()

	slot0:RefreshAllUserData()
	manager.redPoint:bindUIandKey(slot0.rectAchievement_, RedPointConst.ACHIEVEMENT)
	manager.redPoint:bindUIandKey(slot0.illustratedhandbookBtn_.transform, RedPointConst.ILLU_USER)
end

function slot0.SetCharLimit(slot0)
	slot0.inputfieldCharLimit_ = slot0.signinput_.characterLimit
	slot0.signinput_.characterLimit = 0
end

function slot0.RefreshAllUserData(slot0)
	slot0:RefreshInfoPage()
end

function slot0.RefreshInfoPage(slot0)
	slot0.uid_.text = string.format("%d", slot0.userData_.userID)

	slot0:RefreshIP(slot0.userData_.ip)
	slot0:RefreshName(slot0.userData_.nick)
	slot0:RefreshHead(slot0.userData_.portrait, slot0.userData_.icon_frame)
	slot0:RefreshSign(slot0.userData_.sign)
	slot0:RefreshLvInfo(slot0.userData_.userLevel, slot0.userData_.remain_exp)
	slot0:RefreshPosterGirl(slot0.userData_.poster_girl)
	slot0:RefreshIsHeroShow(slot0.userData_.show_hero_flag)
	slot0:RefreshHeroShow(PlayerData:GetHeroShowList())
end

function slot0.RefreshIP(slot0, slot1)
	SetActive(slot0.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	if slot0.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.ipGo_.transform)
	end

	slot0.ip_.text = slot1
end

function slot0.RefreshName(slot0, slot1)
	slot2, slot0.name_.text = wordVerify(slot1, {
		isReplace = true
	})
end

function slot0.RefreshHead(slot0, slot1, slot2)
	slot0.headIcon_.sprite = ItemTools.getItemSprite(slot1)

	slot0.headIcon_:SetNativeSize()

	slot0.headFrameIcon_.sprite = ItemTools.getItemSprite(slot2)

	slot0.headFrameIcon_:SetNativeSize()
end

function slot0.RefreshSign(slot0, slot1)
	slot2, slot0.sign_.text = wordVerify(slot1, {
		isReplace = true
	})
end

function slot0.RefreshLvInfo(slot0, slot1, slot2)
	slot0.lv_.text = slot1

	if LvTools.GetIsMaxLv(slot1, "user") then
		slot0.exp_.text = "-/-"
		slot0.progressTrs_.sizeDelta = Vector2(slot0.lvBg_.rect.width + 30, slot0.progressTrs_.rect.height)
	else
		slot3 = GameLevelSetting[slot1].user_level_exp
		slot0.exp_.text = string.format("%d/%d", slot2, slot3)
		slot0.progressTrs_.sizeDelta = Vector2(slot2 / slot3 * (slot0.lvBg_.rect.width + 30), slot0.progressTrs_.rect.height)
	end
end

function slot0.RefreshPosterGirl(slot0, slot1)
	slot0.PosterGirl_.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. HeroTools.HeroUsingSkinInfo(slot1).picture_id)
end

function slot0.RefreshIsHeroShow(slot0, slot1)
	slot0.isHeroShow_ = slot1 or 1

	slot0.isHeroShowController_:SetSelectedState(slot0.isHeroShow_)
end

function slot0.RefreshHeroShow(slot0, slot1)
	slot0.heroes_ = slot1

	for slot5 = 1, 3 do
		if slot1[slot5] then
			slot0.heroItemController_[slot5]:SetSelectedState("0")
			slot0.heroItemList_[slot5]:SetHeroId(slot1[slot5])
		else
			slot0.heroItemController_[slot5]:SetSelectedState("1")
		end
	end
end

function slot0.HideChangeNameBtn(slot0)
	if slot0.userData_.is_changed_nick == 2 and PlayerData:GetExtraChangeNickTime() <= 0 then
		SetActive(slot0.changeNameBtn_, false)

		slot0.changeNameBtn2_.enabled = false
	elseif slot1 == 1 or PlayerData:GetExtraChangeNickTime() > 0 then
		SetActive(slot0.changeNameBtn_, true)

		slot0.changeNameBtn2_.enabled = true
	end
end

function slot0.OnChangeNickname(slot0, slot1)
	slot0:HideChangeNameBtn()
	slot0:RefreshName(slot1.nick)
end

function slot0.OnChangeSign(slot0, slot1, slot2)
	SetActive(slot0.signinput_.gameObject, false)
	SetActive(slot0.sign_.gameObject, true)
	slot0:RefreshSign(slot2.sign)
	ShowTips("SUCCESS_CHANGE_SIGNATURE")
end

function slot0.OnChangeHeroShow(slot0, slot1)
	slot0:RefreshIsHeroShow(slot1)
end

function slot0.OnChangePortrait(slot0)
	slot0:RefreshHead(slot0.userData_.portrait, slot0.userData_.icon_frame)
end

function slot0.OnChangeFrame(slot0)
	slot0:RefreshHead(slot0.userData_.portrait, slot0.userData_.icon_frame)
end

function slot0.OnExit(slot0)
	slot0.medalList_ = {}

	manager.redPoint:unbindUIandKey(slot0.rectAchievement_)

	slot4 = slot0.illustratedhandbookBtn_.transform

	manager.redPoint:unbindUIandKey(slot4)
	manager.windowBar:HideBar()

	for slot4 = 1, 3 do
		slot0.heroItemList_[slot4]:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0.signinput_.onEndEdit:RemoveAllListeners()
	slot0:RemoveAllListeners()

	for slot4 = 1, 3 do
		slot0.heroItemList_[slot4]:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
