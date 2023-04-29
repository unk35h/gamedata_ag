slot0 = class("MailBoxView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Mailbox/Mailbox"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.bulletinItem_ = {}
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.starController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "star")
	slot0.starToggleController_ = ControllerUtil.GetController(slot0.starBtn_.transform, "toggle")
	slot0.emptyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "empty")
	slot0.mailStatusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "mailStatus")
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.mailListGo_, MailBoxListItem)
	slot0.rewardScrollHelper_ = LuaList.New(handler(slot0, slot0.indexRewardItem), slot0.rewardListGo_, MailBoxRewardItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.delBtn_, nil, function ()
		if MailData.GetTotal() <= MailData.GetUnread() then
			ShowTips("NO_MAIL_CAN_BE_DELETED")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MAIL_DELETE_CONFIRM"),
			OkCallback = function ()
				MailAction.TryToDeteleMail(0)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.letterBtn_, nil, function ()
		JumpTools.GoToSystem("/letterBox")
	end)
	slot0:AddBtnListener(slot0.letterBtn1_, nil, function ()
		JumpTools.GoToSystem("/letterBox")
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if MailData.GetTotal() == 0 then
			ShowTips("ERROR_NO_MAIL_CAN_RECEIVE")

			return
		end

		MailAction.ReceiveAllMails()
	end)
	slot0:AddBtnListener(slot0.removeBtn_, nil, function ()
		if uv0.curContentId_ ~= nil and uv0.curContentId_ ~= 0 then
			if MailData.GetMail(uv0.curContentId_).star_state == 1 then
				ShowMessageBox({
					isTop = true,
					title = GetTips("PROMPT"),
					content = string.format(GetTips("MAIL_STAR_DELETE_TIP")),
					OkCallback = function ()
						uv0:DeleteCurrentMail()
					end,
					CancelCallback = function ()
					end
				})
			else
				uv0:DeleteCurrentMail()
			end
		end
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		MailAction.TryToGetMailAttachment(uv0.curContentId_)
	end)
	slot0:AddBtnListener(slot0.starBtn_, nil, function ()
		if MailData.GetMail(uv0.curContentId_).star_state == 1 then
			MailAction.SetMailStar(uv0.curContentId_, 0)
		else
			MailAction.SetMailStar(uv0.curContentId_, 1)
		end
	end)
end

function slot0.DeleteCurrentMail(slot0)
	slot0.lastDeletedIndex_ = table.indexof(MailData.GetMailSort(), slot0.curContentId_)
	slot0.firstDeletedIndex_ = slot0.lastDeletedIndex_

	MailAction.DeleteOneMail(slot0.curContentId_)
end

function slot0.AddEventListener(slot0)
	slot0:RegistEventListener(MAIL_BRIEF_UPDATE, handler(slot0, slot0.OnBriefUpdate))
	slot0:RegistEventListener(MAIL_LIST_UPDATE, handler(slot0, slot0.OnMailListUpdate))
	slot0:RegistEventListener(MAIL_INFO_UPDATE, handler(slot0, slot0.OnMailInfoUpdate))
	slot0:RegistEventListener(MAIL_STAR_UPDATE, handler(slot0, slot0.OnMailStarUpdate))
end

function slot0.OnMailInfoUpdate(slot0, slot1)
	if slot0.curContentId_ ~= nil and slot1.id == slot0.curContentId_ then
		slot0:UpdateMailView(slot1.id)
	end
end

function slot0.OnMailStarUpdate(slot0, slot1)
	if slot1.id == slot0.curContentId_ then
		slot0:UpdateStar(MailData.GetMail(slot0.curContentId_))

		if slot1.star_state == 1 then
			slot0:UpdateList(false)
		end
	end
end

function slot0.OnBriefUpdate(slot0)
	slot0:UpdateView()
end

function slot0.OnMailListUpdate(slot0)
	if not MailData.IsMailDataComplete() then
		MailData.GetMailListFromServer(handler(slot0, function ()
			uv0:UpdateList()
			uv0:UpdateView()
		end))
	else
		slot0:UpdateList()
		slot0:UpdateView()
	end
end

function slot0.OnMailDelete(slot0, slot1)
	slot0.lastDeletedIndex_ = nil
	slot0.firstDeletedIndex_ = nil
end

function slot0.indexRewardItem(slot0, slot1, slot2)
	slot3 = MailData.GetMail(slot0.curContentId_)

	slot2:SetRewardData(slot3.rewardList[slot1], slot3.attach_flag == 2)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2.handler_ = handler(slot0, slot0.OnListClick)

	slot2:SetMailData(MailData.GetMail(MailData.GetMailSort()[slot1]))

	if slot0.curContentId_ and slot0.curContentId_ == slot4.id then
		slot2:SetSelected(true)
	else
		slot2:SetSelected(false)
	end
