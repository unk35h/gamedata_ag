slot0 = import(".MailReducer")

return function (slot0, slot1)
	if slot0 == nil then
		slot0 = {
			total = 0,
			mailSimpleData = {
				{
					name = "公众号",
					totalCnt = 1,
					type = "title",
					id = 1,
					cnt = 1
				},
				{
					id = 2,
					name = "奥林匹亚速运",
					tag = "官方",
					type = "mail"
				}
			},
			mail = {},
			unread = tonumber(getData("mail", "unread") or 0),
			arriveTime = tonumber(getData("mail", "arrive") or 0),
			clickTime = tonumber(getData("mail", "click") or 0),
			mailSort = {}
		}
	end

	if ({
		[ACTIONS.MAIL_INIT] = function (slot0)
			if slot0.unread < uv0.data.unread_number then
				slot0.arriveTime = manager.time:GetServerTime()

				saveData("mail", "arrive", manager.time:GetServerTime())
			end

			slot0.unread = uv0.data.unread_number
			slot0.total = uv0.data.total_number

			saveData("mail", "unread", tostring(slot0.unread))
		end,
		[ACTIONS.MAIL_LIST_GET] = function (slot0)
			for slot4, slot5 in ipairs(uv0.data) do
				if slot0.mail[slot5.id] then
					for slot9 = immer.getn(slot0.mailSort), 1, -1 do
						if slot0.mailSort[slot9] == slot5.id then
							immer.remove(slot0.mailSort, slot9)

							break
						end
					end
				end

				immer.insert(slot0.mailSort, slot5.id)

				slot0.mail[slot5.id] = {
					id = slot5.id,
					date = slot5.date,
					title = slot5.title,
					attach_flag = slot5.attach_flag,
					read_flag = slot5.read_flag,
					timeout_timestamp = slot5.timeout_timestamp
				}
				slot6 = {}
				slot7 = {}

				if slot5.attach_flag ~= 0 then
					for slot11, slot12 in ipairs(slot5.attachment_list) do
						table.insert(slot7, {
							slot12.id,
							slot12.number
						})
					end
				end

				slot0.mail[slot5.id].rewardList = slot7
			end
		end,
		[ACTIONS.MAIL_DETAIL_GET] = function (slot0)
			slot1 = uv0.data
			slot0.mail[slot1.id] = uv1(slot0.mail[slot1.id], uv0)

			if slot0.mail[slot1.id].attach_flag == 0 then
				slot0.unread = slot0.unread - 1

				saveData("mail", "unread", tostring(slot0.unread))
			end
		end,
		[ACTIONS.MAIL_ATTACHMENT_GET] = function (slot0)
			for slot4, slot5 in ipairs(uv0.data) do
				if slot0.mail[slot5] then
					slot0.mail[slot5] = uv1(slot0.mail[slot5], uv0)
				end

				slot0.unread = slot0.unread - 1
			end

			saveData("mail", "unread", tostring(slot0.unread))
		end,
		[ACTIONS.MAIL_DELETE] = function (slot0)
			for slot4, slot5 in ipairs(uv0.data) do
				if slot0.mail[slot5] == nil then
					break
				end

				if slot0.mail[slot5].read_flag == 1 then
					slot0.unread = slot0.unread - 1
				end

				slot0.mail[slot5] = nil
				slot0.total = slot0.total - 1

				for slot9 = immer.getn(slot0.mailSort), 1, -1 do
					if slot0.mailSort[slot9] == slot5 then
						immer.remove(slot0.mailSort, slot9)

						break
					end
				end
			end
		end,
		[ACTIONS.MAIL_BTN_CLICK] = function (slot0)
			slot0.clickTime = uv0.data

			if uv0.data < slot0.arriveTime then
				slot0.arriveTime = uv0.data

				saveData("mail", "arrive", uv0.data)
			end

			saveData("mail", "click", tostring(uv0.data))
		end
	})[slot1.type] then
		return immer.produce(slot0, function (slot0)
			uv0[uv1.type](slot0)
		end)
	else
		return slot0
	end
end
