slot0 = class("NewUserAndPlayerInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/UserInfoUI_new"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot1 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV or not SDKTools.GetIsOverSea() and _G.CHANNEL_MASTER_ID ~= 1

	SetActive(slot0.logoutBtn_.gameObject, slot1)
	SetActive(slot0.userCenterBtn_.gameObject, not slot1)

	slot0.lvGo_ = {}
	slot0.content_ = {}
	slot0.heroBtn_ = {}
	slot0.heroIcon_ = {}
	slot0.heroLvTxt_ = {}
	slot0.heroStarCon_ = {}
	slot0.heroCampCon_ = {}
	slot0.heroStateCon_ = {}

	for slot5 = 1, 3 do
		slot0.lvGo_[slot5] = slot0["lvGo_" .. slot5]
		slot0.content_[slot5] = slot0["content_" .. slot5]
		slot0.heroBtn_[slot5] = slot0["heroBtn_" .. slot5]
		slot0.heroIcon_[slot5] = slot0["heroIcon_" .. slot5]
		slot0.heroLvTxt_[slot5] = slot0["heroLvTxt_" .. slot5]
		slot0.heroCampCon_[slot5] = ControllerUtil.GetController(slot0["heroGo_" .. slot5].transform, "camp")
		slot0.heroStarCon_[slot5] = ControllerUtil.GetController(slot0["heroGo_" .. slot5].transform, "grade")
		slot0.heroStateCon_[slot5] = ControllerUtil.GetController(slot0["heroGo_" .. slot5].transform, "state")
	end

	slot0.guildCon_ = ControllerUtil.GetController(slot0.transform_, "guild")
	slot0.onlineCon_ = ControllerUtil.GetController(slot0.transform_, "online")
	slot0.newFriendCon_ = ControllerUtil.GetController(slot0.transform_, "newFriend")
	slot0.friendStateCon_ = ControllerUtil.GetController(slot0.transform_, "friendState")
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.nameBtn_, nil, function ()
		if table.keyof(uv0.operationInfo_, OperationConst.CHANGE_NICK) ~= nil then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		JumpTools.OpenPageByJump("changeName")
	end)
	slot0:AddBtnListener(slot0.changeNameBtn_, nil, function ()
		if table.keyof(uv0.operationInfo_, OperationConst.CHANGE_NICK) ~= nil then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		JumpTools.OpenPageByJump("changeName")
	end)
	slot0:AddBtnListener(slot0.signBtn_, nil, function ()
		uv0.signInput_.text = uv0.sign_

		SetActive(uv0.signInput_.gameObject, true)
		uv0.signInput_:ActivateInputField()
		SetActive(uv0.signTxt_.gameObject, false)
	end)

	slot1 = slot0.signInput_.onEndEdit

	slot1:AddListener(function ()
		if table.keyof(info, OperationConst.CHANGE_SIGN) ~= nil then
			ShowTips("ERROR_FUNCTION_STOP")
			SetActive(uv0.signInput_.gameObject, false)
			SetActive(uv0.signTxt_.gameObject, true)

			return
		end

		if uv0.signInput_.text ~= nil and slot0 ~= "" and uv0.sign_ == slot0 then
			SetActive(uv0.signInput_.gameObject, false)
			SetActive(uv0.signTxt_.gameObject, true)

			return
		end

		slot0, slot2 = textLimit(slot0, GameSetting.personal_signature_max.value[1])

		if not slot2 then
			ShowTips("PERSONAL_SIGNATURE_MAX")
			SetActive(uv0.signInput_.gameObject, false)
			SetActive(uv0.signTxt_.gameObject, true)

			return
		end

		WordVerifyBySDK(slot0, function (slot0)
			slot1 = PlayerData:GetPlayerInfo()

			if not slot0 then
				ShowTips("SENSITIVE_WORD")
				uv0:RefreshSign(slot1.sign)
				SetActive(uv0.signInput_.gameObject, false)
				SetActive(uv0.signTxt_.gameObject, true)

				return
			end

			if slot1.sign == uv1 then
				SetActive(uv0.signInput_.gameObject, false)
				SetActive(uv0.signTxt_.gameObject, true)

				return
			end

			PlayerAction.ChangeSign(uv1)
		end, JUDGE_MESSAGE_TYPE.PLAYER_SIGN)
	end)
	slot0:AddBtnListener(slot0.logoutBtn_, nil, function ()
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
	slot0:AddBtnListener(slot0.headBtn_, nil, function ()
		JumpTools.OpenPageByJump("HeadIconChange")
	end)
	slot0:AddBtnListener(slot0.brithdayBtn_, nil, function ()
		JumpTools.OpenPageByJump("BirthdayView")
	end)
	slot0:AddBtnListener(slot0.copyBtn_, nil, function ()
		UnityEngine.GUIUtility.systemCopyBuffer = uv0.userID_

		ShowTips("COPY_SUCCESS")
	end)

	slot4 = slot0.medalBtn_

	slot0:AddBtnListener(slot4, nil, function ()
		JumpTools.OpenPageByJump("/MainSticker", {
			index = 1,
			stickerInfo = uv0.stickerList_,
			stickerBg = uv0.stickerBg_,
			type = uv0.isForeign_ and 3 or 1
		})
	end)

	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0.heroBtn_[slot4], nil, function ()
			if not uv0.isForeign_ then
				JumpTools.OpenPageByJump("/HeroShowChange", {
					heroID = uv0.heroList_[uv1] and uv0.heroList_[uv1].hero_id or nil
				})
			elseif uv0.heroList_[uv1] and uv0.heroList_[uv1].hero_id then
				slot0 = ForeignInfoAction

				slot0:TryToCheckForeignHeroInfo(uv0.userID_, uv0.heroList_[uv1].hero_id, 1, function ()
					JumpTools.OpenPageByJump("/newHero", {
						isEnter = true,
						isForeign = true,
						notShowBar = true,
						hid = uv0.heroList_[uv1].hero_id
					}, ViewConst.SYSTEM_ID.PLAYER_INFO)
				end)
			end
		end)
	end

	slot0:AddBtnListener(slot0.buttonAdd_, nil, function ()
		FriendsAction:TryToRequestToFriend(uv0.userID_)
		uv0.newFriendCon_:SetSelectedState(1)

		uv0.buttonAdd_.interactable = false
	end)
	slot0:AddBtnListener(slot0.buttonTalk_, nil, function ()
		if not FriendsData:GetFreshFlag() then
			slot0 = FriendsAction

			slot0:TryToRefreshFriendsView(1, function ()
				ChatFriendData:AddCacheFriend(uv0.userID_)
				JumpTools.GoToSystem("/chatFriend", {
					friendID = uv0.userID_
				})
			end)

			return
		end

		ChatFriendData:AddCacheFriend(uv0.userID_)
		JumpTools.GoToSystem("/chatFriend", {
			friendID = uv0.userID_
		})
	end)
	slot0:AddBtnListener(slot0.buttonDeleteFriend_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("FRIEND_DELETE_QUEST"), uv0.nick_),
			OkCallback = function ()
				FriendsAction:TryToDelectFromMyFriendsList(uv0.userID_)
				uv0:Back()
			end
		})
	end)
	slot0:AddBtnListener(slot0.buttonMore_, nil, function ()
		if uv0.isPop_ then
			uv0.isPop_ = false

			uv0:HidePop()

			return
		end

		SetActive(uv0.goPop_, true)
		uv0:AddClickTimer()

		uv0.isPop_ = true
	end)
	slot0:AddBtnListener(slot0.buttonReport_, nil, function ()
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.USER,
			reportData = {
				nick = uv0.nick_,
				userID = uv0.userID_
			}
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
	slot0:AddBtnListener(slot0.buttonBlackList_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("FRIEND_MOVE_TO_BLACLIST_QUEST"), uv0.nick_),
			OkCallback = function ()
				FriendsAction:TryToAddToBlacklist(uv0.userID_)
				uv0:Back()
			end
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.isForeign_ = slot0.params_.isForeign

	if not slot0.isForeign_ then
		slot0:BindRedPoint()
	end

	slot0:RefreshUI()

	slot0.operationInfo_ = OperationData:GetOperationOpenList()
end

function slot0.RefreshUI(slot0)
	if not slot0.isForeign_ then
		slot0.stateCon_:SetSelectedState("user")
		slot0:RefreshUserData()
		slot0:HideChangeNameBtn()
		slot0:RefreshExpInfo(slot0.lv_, slot0.exp_)
	else
		slot0.stateCon_:SetSelectedState("player")
		slot0:RefreshPlayerData()
		slot0:RefreshFriendState()
		slot0:RefreshOnlineState()
		SetActive(slot0.changeNameBtn_.gameObject, false)

		slot0.nameBtn_.interactable = false

		if manager.windowBar:GetWhereTag() then
			SetActive(slot0.friendPanel_, false)
		end
	end

	slot0:RefreshBtn()
	slot0:RefreshIP(slot0.ip_)
	slot0:RefreshID(slot0.userID_)
	slot0:RefreshName(slot0.nick_)
	SetActive(slot0.signInput_.gameObject, false)
	SetActive(slot0.signTxt_.gameObject, true)
	slot0:RefreshSign(slot0.sign_)
	slot0:RefreshHead(slot0.headIconID_)
	slot0:RefreshFrame(slot0.iconFrameID_)
	slot0:RefreshLvInfo(slot0.lv_, slot0.exp_)
	slot0:RefreshPosterGirl(slot0.postGirl_)
	slot0:RefreshHeroShow(slot0.heroList_)
	slot0:RefreshGuild(slot0.guildID_, slot0.guildName_)
	slot0:RefreshBirthday()
	slot0:RefreshNum()
end

function slot0.RefreshUserData(slot0)
	slot1 = PlayerData:GetPlayerInfo()
	slot0.isSelf_ = true
	slot0.ip_ = slot1.ip
	slot0.nick_ = slot1.nick
	slot0.sign_ = slot1.sign
	slot0.lv_ = slot1.userLevel
	slot0.userID_ = slot1.userID
	slot0.exp_ = slot1.remain_exp
	slot0.headIconID_ = slot1.portrait
	slot0.iconFrameID_ = slot1.icon_frame
	slot0.birthdayMonth_ = slot1.birthday_month
	slot0.birthdayDay_ = slot1.birthday_day
	slot0.postGirl_ = HeroTools.HeroUsingSkinInfo(slot1.poster_girl).picture_id

	if GuildData:GetGuildInfo() and slot3.id and slot3.name then
		slot0.guildID_ = slot3.id
		slot0.guildName_ = slot3.name
	else
		slot0.guildID_ = 0
		slot0.guildName_ = ""
	end

	slot0.heroList_ = {}

	for slot8, slot9 in ipairs(PlayerData:GetHeroShowList()) do
		slot10 = HeroData:GetHeroData(slot9)
		slot0.heroList_[slot8] = {
			hero_id = slot9,
			star = slot10.star,
			using_skin = slot10.using_skin
		}
	end

	slot0.stickerList_ = slot1.sticker_show_info
	slot0.stickerBg_ = slot1.sticker_background
	slot0.heroNum_ = HeroData:GetHeroNum()
	slot0.weaponServantNum_ = table.length(IllustratedData:GetServantInfo())
	slot0.stickerNum_ = #slot1.all_sticker_list
	slot0.achieveNum_ = AchievementData:GetFinishAchievementCnt()
end

function slot0.Calculate(slot0, slot1)
	slot2 = string.format("%.2f%%", slot1)

	return string.sub(slot2, 1, #slot2 - 3), string.sub(slot2, #slot2 - 2, #slot2)
end

function slot0.RefreshPlayerData(slot0)
	slot1 = slot0.params_.data
	slot0.isSelf_ = false
	slot0.ip_ = slot1.ip
	slot0.nick_ = slot1.nick
	slot0.sign_ = slot1.sign
	slot0.lv_ = slot1.level
	slot0.userID_ = slot1.user_id
	slot0.headIconID_ = slot1.icon
	slot0.iconFrameID_ = slot1.icon_frame
	slot0.postGirl_ = slot1.postGril
	slot0.guildID_ = slot1.guildID
	slot0.guildName_ = slot1.guildName
	slot0.isOnline_ = slot1.is_online
	slot0.heroList_ = slot1.hero_list
	slot0.stickerList_ = slot1.sticker_show_info
	slot0.stickerBg_ = slot1.sticker_background
	slot0.birthdayMonth_ = slot1.birthdayMonth
	slot0.birthdayDay_ = slot1.birthdayDay
	slot0.heroNum_ = slot1.heroNum
	slot0.weaponServantNum_ = slot1.servantNum
	slot0.stickerNum_ = slot1.stickerNum
	slot0.achieveNum_ = slot1.achieveNum
end

function slot0.RefreshBtn(slot0)
	slot0.signBtn_.interactable = not slot0.isForeign_
	slot0.headBtn_.interactable = not slot0.isForeign_
end

function slot0.RefreshBirthday(slot0)
	SetActive(slot0.birthdayPanelGo_, slot0.isSelf_)

	if slot0.birthdayDay_ == 0 then
		SetActive(slot0.brithdayBtn_.gameObject, slot0.isSelf_)

		slot0.brithdayTxt_.text = GetTips("UNSET_BIRTHDAY")
	else
		SetActive(slot0.brithdayBtn_.gameObject, false)

		slot0.brithdayTxt_.text = string.format(GetTips("OTHER_BIRTHDAY"), slot0.birthdayMonth_, slot0.birthdayDay_)
	end
end

function slot0.RefreshIP(slot0, slot1)
	SetActive(slot0.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	slot0.ipTxt_.text = slot1

	if slot0.ipGo_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.ipGo_.transform)
	end
end

function slot0.RefreshID(slot0, slot1)
	slot0.uid_.text = slot1
end

function slot0.RefreshName(slot0, slot1)
	slot2, slot0.name_.text = wordVerify(slot1, {
		isReplace = true
	})
end

function slot0.RefreshSign(slot0, slot1)
	slot2, slot0.signTxt_.text = wordVerify(slot1, {
		isReplace = true
	})
end

function slot0.RefreshHead(slot0, slot1)
	slot0.headIcon_.sprite = ItemTools.getItemSprite(slot1)

	slot0.headIcon_:SetNativeSize()
end

function slot0.RefreshFrame(slot0, slot1)
	slot0.headFrameIcon_.sprite = ItemTools.getItemSprite(slot1)

	slot0.headFrameIcon_:SetNativeSize()
end

function slot0.RefreshLvInfo(slot0, slot1)
	slot0.lvTxt_.text = slot1
end

function slot0.RefreshExpInfo(slot0, slot1, slot2)
	if LvTools.GetIsMaxLv(slot1, "user") then
		slot0.expTxt_.text = "-/-"
		slot0.progressTrs_.fillAmount = 1
	else
		slot3 = GameLevelSetting[slot1].user_level_exp
		slot0.expTxt_.text = string.format("%d/%d", slot2, slot3)
		slot0.progressTrs_.fillAmount = slot2 / slot3
	end
end

function slot0.RefreshPosterGirl(slot0, slot1)
	slot0.posterGirl_.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. slot1)
end

function slot0.RefreshHeroShow(slot0, slot1)
	for slot5 = 1, 3 do
		if slot1[slot5] then
			slot0.heroIcon_[slot5].sprite = getSpriteViaConfig("HeroLittleIcon", slot1[slot5].using_skin == 0 and slot1[slot5].hero_id or slot1[slot5].using_skin)

			if not slot0.isForeign_ then
				slot0.heroLvTxt_[slot5].text = HeroData:GetHeroData(slot1[slot5].hero_id).level

				SetActive(slot0.lvGo_[slot5], true)
				SetActive(slot0.content_[slot5], true)
			else
				SetActive(slot0.lvGo_[slot5], false)
				SetActive(slot0.content_[slot5], false)
				print(slot0.lvGo_[slot5].activeInHierarchy)
			end

			slot0.heroStarCon_[slot5]:SetSelectedState(HeroStarCfg[slot1[slot5].star] ~= nil and slot6.star or 1)
			slot0.heroCampCon_[slot5]:SetSelectedState(HeroCfg[slot1[slot5].hero_id].race)
			slot0.heroStateCon_[slot5]:SetSelectedState("0")
		elseif not slot0.isForeign_ then
			slot0.heroStateCon_[slot5]:SetSelectedState("1")
		else
			slot0.heroStateCon_[slot5]:SetSelectedState("2")
		end
	end
end

function slot0.RefreshFriendState(slot0)
	if FriendsData:GetInfoByID(slot0.userID_) then
		if slot1.relationship == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
			slot0.friendStateCon_:SetSelectedState("myFriend")
		elseif slot2 == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
			slot0.friendStateCon_:SetSelectedState("newFriend")
			slot0.newFriendCon_:SetSelectedState(slot1.isDeal and 1 or 0)

			slot0.buttonAdd_.interactable = not slot1.isDeal
		elseif slot2 == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
			slot0.friendStateCon_:SetSelectedState("request")
			slot0.newFriendCon_:SetSelectedState(1)

			slot0.buttonAdd_.interactable = false
		end
	else
		slot0.friendStateCon_:SetSelectedState("newFriend")
		slot0.newFriendCon_:SetSelectedState(FriendsData:IsInRequest(slot0.userID_) and 1 or 0)

		slot0.buttonAdd_.interactable = true
	end
end

function slot0.RefreshOnlineState(slot0)
	slot0.onlineCon_:SetSelectedState(slot0.isOnline_ == 1 and "on" or "off")
end

function slot0.RefreshGuild(slot0, slot1, slot2)
	if slot1 == 0 then
		slot0.guildCon_:SetSelectedState("false")
	else
		slot0.guildTxt_.text = slot2

		slot0.guildCon_:SetSelectedState("true")
	end
end

function slot0.RefreshNum(slot0)
	slot0.heroCnt_.text = slot0.heroNum_
	slot0.weaponServantCnt_.text = slot0.weaponServantNum_
	slot0.stickerCnt_.text = slot0.stickerNum_
	slot0.achieveCnt_.text = slot0.achieveNum_
end

function slot0.HideChangeNameBtn(slot0)
	SetActive(slot0.changeNameBtn_.gameObject, true)
end

function slot0.AddClickTimer(slot0)
	slot0:StopTimer()

	slot0.buttonUp_ = 0
	slot1 = FuncTimerManager.inst
	slot0.clickTimer_ = slot1:CreateFuncFrameTimer(function ()
		if Input.GetMouseButtonUp(0) then
			uv0.buttonUp_ = uv0.buttonUp_ + 1

			if uv0.buttonUp_ >= 2 then
				uv0:HidePop()
				FuncTimerManager.inst:RemoveFuncTimer(uv0.clickTimer_)

				uv0.clickTimer_ = nil
			end
		end
	end, -1, true)
end

function slot0.StopTimer(slot0)
	if slot0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.clickTimer_)

		slot0.clickTimer_ = nil
	end