end

function slot0.SelectItem(slot0, slot1)
	if slot1 == 0 then
		return
	end

	slot0.curContentId_ = slot1

	MailAction.ReadMail(slot1)
	slot0.scrollHelper_:Refresh()
	slot0:UpdateMailView(slot1)
end

function slot0.OnListClick(slot0, slot1)
	slot0:SelectItem(slot1:GetData().id)
end

function slot0.UpdateMailView(slot0, slot1)
	slot2 = MailData.GetMail(slot1)
	slot0.titleText_.text = MailData.GetMailTitle(slot1)
	slot0.dateText_.text = manager.time:STimeDescS(slot2.date, "!%Y-%m-%d")

	SetActive(slot0.itemParent_.gameObject, false)
	MailData.TryToGetMailDetail(slot2.id, handler(slot0, function ()
		uv0:UpdateMailContentView(uv1)
		TimeTools.StartAfterSeconds(0.1, function ()
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.itemParent_.transform)
			SetActive(uv0.itemParent_.gameObject, true)
		end, {})
	end))
	slot0.rewardScrollHelper_:StartScroll(#slot2.rewardList)

	if slot2.attach_flag == 0 then
		slot0.mailStatusController_:SetSelectedState("noReward")
	elseif slot2.attach_flag == 2 then
		slot0.mailStatusController_:SetSelectedState("haveGet")
	else
		slot0.mailStatusController_:SetSelectedState("canGet")
	end
end

function slot0.UpdateStar(slot0, slot1)
	if MailData.GetMail(slot1.id).star_state == 1 then
		slot0.starToggleController_:SetSelectedState("on")
		slot0.starController_:SetSelectedState("true")
	else
		slot0.starToggleController_:SetSelectedState("off")
		slot0.starController_:SetSelectedState("false")
	end
end

function slot0.UpdateMailContentView(slot0, slot1)
	slot0.curContentId_ = slot1.id
	slot0.senderText_.text = MailData.GetMailSender(slot1.id)
	slot5 = slot1

	slot0:UpdateStar(slot5)

	for slot5 = #slot0.bulletinItem_, 1, -1 do
		slot0.bulletinItem_[slot5]:Dispose()

		slot0.bulletinItem_[slot5] = nil
	end

	for slot6, slot7 in ipairs(MailData.GetMailContent(slot1.id)) do
		if slot7.content_type == 1 then
			slot9 = MailImageItemView.New(Object.Instantiate(slot0.imageItem_, slot0.itemParent_.transform), handler(slot0, slot0.OnContentResize))

			slot9:SetData(slot7)
			table.insert(slot0.bulletinItem_, slot9)
		elseif slot7.content_type == 2 then
			slot9 = MailTextItemView.New(Object.Instantiate(slot0.textItem_, slot0.itemParent_.transform), handler(slot0, slot0.OnContentResize))

			slot9:SetData(slot7)
			table.insert(slot0.bulletinItem_, slot9)
		elseif slot7.content_type == 3 then
			slot9 = MailRewardItemView.New(Object.Instantiate(slot0.rewardItem_, slot0.itemParent_.transform), handler(slot0, slot0.OnContentResize))

			slot9:SetData(slot7)
			table.insert(slot0.bulletinItem_, slot9)
		elseif slot7.content_type == 4 then
			slot9 = MailTitleItemView.New(Object.Instantiate(slot0.titleItem_, slot0.itemParent_.transform), handler(slot0, slot0.OnContentResize))

			slot9:SetData(slot7)
			table.insert(slot0.bulletinItem_, slot9)
		end
	end

	slot0:ForceLayout()
end

function slot0.OnContentResize(slot0)
	slot0:ForceLayout()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.itemParent_.transform)

	for slot4 = 1, #slot0.bulletinItem_ do
		slot7 = slot0.bulletinItem_[slot4].gameObject_.transform.rect.height
	end
end

function slot0.ForceLayout(slot0)
	slot1 = slot0.itemParent_:GetComponent("VerticalLayoutGroup").spacing
	slot2 = 0

	for slot6 = 1, #slot0.bulletinItem_ do
		slot7 = slot0.bulletinItem_[slot6]
		slot8 = slot7.transform_.localPosition
		slot8.y = slot2
		slot7.transform_.localPosition = slot8
		slot2 = slot2 + slot1 + slot7:GetHeight()
	end
end

