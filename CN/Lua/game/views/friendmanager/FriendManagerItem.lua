slot0 = class("FriendManagerItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:CreateSelector()
	slot0:Init()
	slot0:Show(true)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.Dispose(slot0)
	if slot0.unsubscribeFun then
		slot0.unsubscribeFun()

		slot0.unsubscribeFun = nil
	end

	slot0:RemoveListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.icon_ = slot0:FindCom(typeof(Image), "bg/iconBg/icon")
	slot0.levelText_ = slot0:FindCom(typeof(Text), "bg/iconBg/levelText")
	slot0.nameText_ = slot0:FindCom(typeof(Text), "bg/nameText")
	slot0.dateText_ = slot0:FindCom(typeof(Text), "bg/dateText")
	slot0.leftBtnGo_ = slot0:FindGo("bg/leftBtn")
	slot0.leftBtn_ = slot0:FindCom(typeof(Button), "bg/leftBtn")
	slot0.leftImage_ = slot0:FindCom(typeof(Image), "bg/leftBtn")
	slot0.leftBtnImage_ = slot0:FindCom(typeof(Image), "bg/leftBtn/image")
	slot0.leftBtnText_ = slot0:FindCom(typeof(Text), "bg/leftBtn/Text")
	slot0.rightBtnGo_ = slot0:FindGo("bg/rightBtn")
	slot0.rightBtn_ = slot0:FindCom(typeof(Button), "bg/rightBtn")
	slot0.rightBtnImage_ = slot0:FindCom(typeof(Image), "bg/rightBtn/image")
	slot0.rightBtnText_ = slot0:FindCom(typeof(Text), "bg/rightBtn/Text")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.leftBtn_, nil, function ()
		if uv0.model_.friendInfo.fType == FriendConst.FRIEND_TYPE.RECOMMEND or uv0.model_.friendInfo.fType == FriendConst.FRIEND_TYPE.APPLY then
			uv0:RefreshRecommendEvent()
		elseif uv0.model_.friendInfo.fType == FriendConst.FRIEND_TYPE.APPLYED then
			OperationRecorder.Record(uv0.class.__cname, "reject")
			uv0:RejectFriendEvent()
		end
	end)
	slot0:AddBtnListener(slot0.rightBtn_, nil, function ()
		if uv0.model_.friendInfo.isBlackList == false then
			if uv0.model_.friendInfo.fType == FriendConst.FRIEND_TYPE.RECOMMEND or uv0.model_.friendInfo.fType == FriendConst.FRIEND_TYPE.APPLY then
				OperationRecorder.Record(uv0.class.__cname, "applyFriend")
				uv0:AgreeRequestFriend()
			elseif uv0.model_.friendInfo.fType == FriendConst.FRIEND_TYPE.APPLYED then
				OperationRecorder.Record(uv0.class.__cname, "agree")
				uv0:AgreeMakeFriend()
			end
		else
			uv0:RemoveBlackList()
		end
	end)
end

function slot0.RefreshRecommendEvent(slot0)
	slot2 = ActionCreators.TryToRecommendFriend(2)

	ActionCreators.FriendRecommendRefresh({
		slot0.model_.friendInfo.user_id
	})
	slot2:next(function (slot0)
		ShowTips(slot0.result)
	end, function (slot0)
		ShowTips(string.format("RECOMMEND_FRIEND_CD", slot0))
	end)
end

function slot0.AgreeRequestFriend(slot0)
	slot2 = ActionCreators.TryToMakeFriend(slot0.model_.friendInfo.user_id)

	slot2:next(function (slot0)
		if isSuccess(slot0.result) then
			ActionCreators.SendFriendApply({
				uv0
			})
			ShowTips("FRIEND_APPLY_SEND")
		elseif slot0.result == TipsCfg.get_id_list_by_define.ERROR_FRIEND_EXIST_REQUEST then
			ActionCreators.SendFriendApply({
				uv0
			})
			ShowTips(slot0.result)
		else
			ShowTips(slot0.result)
			ActionCreators.FriendDelete({
				{
					user_id = uv0
				}
			}, {})
		end
	end)
end