end

function slot0.HidePop(slot0)
	SetActive(slot0.goPop_, false)
end

function slot0.OnFriendsDelect(slot0, slot1)
	if slot1 == slot0.userID_ then
		slot0:Back()
	end
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.buttonAchievement_.transform, RedPointConst.ACHIEVEMENT)
	manager.redPoint:bindUIandKey(slot0.illustratedhandbookBtn_.transform, RedPointConst.ILLU_USER)
	manager.redPoint:bindUIandKey(slot0.brithdayBtn_.transform, RedPointConst.BRITHDAY)
	manager.redPoint:bindUIandKey(slot0.medalBtn_.transform, RedPointConst.STICKER_BG)
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.buttonAchievement_.transform, RedPointConst.ACHIEVEMENT)
	manager.redPoint:unbindUIandKey(slot0.illustratedhandbookBtn_.transform, RedPointConst.ILLU_USER)
	manager.redPoint:unbindUIandKey(slot0.brithdayBtn_.transform, RedPointConst.BRITHDAY)
	manager.redPoint:unbindUIandKey(slot0.medalBtn_.transform, RedPointConst.STICKER_BG)
end

function slot0.OnTop(slot0)
	if manager.windowBar:GetWhereTag() == nil then
		slot0:ShowDefaultBar()
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function slot0.OnChangeNickname(slot0, slot1)
	slot0:HideChangeNameBtn()
	slot0:RefreshName(slot1.nick)
end

function slot0.OnChangeSign(slot0, slot1, slot2)
	SetActive(slot0.signInput_.gameObject, false)
	SetActive(slot0.signTxt_.gameObject, true)

	slot0.sign_ = slot2.sign

	slot0:RefreshSign(slot2.sign)
	ShowTips("SUCCESS_CHANGE_SIGNATURE")
end

function slot0.OnChangePortrait(slot0)
	slot0:RefreshHead(PlayerData:GetPlayerInfo().portrait)
end

function slot0.OnChangeFrame(slot0)
	slot0:RefreshFrame(PlayerData:GetPlayerInfo().icon_frame)
end

function slot0.OnChangeBirthday(slot0)
	slot0.birthdayMonth_, slot0.birthdayDay_ = PlayerData:GetPlayerBrithday()

	slot0:RefreshBirthday()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	slot0.stickerList_ = {}

	slot0:UnbindRedPoint()
	slot0:StopTimer()
	slot0:HidePop()
end

function slot0.Dispose(slot0)
	slot0.signInput_.onEndEdit:RemoveAllListeners()
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
