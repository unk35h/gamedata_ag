slot0 = class("FriendRightContentView", ReduxView)
slot0.ITEM_SPACE = 10
slot0.CONTENT_HEIGHT = 686

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:SetViewProp("friendSwitchType", slot2)
	slot0:CreateSelector()
	slot0:InitUI()
end

function slot0.OnEnter(slot0)
	slot0.itemList_ = {}
	slot0.contentHeight_ = 0
	slot0.itemPool_ = {}
	slot0.model_ = slot0.selector_.compute(gameStore.getState(), slot0:GetViewProp("friendSwitchType"))

	slot0:AddListeners()

	slot0.unsubscribeFun = gameStore.subscribe(function (slot0)
		uv0:OnSubscribe()
	end)

	slot0:RefreshUI()
	slot0:Show()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.OnExit(slot0)
	slot0.unsubscribeFun()
	slot0:RemoveAllListeners()

	if slot0.refreshTimer_ then
		slot0.refreshTimer_:Stop()

		slot0.refreshTimer_ = nil
	end

	slot0:RemoveListeners()

	for slot4, slot5 in pairs(slot0.itemPool_) do
		slot5.itemView:Dispose()
	end

	slot0.itemPool_ = nil
end

function slot0.InitUI(slot0)
	slot0.titleText_ = slot0:FindCom(typeof(Text), "topPanel/textCnt")
	slot0.scrollView_ = slot0:FindCom(typeof(ScrollRectEx), "contentPanel/ScrollView")
	slot0.scrollRect_ = slot0:FindCom(typeof(RectTransform), "contentPanel/ScrollView")
	slot0.scrollContent_ = slot0:FindGo("contentPanel/ScrollView/Viewport/Content")
	slot0.content_ = slot0.scrollContent_:GetComponent("RectTransform")
	slot0.scrollBar_ = slot0:FindCom("Scrollbar", "contentPanel/ScrollView/ScrollbarVertical")
	slot0.friendItem_ = slot0:FindGo("contentPanel/ScrollView/Viewport/Content/friendItem")
	slot0.recommendBottomPanel_ = slot0:FindGo("recommendBottomPanel")
	slot0.refreshCommendBtn_ = slot0:FindCom(typeof(Button), "recommendBottomPanel/refreshBtn")
	slot0.refreshTimeText_ = slot0:FindCom(typeof(Text), "recommendBottomPanel/refreshBtn/text")
	slot0.agreeCommendBtn_ = slot0:FindCom(typeof(Button), "recommendBottomPanel/agreeBtn")
	slot0.newFriendBottomPanel_ = slot0:FindGo("newFriendBottomPanel")
	slot0.ignoreFriendBtn_ = slot0:FindCom(typeof(Button), "newFriendBottomPanel/ignoreBtn")
	slot0.agreeFriendBtn_ = slot0:FindCom(typeof(Button), "newFriendBottomPanel/agreeBtn")
end

function slot0.GetContentHeight(slot0)
	return slot0.scrollRect_.rect.height > 0 and slot1 or uv0.CONTENT_HEIGHT
end

