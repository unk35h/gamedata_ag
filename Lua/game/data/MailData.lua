slot0 = singletonClass("MailData")
slot1 = 0
slot2 = 0
slot3 = 0
slot4 = 0
slot5 = {}
slot6 = {}
slot7 = {
	tag = "官方",
	name = "奥林匹亚速运",
	type = "mail"
}

function slot0.Init()
	uv0 = 0
	uv1 = 0
	uv2 = 0
	uv3 = 0
	uv4 = {}
	uv5 = {}
end

function slot0.MailInit(slot0)
	if uv0 < slot0.unread_number then
		uv1 = manager.time:GetServerTime()

		saveData("mail", "arrive", manager.time:GetServerTime())
	end

	uv0 = slot0.unread_number
	uv2 = slot0.total_number

	saveData("mail", "unread", tostring(uv0))
	manager.notify:Invoke(MAIL_LIST_UPDATE)
	manager.notify:Invoke(MAIL_BRIEF_UPDATE)
end

function slot0.getNextMail(slot0)
	MailAction.TryToGetMailListFromServer()
end

function slot0.IsMailDataComplete()
	return uv0 <= #uv1
end

slot8 = nil

function slot0.GetMailListFromServer(slot0)
	uv0 = slot0

	MailAction.TryToGetMailListFromServer()
end

function slot0.OnGetMailListFromServer(slot0)
	uv0 = slot0.total_num

	uv1.OnMailListGet(slot0.mail_list)
	uv1.OnGetWholeMailList()
end

function slot0.OnMailListGet(slot0)
	for slot4, slot5 in ipairs(slot0) do
		slot6 = uv0[slot5.id] ~= nil

		if slot5.id == "196690" then
			CustomLog.Log(debug.traceback(string.format("196690")))
		end

		uv0[slot5.id] = {
			id = slot5.id,
			date = slot5.date,
			title = slot5.title,
			attach_flag = slot5.attach_flag,
			read_flag = slot5.read_flag,
			timeout_timestamp = slot5.timeout_timestamp,
			star_state = slot5.star_state or 0,
			mail_template_id = slot5.mail_template_id or 0,
			title_format = {}
		}

		if uv0[slot5.id].mail_template_id ~= 0 then
			for slot10, slot11 in ipairs(slot5.title_format) do
				table.insert(uv0[slot5.id].title_format, slot11)
			end
		end

		if not slot6 then
			table.insert(uv1, slot5.id)
		end

		if uv2.GetCachedReadFlag(slot5.id) >= 0 then
			uv0[slot5.id].read_flag = uv2.GetCachedReadFlag(slot5.id)
		end

		slot7 = {}

		if slot5.attach_flag ~= 0 then
			for slot11, slot12 in ipairs(slot5.attachment_list) do
				table.insert(slot7, {
					slot12.id,
					slot12.number
				})
			end
		end

		uv0[slot5.id].rewardList = slot7
	end
end

function slot0.OnGetWholeMailList()
	if uv0 then
		uv0()

		uv0 = nil
	end
end

function slot0.DeleteMail(slot0)
	for slot4, slot5 in ipairs(slot0) do
		if uv0[slot5] == nil then
			break
		end

		uv1.DeleteCachedReadFlag(slot5)

		if uv0[slot5].read_flag == 1 then
			uv2 = uv2 - 1
		end

		uv0[slot5] = nil
		uv3 = uv3 - 1

		for slot9 = #uv4, 1, -1 do
			if uv4[slot9] == slot5 then
				table.remove(uv4, slot9)

				break
			end
		end
	end

	MailAction.UpdateMailUnread()
	manager.notify:Invoke(MAIL_LIST_UPDATE)
end

slot9 = nil

function slot0.TryToGetMailDetail(slot0, slot1)
	uv0 = slot1

	if uv1[slot0].content_list then
		if uv0 ~= nil then
			uv0()

			uv0 = nil
		end

		return
	end

	MailAction.TryToGetMailDetailFromServer(slot0)
end

function slot0.OnGetMailDetailFromServer(slot0)
	if slot0.detail_info.id == "196690" then
		CustomLog.Log(debug.traceback(string.format("196690")))
	end

	slot1 = uv0[slot0.detail_info.id]
	slot1.content_list = slot0.detail_info.content_list
	slot1.sender = slot0.detail_info.sender
	slot1.mail_template_id = slot0.detail_info.mail_template_id or 0
	slot1.sender_format = slot0.detail_info.sender_format
	slot1.content_format = {}

	if slot1.mail_template_id ~= 0 then
		for slot5, slot6 in ipairs(slot0.detail_info.content_format) do
			table.insert(slot1.content_format, slot6)
		end
	end

	slot1.read_flag = 2

	if slot1.attach_flag == 0 then
		uv1 = uv1 - 1

		MailAction.UpdateMailUnread()
		saveData("mail", "unread", tostring(uv1))
		manager.notify:Invoke(MAIL_BRIEF_UPDATE)
	end

	if uv2 ~= nil then
		uv2()

		uv2 = nil
	end

	manager.notify:Invoke(MAIL_INFO_UPDATE, slot1)
