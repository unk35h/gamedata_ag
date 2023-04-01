slot1 = manager.net

slot1:Bind(30001, function (slot0)
	MailData.MailInit(slot0)
	uv0.UpdateMailUnread()
end)

slot1 = manager.net

slot1:Bind(30013, function (slot0)
	MailData.DeleteMail(slot0.del_id_list)
	uv0.UpdateMailUnread()
end)

return {
	TryToGetMailListFromServer = function ()
		manager.net:SendWithLoadingNew(30002, {}, 30003, uv0.OnGetMailListFromServer)
	end,
	OnGetMailListFromServer = function (slot0, slot1)
		MailData.OnGetMailListFromServer(slot0)
		uv0.UpdateMailUnread()
	end,
	TryToGetMailDetailFromServer = function (slot0)
		manager.net:SendWithLoadingNew(30008, {
			id = slot0
		}, 30009, uv0.OnGetMailDetailFromServer)
	end,
	OnGetMailDetailFromServer = function (slot0, slot1)
		if isSuccess(slot0.result) then
			MailData.OnGetMailDetailFromServer(slot0)
		else
			MailData.DeleteMail({
				slot1.id
			})
			ShowTips("TIP_MAIL_EXPIRED")
		end
	end,
	ReadMail = function (slot0)
		MailData.CacheReadFlag(slot0)
	end,
	DeleteOneMail = function (slot0)
		manager.net:SendWithLoadingNew(30006, {
			id = slot0
		}, 30007, uv0.OnDeleteMail)
	end,
	TryToDeteleMail = function ()
		return manager.net:SendWithLoadingNew(30006, {
			id = 0
		}, 30007, uv0.OnDeleteMail)
	end,
	OnDeleteMail = function (slot0, slot1)
		if #slot0.id_list <= 0 then
			ShowTips("NO_MAIL_CAN_BE_DELETED")

			return
		end

		ShowTips("SUCCESS_DELETE_MAIL")
		MailData.DeleteMail(slot0.id_list)
		manager.notify:CallUpdateFunc(ON_MAIL_DELETE, slot0.id_list)
	end,
	TryToGetMailAttachment = function (slot0)
		manager.net:SendWithLoadingNew(30004, {
			id = slot0
		}, 30005, uv0.OnGetMailAttachment)
	end,
	OnGetMailAttachment = function (slot0, slot1)
		if isSuccess(slot0.result) then
			MailData.GetMailAttachment(slot0.success_mail_ids)

			if #slot0.attachment_list > 0 then
				slot2 = {}

				for slot6, slot7 in ipairs(slot0.attachment_list) do
					if ItemCfg[slot7.id].sub_type == 404 then
						slot9 = slot8.time

						table.insert(slot2, {
							slot8.param[1],
							slot7.number,
							0,
							_G.gameTimer:GetNextWeekFreshTime() + slot9[2][1] * 604800 + (slot9[2][2][1] - 1) * 24 * 3600 + (slot9[2][2][2] - 5) * 3600
						})
					else
						table.insert(slot2, {
							slot7.id,
							slot7.number
						})
					end
				end

				getReward(mergeReward(slot2), {
					ItemConst.ITEM_TYPE.HERO,
					ItemConst.ITEM_TYPE.WEAPON_SERVANT
				})
			end
		elseif slot0.result == TipsCfg.get_id_list_by_define.ERROR_EQUIP_EXCEED_LIMIT then
			showBagFullBox()
		elseif slot0.result == TipsCfg.get_id_list_by_define.ERROR_SERVANT_EXCEED_LIMIT then
			ShowMessageBox({
				content = GetTips("SERVANT_NUM_MAX"),
				OkCallback = function ()
					JumpTools.OpenPageByJump("/weaponServantList")
				end,
				CancelCallback = function ()
				end
			})
		else
			if slot0.result == 2100 then
				-- Nothing
			end

			ShowTips(slot0.result)
		end
	end,
	ReceiveAllMails = function ()
		if #MailData.GetMailSort() < MailData.GetTotal() then
			MailData.GetMailListFromServer(handler(self, function ()
				uv0.TryToGetMailAttachment(0)
			end))
		else
			uv0.TryToGetMailAttachment(0)
		end
	end,
	SortMailManual = function ()
		MailData.SortMailManual()
	end,
	UpdateMailUnread = function ()
		slot0 = false
		slot1 = false
		slot2 = MailData.GetClickTime()
		slot0 = MailData.GetUnread() > 0 and (manager.time:IsToday(slot2) and slot2 < MailData.GetArriveTime() or true) or false

		for slot6, slot7 in pairs(MailData.GetMailSort()) do
			if MailData.GetMail(slot7) and (slot8.read_flag == 1 or slot8.attach_flag == 1) then
				slot1 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.MAIL_UNREAD, (slot0 or slot1) and 1 or 0)
	end,
	SetMailStar = function (slot0, slot1)
		manager.net:SendWithLoadingNew(30014, {
			mail_id = tonumber(slot0),
			state = slot1
		}, 30015, uv0.OnSetMailStarCallback)
	end,
	OnSetMailStarCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			MailData.SetMailStar(slot1.mail_id, slot1.state)
		else
			ShowTips(GetTips(slot0.result))
		end
	end
}
