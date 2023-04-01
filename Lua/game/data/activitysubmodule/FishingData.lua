slot0 = singletonClass("FishingData")
slot1 = {}
slot2 = {}
slot3 = {}

function slot0.Reset(slot0)
	uv0 = {
		fish_infos = {},
		request_infos = {},
		received_award_list = {},
		received_constitute_list = {},
		send_present_list = {},
		score = 0
	}
	uv1 = {}
	uv2 = {}
end

function slot0.InitFromServer(slot0, slot1)
	uv0.score = slot1.score
	uv0.today_total_score = slot1.today_total_score
	uv0.today_treasure_num = slot1.today_treasure_num
	uv0.send_present_list = {}

	for slot5, slot6 in ipairs(slot1.send_present_list) do
		uv0.send_present_list[slot6.id] = slot6.num
	end

	uv0.fish_infos = {}
	uv0.request_infos = {}

	for slot5, slot6 in ipairs(slot1.fish_info) do
		uv0.fish_infos[slot6.id] = {
			id = slot6.id,
			num = slot6.num,
			len = slot6.length
		}
	end

	for slot5, slot6 in ipairs(slot1.request_info) do
		table.insert(uv0.request_infos, slot6)
	end

	uv0.received_award_list = {}

	for slot5, slot6 in ipairs(slot1.received_award_list) do
		table.insert(uv0.received_award_list, slot6)
	end

	uv0.received_constitute_list = {}

	for slot5, slot6 in ipairs(slot1.received_constitute_list) do
		table.insert(uv0.received_constitute_list, slot6)
	end

	manager.notify:Invoke(RARE_FISH_CHANGE, 0)
end

function slot0.OnFishingResult(slot0, slot1, slot2, slot3)
	CurrencyData:CurrencyModify(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN, slot1)

	uv0.today_total_score = uv0.today_total_score + slot1
	uv0.score = uv0.score + slot1
	slot7 = uv0.today_treasure_num + slot3
	slot8 = GameSetting.activity_fishing_fish_max.value[1]
	uv0.today_treasure_num = math.min(slot7, slot8)

	for slot7, slot8 in ipairs(slot2) do
		uv0.fish_infos[slot8.id] = {
			id = slot8.id,
			num = slot8.num,
			len = slot8.length
		}
	end

	manager.notify:Invoke(RARE_FISH_CHANGE, 0)
end

function slot0.UpdateRequest(slot0, slot1)
	uv0.request_infos = slot1

	manager.notify:Invoke(FISHING_REQUEST_CHANGE, {})
end

function slot0.OnReceiveInfoGet(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(uv0, {
			timestamp = slot6.timestamp,
			giver_id = slot6.giver_id,
			giver_icon = slot6.giver_icon,
			giver_nick = slot6.giver_nick,
			fish_id = slot6.fish_id
		})
	end

	manager.notify:Invoke(RECEIVE_FISH_CHANGE, {})
end

function slot0.OnFriendRequestFishInfoGet(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = {
			friendId = slot6.Id
		}
		slot8 = {}

		for slot12, slot13 in ipairs(slot6.need_list) do
			table.insert(slot8, slot13)
		end

		slot7.fishList = slot8

		table.insert(uv0, slot7)
	end

	manager.notify:Invoke(FRIENDS_REQUEST_FISH_INFO_CHANGE, {})
end

function slot0.OnReceiveFriendsFish(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(uv0) do
		if slot8.giver_id == slot1 and slot8.timestamp == slot2 then
			table.remove(uv0, slot7)

			break
		end
	end

	slot7 = RECEIVE_FISH_CHANGE
	slot8 = {}

	manager.notify:Invoke(slot7, slot8)

	for slot7, slot8 in ipairs(slot3) do
		uv1.fish_infos[slot8.id] = {
			id = slot8.id,
			num = slot8.num,
			len = slot8.length
		}
	end

	manager.notify:Invoke(RARE_FISH_CHANGE, 0)
end

function slot0.OnGiveComplete(slot0, slot1, slot2, slot3)
	slot0:RemoveFish(slot2, slot3)

	if not uv0.send_present_list[slot1] then
		uv0.send_present_list[slot1] = 1
	else
		uv0.send_present_list[slot1] = uv0.send_present_list[slot1] + 1
	end

	manager.notify:Invoke(FRIENDS_REQUEST_FISH_INFO_CHANGE, {})
end

function slot0.RemoveFish(slot0, slot1, slot2)
	uv0.fish_infos[slot1].num = uv0.fish_infos[slot1].num - slot2

	manager.notify:Invoke(RARE_FISH_CHANGE, slot1)
end

function slot0.OnGetGroupReward(slot0, slot1)
	for slot7, slot8 in ipairs(ActivitySummerFishGroupCfg[slot1].group[1]) do
		uv0.fish_infos[slot8].num = uv0.fish_infos[slot8].num - 1
	end

	table.insert(uv0.received_constitute_list, slot1)
	manager.notify:Invoke(RARE_FISH_CHANGE, fishId)
	manager.notify:Invoke(FISHING_GROUP_REWARD_CHANGE, {})
end

function slot0.OnGetScoreReward(slot0, slot1)
	table.insert(uv0.received_award_list, slot1)
	manager.notify:Invoke(FISHING_SCORE_REWARD_CHANGE, {})
end

function slot0.OnBuySuccess(slot0, slot1, slot2, slot3)
	slot2 = slot2 or 1

	if uv0.fish_infos[slot1] then
		uv0.fish_infos[slot1].num = uv0.fish_infos[slot1].num + slot2
		uv0.fish_infos[slot1].len = slot3.length
	else
		uv0.fish_infos[slot1] = {
			id = slot1,
			num = slot2,
			len = slot3.length
		}
	end

	manager.notify:Invoke(RARE_FISH_CHANGE, slot1)
end

function slot0.GetActivityData(slot0)
	return uv0
end

function slot0.GetFish(slot0, slot1)
	return uv0.fish_infos[slot1]
end

function slot0.GetFishReceiveInfo(slot0)
	return uv0
end

function slot0.GetFriendRequestFishInfo(slot0)
	return uv0
end

function slot0.IsFriendGiveMax(slot0, slot1)
	if GameSetting.activity_fishing_present_max.value[1] <= (uv0.send_present_list[slot1] or 0) then
		return true
	end

	return false
end

function slot0.GetRareLabel(slot0, slot1)
	if slot1 == 1 then
		return "B"
	end

	if slot1 == 2 then
		return "A"
	end

	if slot1 == 3 then
		return "S"
	end
end

return slot0
