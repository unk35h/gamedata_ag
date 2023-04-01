slot0 = singletonClass("MailData")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = {}
slot5 = {}

function slot0.Init()
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = {}
	uv4 = {}
end

function slot0.LetterInit(slot0)
	for slot4, slot5 in ipairs(slot0.letter_list) do
		slot7 = MailSpecialLetterCfg[slot5.id]
		uv0[slot5.id] = {
			id = slot5.id,
			isViewed = slot5.is_viewed,
			title = slot7.letter_title,
			desc = slot7.letter_desc,
			send_time = slot7.letter_send_time_1,
			sender = slot7.letter_sender,
			belongs = slot7.letter_belongs,
			sender_face = slot7.letter_sender_face
		}

		if not (uv0[slot5.id] ~= nil) then
			table.insert(uv1, slot5.id)
		end

		uv2[slot7.letter_belongs] = {
			id = slot7.letter_belongs,
			sender = slot7.letter_sender,
			sender_face = slot7.letter_sender_face
		}
	end
end

function slot0.SortLetters()
	for slot3, slot4 in pairs(uv0) do
		if not (uv1[slot4.belongs] ~= nil) then
			uv1[slot4.belongs] = {}

			table.insert(uv2, slot4.belongs)
		end

		if not table.keyof(uv1[slot4.belongs], slot3) then
			table.insert(uv1[slot4.belongs], slot3)
		end
	end

	for slot3, slot4 in pairs(uv1) do
		table.sort(slot4, function (slot0, slot1)
			if uv0[slot1].send_time < uv0[slot0].send_time then
				return true
			elseif uv0[slot0].send_time < uv0[slot1].send_time then
				return false
			end

			return slot1 < slot0
		end)
	end

	table.sort(uv2, function (slot0, slot1)
		slot4 = string.split(uv1[uv0[slot0][1]].send_time, ",")
		slot5 = string.split(uv1[uv0[slot1][1]].send_time, ",")

		if os.time({
			year = slot5[1],
			month = slot5[2],
			day = slot5[3]
		}) < os.time({
			year = slot4[1],
			month = slot4[2],
			day = slot4[3]
		}) then
			return true
		elseif slot6 < slot7 then
			return false
		end

		return slot1 < slot0
	end)
end

function slot0.CacheReadFlag(slot0)
	if uv0[slot0] then
		uv0[slot0].isViewed = true

		manager.notify:Invoke(LETTER_READ_UPDATE, slot0)
	end
end

function slot0.HaveUnreadLetter(slot0)
	slot2 = false

	for slot6, slot7 in pairs(uv0[slot0]) do
		if uv1[slot7].isViewed == false then
			slot2 = true

			break
		end
	end

	return slot2
end

function slot0.GetLetters()
	return uv0
end

function slot0.GetLetterSort()
	return uv0
end

function slot0.GetLetter(slot0)
	return uv0[slot0]
end

function slot0.GetLettersFromSender(slot0)
	return uv0[slot0]
end

function slot0.GetSenderNums()
	return #uv0
end

function slot0.GetSenderSort()
	return uv0
end

function slot0.GetSender(slot0)
	return uv0[slot0]
end

return slot0