end

function slot0.GetMailAttachment(slot0)
	for slot4, slot5 in ipairs(slot0) do
		if uv0[slot5] then
			uv0[slot5].attach_flag = 2
			uv0[slot5].read_flag = 2

			manager.notify:Invoke(MAIL_INFO_UPDATE, uv0[slot5])
		end

		uv1 = uv1 - 1

		MailAction.UpdateMailUnread()
	end

	saveData("mail", "unread", tostring(uv1))
	manager.notify:Invoke(MAIL_BRIEF_UPDATE)
end

function slot0.ClickMailBtn(slot0)
	uv0 = slot0
end

function slot0.HaveMailRead(slot0)
	if uv0[slot0] then
		return uv0[slot0].read_flag == 0 or uv0[slot0].read_flag == 2
	end

	return false
end

function slot0.CacheReadFlag(slot0)
	if uv0[slot0] then
		uv0[slot0].read_flag = 2

		saveData("mail_read_flag", slot0, 2)
		manager.notify:Invoke(MAIL_INFO_UPDATE, uv0[slot0])
	end
end

function slot0.DeleteCachedReadFlag(slot0)
	if uv0[slot0] then
		saveData("mail_read_flag", slot0, nil)
	end
end

function slot0.GetCachedReadFlag(slot0)
	if uv0[slot0] then
		return getData("mail_read_flag", slot0) or -1
	end

	return -1
end

function slot0.SortMailManual()
	table.sort(uv0, function (slot0, slot1)
		slot3 = uv0[slot1]

		if uv0[slot0].attach_flag == 1 and slot3.attach_flag ~= 1 then
			return true
		elseif slot2.attach_flag ~= 1 and slot3.attach_flag == 1 then
			return false
		end

		if ((uv1.GetCachedReadFlag(slot0) == 2 or slot2.read_flag == 2) and 1 or 0) ~= ((uv1.GetCachedReadFlag(slot1) == 2 or slot3.read_flag == 2) and 1 or 0) then
			return slot4 < slot5
		end

		if slot2.star_state ~= slot3.star_state then
			return slot3.star_state < slot2.star_state
		end

		if slot3.date < slot2.date then
			return true
		elseif slot2.date < slot3.date then
			return false
		end

		return slot1 < slot0
	end)
end

function slot0.SetMailStar(slot0, slot1)
	slot2 = uv0.GetMail(tostring(slot0))
	slot2.star_state = slot1

	if slot2.star_state == 1 then
		uv0.SortMailManual()
	end

	manager.notify:Invoke(MAIL_STAR_UPDATE, slot2)
end

function slot0.GetMailSort()
	return uv0
end

function slot0.GetTotal()
	return uv0
end

function slot0.GetUnread()
	return uv0
end

function slot0.GetArriveTime()
	return uv0
end

function slot0.GetClickTime()
	return uv0
end

function slot0.GetMail(slot0)
	return uv0[slot0]
end

function slot0.GetMailContent(slot0)
	if uv0.GetMail(slot0).mail_template_id ~= nil and slot1.mail_template_id ~= 0 then
		slot2 = MailTemplateCfg[slot1.mail_template_id]

		table.insert({}, {
			content_type = 2,
			text = string.format(slot2.mail_desc, unpack(slot1.content_format))
		})

		if slot2.event_type ~= 0 and slot2.event_type == 2 then
			table.insert(slot3, {
				text = "",
				content_type = 1,
				image = slot2.image,
				event_type = slot2.event_type,
				event_arg = slot2.event_url
			})
		end

		return slot3
	else
		return slot1.content_list
	end
end

function slot0.GetMailTitle(slot0)
	if uv0.GetMail(slot0).mail_template_id ~= nil and slot1.mail_template_id ~= 0 then
		return string.format(MailTemplateCfg[slot1.mail_template_id].mail_title, unpack(slot1.title_format))
	else
		return slot1.title
	end
end

function slot0.GetMailSender(slot0)
	if uv0.GetMail(slot0).mail_template_id ~= nil and slot1.mail_template_id ~= 0 then
		return string.format(MailTemplateCfg[slot1.mail_template_id].mail_sender, unpack(slot1.sender_format))
	else
		return slot1.sender
	end
end

function slot0.GetSimpleData()
	return uv0
end

function slot0.IsSpecialMail(slot0)
	if uv0.GetMail(slot0).mail_template_id ~= nil and slot1.mail_template_id ~= 0 and MailTemplateCfg[slot1.mail_template_id].mail_type == 1 then
		return true
	end

	return false
end

return slot0
