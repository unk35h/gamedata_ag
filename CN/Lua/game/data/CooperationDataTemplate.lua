CooperationConst = {
	State = {
		READY = 3,
		REPEAT = 2,
		COMMON = 4,
		ADJUSTMENT = 1
	}
}
CooperationRoomTemplate = class("CooperationRoomTemplate")

function CooperationRoomTemplate.Ctor(slot0)
	slot0.room_id = -1
	slot0.dest = -1
	slot0.type = -1
	slot0.available = true
	slot0.room_player_id_list = {}
	slot0.room_player_list = {}
end

function CooperationRoomTemplate.Init(slot0, slot1)
	slot0.room_id = slot1.room_id
	slot0.dest = slot1.dest
	slot0.available = slot1.available
	slot0.type = slot1.type
	slot0.room_player_list = {}
	slot0.room_player_id_list = {}

	for slot5, slot6 in ipairs(slot1.player_list) do
		slot7 = BattleTeamPlayerTemplate.New(slot6)
		slot8 = slot7.playerID

		table.insert(slot0.room_player_id_list, slot8)

		slot0.room_player_list[slot8] = slot7
	end
end

function CooperationRoomTemplate.Update(slot0, slot1)
	slot0.room_id = slot1.room_id
	slot0.dest = slot1.dest
	slot0.available = slot1.available
	slot0.type = slot1.type

	for slot5, slot6 in ipairs(slot1.player_list) do
		if slot0.room_player_list[tonumber(slot6.player_id)] then
			slot8.UpdateRoomData(slot8, slot6.player_room_info)
		end
	end
end

function CooperationRoomTemplate.IsAvailable(slot0)
	return slot0.available
end

function CooperationRoomTemplate.GetRoomPlayerIdList(slot0)
	return clone(slot0.room_player_id_list)
end

function CooperationRoomTemplate.GetRoomPlayerData(slot0, slot1)
	return slot0.room_player_list[slot1]
end

function CooperationRoomTemplate.GetSelfHero(slot0)
	slot3 = slot0.room_player_list[PlayerData:GetPlayerInfo().userID].heroList

	return slot3[1].id, slot3[1].trialID
end

function CooperationRoomTemplate.IsFull(slot0)
	return #slot0.room_player_list >= 3
end

function CooperationRoomTemplate.RepeatHero(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in pairs(slot0.room_player_list) do
		if slot7.heroList[1].id == slot1 then
			slot2 = slot2 + 1
		end
	end

	return slot2 > 1
end

CooperationInviteTemplate = class("CooperationInviteTemplate")

function CooperationInviteTemplate.Ctor(slot0, slot1)
	slot0.invite_type = slot1.type
	slot0.uid = slot1.uid
	slot0.nick = slot1.nick
	slot0.icon = slot1.icon
	slot0.icon_frame = slot1.icon_frame
	slot0.level = slot1.level
	slot0.dest = slot1.dest
	slot0.timestamp = slot1.timestamp
	slot0.room_id = slot1.room_id
	slot0.refuse = false
end

function CooperationInviteTemplate.Refuse(slot0)
	slot0.refuse = true
end

function CooperationInviteTemplate.IsOverdue(slot0)
	return manager.time:GetServerTime() > slot0.timestamp + 300
end

CooperationRecentVisitTemplate = class("CooperationRecentVisitTemplate")

function CooperationRecentVisitTemplate.Ctor(slot0, slot1)
	slot0.uid = slot1.uid
	slot0.nick = slot1.nick
	slot0.icon = slot1.icon
	slot0.icon_frame = slot1.icon_frame
	slot0.level = slot1.level
	slot0.timestamp = slot1.timestamp
end
