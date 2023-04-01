slot0 = class("PlayerInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Friends/AdminInfoPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.onLineController_ = ControllerUtil.GetController(slot0.goOnline_.transform, "online")
	slot0.friendController_ = ControllerUtil.GetController(slot0.rectBtn_, "friendState")
	slot0.moreController_ = ControllerUtil.GetController(slot0.goMore_.transform, "select")
	slot0.medalShowController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "medalShow")
	slot4 = "heroShow"
	slot0.heroShowController_ = ControllerUtil.GetController(slot0.gameObject_.transform, slot4)
	slot0.heroItemList_ = {}
	slot0.heroItemController_ = {}

	for slot4 = 1, 3 do
		slot0.heroItemList_[slot4] = PlayerDisplayHeroItem.New(slot0[string.format("goHero%s_", slot4)], slot4)
		slot0.heroItemController_[slot4] = ControllerUtil.GetController(slot0[string.format("goHero%s_", slot4)].transform, "conNamemodifier")
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonCopy_, nil, function ()
		UnityEngine.GUIUtility.systemCopyBuffer = uv0.userID_

		ShowTips("COPY_SUCCESS")
	end)
	slot0:AddBtnListener(slot0.buttonIgnore_, nil, function ()
		FriendsAction:TryToDealRequest(uv0.userID_, 2)
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonAccept_, nil, function ()
		FriendsAction:TryToDealRequest(uv0.userID_, 1)
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonAdd_, nil, function ()
		FriendsAction:TryToRequestToFriend(uv0.userID_)
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonTalk_, nil, function ()
		if not FriendsData:GetFreshFlag() then
			slot0 = FriendsAction

			slot0:TryToRefreshFriendsView(1, function ()
				ChatFriendData:AddCacheFriend(uv0.userID_)
				uv0:Back()
				JumpTools.GoToSystem("/chatFriend", {
					friendID = uv0.userID_
				})
			end)

			return
		end

		ChatFriendData:AddCacheFriend(uv0.userID_)
		uv0:Back()
		JumpTools.GoToSystem("/chatFriend", {
			friendID = uv0.userID_
		})
	end)
	slot0:AddBtnListener(slot0.buttonDeleteFriend_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("FRIEND_DELETE_QUEST"), uv0.data_.nick),
			OkCallback = function ()
				FriendsAction:TryToDelectFromMyFriendsList(uv0.userID_)
				uv0:Back()
			end
		})
	end)
	slot0:AddBtnListener(slot0.buttonMore_, nil, function ()
		uv0.moreController_:SetSelectedState("selected")
		SetActive(uv0.goPop_, true)
		uv0:AddClickTimer()
	end)
	slot0:AddBtnListener(slot0.buttonReport_, nil, function ()
		uv0:Back()
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.USER,
			reportData = {
				nick = uv0.data_.nick,
				userID = uv0.data_.user_id
			}
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
	slot0:AddBtnListener(slot0.buttonBlackList_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("FRIEND_MOVE_TO_BLACLIST_QUEST"), uv0.data_.nick),
			OkCallback = function ()
				FriendsAction:TryToAddToBlacklist(uv0.userID_)
				uv0:Back()
			end
		})
	end)
	slot0:AddBtnListener(slot0.stickerBtn_, nil, function ()
		slot0 = {}

		for slot4, slot5 in ipairs(uv0.data_.sticker_show) do
			slot0[slot4] = {
				sticker_id = slot5.sticker_id,
				location = slot5.location
			}
		end

		JumpTools.OpenPageByJump("/MainSticker", {
			isForeign = true,
			list = slot0
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.data_ = slot0.params_.data
	slot0.userID_ = slot0.data_.user_id

	slot0:HidePop()
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.imageHead_.sprite = ItemTools.getItemSprite(slot0.data_.icon)

	slot0.imageHead_:SetNativeSize()

	slot0.data_.icon_frame = slot0.data_.icon_frame ~= 0 and slot0.data_.icon_frame or 2001
	slot0.iconFrame_.sprite = ItemTools.getItemSprite(slot0.data_.icon_frame)
	slot0.textName_.text = slot0.data_.nick
	slot0.textID_.text = slot0.data_.user_id
	slot0.textLevel_.text = slot0.data_.level
	slot0.textSign_.text = slot0.data_.sign
	slot0.ip_.text = slot0.data_.ip

	SetActive(slot0.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	if slot0.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.ipGo_.transform)
	end

	slot0.onLineController_:SetSelectedState(slot0.data_.is_online == 1 and "on" or "off")
	slot0.medalShowController_:SetSelectedState(slot0.data_.sticker_flag == 1 and "on" or "off")
	slot0.heroShowController_:SetSelectedState(slot0.data_.hero_flag == 1 and "on" or "off")
	slot0:SetState()
	slot0:ShowHero()
	slot0:RefreshGuildInfo()
end

function slot0.SetState(slot0)
	if FriendsData:GetInfoByID(slot0.userID_) then
		if slot1.relationship == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
			slot0.friendController_:SetSelectedState("myFriend")
		elseif slot2 == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
			slot0.friendController_:SetSelectedState("newFriend")
		elseif slot2 == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
			slot0.friendController_:SetSelectedState("request")
		end
	else
		slot0.friendController_:SetSelectedState("newFriend")
	end
end

function slot0.ShowHero(slot0)
	for slot4 = 1, 3 do
		if slot0.data_.hero_list[slot4] then
			slot0.heroItemList_[slot4]:SetHeroData(slot0.userID_, slot0.data_.hero_list[slot4])
			slot0.heroItemController_[slot4]:SetSelectedState("1")
		else
			slot0.heroItemController_[slot4]:SetSelectedState("0")
		end
	end
end

function slot0.RefreshGuildInfo(slot0)
	if slot0.data_.guildID == 0 then
		slot0.guildName_.text = GetTips("NOT_MEMNER_OF_CLUB")

		SetActive(slot0.guildGo_, false)
	else
		slot0.guildName_.text = slot0.data_.guildName

		SetActive(slot0.guildGo_, true)
	end
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
	slot0.moreController_:SetSelectedState("nor")
	SetActive(slot0.goPop_, false)
end

function slot0.OnFriendsDelect(slot0, slot1)
	if slot1 == slot0.userID_ then
		slot0:Back()
	end
end

function slot0.OnExit(slot0)
	slot0:StopTimer()

	for slot4, slot5 in ipairs(slot0.heroItemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.heroItemList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
