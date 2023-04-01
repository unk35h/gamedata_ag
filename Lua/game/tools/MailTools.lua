return {
	Sort = function (slot0)
		slot1 = {}
		slot2 = {}
		slot3 = {}

		for slot7, slot8 in pairs(slot0) do
			if type(slot8) == "table" then
				if slot8.read_flag == 2 and slot8.attach_flag ~= 1 then
					table.insert(slot2, slot7)
				else
					table.insert(slot1, slot7)
				end

				table.insert(slot3, slot7)
			end
		end

		table.sort(slot3, function (slot0, slot1)
			return slot1 < slot0
		end)
		table.sort(slot1, function (slot0, slot1)
			return slot1 < slot0
		end)

		function slot7(slot0, slot1)
			return slot1 < slot0
		end

		table.sort(slot2, slot7)

		for slot7, slot8 in ipairs(slot2) do
			table.insert(slot1, slot8)
		end

		return slot1, #slot3, slot3[1] or 0, slot3[slot4] or 0
	end,
	SortBySelectId = function (slot0, slot1)
		slot2 = {}
		slot3 = {}

		for slot7, slot8 in pairs(slot0) do
			if type(slot8) == "table" then
				if slot8.read_flag == 2 and slot8.attach_flag ~= 1 then
					table.insert(slot3, slot7)
				else
					table.insert(slot2, slot7)
				end
			end
		end

		table.sort(slot2, function (slot0, slot1)
			if uv0[slot0].date == uv0[slot1].date then
				return slot1 < slot0
			else
				return uv0[slot1].date < uv0[slot0].date
			end
		end)

		function slot7(slot0, slot1)
			if uv0[slot0].date == uv0[slot1].date then
				return slot1 < slot0
			else
				return uv0[slot1].date < uv0[slot0].date
			end
		end

		table.sort(slot3, slot7)

		for slot7, slot8 in ipairs(slot3) do
			table.insert(slot2, slot8)
		end

		if slot1 ~= 0 and uv0.lastSort then
			slot4 = table.keyof(uv0.lastSort, slot1)

			if table.keyof(slot2, slot1) and slot4 ~= slot5 then
				for slot9, slot10 in ipairs(slot2) do
					if table.keyof(uv0.lastSort, slot10) == nil then
						table.insert(uv0.lastSort, slot10)
					end
				end

				return clone(uv0.lastSort)
			end
		end

		uv0.lastSort = slot2

		return slot2
	end,
	GetLostTimeStr = function (slot0)
		slot1 = slot0 - TimeMgr.GetInstance():GetServerTime()
		slot3 = math.fmod(math.floor(slot1 / 3600), 24)
		slot4 = math.fmod(math.floor(slot1 / 60), 60)
		slot5 = math.fmod(slot1, 60)

		if math.floor(slot1 / 86400) > 0 then
			return string.format(GetTips("EXPIRED_DAY"), slot2 + 1)
		elseif slot3 > 0 then
			return string.format(GetTips("EXPIRED_HOUR"), slot3 + 1)
		elseif slot4 > 0 then
			return string.format(GetTips("EXPIRED_MINUTE"), slot4 + 1)
		elseif slot5 > 0 then
			return string.format(GetTips("EXPIRED_SECOND"), slot5)
		else
			return GetTips("TIME_OUT")
		end
	end
}