function slot0.RejectFriendEvent(slot0)
	slot1 = slot0.model_.friendInfo.user_id
	slot2 = ActionCreators.TryToAcceptFriend(1, slot0.model_.friendInfo.user_id)

	slot2:next(function (slot0)
		if isSuccess(slot0.result) then
			ShowTips("FRIEND_APPLY_REJECT")
			ActionCreators.FriendDelete({
				{
					user_id = uv0
				}
			}, {})
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.AgreeMakeFriend(slot0)
	slot1 = slot0.model_.friendInfo.nick
	slot2 = ActionCreators.TryToAcceptFriend(0, slot0.model_.friendInfo.user_id)

	slot2:next(function (slot0)
		if isSuccess(slot0.result) then
			ShowTips(string.format(GetTips("FRIEND_MAKE_SUCCESS"), uv0))
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.RemoveBlackList(slot0)
	slot1 = slot0.model_.friendInfo.nick
	slot2 = ActionCreators.TryToDeleteBlackList(slot0.model_.friendInfo.user_id)

	slot2:next(function (slot0)
		if isSuccess(slot0.result) then
			ShowTips(string.format(GetTips("BLACKLIST_REMOVE_NOTE"), uv0))
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.leftBtn_.onClick:RemoveAllListeners()
	slot0.rightBtn_.onClick:RemoveAllListeners()
end

function slot0.CreateSelector(slot0)
	slot0.selector_ = createStructuredSelector({
		friendInfo = function (slot0, slot1)
			return slot0.friendlist.friend[slot1]
		end
	})
end

function slot0.OnSubscribe(slot0)
	if slot0.model_.friendInfo ~= slot0.selector_.compute(gameStore.getState(), slot0.friendID_).friendInfo then
		slot0.model_.friendInfo = slot1.friendInfo

		slot0:RefreshUI()
	end
end

function slot0.RefreshUI(slot0)
	if slot0.model_.friendInfo == nil then
		SetActive(slot0.gameObject_, false)

		return
	end

	slot0.nameText_.text = slot1.nick
	slot0.levelText_.text = GetTips("LEVEL") .. string.format("%s", slot1.level)
	slot0.dateText_.text = slot0:CalcTime(slot1.online_state)

	SetActive(slot0.gameObject_, true)

	if slot1.isBlackList == false then
		if slot1.fType == FriendConst.FRIEND_TYPE.RECOMMEND or slot1.fType == FriendConst.FRIEND_TYPE.APPLY then
			SetActive(slot0.leftBtnGo_, false)

			slot0.rightBtnText_.text = "申请"
			slot0.rightBtnImage_.sprite = getSprite("Atlas/NewFriend2", "icon_tine_agree")
		elseif slot1.fType == FriendConst.FRIEND_TYPE.APPLY then
			SetActive(slot0.leftBtnGo_, true)

			slot0.leftBtnText_.text = "拒绝"
			slot0.leftBtnImage_.sprite = getSprite("Atlas/NewFriend2", "icon_tine_ignore")
			slot0.leftImage_.sprite = getSprite("Atlas/NewFriend2", "button_mail_gray_01")
			slot0.rightBtnText_.text = "同意"
			slot0.rightBtnImage_.sprite = getSprite("Atlas/NewFriend2", "icon_tine_agree")
		else
			SetActive(slot0.gameObject_, false)
		end
	else
		SetActive(slot0.leftBtnGo_, false)

		slot0.rightBtnText_.text = "恢复"
		slot0.rightBtnImage_.sprite = getSprite("Atlas/NewFriend2", "icon_tine_recovery")
	end
end

function slot0.SetData(slot0, slot1)
	slot0.friendID_ = slot1

	if slot0.unsubscribeFun then
		slot0.unsubscribeFun()

		slot0.unsubscribeFun = nil
	end

	slot0.model_ = slot0.selector_.compute(gameStore.getState(), slot1)
	slot0.unsubscribeFun = gameStore.subscribe(function (slot0)
		uv0:OnSubscribe()
	end)

	slot0:RefreshUI()
	slot0:Show(true)
end

function slot0.GetID(slot0)
	return slot0.friendID_
end

function slot0.GetItemHeight(slot0)
	return 120
end

function slot0.SetAsLastSibling(slot0)
	slot0.transform_:SetAsLastSibling()
end

function slot0.SetAsFirstSibling(slot0)
	slot0.transform_:SetAsFirstSibling()
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 == false and slot0.unsubscribeFun then
		slot0.unsubscribeFun()

		slot0.unsubscribeFun = nil
	end
end

function slot0.CalcTime(slot0, slot1)
	if slot1 == 0 then
		return GetTips("ONLINE")
	else
		return manager.time:GetBeforeTimeStr(slot1)
	end
end

return slot0