function slot0.AddListeners(slot0)
	slot0:AddToggleListener(slot0.scrollView_, function (slot0)
		if slot0.y < 0 or slot0.y == 0 and uv0.content_.anchoredPosition.y > 0 then
			uv0:DeleteItem(true)
			uv0:InsertNextItem()
		elseif slot0.y > 1 or slot0.y == 1 and uv0.content_.anchoredPosition.y < 0 then
			uv0:DeleteItem(false)
			uv0:InsertFirstItem()
		end

		if #uv0.model_.friendIDList <= 0 then
			uv0.scrollBar_.size = 1
			uv0.scrollBar_.value = 1

			return
		end

		slot1 = 1

		if uv0.itemList_[1] then
			slot1 = table.keyof(uv0.model_.friendIDList, uv0.itemList_[1].itemView:GetID())
		end

		uv0.scrollBar_.size = uv0:GetContentHeight() / uv0.contentHeight_ * #uv0.itemList_ / #uv0.model_.friendIDList
		uv0.scrollBar_.value = (slot1 + uv0:CalacuteNormalRate() - 1) / (#uv0.model_.friendIDList - uv0:CalacuteViewBoundItemRate())
	end)
	slot0:AddBtnListener(slot0.refreshCommendBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "refreshCommend")

		if uv0.refreshTimer_ then
			ShowTips("FREQUENT_OPERATION_")

			return
		end

		slot0 = clone(uv0.model_.friendIDList)

		ActionCreators.FriendRecommendRefresh(slot0)

		slot1 = ActionCreators.TryToRecommendFriend(1, #slot0)

		slot1:next(function (slot0)
			ShowTips(slot0.result)

			if isSuccess(slot0.result) then
				uv0.refreshCount_ = 10
				uv0.refreshTimeText_.text = string.format("全部刷新(%s)", uv0.refreshCount_)
				uv0.refreshTimer_ = Timer.New(function ()
					uv0.refreshCount_ = uv0.refreshCount_ - 1
					uv0.refreshTimeText_.text = string.format("全部刷新(%s)", uv0.refreshCount_)

					if uv0.refreshCount_ <= 0 then
						uv0.refreshTimer_:Stop()

						uv0.refreshTimeText_.text = string.format("全部刷新")
						uv0.refreshTimer_ = nil
					end
				end, 1, -1)

				uv0.refreshTimer_:Start()
			end
		end)
	end)

	slot1 = slot0.agreeCommendBtn_.onClick

	slot1:AddListener(function ()
		OperationRecorder.Record(uv0.class.__cname, "agreeCommend")

		if #uv0.model_.friendIDList == 0 then
			return
		end

		slot1 = 0

		for slot5, slot6 in pairs(gameStore.getState().friendlist.friend) do
			if slot6.fType == FriendConst.FRIEND_TYPE.BLACK_LIST then
				slot1 = slot1 + 1
			end
		end

		if GameSetting.user_friend_num_max.value[1] <= slot1 then
			ShowTips("ERROR_FRIEND_NUM_LIMIT_ME")

			return
		end

		if #clone(uv0.model_.friendIDList) > 0 then
			slot3 = ActionCreators.TryToMakeAllFriend(slot2)

			slot3:next(function (slot0)
				if isSuccess(slot0.result) then
					ActionCreators.SendFriendApply(uv0)
					ShowTips("FRIEND_APPLY_SEND")
				else
					ShowTips(slot0.result)
				end
			end)
		end
	end)
	slot0:AddBtnListener(slot0.ignoreFriendBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "IgnoreAll")

		if #uv0.model_.friendIDList == 0 then
			return
		end

		slot0 = ActionCreators.TryToAcceptAllFriend(2)

		slot0:next(function (slot0)
			if isSuccess(slot0.result) then
				ShowTips("FRIEND_APPLY_REJECT")

				slot1 = {}

				for slot5, slot6 in ipairs(uv0.model_.friendIDList) do
					table.insert(slot1, {
						user_id = slot6
					})
				end

				ActionCreators.FriendApply(slot1, 1)
			else
				ShowTips(slot0.result)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.agreeFriendBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "agreeAllApply")

		if #uv0.model_.friendIDList == 0 then
			return
		end

		slot0 = ActionCreators.TryToAcceptAllFriend(1)

		slot0:next(function (slot0)
			if isSuccess(slot0.result) then
				ShowTips(string.format(GetTips("FRIEND_MAKE_SUCCESS"), "所有申请玩家"))
			else
				ShowTips(slot0.result)
			end
		end)
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.scrollView_.onValueChanged:RemoveAllListeners()
	slot0.refreshCommendBtn_.onClick:RemoveAllListeners()
	slot0.agreeCommendBtn_.onClick:RemoveAllListeners()
	slot0.ignoreFriendBtn_.onClick:RemoveAllListeners()
	slot0.agreeFriendBtn_.onClick:RemoveAllListeners()
end

function slot0.CreateSelector(slot0)
	slot0.selector_ = createStructuredSelector({
		friendSwitchType = function (slot0, slot1)
			return slot1
		end,
		friendIDList = function (slot0, slot1)
			if slot1 == 1 then
				return {}
			elseif slot1 == 2 then
				slot2 = {}

				for slot6, slot7 in pairs(slot0.friendlist.friend) do
					if slot7.fType == FriendConst.FRIEND_TYPE.APPLYED then
						table.insert(slot2, slot7.user_id)
					end
				end

				table.sort(slot2, function (slot0, slot1)
					return uv0.friendlist.friend[slot0].requestIndex < uv0.friendlist.friend[slot1].requestIndex
				end)

				return slot2
			elseif slot1 == 3 then
				return slot0.friendlist.recommendData
			elseif slot1 == 4 then
				slot2 = {}

				for slot6, slot7 in pairs(slot0.friendlist.friend) do
					if slot7.isBlackList == true then
						table.insert(slot2, slot7.user_id)
					end
				end

				return slot2
			else
				print("未知的类型", slot1)
			end
		end
	})
end

function slot0.OnSubscribe(slot0)
	if slot0.model_.friendIDList ~= slot0.selector_.compute(gameStore.getState(), slot0:GetViewProp("friendSwitchType")).friendIDList then
		slot0.model_.friendIDList = slot1.friendIDList

		if slot0.model_.friendSwitchType ~= slot1.friendSwitchType then
			slot0:ReplaceItems()
		else
			slot0:RefreshItems()
		end

		slot0:RefreshTitle()
	end

	if slot0.model_.friendSwitchType ~= slot1.friendSwitchType then
		slot0.model_.friendSwitchType = slot1.friendSwitchType

		slot0:Show()
	end
end

function slot0.SetFriendSwitchType(slot0, slot1)
	slot0:SetViewProp("friendSwitchType", slot1)
	slot0:OnSubscribe()
end

function slot0.RefreshUI(slot0)
	slot0.refreshCount_ = 0
	slot0.refreshTimeText_.text = string.format("全部刷新")
end

function slot0.Show(slot0)
	SetActive(slot0.gameObject_, slot0.model_.friendSwitchType ~= 1)
	SetActive(slot0.newFriendBottomPanel_, slot0.model_.friendSwitchType == 2)
	SetActive(slot0.recommendBottomPanel_, slot0.model_.friendSwitchType == 3)
	slot0:RefreshTitle()
end

function slot0.RefreshTitle(slot0)
	if slot0.model_.friendSwitchType == 2 then
		slot0.titleText_.text = string.format("<color=#3c474d>%s/30 未处理申请</color>", #slot0.model_.friendIDList)
	elseif slot0.model_.friendSwitchType == 3 then
		slot0.titleText_.text = "<color=#3c474d>推荐好友</color>"
	elseif slot0.model_.friendSwitchType == 4 then
		slot0.titleText_.text = string.format("<color=#3c474d>黑名单</color> <color=#2c9cde>%s/%s</color>", #slot0.model_.friendIDList, GameSetting.user_black_num_max.value[1])
	end
end

function slot0.CalacuteNormalRate(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.itemList_) do
		if slot0.content_.anchoredPosition.y <= slot1 + slot6.itemView:GetItemHeight() + uv0.ITEM_SPACE then
			return (slot0.content_.anchoredPosition.y - slot1) / slot7 + slot5 - 1
		end

		slot1 = slot1 + slot7
	end

	return #slot0.itemList_
end

function slot0.CalacuteViewBoundItemRate(slot0)
	slot1 = 0

	for slot5 = #slot0.itemList_, 1, -1 do
		if slot0:GetContentHeight() <= slot1 + slot0.itemList_[slot5].itemView:GetItemHeight() then
			return #slot0.itemList_ - slot5 + (slot6 - (slot1 + slot6 - slot0:GetContentHeight())) / slot6
		end

		slot1 = slot1 + slot6 + uv0.ITEM_SPACE
	end

	return 0
end

function slot0.ReplaceItems(slot0)
	for slot4 = #slot0.itemList_, 1, -1 do
		slot0:RemoveItem(slot0.itemList_[slot4])
		table.remove(slot0.itemList_, #slot0.itemList_)
	end

	slot0.contentHeight_ = 0

	for slot4, slot5 in ipairs(slot0.model_.friendIDList) do
		slot6 = slot0:AddItem(slot5)

		table.insert(slot0.itemList_, slot6)
		slot6.itemView:SetAsLastSibling()

		slot0.contentHeight_ = slot0.contentHeight_ + uv0.ITEM_SPACE + slot6.itemView:GetItemHeight()

		if slot0:GetContentHeight() <= slot0.contentHeight_ then
			break
		end
	end
end

function slot0.RefreshItems(slot0)
	for slot4 = #slot0.itemList_, 1, -1 do
		if not table.keyof(slot0.model_.friendIDList, slot0.itemList_[slot4].itemView:GetID()) then
			slot0:RemoveItem(slot5)

			slot0.contentHeight_ = slot0.contentHeight_ - uv0.ITEM_SPACE - slot5.itemView:GetItemHeight()

			table.remove(slot0.itemList_, slot4)
		end
	end
end

function slot0.InsertFirstItem(slot0)
	slot1 = 1

	if #slot0.itemList_ > 0 then
		slot1 = table.keyof(slot0.model_.friendIDList, slot0.itemList_[1].itemView:GetID()) - 1
	end

	if slot1 <= 0 or #slot0.model_.friendIDList <= 0 then
		return
	end

	slot2 = slot0:InsertItem(slot1)

	table.insert(slot0.itemList_, 1, slot2)
	slot2.itemView:SetAsFirstSibling()
	slot0.scrollView_:AddContentPosition(Vector2(0, uv0.ITEM_SPACE + slot2.itemView:GetItemHeight()))
end

function slot0.InsertNextItem(slot0)
	slot1 = 1

	if #slot0.itemList_ > 0 then
		slot1 = table.keyof(slot0.model_.friendIDList, slot0.itemList_[#slot0.itemList_].itemView:GetID()) + 1
	end

	if slot1 > #slot0.model_.friendIDList then
		return
	end

	slot2 = slot0:InsertItem(slot1)

	table.insert(slot0.itemList_, slot2)
	slot2.itemView:SetAsLastSibling()
end

function slot0.InsertItem(slot0, slot1)
	slot3 = slot0:AddItem(slot0.model_.friendIDList[slot1])
	slot0.contentHeight_ = slot0.contentHeight_ + uv0.ITEM_SPACE + slot3.itemView:GetItemHeight()

	return slot3
end

function slot0.AddItem(slot0, slot1)
	slot2 = slot0:GetFreeItem()

	slot2.itemView:SetData(slot1)

	return slot2
end

function slot0.RemoveItem(slot0, slot1)
	slot1.itemView:Show(false)

	slot1.isFree = true
end

function slot0.GetFreeItem(slot0)
	for slot4, slot5 in pairs(slot0.itemPool_) do
		if slot5.isFree == true then
			slot5.isFree = false

			return slot5
		end
	end

	slot2 = {
		isFree = false,
		itemView = FriendManagerItem.New(slot0.friendItem_, slot0.scrollContent_)
	}

	table.insert(slot0.itemPool_, slot2)

	return slot2
end

function slot0.DeleteItem(slot0, slot1)
	while slot0:GetContentHeight() < slot0.contentHeight_ do
		slot2 = 1

		if slot1 then
			slot0:DeleteFirstItem()
		else
			slot0:DeleteLastItem()

			slot2 = #slot0.itemList_
		end

		if slot2 <= 0 then
			break
		end

		if slot0.itemList_[slot2] == nil then
			break
		end

		if slot0.contentHeight_ - uv0.ITEM_SPACE - slot3.itemView:GetItemHeight() < slot0:GetContentHeight() then
			break
		end
	end
end

function slot0.DeleteFirstItem(slot0)
	if slot0:GetContentHeight() < slot0.contentHeight_ - uv0.ITEM_SPACE - slot0.itemList_[1].itemView:GetItemHeight() then
		slot0.scrollView_:AddContentPosition(Vector2(0, -uv0.ITEM_SPACE - slot1.itemView:GetItemHeight()))
		slot0:RemoveItem(slot1)

		slot0.contentHeight_ = slot0.contentHeight_ - uv0.ITEM_SPACE - slot1.itemView:GetItemHeight()

		table.remove(slot0.itemList_, 1)
	end
end

function slot0.DeleteLastItem(slot0)
	if slot0:GetContentHeight() < slot0.contentHeight_ - uv0.ITEM_SPACE - slot0.itemList_[#slot0.itemList_].itemView:GetItemHeight() then
		slot0:RemoveItem(slot1)

		slot0.contentHeight_ = slot0.contentHeight_ - uv0.ITEM_SPACE - slot1.itemView:GetItemHeight()

		table.remove(slot0.itemList_, #slot0.itemList_)
	end
end

return slot0
