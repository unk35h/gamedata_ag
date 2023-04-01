slot0 = singletonClass("ArchiveData")
slot1 = {}

function slot0.InitArchive(slot0, slot1)
	uv0 = {}
	slot6 = slot1

	for slot5, slot6 in ipairs(cleanProtoTable(slot6)) do
		slot10 = {}
		uv0[slot6.archive_id] = {
			archive_id = slot6.archive_id,
			exp = slot6.exp,
			lv = LvTools.LoveExpToLevel(slot6.exp),
			gift_list = {},
			text_list = {},
			video_list = slot10
		}
		slot11 = slot6.gift_list

		for slot10, slot11 in ipairs(cleanProtoTable(slot11)) do
			uv0[slot6.archive_id].gift_list[slot11.id] = slot11.num
		end

		slot11 = slot6.text_list

		for slot10, slot11 in ipairs(cleanProtoTable(slot11)) do
			uv0[slot6.archive_id].text_list[slot11] = true
		end

		slot11 = slot6.video_list

		for slot10, slot11 in ipairs(cleanProtoTable(slot11)) do
			uv0[slot6.archive_id].video_list[slot11] = true
		end
	end
end

function slot0.GetArchiveList(slot0)
	return uv0
end

function slot0.IsHeartRead(slot0, slot1, slot2)
	if uv0[slot1] == nil then
		return true
	end

	return uv0[slot1].text_list[slot2]
end

function slot0.IsStoryRead(slot0, slot1, slot2)
	return uv0[slot1].video_list[slot2]
end

function slot0.SetHeartRead(slot0, slot1, slot2)
	uv0[slot1].text_list[slot2] = true
end

function slot0.SetStoryRead(slot0, slot1, slot2)
	uv0[slot1].video_list[slot2] = true
end

function slot0.GetArchive(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = {
			exp = 0,
			lv = 1,
			archive_id = slot1,
			gift_list = {},
			text_list = {},
			video_list = {}
		}
	end

	return uv0[slot1]
end

function slot0.AddExp(slot0, slot1, slot2)
	slot4 = slot0:GetArchive(slot1).exp + slot2
	uv0[slot1].lv, slot6 = LvTools.LoveExpToLevel(slot4)
	uv0[slot1].exp = slot4
end

function slot0.AddGift(slot0, slot1, slot2)
	slot3 = uv0[slot1].gift_list

	for slot7, slot8 in pairs(slot2) do
		slot3[slot8.id] = (slot3[slot8.id] or 0) + slot8.num
	end
end

return slot0