function slot0.OnEnter(slot0)
	MailAction.SortMailManual()
	slot0:AddEventListener()
	manager.redPoint:bindUIandKey(slot0.btn_letter_transform, RedPointConst.LETTER_UNREAD)
	manager.redPoint:bindUIandKey(slot0.btn_letter_transform1, RedPointConst.LETTER_UNREAD)
	slot0:UpdateList(true)
	slot0:UpdateView()
	slot0:StartTimer()
end

function slot0.OnTop(slot0)
	slot0:ShowDefaultBar()
end

function slot0.StartTimer(slot0)
	if not slot0.timer_ then
		slot0.timer_ = Timer.New(function ()
			slot0 = {}
			slot1 = manager.time:GetServerTime()

			for slot5, slot6 in pairs(MailData.GetMailSort()) do
				if MailData.GetMail(slot6).timeout_timestamp <= slot1 then
					table.insert(slot0, slot6)
				end
			end

			if #slot0 > 0 then
				uv0:DeleteMailByIds(slot0)
				ShowTips("MAIL_EXPIRED")
			end

			uv0:UpdateItemCountdown()
		end, 0.2, -1)
	end

	slot0.timer_:Start()
end

function slot0.DeleteMailById(slot0, slot1)
	slot0.lastDeletedIndex_ = table.indexof(MailData.GetMailSort(), slot1)
	slot0.firstDeletedIndex_ = slot0.lastDeletedIndex_

	MailData.DeleteMail({
		slot1
	})
end

function slot0.DeleteMailByIds(slot0, slot1)
	slot0.firstDeletedIndex_ = table.indexof(MailData.GetMailSort(), slot1[1])
	slot0.lastDeletedIndex_ = table.indexof(MailData.GetMailSort(), slot1[#slot1])

	MailData.DeleteMail(slot1)
end

function slot0.RemoveTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.UpdateList(slot0, slot1)
	slot0.emptyController_:SetSelectedState(MailData.GetTotal() <= 0 and "true" or "false")

	if MailData.GetTotal() <= 0 then
		slot0.scrollHelper_:StartScroll(0)

		slot0.curContentId_ = nil
	else
		if slot0.curContentId_ then
			if not table.indexof(MailData.GetMailSort(), slot0.curContentId_) then
				slot0.curContentId_ = slot0:GetFirstSelectedId()
			end
		else
			slot0.curContentId_ = slot0:GetFirstSelectedId()
		end

		if slot0.curContentId_ ~= 0 then
			slot0.scrollHelper_:StartScroll(#MailData.GetMailSort(), table.indexof(MailData.GetMailSort(), slot0.curContentId_), not slot1)
			slot0:SelectItem(slot0.curContentId_)
		else
			slot0.scrollHelper_:StartScroll(0)

			slot0.curContentId_ = nil
		end
	end
end

function slot0.UpdateView(slot0)
	slot0.mailNumText_.text = string.format("%d/%d", MailData.GetTotal(), GameSetting.max_mail_count.value[1])
end

function slot0.UpdateItemCountdown(slot0)
	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		if slot5 then
			slot5:UpdateCountdown()
		end
	end
end

function slot0.GetFirstSelectedId(slot0)
	slot1 = nil

	return MailData.GetMailSort()[(slot0.lastDeletedIndex_ == nil or slot0.lastDeletedIndex_ <= 0 or math.min(slot0.lastDeletedIndex_, #MailData.GetMailSort())) and math.min(1, #MailData.GetMailSort())] or 0
end

function slot0.CurrentItemIndex(slot0)
	if not slot0.curContentId_ then
		return false
	end

	return table.indexof(MailData.GetMailSort(), slot0.curContentId_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
	slot0:RemoveTimer()
	manager.redPoint:unbindUIandKey(slot0.btn_letter_transform)
	manager.redPoint:unbindUIandKey(slot0.btn_letter_transform1)

	slot0.lastDeletedIndex_ = nil
	slot0.firstDeletedIndex_ = nil
	slot0.currentItem_ = nil
	slot0.curContentId_ = nil
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()

	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	if slot0.rewardScrollHelper_ then
		slot0.rewardScrollHelper_:Dispose()

		slot0.rewardScrollHelper_ = nil
	end

	for slot4 = #slot0.bulletinItem_, 1, -1 do
		slot0.bulletinItem_[slot4]:Dispose()

		slot0.bulletinItem_[slot4] = nil
	end

	slot0.bulletinItem_ = nil

	manager.classPool:DisposeOnePool(MailBoxListItem)
	uv0.super.Dispose(slot0)
end

return slot0
