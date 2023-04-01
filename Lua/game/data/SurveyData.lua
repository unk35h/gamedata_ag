slot0 = singletonClass("SurveyData")
slot1 = {}
slot2 = false
slot3 = 0
slot4 = false
slot5 = nil

function slot0.InitData(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.survey_list) do
		slot7 = {
			id = slot6.id,
			question_num = slot6.question_num,
			url = slot6.url,
			name = slot6.name,
			type = slot6.type,
			start_time = slot6.start_time,
			stop_time = slot6.stop_time,
			attachment_list = {},
			status = slot6.status
		}

		for slot11, slot12 in ipairs(slot6.attachment_list) do
			table.insert(slot7.attachment_list, {
				id = slot12.item_id,
				num = slot12.item_num
			})
		end

		uv0[slot6.id] = slot7
	end

	print(uv0)

	uv1 = false
end

function slot0.FinishSurvey(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].status = 1
	end
end

function slot0.GotReward(slot0, slot1)
	uv0[slot1].status = 2
end

function slot0.GetSurveyList(slot0)
	return uv0
end

function slot0.ReservationGame(slot0, slot1)
	uv0 = slot1
end

function slot0.IsReservation(slot0)
	return uv0
end

function slot0.GetPraise(slot0)
	return uv0
end

function slot0.GetSourceId(slot0)
	return uv0
end

function slot0.SetSourceId(slot0, slot1)
	uv0 = slot1
end

function slot0.SetPraise(slot0, slot1)
	uv0 = slot1
end

function slot0.CacheFollowTip(slot0, slot1)
	uv0 = slot1
end

function slot0.GetCacheFollowTip(slot0)
	uv0 = nil

	return uv0
end

return slot0
